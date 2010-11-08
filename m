From: Atul Sowani <sowani@gmail.com>
Subject: Subject: [PATCH 2.6.36 1/1] autofs4: fix for root.c compiler warnings.
Date: Mon, 08 Nov 2010 21:29:58 +0530
Message-ID: <4CD81E7E.20308@gmail.com>
Reply-To: sowani@gmail.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=jyQQLmehRrNrEw9qPqcMS5MxeuivKkAfn8OD5LTvIAo=;
        b=oUjprDRLjy2oeoc0EZo3w3qm3Kz3W/7WbgWfk0xJPPNt2rLFNeyoDfTNUMLJVaiFzE
         J7DDG8J8KKA7g1a7U42nmzj1KWyZ9Y9XuR+oJdRrlJ6OWEsgP0x2M7iqv+ZVXeC0C3Oe
         jSgb2s4z9OUyRnpCPP1Yx1iGFdcP7Um/ZOGLs=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@zeniv.linux.org.uk
Cc: raven@themaw.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, linux-afs@lists.infradead.org

Added conditional compilation with CONFIG_COMPAT to avoid compiler warning:
fs/autofs4/root.c:31: warning: autofs4_root_compat_ioctl declared static but never defined

Signed-off-by: Atul Sowani <sowani@gmail.com>
---
diff -uprN a/fs/autofs4/root.c b/fs/autofs4/root.c
--- a/fs/autofs4/root.c	2010-10-21 02:00:22.000000000 +0530
+++ b/fs/autofs4/root.c	2010-11-08 09:37:47.675766134 +0530
@@ -28,7 +28,9 @@ static int autofs4_dir_unlink(struct ino
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static long autofs4_root_ioctl(struct file *,unsigned int,unsigned long);
+#ifdef CONFIG_COMPAT
 static long autofs4_root_compat_ioctl(struct file *,unsigned int,unsigned long);
+#endif
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static void *autofs4_follow_link(struct dentry *, struct nameidata *);
-- 
Atul Sowani (sowani@gmail.com)
http://savannah.gnu.org/users/atul
------------------------------------------------------------------------
