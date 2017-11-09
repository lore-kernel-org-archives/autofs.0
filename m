From: NeilBrown <neilb@suse.com>
Subject: [PATCH 0/3] VFS: name lookup improvements.
Date: Thu, 09 Nov 2017 18:20:24 +1100
Message-ID: <151021179901.22743.15252956909042161062.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <ikent@redhat.com>, Latchesar Ionkov <lucho@ionkov.net>, Jeff Layton <jlayton@redhat.com>, Eric Van Hensbergen <ericvh@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Ron Minnich <rminnich@sandia.gov>, Trond Myklebust <trondmy@primarydata.com>
Cc: linux-nfs@vger.kernel.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, Linus Torvalds <torvalds@linux-foundation.org>

These three patches address two issues: d_weak_revalidate and
path_mountpoint lookups.

The former is poorly defined and doesn't actually do the one thing
that it would be useful for it to do.  So the nfs implemention
is improved, the 9p one discarded, and the documentation clarified.

Given this change and recent change to follow_automount() the
mountpoint path lookup functions are no longer needed.  The regular
path look functions are quite sufficient.
The second two patches remove this with detailed explanation of why
it is OK.

Thanks,
NeilBrown


---

NeilBrown (3):
      VFS/nfs/9p: revise meaning of d_weak_invalidate.
      VFS: remove user_path_mountpoint_at()
      VFS / autofs4: remove kern_path_mountpoint()


 Documentation/filesystems/porting |    5 +
 Documentation/filesystems/vfs.txt |   11 +--
 fs/9p/vfs_dentry.c                |    1 
 fs/autofs4/dev-ioctl.c            |    5 -
 fs/internal.h                     |    1 
 fs/namei.c                        |  150 -------------------------------------
 fs/namespace.c                    |    2 
 fs/nfs/dir.c                      |   60 ++-------------
 include/linux/namei.h             |    1 
 9 files changed, 24 insertions(+), 212 deletions(-)

--
Signature

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
