From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/18] Introduce automount support in the VFS
Date: Tue, 11 Jan 2011 17:48:10 +0000
Message-ID: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org


Hi Nick,

Could you look over these patches, please?  They were surviving Ian's autofs
tests quite nicely, but I had to rework them a bit to take account of your
RCU-mode pathwalk changes.  I'm not sure the locking is fully correct.  In some
of the autofs patches you'll find locks with marks on them (search for '//')
where dcache_lock was being used and I'm not sure of the correct transformation
now that it no longer exists.

Hi Al,

Could you look over these patches and make sure you're happy with the way we've
done things?

Hi Ian,

Could you have a poke at the autofs4 changes, make sure things still work?

---
The attached patches implement VFS support for automounting - which several
filesystems, including autofs, can use to resolve problems with their current
implementations.  This means that these filesystems no longer have to abuse
lookup(), follow_link() and d_revalidate() to achieve the desired effects.

Probably the most significant advantage for autofs is a long standing potential
deadlock can be removed which otherwise cannot be resolved.


These patches introduce a couple of new dentry operations for use by
automounters and make AFS, NFS, CIFS and autofs4 use them.

There are two dentry operations provided:

 (1) struct vfsmount *(*d_automount)(struct path *path);

     This is used by follow_automount() in fs/namei.c to ask the filesystem
     that owns the dentry at the current path point to mount something on
     @path.

     It is called if either the inode belonging to the given dentry is flagged
     S_AUTOMOUNT or the dentry is flagged DCACHE_NEED_AUTOMOUNT, and if the
     dentry has nothing mounted on it in the current namespace when someone
     attempts to use that dentry.

     No locks will be held when this is called.

     d_op->d_automount() may return one of:

     (a) The vfsmount mounted upon that dentry, in which case pathwalk will
     	 move to the root dentry of that vfsmount.

     (b) NULL if something was already mounted there, in which case pathwalk
     	 will loop around and recheck the mountings.

     (c) -EISDIR, in which case pathwalk will stop at this point and attempt to
     	 use that dentry as the object of interest.  If the current dentry is
     	 not terminal within the path, -EREMOTE will be returned.

     (d) An error value, to be returned immediately.

     Automount transits are counted as symlinks to prevent circular references
     from being a problem.  If one is detected, -ELOOP will be returned.

     If stat() is given AT_NO_AUTOMOUNT then d_op->d_automount() will not be
     invoked on a terminal dentry; instead that dentry will be returned by
     pathwalk.

     follow_automount() also does not invoke d_op->d_automount() if the caller
     gave AT_SYMLINK_NOFOLLOW to stat(), but rather returns the base dentry.


 (2) int (*d_manage)(struct path *path, bool mounting_here);

     This is called by managed_dentry() or follow_down() in fs/namei.c to
     indicate to a filesystem that pathwalk is about to step off of the current
     path point and walk to another point in the path.

     This is called if DCACHE_MANAGE_TRANSIT is set on a dentry.

     This can then be used by autofs to stop non-daemon processes from walking
     until it has finished constructing or expiring the tree behind the dentry.
     It could also be used to prevent undesirables from mounting on this
     dentry.

     @mounting_here is true if called from follow_down() from mount, in which
     case namespace_sem is held exclusively by the caller of follow_down().
     Otherwise, no locks are held.

     d_op->d_manage() may return one of:

     (a) 0 to continue the pathwalk as normal.

     (b) -EISDIR to prevent managed_dentry() from crossing to a mounted
     	 filesystem or calling d_op->d_automount(), in which case the dentry
     	 will be treated as an ordinary directory.

     (c) An error to abort the pathwalk completely.


To make this work for autofs a couple of additional dentry d_flags have been
defined: DCACHE_MANAGE_TRANSIT and DCACHE_NEED_AUTOMOUNT.  This allows
managed_dentry() to test all three conditions with minimumal overhead if none
of them are true.

For other filesystems, setting S_AUTOMOUNT is sufficient.  This is noted by
d_set_d_op() which will set DCACHE_NEED_AUTOMOUNT automatically if it is seen.
Checking S_AUTOMOUNT doesn't work for autofs, however, since the dentry might
not have an inode, hence why a dentry flag also.

S_AUTOMOUNT and d_automount() are introduced in patch 1; d_manage(),
DCACHE_MANAGE_TRANSIT and DCACHE_NEED_AUTOMOUNT are introduced in patch 7.


=======
UPDATES
=======

 [ver #3]
   - Update to take account of Nick Piggin's RCU-based pathwalk changes.

 [ver #2]
   - Fixed a EXDEV in patch 6 to be EISDIR.  We were previously using EXDEV to
     indicate we wanted to handle a directory as a directory and not to process
     it as a mountpoint.
   - Move some autofs v4 pseudo mount bits into the v4 pseudo direct mount
     patch [patch 16].
   - Move a comment fix to the autofs d_automount() patch [patch 10 -> 9].
   - Adjust the patch titles of the last three autofs patches.

David
---

David Howells (9):
      Remove a further kludge from __do_follow_link()
      Make follow_down() handle d_manage()
      Add more dentry flags for special function directories
      Add an AT_NO_AUTOMOUNT flag to suppress terminal automount
      Remove the automount through follow_link() kludge code from pathwalk
      CIFS: Use d_automount() rather than abusing follow_link()
      NFS: Use d_automount() rather than abusing follow_link()
      AFS: Use d_automount() rather than abusing follow_link()
      Add a dentry op to handle automounting rather than abusing follow_link()

Ian Kent (9):
      autofs4: Bump version
      autofs4: Add v4 pseudo direct mount support
      autofs4: Fix wait validation
      autofs4: Clean up autofs4_free_ino()
      autofs4: Clean up dentry operations
      autofs4: Clean up inode operations
      autofs4: Remove unused code
      autofs4: Add d_manage() dentry operation
      autofs4: Add d_automount() dentry operation


 Documentation/filesystems/Locking |    2 
 Documentation/filesystems/vfs.txt |   22 +
 drivers/staging/autofs/dirhash.c  |    5 
 fs/afs/dir.c                      |    1 
 fs/afs/inode.c                    |    3 
 fs/afs/internal.h                 |    1 
 fs/afs/mntpt.c                    |   47 +--
 fs/autofs4/autofs_i.h             |  100 ++++-
 fs/autofs4/dev-ioctl.c            |    2 
 fs/autofs4/expire.c               |   51 ++-
 fs/autofs4/inode.c                |   28 --
 fs/autofs4/root.c                 |  681 ++++++++++++++++---------------------
 fs/autofs4/waitq.c                |   17 +
 fs/cifs/cifs_dfs_ref.c            |  134 ++++---
 fs/cifs/cifsfs.h                  |    6 
 fs/cifs/dir.c                     |    2 
 fs/cifs/inode.c                   |    8 
 fs/dcache.c                       |    2 
 fs/namei.c                        |  303 +++++++++++++---
 fs/namespace.c                    |   14 -
 fs/nfs/dir.c                      |    4 
 fs/nfs/inode.c                    |    4 
 fs/nfs/internal.h                 |    1 
 fs/nfs/namespace.c                |   87 ++---
 fs/nfsd/vfs.c                     |    5 
 fs/stat.c                         |    4 
 include/linux/auto_fs4.h          |    2 
 include/linux/dcache.h            |   16 +
 include/linux/fcntl.h             |    1 
 include/linux/fs.h                |    2 
 include/linux/namei.h             |    5 
 include/linux/nfs_fs.h            |    1 
 32 files changed, 867 insertions(+), 694 deletions(-)

