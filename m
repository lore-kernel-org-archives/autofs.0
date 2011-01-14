From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/18] Unexport do_add_mount() and add in follow_automount(), not ->d_automount()
Date: Fri, 14 Jan 2011 17:26:09 +0000
Message-ID: <6672.1295025969@redhat.com>
References: <20110114154652.GD19804@ZenIV.linux.org.uk> <20110114070224.GB19804@ZenIV.linux.org.uk> <20110113215359.19406.37232.stgit@warthog.procyon.org.uk> <2443.1295005428@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110114154652.GD19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: dhowells@redhat.com, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org


Unexport do_add_mount() and make ->d_automount() return the vfsmount to be
added rather than calling do_add_mount() itself.  follow_automount() will then
do the addition.

This slightly complicates things as ->d_automount() normally wants to add the
new vfsmount to an expiration list and start an expiration timer.  The problem
with that is that the vfsmount will be deleted if it has a refcount of 1 and
the timer will not repeat if the expiration list is empty.

To this end, we require the vfsmount to be returned from d_automount() with a
refcount of (at least) 2.  One of these refs will be dropped unconditionally.
In addition, follow_automount() must get a 3rd ref around the call to
do_add_mount() lest it eat a ref and return an error, leaving the mount we
have open to being expired as we would otherwise have only 1 ref on it.  This
would mean the currently upstream code is buggy for AFS, CIFS and NFS.

d_automount() should also add the the vfsmount to the expiration list (by
calling mnt_set_expiry()) and start the expiration timer before returning, if
this mechanism is to be used.  The vfsmount will be unlinked from the
expiration list by follow_automount() if do_add_mount() fails.

This patch also fixes the call to do_add_mount() for AFS and CIFS to propagate
the mount flags from the parent vfsmount.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/vfs.txt |   23 ++++++++++++--------
 fs/afs/mntpt.c                    |   25 +++++-----------------
 fs/cifs/cifs_dfs_ref.c            |   26 +++++------------------
 fs/internal.h                     |    2 ++
 fs/namei.c                        |   42 +++++++++++++++++++++++++++++++------
 fs/namespace.c                    |   41 +++++++++++++++++++++++++++++-------
 fs/nfs/namespace.c                |   24 ++++-----------------
 include/linux/mount.h             |    7 +-----
 8 files changed, 101 insertions(+), 89 deletions(-)


diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 3c4b2f1..94cf97b 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -933,15 +933,20 @@ struct dentry_operations {
 	dynamic_dname() helper function is provided to take care of this.
 
   d_automount: called when an automount dentry is to be traversed (optional).
-	This should create a new VFS mount record, mount it on the directory
-	and return the record to the caller.  The caller is supplied with a
-	path parameter giving the automount directory to describe the automount
-	target and the parent VFS mount record to provide inheritable mount
-	parameters.  NULL should be returned if someone else managed to make
-	the automount first.  If the automount failed, then an error code
-	should be returned.  If -EISDIR is returned, then the directory will
-	be treated as an ordinary directory and returned to pathwalk to
-	continue walking.
+	This should create a new VFS mount record and return the record to the
+	caller.  The caller is supplied with a path parameter giving the
+	automount directory to describe the automount target and the parent
+	VFS mount record to provide inheritable mount parameters.  NULL should
+	be returned if someone else managed to make the automount first.  If
+	the vfsmount creation failed, then an error code should be returned.
+	If -EISDIR is returned, then the directory will be treated as an
+	ordinary directory and returned to pathwalk to continue walking.
+
+	If a vfsmount is returned, the caller will attempt to mount it on the
+	mountpoint and will remove the vfsmount from its expiration list in
+	the case of failure.  The vfsmount should be returned with 2 refs on
+	it to prevent automatic expiration - the caller will clean up the
+	additional ref.
 
 	This function is only used if DCACHE_NEED_AUTOMOUNT is set on the
 	dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is set on the
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 0f7dd7a..0d74c2c 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -241,7 +241,6 @@ error_no_devname:
 struct vfsmount *afs_d_automount(struct path *path)
 {
 	struct vfsmount *newmnt;
-	int err;
 
 	_enter("{%s,%s}", path->mnt->mnt_devname, path->dentry->d_name.name);
 
@@ -249,24 +248,12 @@ struct vfsmount *afs_d_automount(struct path *path)
 	if (IS_ERR(newmnt))
 		return newmnt;
 
-	mntget(newmnt);
-	err = do_add_mount(newmnt, path, MNT_SHRINKABLE, &afs_vfsmounts);
-	switch (err) {
-	case 0:
-		schedule_delayed_work(&afs_mntpt_expiry_timer,
-				      afs_mntpt_expiry_timeout * HZ);
-		_leave(" = %p {%s}", newmnt, newmnt->mnt_devname);
-		return newmnt;
-	case -EBUSY:
-		/* someone else made a mount here whilst we were busy */
-		mntput(newmnt);
-		_leave(" = NULL [EBUSY]");
-		return NULL;
-	default:
-		mntput(newmnt);
-		_leave(" = %d", err);
-		return ERR_PTR(err);
-	}
+	mntget(newmnt); /* prevent immediate expiration */
+	mnt_set_expiry(newmnt, &afs_vfsmounts);
+	schedule_delayed_work(&afs_mntpt_expiry_timer,
+			      afs_mntpt_expiry_timeout * HZ);
+	_leave(" = %p {%s}", newmnt, newmnt->mnt_devname);
+	return newmnt;
 }
 
 /*
diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index ddd0b3e..7ed3653 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -351,7 +351,6 @@ free_xid:
 struct vfsmount *cifs_dfs_d_automount(struct path *path)
 {
 	struct vfsmount *newmnt;
-	int err;
 
 	cFYI(1, "in %s", __func__);
 
@@ -361,25 +360,12 @@ struct vfsmount *cifs_dfs_d_automount(struct path *path)
 		return newmnt;
 	}
 
-	mntget(newmnt);
-	err = do_add_mount(newmnt, path, MNT_SHRINKABLE,
-			   &cifs_dfs_automount_list);
-	switch (err) {
-	case 0:
-		schedule_delayed_work(&cifs_dfs_automount_task,
-				      cifs_dfs_mountpoint_expiry_timeout);
-		cFYI(1, "leaving %s [ok]" , __func__);
-		return newmnt;
-	case -EBUSY:
-		/* someone else made a mount here whilst we were busy */
-		mntput(newmnt);
-		cFYI(1, "leaving %s [EBUSY]" , __func__);
-		return NULL;
-	default:
-		mntput(newmnt);
-		cFYI(1, "leaving %s [error %d]" , __func__, err);
-		return ERR_PTR(err);
-	}
+	mntget(newmnt); /* prevent immediate expiration */
+	mnt_set_expiry(newmnt, &cifs_dfs_automount_list);
+	schedule_delayed_work(&cifs_dfs_automount_task,
+			      cifs_dfs_mountpoint_expiry_timeout);
+	cFYI(1, "leaving %s [ok]" , __func__);
+	return newmnt;
 }
 
 const struct inode_operations cifs_dfs_referral_inode_operations = {
diff --git a/fs/internal.h b/fs/internal.h
index 9687c2e..4931060 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -70,6 +70,8 @@ extern void mnt_set_mountpoint(struct vfsmount *, struct dentry *,
 extern void release_mounts(struct list_head *);
 extern void umount_tree(struct vfsmount *, int, struct list_head *);
 extern struct vfsmount *copy_tree(struct vfsmount *, struct dentry *, int);
+extern int do_add_mount(struct vfsmount *, struct path *, int);
+extern void mnt_clear_expiry(struct vfsmount *);
 
 extern void __init mnt_init(void);
 
diff --git a/fs/namei.c b/fs/namei.c
index b099541..cd7b7e4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -898,6 +898,7 @@ static int follow_automount(struct path *path, unsigned flags,
 			    bool *need_mntput)
 {
 	struct vfsmount *mnt;
+	int err;
 
 	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
 		return -EREMOTE;
@@ -940,22 +941,49 @@ static int follow_automount(struct path *path, unsigned flags,
 			return -EREMOTE;
 		return PTR_ERR(mnt);
 	}
+
 	if (!mnt) /* mount collision */
 		return 0;
 
+	/* The new mount record should have at least 2 refs to prevent it being
+	 * expired before we get a chance to add it
+	 */
+	BUG_ON(mnt_get_count(mnt) < 2);
+
 	if (mnt->mnt_sb == path->mnt->mnt_sb &&
 	    mnt->mnt_root == path->dentry) {
+		mnt_clear_expiry(mnt);
+		mntput(mnt);
 		mntput(mnt);
 		return -ELOOP;
 	}
 
-	dput(path->dentry);
-	if (*need_mntput)
-		mntput(path->mnt);
-	path->mnt = mnt;
-	path->dentry = dget(mnt->mnt_root);
-	*need_mntput = true;
-	return 0;
+	/* We need to add the mountpoint to the parent.  The filesystem may
+	 * have placed it on an expiry list, and so we need to make sure it
+	 * won't be expired under us if do_add_mount() fails (do_add_mount()
+	 * will eat a reference unconditionally).
+	 */
+	mntget(mnt);
+	err = do_add_mount(mnt, path, path->mnt->mnt_flags | MNT_SHRINKABLE);
+	switch (err) {
+	case -EBUSY:
+		/* Someone else made a mount here whilst we were busy */
+		err = 0;
+	default:
+		mnt_clear_expiry(mnt);
+		mntput(mnt);
+		mntput(mnt);
+		return err;
+	case 0:
+		mntput(mnt);
+		dput(path->dentry);
+		if (*need_mntput)
+			mntput(path->mnt);
+		path->mnt = mnt;
+		path->dentry = dget(mnt->mnt_root);
+		*need_mntput = true;
+		return 0;
+	}
 }
 
 /*
diff --git a/fs/namespace.c b/fs/namespace.c
index d94ccd6..bfcb701 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1925,15 +1925,14 @@ static int do_new_mount(struct path *path, char *type, int flags,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	return do_add_mount(mnt, path, mnt_flags, NULL);
+	return do_add_mount(mnt, path, mnt_flags);
 }
 
 /*
  * add a mount into a namespace's mount tree
- * - provide the option of adding the new mount to an expiration list
+ * - this unconditionally eats one of the caller's references to newmnt.
  */
-int do_add_mount(struct vfsmount *newmnt, struct path *path,
-		 int mnt_flags, struct list_head *fslist)
+int do_add_mount(struct vfsmount *newmnt, struct path *path, int mnt_flags)
 {
 	int err;
 
@@ -1963,9 +1962,6 @@ int do_add_mount(struct vfsmount *newmnt, struct path *path,
 	if ((err = graft_tree(newmnt, path)))
 		goto unlock;
 
-	if (fslist) /* add to the specified expiration list */
-		list_add_tail(&newmnt->mnt_expire, fslist);
-
 	up_write(&namespace_sem);
 	return 0;
 
@@ -1975,7 +1971,36 @@ unlock:
 	return err;
 }
 
-EXPORT_SYMBOL_GPL(do_add_mount);
+/**
+ * mnt_set_expiry - Put a mount on an expiration list
+ * @mnt: The mount to list.
+ * @expiry_list: The list to add the mount to.
+ */
+void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
+{
+	down_write(&namespace_sem);
+	br_write_lock(vfsmount_lock);
+
+	list_add_tail(&mnt->mnt_expire, expiry_list);
+
+	br_write_unlock(vfsmount_lock);
+	up_write(&namespace_sem);
+}
+EXPORT_SYMBOL(mnt_set_expiry);
+
+/*
+ * Remove a vfsmount from any expiration list it may be on
+ */
+void mnt_clear_expiry(struct vfsmount *mnt)
+{
+	if (!list_empty(&mnt->mnt_expire)) {
+		down_write(&namespace_sem);
+		br_write_lock(vfsmount_lock);
+		list_del_init(&mnt->mnt_expire);
+		br_write_unlock(vfsmount_lock);
+		up_write(&namespace_sem);
+	}
+}
 
 /*
  * process a list of expirable mountpoints with the intent of discarding any
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index f3fbb1b..f32b860 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -149,26 +149,10 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (IS_ERR(mnt))
 		goto out;
 
-	mntget(mnt);
-	err = do_add_mount(mnt, path, path->mnt->mnt_flags | MNT_SHRINKABLE,
-			   &nfs_automount_list);
-	switch (err) {
-	case 0:
-		dprintk("%s: done, success\n", __func__);
-		schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
-		break;
-	case -EBUSY:
-		/* someone else made a mount here whilst we were busy */
-		mntput(mnt);
-		dprintk("%s: done, collision\n", __func__);
-		mnt = NULL;
-		break;
-	default:
-		mntput(mnt);
-		dprintk("%s: done, error %d\n", __func__, err);
-		mnt = ERR_PTR(err);
-		break;
-	}
+	dprintk("%s: done, success\n", __func__);
+	mntget(mnt); /* prevent immediate expiration */
+	mnt_set_expiry(mnt, &nfs_automount_list);
+	schedule_delayed_work(&nfs_automount_task, nfs_mountpoint_expiry_timeout);
 
 out:
 	nfs_free_fattr(fattr);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1869ea2..af4765e 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -110,12 +110,7 @@ extern struct vfsmount *vfs_kern_mount(struct file_system_type *type,
 				      int flags, const char *name,
 				      void *data);
 
-struct nameidata;
-
-struct path;
-extern int do_add_mount(struct vfsmount *newmnt, struct path *path,
-			int mnt_flags, struct list_head *fslist);
-
+extern void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list);
 extern void mark_mounts_for_expiry(struct list_head *mounts);
 
 extern dev_t name_to_dev_t(char *name);
