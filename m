From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/18] autofs4: Clean up inode operations [ver #4]
Date: Thu, 13 Jan 2011 21:54:59 +0000
Message-ID: <20110113215458.19406.72282.stgit@warthog.procyon.org.uk>
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

Since the use of ->follow_link() has been eliminated there is no
need to separate the indirect and direct inode operations.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/autofs_i.h |    3 ---
 fs/autofs4/inode.c    |    4 +---
 fs/autofs4/root.c     |   15 ---------------
 3 files changed, 1 insertions(+), 21 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 8b746f6..c3b0afe 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -204,9 +204,6 @@ void autofs_dev_ioctl_exit(void);
 
 extern const struct inode_operations autofs4_symlink_inode_operations;
 extern const struct inode_operations autofs4_dir_inode_operations;
-extern const struct inode_operations autofs4_root_inode_operations;
-extern const struct inode_operations autofs4_indirect_root_inode_operations;
-extern const struct inode_operations autofs4_direct_root_inode_operations;
 extern const struct file_operations autofs4_dir_operations;
 extern const struct file_operations autofs4_root_operations;
 
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 75c1ed8..dac3dc7 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -326,9 +326,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		__managed_dentry_set_managed(root);
 
 	root_inode->i_fop = &autofs4_root_operations;
-	root_inode->i_op = autofs_type_trigger(sbi->type) ?
-			&autofs4_direct_root_inode_operations :
-			&autofs4_indirect_root_inode_operations;
+	root_inode->i_op = &autofs4_dir_inode_operations;
 
 	/* Couldn't this be tested earlier? */
 	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 91db5dd..ab391d4 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -56,21 +56,6 @@ const struct file_operations autofs4_dir_operations = {
 	.llseek		= dcache_dir_lseek,
 };
 
-const struct inode_operations autofs4_indirect_root_inode_operations = {
-	.lookup		= autofs4_lookup,
-	.unlink		= autofs4_dir_unlink,
-	.symlink	= autofs4_dir_symlink,
-	.mkdir		= autofs4_dir_mkdir,
-	.rmdir		= autofs4_dir_rmdir,
-};
-
-const struct inode_operations autofs4_direct_root_inode_operations = {
-	.lookup		= autofs4_lookup,
-	.unlink		= autofs4_dir_unlink,
-	.mkdir		= autofs4_dir_mkdir,
-	.rmdir		= autofs4_dir_rmdir,
-};
-
 const struct inode_operations autofs4_dir_inode_operations = {
 	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,

