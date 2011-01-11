From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/18] Make follow_down() handle d_manage()
Date: Tue, 11 Jan 2011 17:48:52 +0000
Message-ID: <20110111174852.2291.45091.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

The previous patch (that adds d_manage()) offers autofs the opportunity to
block processes whilst it is rearranging its dentry tree, but only covers cases
where managed_dentry() is called.  Some places call follow_down(), which would
allow processes to bypass autofs's attempts to block them.

Make follow_down() handle managed dentries.  Do this by renaming follow_down()
to follow_down_one() and instituting a new follow_down().  follow_down_one() is
then only used where a call to d_manage() is not needed.

follow_down() then incorporates the loop from its remaining callers to follow
down through all mounted filesystems at that point.  Before each mountpoint is
transited and if requested by the filesystem, d_manage() is called to hold or
reject that transit.  The callers of follow_down() must then handle a possible
error condition.

follow_down() is given a parameter to say whether someone is trying to mount on
that point (and holding namespace_sem).  This is now passed on to d_manage().
The filesystem may reject this request by returning an error from d_manage().

Furthermore, d_manage() may end follow_down() processing early by returning
-EISDIR to indicate it wants the dentry to be dealt with as an ordinary
directory, not a mountpoint.  This permits autofs to let its daemon see the
underlying dentry.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 drivers/staging/autofs/dirhash.c |    5 +--
 fs/autofs4/autofs_i.h            |   13 ---------
 fs/autofs4/dev-ioctl.c           |    2 +
 fs/autofs4/expire.c              |    2 +
 fs/autofs4/root.c                |   11 +++----
 fs/namei.c                       |   58 ++++++++++++++++++++++++++++++++++++--
 fs/namespace.c                   |   14 +++++----
 fs/nfsd/vfs.c                    |    5 ++-
 include/linux/dcache.h           |    7 ++++-
 include/linux/namei.h            |    3 +-
 10 files changed, 83 insertions(+), 37 deletions(-)

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
diff --git a/fs/namei.c b/fs/namei.c
index 1e31f96..e2c5db2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -970,9 +970,9 @@ static int managed_dentry(struct path *path, unsigned flags)
 		if (managed & DCACHE_MANAGE_TRANSIT) {
 			BUG_ON(!path->dentry->d_op);
 			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(path);
+			ret = path->dentry->d_op->d_manage(path, false);
 			if (ret < 0)
-				return ret;
+				return ret == -EISDIR ? 0 : ret;
 		}
 
 		/* Transit to a mounted filesystem. */
@@ -1008,7 +1008,7 @@ static int managed_dentry(struct path *path, unsigned flags)
 	return 0;
 }
 
-int follow_down(struct path *path)
+int follow_down_one(struct path *path)
 {
 	struct vfsmount *mounted;
 
@@ -1086,6 +1086,57 @@ static int follow_dotdot_rcu(struct nameidata *nd)
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
@@ -3511,6 +3562,7 @@ const struct inode_operations page_symlink_inode_operations = {
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
index c6a4821..946521d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -168,7 +168,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct path *);
+	int (*d_manage)(struct path *, bool);
 } ____cacheline_aligned;
 
 /*
@@ -406,6 +406,11 @@ static inline void dont_mount(struct dentry *dentry)
 
 extern void dput(struct dentry *);
 
+static inline bool d_managed(struct dentry *dentry)
+{
+	return dentry->d_flags & DCACHE_MANAGED_DENTRY;
+}
+
 static inline bool d_mountpoint(struct dentry *dentry)
 {
 	return dentry->d_flags & DCACHE_MOUNTED;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a12d0d7..f276d4f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -81,7 +81,8 @@ extern struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry
 
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
 
-extern int follow_down(struct path *);
+extern int follow_down_one(struct path *);
+extern int follow_down(struct path *, bool);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);

