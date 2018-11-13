From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/6] autofs - improve ioctl sbi checks
Date: Tue, 13 Nov 2018 09:35:57 +0800
Message-ID: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Al Viro made some suggestions to improve the implementation
of commit 0633da48f0 "fix autofs_sbi() does not check super
block type".

The check is unnessesary in all cases except for ioctl usage
so placing the check in the super block accessor function
adds a small overhead to the common case where it isn't
needed.

So it's sufficient to do this in the ioctl code only.

Also the check in the ioctl code is needlessly complex.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---
 fs/autofs/autofs_i.h  |    3 +--
 fs/autofs/dev-ioctl.c |   25 +++++++------------------
 fs/autofs/init.c      |    2 +-
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9f9cadbfbd7a..c4301e33c027 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -126,8 +126,7 @@ struct autofs_sb_info {
 
 static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
-	return sb->s_magic != AUTOFS_SUPER_MAGIC ?
-		NULL : (struct autofs_sb_info *)(sb->s_fs_info);
+	return (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 86eafda4a652..3de4f5e61caf 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -14,6 +14,8 @@
 
 #include "autofs_i.h"
 
+extern struct file_system_type autofs_fs_type;
+
 /*
  * This module implements an interface for routing autofs ioctl control
  * commands via a miscellaneous device file.
@@ -151,22 +153,6 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
 	return err;
 }
 
-/*
- * Get the autofs super block info struct from the file opened on
- * the autofs mount point.
- */
-static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
-{
-	struct autofs_sb_info *sbi = NULL;
-	struct inode *inode;
-
-	if (f) {
-		inode = file_inode(f);
-		sbi = autofs_sbi(inode->i_sb);
-	}
-	return sbi;
-}
-
 /* Return autofs dev ioctl version */
 static int autofs_dev_ioctl_version(struct file *fp,
 				    struct autofs_sb_info *sbi,
@@ -658,6 +644,8 @@ static int _autofs_dev_ioctl(unsigned int command,
 	if (cmd != AUTOFS_DEV_IOCTL_VERSION_CMD &&
 	    cmd != AUTOFS_DEV_IOCTL_OPENMOUNT_CMD &&
 	    cmd != AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD) {
+		struct super_block *sb;
+
 		fp = fget(param->ioctlfd);
 		if (!fp) {
 			if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
@@ -666,12 +654,13 @@ static int _autofs_dev_ioctl(unsigned int command,
 			goto out;
 		}
 
-		sbi = autofs_dev_ioctl_sbi(fp);
-		if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
+		sb = file_inode(fp)->i_sb;
+		if (sb->s_type != &autofs_fs_type) {
 			err = -EINVAL;
 			fput(fp);
 			goto out;
 		}
+		sbi = autofs_sbi(sb);
 
 		/*
 		 * Admin needs to be able to set the mount catatonic in
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index 79ae07d9592f..c0c1db2cc6ea 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -16,7 +16,7 @@ static struct dentry *autofs_mount(struct file_system_type *fs_type,
 	return mount_nodev(fs_type, flags, data, autofs_fill_super);
 }
 
-static struct file_system_type autofs_fs_type = {
+struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.mount		= autofs_mount,

