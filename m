From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/18] Add a dentry op to allow processes to be held during
 pathwalk transit [ver #4]
Date: Thu, 13 Jan 2011 21:54:10 +0000
Message-ID: <20110113215410.19406.66564.stgit@warthog.procyon.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@zeniv.linux.org.uk, raven@themaw.net, npiggin@kernel.dk
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Add a dentry op (d_manage) to permit a filesystem to hold a process and make it
sleep when it tries to transit away from one of that filesystem's directories
during a pathwalk.  The operation is keyed off a new dentry flag
(DCACHE_MANAGE_TRANSIT).

The filesystem is allowed to be selective about which processes it holds and
which it permits to continue on or prohibits from transiting from each flagged
directory.  This will allow autofs to hold up client processes whilst letting
its userspace daemon through to maintain the directory or the stuff behind it
or mounted upon it.

The ->d_manage() dentry operation:

	int (*d_manage)(struct path *path, bool mounting_here);

takes a pointer to the directory about to be transited away from and a flag
indicating whether the transit is undertaken by do_add_mount() or
do_move_mount() skipping through a pile of filesystems mounted on a mountpoint.

It should return 0 if successful and to let the process continue on its way;
-EISDIR to prohibit the caller from skipping to overmounted filesystems or
automounting, and to use this directory; or some other error code to return to
the user.

->d_manage() is called with namespace_sem writelocked if mounting_here is true
and no other locks held, so it may sleep.  However, if mounting_here is true,
it may not initiate or wait for a mount or unmount upon the parameter
directory, even if the act is actually performed by userspace.


Within fs/namei.c, follow_managed() is extended to check with d_manage() first
on each managed directory, before transiting away from it or attempting to
automount upon it.

follow_down() is renamed follow_down_one() and should only be used where the
filesystem deliberately intends to avoid management steps (e.g. autofs).

A new follow_down() is added that incorporates the loop done by all other
callers of follow_down() (do_add/move_mount(), autofs and NFSD; whilst AFS, NFS
and CIFS do use it, their use is removed by converting them to use
d_automount()).  The new follow_down() calls d_manage() as appropriate.  It
also takes an extra parameter to indicate if it is being called from mount code
(with namespace_sem writelocked) which it passes to d_manage().  follow_down()
ignores automount points so that it can be used to mount on them.

__follow_mount_rcu() is made to abort rcu-walk mode if it hits a directory with
DCACHE_MANAGE_TRANSIT set on the basis that we're probably going to have to
sleep.  It would be possible to enter d_manage() in rcu-walk mode too, and have
that determine whether to abort or not itself.  That would allow the autofs
daemon to continue on in rcu-walk mode.


Note that DCACHE_MANAGE_TRANSIT on a directory should be cleared when it isn't
required as every tranist from that directory will cause d_manage() to be
invoked.  It can always be set again when necessary.


==========================
WHAT THIS MEANS FOR AUTOFS
==========================

Autofs currently uses the lookup() inode op and the d_revalidate() dentry op to
trigger the automounting of indirect mounts, and both of these can be called
with i_mutex held.

autofs knows that the i_mutex will be held by the caller in lookup(), and so
can drop it before invoking the daemon - but this isn't so for d_revalidate(),
since the lock is only held on _some_ of the code paths that call it.  This
means that autofs can't risk dropping i_mutex from its d_revalidate() function
before it calls the daemon.

The bug could manifest itself as, for example, a process that's trying to
validate an automount dentry that gets made to wait because that dentry is
expired and needs cleaning up:

	mkdir         S ffffffff8014e05a     0 32580  24956
	Call Trace:
	 [<ffffffff885371fd>] :autofs4:autofs4_wait+0x674/0x897
	 [<ffffffff80127f7d>] avc_has_perm+0x46/0x58
	 [<ffffffff8009fdcf>] autoremove_wake_function+0x0/0x2e
	 [<ffffffff88537be6>] :autofs4:autofs4_expire_wait+0x41/0x6b
	 [<ffffffff88535cfc>] :autofs4:autofs4_revalidate+0x91/0x149
	 [<ffffffff80036d96>] __lookup_hash+0xa0/0x12f
	 [<ffffffff80057a2f>] lookup_create+0x46/0x80
	 [<ffffffff800e6e31>] sys_mkdirat+0x56/0xe4

versus the automount daemon which wants to remove that dentry, but can't
because the normal process is holding the i_mutex lock:

	automount     D ffffffff8014e05a     0 32581      1              32561
	Call Trace:
	 [<ffffffff80063c3f>] __mutex_lock_slowpath+0x60/0x9b
	 [<ffffffff8000ccf1>] do_path_lookup+0x2ca/0x2f1
	 [<ffffffff80063c89>] .text.lock.mutex+0xf/0x14
	 [<ffffffff800e6d55>] do_rmdir+0x77/0xde
	 [<ffffffff8005d229>] tracesys+0x71/0xe0
	 [<ffffffff8005d28d>] tracesys+0xd5/0xe0

which means that the system is deadlocked.

This patch allows autofs to hold up normal processes whilst the daemon goes
ahead and does things to the dentry tree behind the automouter point without
risking a deadlock as almost no locks are held in d_manage() and none in
d_automount().

Signed-off-by: David Howells <dhowells@redhat.com>
Was-Acked-by: Ian Kent <raven@themaw.net>
---

 Documentation/filesystems/Locking |    1 +
 Documentation/filesystems/vfs.txt |   21 ++++++++++-
 drivers/staging/autofs/dirhash.c  |    5 +--
 fs/afs/mntpt.c                    |    5 +--
 fs/autofs4/autofs_i.h             |   13 -------
 fs/autofs4/dev-ioctl.c            |    2 +
 fs/autofs4/expire.c               |    2 +
 fs/autofs4/root.c                 |   11 +++---
 fs/cifs/cifs_dfs_ref.c            |    5 +--
 fs/namei.c                        |   72 ++++++++++++++++++++++++++++++++++++-
 fs/namespace.c                    |   14 ++++---
 fs/nfs/namespace.c                |    5 +--
 fs/nfsd/vfs.c                     |    5 ++-
 include/linux/dcache.h            |   11 +++++-
 include/linux/namei.h             |    3 +-
 15 files changed, 125 insertions(+), 50 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 5f0c52a..621ee98 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -31,6 +31,7 @@ d_release:	no		no		yes		no
 d_iput:		no		no		yes		no
 d_dname:	no		no		no		no
 d_automount:	no		no		yes		no
+d_manage:	no		no		yes		no
 
 --------------------------- inode_operations --------------------------- 
 prototypes:
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 992cf74..3d68c2e 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -865,6 +865,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
+	int (*d_manage)(struct path *, bool);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
@@ -938,12 +939,30 @@ struct dentry_operations {
 	target and the parent VFS mount record to provide inheritable mount
 	parameters.  NULL should be returned if someone else managed to make
 	the automount first.  If the automount failed, then an error code
-	should be returned.
+	should be returned.  If -EISDIR is returned, then the directory will
+	be treated as an ordinary directory and returned to pathwalk to
+	continue walking.
 
 	This function is only used if DCACHE_NEED_AUTOMOUNT is set on the
 	dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is set on the
 	inode being added.
 
+  d_manage: called to allow the filesystem to manage the transition from a
+	dentry (optional).  This allows autofs, for example, to hold up clients
+	waiting to explore behind a 'mountpoint' whilst letting the daemon go
+	past and construct the subtree there.  0 should be returned to let the
+	calling process continue.  -EISDIR can be returned to tell pathwalk to
+	use this directory as an ordinary directory and to ignore anything
+	mounted on it and not to check the automount flag.  Any other error
+	code will abort pathwalk completely.
+
+	If the 'mounting_here' parameter is true, then namespace_sem is being
+	held by the caller and the function should not initiate any mounts or
+	unmounts that it will then wait for.
+
+	This function is only used if DCACHE_MANAGE_TRANSIT is set on the
+	dentry being transited from.
+
 Example :
 
 static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
diff --git a/drivers/staging/autofs/dirhash.c b/drivers/staging/autofs/dirhash.c
index d3f42c8..a08bd73 100644
--- a/drivers/staging/autofs/dirhash.c
+++ b/drivers/staging/autofs/dirhash.c
@@ -88,14 +88,13 @@ struct autofs_dir_ent *autofs_expire(struct super_block *sb,
 		}
 		path.mnt = mnt;
 		path_get(&path);
-		if (!follow_down(&path)) {
+		if (!follow_down_one(&path)) {
 			path_put(&path);
 			DPRINTK(("autofs: not expirable\
 			(not a mounted directory): %s\n", ent->name));
 			continue;
 		}
-		while (d_mountpoint(path.dentry) && follow_down(&path))
-			;
+		follow_down(&path, false);  // TODO: need to check error
 		umount_ok = may_umount(path.mnt);
 		path_put(&path);
 
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 6153417..b8e7fb8 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -273,10 +273,7 @@ static void *afs_mntpt_follow_link(struct dentry *dentry, struct nameidata *nd)
 		break;
 	case -EBUSY:
 		/* someone else made a mount here whilst we were busy */
-		while (d_mountpoint(nd->path.dentry) &&
-		       follow_down(&nd->path))
-			;
-		err = 0;
+		err = follow_down(&nd->path, false);
 	default:
 		mntput(newmnt);
 		break;
diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 0fffe1c..eb67953 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -229,19 +229,6 @@ int autofs4_wait(struct autofs_sb_info *,struct dentry *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
 
-static inline int autofs4_follow_mount(struct path *path)
-{
-	int res = 0;
-
-	while (d_mountpoint(path->dentry)) {
-		int followed = follow_down(path);
-		if (!followed)
-			break;
-		res = 1;
-	}
-	return res;
-}
-
 static inline u32 autofs4_get_dev(struct autofs_sb_info *sbi)
 {
 	return new_encode_dev(sbi->sb->s_dev);
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index eff9a41..1442da4 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -551,7 +551,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 		err = have_submounts(path.dentry);
 
-		if (follow_down(&path))
+		if (follow_down_one(&path))
 			magic = path.mnt->mnt_sb->s_magic;
 	}
 
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index cc1d013..6a930b9 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -56,7 +56,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 
 	path_get(&path);
 
-	if (!follow_down(&path))
+	if (!follow_down_one(&path))
 		goto done;
 
 	if (is_autofs4_dentry(path.dentry)) {
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 651e4ef..2022563 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -234,7 +234,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 		nd->flags);
 	/*
 	 * For an expire of a covered direct or offset mount we need
-	 * to break out of follow_down() at the autofs mount trigger
+	 * to break out of follow_down_one() at the autofs mount trigger
 	 * (d_mounted--), so we can see the expiring flag, and manage
 	 * the blocking and following here until the expire is completed.
 	 */
@@ -243,7 +243,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 		if (ino->flags & AUTOFS_INF_EXPIRING) {
 			spin_unlock(&sbi->fs_lock);
 			/* Follow down to our covering mount. */
-			if (!follow_down(&nd->path))
+			if (!follow_down_one(&nd->path))
 				goto done;
 			goto follow;
 		}
@@ -292,11 +292,10 @@ follow:
 	 * multi-mount with no root offset so we don't need
 	 * to follow it.
 	 */
-	if (d_mountpoint(dentry)) {
-		if (!autofs4_follow_mount(&nd->path)) {
-			status = -ENOENT;
+	if (d_managed(dentry)) {
+		status = follow_down(&nd->path, false);
+		if (status < 0)
 			goto out_error;
-		}
 	}
 
 done:
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index c68a056..83479cf 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -273,10 +273,7 @@ static int add_mount_helper(struct vfsmount *newmnt, struct nameidata *nd,
 		break;
 	case -EBUSY:
 		/* someone else made a mount here whilst we were busy */
-		while (d_mountpoint(nd->path.dentry) &&
-		       follow_down(&nd->path))
-			;
-		err = 0;
+		err = follow_down(&nd->path, false);
 	default:
 		mntput(newmnt);
 		break;
diff --git a/fs/namei.c b/fs/namei.c
index f55c11a..e46a56b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -941,6 +941,7 @@ static int follow_automount(struct path *path, unsigned flags,
 
 /*
  * Handle a dentry that is managed in some way.
+ * - Flagged for transit management (autofs)
  * - Flagged as mountpoint
  * - Flagged as automount point
  *
@@ -960,6 +961,16 @@ static int follow_managed(struct path *path, unsigned flags)
 	while (managed = ACCESS_ONCE(path->dentry->d_flags),
 	       managed &= DCACHE_MANAGED_DENTRY,
 	       unlikely(managed != 0)) {
+		/* Allow the filesystem to manage the transit without i_mutex
+		 * being held. */
+		if (managed & DCACHE_MANAGE_TRANSIT) {
+			BUG_ON(!path->dentry->d_op);
+			BUG_ON(!path->dentry->d_op->d_manage);
+			ret = path->dentry->d_op->d_manage(path, false);
+			if (ret < 0)
+				return ret == -EISDIR ? 0 : ret;
+		}
+
 		/* Transit to a mounted filesystem. */
 		if (managed & DCACHE_MOUNTED) {
 			struct vfsmount *mounted = lookup_mnt(path);
@@ -993,7 +1004,7 @@ static int follow_managed(struct path *path, unsigned flags)
 	return 0;
 }
 
-int follow_down(struct path *path)
+int follow_down_one(struct path *path)
 {
 	struct vfsmount *mounted;
 
@@ -1010,14 +1021,19 @@ int follow_down(struct path *path)
 
 /*
  * Skip to top of mountpoint pile in rcuwalk mode.  We abort the rcu-walk if we
- * meet an automount point and we're not walking to "..".  True is returned to
+ * meet a managed dentry and we're not walking to "..".  True is returned to
  * continue, false to abort.
  */
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 			       struct inode **inode, bool reverse_transit)
 {
+	unsigned abort_mask =
+		reverse_transit ? 0 : DCACHE_MANAGE_TRANSIT;
+
 	while (d_mountpoint(path->dentry)) {
 		struct vfsmount *mounted;
+		if (path->dentry->d_flags & abort_mask)
+			return true;
 		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
 		if (!mounted)
 			break;
@@ -1068,6 +1084,57 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 }
 
 /*
+ * Follow down to the covering mount currently visible to userspace.  At each
+ * point, the filesystem owning that dentry may be queried as to whether the
+ * caller is permitted to proceed or not.
+ *
+ * Care must be taken as namespace_sem may be held (indicated by mounting_here
+ * being true).
+ */
+int follow_down(struct path *path, bool mounting_here)
+{
+	unsigned managed;
+	int ret;
+
+	while (managed = ACCESS_ONCE(path->dentry->d_flags),
+	       unlikely(managed & DCACHE_MANAGED_DENTRY)) {
+		/* Allow the filesystem to manage the transit without i_mutex
+		 * being held.
+		 *
+		 * We indicate to the filesystem if someone is trying to mount
+		 * something here.  This gives autofs the chance to deny anyone
+		 * other than its daemon the right to mount on its
+		 * superstructure.
+		 *
+		 * The filesystem may sleep at this point.
+		 */
+		if (managed & DCACHE_MANAGE_TRANSIT) {
+			BUG_ON(!path->dentry->d_op);
+			BUG_ON(!path->dentry->d_op->d_manage);
+			ret = path->dentry->d_op->d_manage(path, mounting_here);
+			if (ret < 0)
+				return ret == -EISDIR ? 0 : ret;
+		}
+
+		/* Transit to a mounted filesystem. */
+		if (managed & DCACHE_MOUNTED) {
+			struct vfsmount *mounted = lookup_mnt(path);
+			if (!mounted)
+				break;
+			dput(path->dentry);
+			mntput(path->mnt);
+			path->mnt = mounted;
+			path->dentry = dget(mounted->mnt_root);
+			continue;
+		}
+
+		/* Don't handle automount points here */
+		break;
+	}
+	return 0;
+}
+
+/*
  * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
  */
 static void follow_mount(struct path *path)
@@ -3504,6 +3571,7 @@ const struct inode_operations page_symlink_inode_operations = {
 };
 
 EXPORT_SYMBOL(user_path_at);
+EXPORT_SYMBOL(follow_down_one);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
diff --git a/fs/namespace.c b/fs/namespace.c
index 3ddfd90..d94ccd6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1844,9 +1844,10 @@ static int do_move_mount(struct path *path, char *old_name)
 		return err;
 
 	down_write(&namespace_sem);
-	while (d_mountpoint(path->dentry) &&
-	       follow_down(path))
-		;
+	err = follow_down(path, true);
+	if (err < 0)
+		goto out;
+
 	err = -EINVAL;
 	if (!check_mnt(path->mnt) || !check_mnt(old_path.mnt))
 		goto out;
@@ -1940,9 +1941,10 @@ int do_add_mount(struct vfsmount *newmnt, struct path *path,
 
 	down_write(&namespace_sem);
 	/* Something was mounted here while we slept */
-	while (d_mountpoint(path->dentry) &&
-	       follow_down(path))
-		;
+	err = follow_down(path, true);
+	if (err < 0)
+		goto unlock;
+
 	err = -EINVAL;
 	if (!(mnt_flags & MNT_SHRINKABLE) && !check_mnt(path->mnt))
 		goto unlock;
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 74aaf39..bfcb933 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -176,10 +176,7 @@ out_err:
 	path_put(&nd->path);
 	goto out;
 out_follow:
-	while (d_mountpoint(nd->path.dentry) &&
-	       follow_down(&nd->path))
-		;
-	err = 0;
+	err = follow_down(&nd->path, false);
 	goto out;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3a35902..4f3f9d9 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -88,8 +88,9 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 			    .dentry = dget(dentry)};
 	int err = 0;
 
-	while (d_mountpoint(path.dentry) && follow_down(&path))
-		;
+	err = follow_down(&path, false);
+	if (err < 0)
+		goto out;
 
 	exp2 = rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ee6c26d..946521d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -168,6 +168,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
+	int (*d_manage)(struct path *, bool);
 } ____cacheline_aligned;
 
 /*
@@ -214,8 +215,9 @@ struct dentry_operations {
 
 #define DCACHE_MOUNTED		0x10000	/* is a mountpoint */
 #define DCACHE_NEED_AUTOMOUNT	0x20000	/* handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT	0x40000	/* manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
-	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT)
+	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
 extern seqlock_t rename_lock;
 
@@ -404,7 +406,12 @@ static inline void dont_mount(struct dentry *dentry)
 
 extern void dput(struct dentry *);
 
-static inline int d_mountpoint(struct dentry *dentry)
+static inline bool d_managed(struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_MANAGED_DENTRY;
+}
+
+static inline bool d_mountpoint(struct dentry *dentry)
 {
 	return dentry->d_flags & DCACHE_MOUNTED;
 }
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 18d06ad..8ef2c78 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -79,7 +79,8 @@ extern struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry
 
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 
-extern int follow_down(struct path *);
+extern int follow_down_one(struct path *);
+extern int follow_down(struct path *, bool);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);

