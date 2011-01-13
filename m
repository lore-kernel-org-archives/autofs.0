From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/18] autofs4: Clean up dentry operations [ver #4]
Date: Thu, 13 Jan 2011 21:55:04 +0000
Message-ID: <20110113215504.19406.97718.stgit@warthog.procyon.org.uk>
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

From: Ian Kent <raven@themaw.net>

There are now two distinct dentry operations uses. One for dentrys
that trigger mounts and one for dentrys that do not.

Rationalize the use of these dentry operations and rename them to
reflect their function.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/autofs_i.h |    7 ++-----
 fs/autofs4/inode.c    |   12 ++++--------
 fs/autofs4/root.c     |   36 ++++++++++++++++++++----------------
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index c3b0afe..c28085c 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -206,11 +206,8 @@ extern const struct inode_operations autofs4_symlink_inode_operations;
 extern const struct inode_operations autofs4_dir_inode_operations;
 extern const struct file_operations autofs4_dir_operations;
 extern const struct file_operations autofs4_root_operations;
-
-/* Operations methods */
-
-struct vfsmount *autofs4_d_automount(struct path *);
-int autofs4_d_manage(struct path *, bool);
+extern const struct dentry_operations autofs4_dentry_operations;
+extern const struct dentry_operations autofs4_mount_dentry_operations;
 
 /* VFS automount flags management functions */
 
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index dac3dc7..427c357 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -251,12 +251,6 @@ static struct autofs_info *autofs4_mkroot(struct autofs_sb_info *sbi)
 	return ino;
 }
 
-static const struct dentry_operations autofs4_sb_dentry_operations = {
-	.d_automount	= autofs4_d_automount,
-	.d_manage	= autofs4_d_manage,
-	.d_release      = autofs4_dentry_release,
-};
-
 int autofs4_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
@@ -311,7 +305,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_iput;
 	pipe = NULL;
 
-	d_set_d_op(root, &autofs4_sb_dentry_operations);
+	d_set_d_op(root, &autofs4_dentry_operations);
 	root->d_fsdata = ino;
 
 	/* Can this call block? */
@@ -322,8 +316,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_dput;
 	}
 
-	if (autofs_type_trigger(sbi->type))
+	if (autofs_type_trigger(sbi->type)) {
+		d_set_d_op(root, &autofs4_mount_dentry_operations);
 		__managed_dentry_set_managed(root);
+	}
 
 	root_inode->i_fop = &autofs4_root_operations;
 	root_inode->i_op = &autofs4_dir_inode_operations;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index ab391d4..b3ab9e9 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -35,6 +35,8 @@ static long autofs4_root_compat_ioctl(struct file *,unsigned int,unsigned long);
 #endif
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
+static struct vfsmount *autofs4_d_automount(struct path *);
+static int autofs4_d_manage(struct path *, bool);
 
 const struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -64,6 +66,18 @@ const struct inode_operations autofs4_dir_inode_operations = {
 	.rmdir		= autofs4_dir_rmdir,
 };
 
+/* For dentries that don't initiate mounting */
+const struct dentry_operations autofs4_dentry_operations = {
+	.d_release	= autofs4_dentry_release,
+};
+
+/* For dentries that do initiate mounting */
+const struct dentry_operations autofs4_mount_dentry_operations = {
+	.d_automount	= autofs4_d_automount,
+	.d_manage	= autofs4_d_manage,
+	.d_release	= autofs4_dentry_release,
+};
+
 static void autofs4_add_active(struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
@@ -158,18 +172,6 @@ void autofs4_dentry_release(struct dentry *de)
 	}
 }
 
-/* For dentries of directories in the root dir */
-static const struct dentry_operations autofs4_root_dentry_operations = {
-	.d_release	= autofs4_dentry_release,
-};
-
-/* For other dentries */
-static const struct dentry_operations autofs4_dentry_operations = {
-	.d_automount	= autofs4_d_automount,
-	.d_manage	= autofs4_d_manage,
-	.d_release	= autofs4_dentry_release,
-};
-
 static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
@@ -337,7 +339,7 @@ static struct dentry *autofs4_mountpoint_changed(struct path *path)
 	return path->dentry;
 }
 
-struct vfsmount *autofs4_d_automount(struct path *path)
+static struct vfsmount *autofs4_d_automount(struct path *path)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
@@ -506,7 +508,7 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 	if (active) {
 		return active;
 	} else {
-		d_set_d_op(dentry, &autofs4_root_dentry_operations);
+		d_set_d_op(dentry, &autofs4_dentry_operations);
 
 		/*
 		 * A dentry that is not within the root can never trigger a
@@ -519,7 +521,7 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 
 		/* Mark entries in the root as mount triggers */
 		if (autofs_type_indirect(sbi->type) && IS_ROOT(dentry->d_parent)) {
-			d_set_d_op(dentry, &autofs4_dentry_operations);
+			d_set_d_op(dentry, &autofs4_mount_dentry_operations);
 			__managed_dentry_set_managed(dentry);
 		}
 
@@ -578,6 +580,8 @@ static int autofs4_dir_symlink(struct inode *dir,
 	}
 	d_add(dentry, inode);
 
+	d_set_d_op(dentry, &autofs4_dentry_operations);
+
 	dentry->d_fsdata = ino;
 	ino->dentry = dget(dentry);
 	atomic_inc(&ino->count);
@@ -796,7 +800,7 @@ static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
 int is_autofs4_dentry(struct dentry *dentry)
 {
 	return dentry && dentry->d_inode &&
-		(dentry->d_op == &autofs4_root_dentry_operations ||
+		(dentry->d_op == &autofs4_mount_dentry_operations ||
 		 dentry->d_op == &autofs4_dentry_operations) &&
 		dentry->d_fsdata != NULL;
 }

