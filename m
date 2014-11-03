From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/13] autofs4 - fix some white space errors
Date: Mon, 03 Nov 2014 16:12:24 +0800
Message-ID: <20141103081224.6215.69417.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=8of1EGAidg+UTr9bi0wzXn3mq+w=; b=pccPDqJnBmdIiGZqBw
	KzWpoeIr3nML8pcyEgQP2VUioyVGfmupQpxOmSXj3qX9FeZ7KOhtm+7IZjVf7o+N
	vM6JlFiMxAegnrpki6Zh7ekNru7RXDVQnyupecGTnVo2ikMyq+kyywg8UJ68PV0A
	pM77phjT9tMUaJRdiG35cdz9Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=8of1EGAidg+UTr9bi0wzXn
	3mq+w=; b=F8uH1PJma82L+b3NEEntfTf7dnjzrvd6RVtMHuNcKS8R85hVQk+gwX
	Qng3WJoecfmvZ/5h6IjGNFgU0NkzLnQ8OEmYY9hM6k+mi0fdCV9WJK6cV1V5L90j
	51TOu6+oogmf9FZ54Ll30YonGZqvn3ImF1oP0es3maS19RFWHfs4U=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Fix some white space format errors.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c            |    2 +-
 fs/autofs4/root.c             |    8 ++++----
 fs/autofs4/waitq.c            |    2 +-
 include/uapi/linux/auto_fs.h  |    2 +-
 include/uapi/linux/auto_fs4.h |    2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index e855334..80389af 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -323,7 +323,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	 */
 	s->s_root = root;
 	return 0;
-	
+
 	/*
 	 * Failure ... clean up.
 	 */
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 373be98..7f3e182 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -624,7 +624,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
-	
+
 	/* This allows root to remove symlinks */
 	if (!autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -704,7 +704,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
-	
+
 	DPRINTK("dentry %p, removing %.*s",
 		dentry, dentry->d_name.len, dentry->d_name.name);
 
@@ -874,10 +874,10 @@ static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 	if (_IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT)
 		return -ENOTTY;
-	
+
 	if (!autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	
+
 	switch (cmd) {
 	case AUTOFS_IOC_READY:	/* Wait queue: go ahead and retry */
 		return autofs4_wait_release(sbi, (autofs_wqt_t) arg, 0);
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index a0b6a97..b7f2deb 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -86,7 +86,7 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 
 	return (bytes > 0);
 }
-	
+
 static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 				 struct autofs_wait_queue *wq,
 				 int type)
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 5fe176a..9175a1b 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -48,7 +48,7 @@ struct autofs_packet_hdr {
 
 struct autofs_packet_missing {
 	struct autofs_packet_hdr hdr;
-        autofs_wqt_t wait_queue_token;
+	autofs_wqt_t wait_queue_token;
 	int len;
 	char name[NAME_MAX+1];
 };	
diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 924fb1a..8f8f1bd 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -108,7 +108,7 @@ enum autofs_notify {
 /* v4 multi expire (via pipe) */
 struct autofs_packet_expire_multi {
 	struct autofs_packet_hdr hdr;
-        autofs_wqt_t wait_queue_token;
+	autofs_wqt_t wait_queue_token;
 	int len;
 	char name[NAME_MAX+1];
 };
