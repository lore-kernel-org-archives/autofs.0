From: David Howells <dhowells@redhat.com>
Subject: [PATCH] autofs4: Merge the remaining dentry ops tables
Date: Sat, 15 Jan 2011 10:51:57 +0000
Message-ID: <20110115105156.26397.56719.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net, viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, autofs@linux.kernel.org

Merge the remaining autofs4 dentry ops tables.  It doesn't matter if
d_automount and d_manage are present on something that's not mountable or
holdable as these ops are only used if the appropriate flags are set in
dentry->d_flags.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/autofs_i.h |    1 -
 fs/autofs4/inode.c    |    4 +---
 fs/autofs4/root.c     |   13 ++-----------
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index c28085c..1f016bf 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -207,7 +207,6 @@ extern const struct inode_operations autofs4_dir_inode_operations;
 extern const struct file_operations autofs4_dir_operations;
 extern const struct file_operations autofs4_root_operations;
 extern const struct dentry_operations autofs4_dentry_operations;
-extern const struct dentry_operations autofs4_mount_dentry_operations;
 
 /* VFS automount flags management functions */
 
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 3ecd2e2..2e80cf0 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -304,10 +304,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_dput;
 	}
 
-	if (autofs_type_trigger(sbi->type)) {
-		d_set_d_op(root, &autofs4_mount_dentry_operations);
+	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
-	}
 
 	root_inode->i_fop = &autofs4_root_operations;
 	root_inode->i_op = &autofs4_dir_inode_operations;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index dbd9551..0db9d53 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -66,13 +66,7 @@ const struct inode_operations autofs4_dir_inode_operations = {
 	.rmdir		= autofs4_dir_rmdir,
 };
 
-/* For dentries that don't initiate mounting */
 const struct dentry_operations autofs4_dentry_operations = {
-	.d_release	= autofs4_dentry_release,
-};
-
-/* For dentries that do initiate mounting */
-const struct dentry_operations autofs4_mount_dentry_operations = {
 	.d_automount	= autofs4_d_automount,
 	.d_manage	= autofs4_d_manage,
 	.d_release	= autofs4_dentry_release,
@@ -512,10 +506,8 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 			return ERR_PTR(-ENOENT);
 
 		/* Mark entries in the root as mount triggers */
-		if (autofs_type_indirect(sbi->type) && IS_ROOT(dentry->d_parent)) {
-			d_set_d_op(dentry, &autofs4_mount_dentry_operations);
+		if (autofs_type_indirect(sbi->type) && IS_ROOT(dentry->d_parent))
 			__managed_dentry_set_managed(dentry);
-		}
 
 		ino = autofs4_init_ino(NULL, sbi, 0555);
 		if (!ino)
@@ -848,8 +840,7 @@ static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
 int is_autofs4_dentry(struct dentry *dentry)
 {
 	return dentry && dentry->d_inode &&
-		(dentry->d_op == &autofs4_mount_dentry_operations ||
-		 dentry->d_op == &autofs4_dentry_operations) &&
+		dentry->d_op == &autofs4_dentry_operations &&
 		dentry->d_fsdata != NULL;
 }
