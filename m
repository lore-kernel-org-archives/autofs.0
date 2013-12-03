From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs: fix the return value of autofs4_fill_super
Date: Tue, 03 Dec 2013 13:11:36 +0800
Message-ID: <20131203051135.15048.28126.stgit@perseus.fritz.box>
References: <20131203050323.15048.52933.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=5syu/gQn2P2KsGGR96gnji0SbC4=; b=Mz0Ep0ay99oLlxkML5GhruBDHbK5
	JEXW5gW9axoleRq/Jd7a2fFvvXAPvq2RIoXpH0ke7Nw12owkbn6HUJG1WvzmftnX
	K7r8jXQaj4hH0LiD0zBbLozyzCUdYUumxXBlb6lfBtyljUTKHGUb3WQ7dixPyZGQ
	pN0X+d7mbddFs9Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=5syu/gQn2P2KsGGR96gnji
	0SbC4=; b=CXa0eqyDCw982e1KcHmA/O9purNjoxVJdQbVKtU9uQfBkhqKc596FF
	yF6KoRu9iuLblSmMjuE0ZfxqpvDWQnrRXnmvmuVIyertmx/cbk8N/CPi4ai/J2oH
	4EcuhJXKgLTy6vt6b0Zx2PZ5mTAxrqOXQUi34XOUrFBCD2tjHCw1M=
In-Reply-To: <20131203050323.15048.52933.stgit@perseus.fritz.box>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Rui Xiang <rui.xiang@huawei.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rui Xiang <rui.xiang@huawei.com>

While kzallocing sbi/ino fails, it should return -ENOMEM.

And it should return the err value from autofs_prepare_pipe.

Signed-off-by: Rui Xiang <rui.xiang@huawei.com>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 3b9cc9b..07d22c0 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -206,10 +206,11 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
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
@@ -243,8 +244,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
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
@@ -291,7 +294,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		printk("autofs: could not open pipe file descriptor\n");
 		goto fail_dput;
 	}
-	if (autofs_prepare_pipe(pipe) < 0)
+	ret = autofs_prepare_pipe(pipe);
+	if (ret < 0)
 		goto fail_fput;
 	sbi->pipe = pipe;
 	sbi->pipefd = pipefd;
@@ -318,8 +322,7 @@ fail_ino:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-fail_unlock:
-	return -EINVAL;
+	return ret;
 }
 
 struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)

