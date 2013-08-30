From: Rui Xiang <rui.xiang@huawei.com>
Subject: [PATCH 1/2] autofs: fix the return value of autofs4_fill_super
Date: Fri, 30 Aug 2013 15:22:17 +0800
Message-ID: <1377847338-51032-1-git-send-email-rui.xiang@huawei.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Rui Xiang <rui.xiang@huawei.com>

While kzallocing sbi/ino fails, it should return -ENOMEM.

And it should return the err value from autofs_prepare_pipe.

Signed-off-by: Rui Xiang <rui.xiang@huawei.com>
---
 fs/autofs4/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index b104726..fe390ed 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -211,10 +211,11 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
+	int ret = -EINVAL;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		goto fail_unlock;
+		return -ENOMEM;
 	DPRINTK("starting up, sbi = %p",sbi);
 
 	s->s_fs_info = sbi;
@@ -248,8 +249,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
 	ino = autofs4_new_ino(sbi);
-	if (!ino)
+	if (!ino) {
+		ret = -ENOMEM;
 		goto fail_free;
+	}
 	root_inode = autofs4_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
 	if (!root)
@@ -296,7 +299,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		printk("autofs: could not open pipe file descriptor\n");
 		goto fail_dput;
 	}
-	if (autofs_prepare_pipe(pipe) < 0)
+	ret = autofs_prepare_pipe(pipe);
+	if (ret < 0)
 		goto fail_fput;
 	sbi->pipe = pipe;
 	sbi->pipefd = pipefd;
@@ -323,8 +327,7 @@ fail_ino:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-fail_unlock:
-	return -EINVAL;
+	return ret;
 }
 
 struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
-- 
1.8.2.2

