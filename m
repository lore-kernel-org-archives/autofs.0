From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs: use IS_ROOT to replace root dentry checks
Date: Tue, 03 Dec 2013 13:11:42 +0800
Message-ID: <20131203051141.15048.50495.stgit@perseus.fritz.box>
References: <20131203050323.15048.52933.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=gEDdliQT4sW/jW5PTpYPaHCRv2g=; b=a+zSmXP1i28S1WkrzI13iOWEpU3N
	10BvWif8u3jbgzg+lO38bEjCRVmY7OcxeDMcJWYqMdBOq5Ypl0WUrIBcBP4aup/S
	uhhDM8O6XbAPceoKtxPC4sU+90thaJu9pCsm+wNJLSE1ZUwZx8O3Qjauh+AOcMaW
	AiB1HsDaM9Gnlwg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=gEDdliQT4sW/jW5PTpYPaH
	CRv2g=; b=Hqln5G+J1xaatnAHRPTDq+PvKc57H9e81bEo+Dd25OHPS2nZ9iyZw8
	/sGx4khiF1gYl2jaHGi4/UuajoSOOkr4+qA7VVPnzbqA+TFUeMG0snCdJrBOk6yC
	KS4JjrhJ6IHskijQnyqJkIPzPSwikthOZ7qxR1ZhZFpSi1p7C5wrY=
In-Reply-To: <20131203050323.15048.52933.stgit@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Rui Xiang <rui.xiang@huawei.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Rui Xiang <rui.xiang@huawei.com>

Use the helper macro !IS_ROOT to replace parent != dentry->d_parent.
Just clean up.

Signed-off-by: Rui Xiang <rui.xiang@huawei.com>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 92ef341..2caf36a 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -558,7 +558,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 	dget(dentry);
 	atomic_inc(&ino->count);
 	p_ino = autofs4_dentry_ino(dentry->d_parent);
-	if (p_ino && dentry->d_parent != dentry)
+	if (p_ino && !IS_ROOT(dentry))
 		atomic_inc(&p_ino->count);
 
 	dir->i_mtime = CURRENT_TIME;
@@ -593,7 +593,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (atomic_dec_and_test(&ino->count)) {
 		p_ino = autofs4_dentry_ino(dentry->d_parent);
-		if (p_ino && dentry->d_parent != dentry)
+		if (p_ino && !IS_ROOT(dentry))
 			atomic_dec(&p_ino->count);
 	}
 	dput(ino->dentry);
@@ -732,7 +732,7 @@ static int autofs4_dir_mkdir(struct inode *dir, struct dentry *dentry, umode_t m
 	dget(dentry);
 	atomic_inc(&ino->count);
 	p_ino = autofs4_dentry_ino(dentry->d_parent);
-	if (p_ino && dentry->d_parent != dentry)
+	if (p_ino && !IS_ROOT(dentry))
 		atomic_inc(&p_ino->count);
 	inc_nlink(dir);
 	dir->i_mtime = CURRENT_TIME;
