From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/3] autofs: fix the return value of autofs4_fill_super
Date: Wed, 04 Sep 2013 08:55:04 +0800
Message-ID: <20130904005503.5025.2712.stgit@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=aV1+u/KeMsL/BGpEfYM3edI5mJU=; b=RgjMFgsMNkSnYYVZVXfH3kqNJEBs
	SWPSHi+Z9WbkRaUBiR6UPv+r5NGmYmVDAlz6ELVNmdNPpbYzlUTZcqkGJubT0wfQ
	bY0gfHCz6y3XOMcPQQV4Kvmj27bE83CkEc93JQNrr+SY0+Z/X+jCSOsNMrTLZl4W
	Ns+YDzJYWXZ0BGM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=aV1+u/KeMsL/BGpEfYM3ed
	I5mJU=; b=XO5maOApQOn1Hv4jzCa2FuV8s1jaUy3SqQ+xBu1TUSECWVX3j0CJw0
	uyYxQBNB+oofDfqFZedidAhndh7Z5tHljGamRB4eJ6d9i7PorW2Qc2gcc839Av0+
	WXlUQErdiqxStBHVKVLxiCwIYmCCLtuoKan+nhjFcq3IkuXWgzTMc=
In-Reply-To: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>

From: Rui Xiang <rui.xiang@huawei.com>

While kzallocing sbi/ino fails, it should return -ENOMEM.

And it should return the err value from autofs_prepare_pipe.

Signed-off-by: Rui Xiang <rui.xiang@huawei.com>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |   13 ++++++++-----
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
