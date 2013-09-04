From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/3] autofs: use IS_ROOT to replace root dentry checks
Date: Wed, 04 Sep 2013 08:55:11 +0800
Message-ID: <20130904005510.5025.56622.stgit@perseus.fritz.box>
References: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=gEDdliQT4sW/jW5PTpYPaHCRv2g=; b=u+kCjRaC4Rz8ZRyVvW5XBkAeGHpQ
	N+3dG8/cAhJQDTHWJQOjla8MgLEGNeoJiClDXeImm9795rhPx5bdIwluKiDt+fTS
	zBzCuTPjq2xeCXROKe3Vhs+vklju1hJam6rCP0Etsga8NZYySucFxFYdHGJB+G1Z
	gwkbACUZolx30LY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=gEDdliQT4sW/jW5PTpYPaH
	CRv2g=; b=Yxq6nHGlVe8VfiPmUw70juuAjH3v5rRSOnK33RDWMqHKg3hqz1i2Ix
	DHwzrvdV04+PM/gt8fVw5mYhxUjTYs6DDkgkvd2wZZkRpRG4/ywSp4+jsWfRm1mQ
	1gTIxTaIr1IBWbmOhBllg+/gcryuacoAwe1KtRPCk/RYIGU9ZfQTs=
In-Reply-To: <20130904005456.5025.94309.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, rui.xiang@huawei.com, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>

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

