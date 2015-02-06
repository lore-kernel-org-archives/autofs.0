From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] autofs4: Wrong format for printing dentry
Date: Fri,  6 Feb 2015 16:28:17 +0100
Message-ID: <1423236497-28139-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cgRx3Y7rD57SFg2aUeRC/HWyyLrHb2fVXpx/pi0dTbU=;
        b=c12j9F+CcVQBcRfLfDCbk/Illyd+omY+1rJiP3zCJZmbfoiF62FhDOqfY1HACdDnyH
         lgapiLQIzMsGI/Yk/tB4Nz5dOQukDjw4wl5gxrj7FEuBj7xMZGX/wAmsjslAow9NzpdS
         1MeHch7XNvMtYRcA8pN1ZhfzKRz9QSJUB5ifc=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

%pD for struct file*, %pd for struct dentry*.

Fixes: a455589f181e ("assorted conversions to %p[dD]")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/autofs4/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index dbb5b7212ce1..7ba355b8d4ac 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -108,7 +108,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
-	DPRINTK("file=%p dentry=%p %pD", file, dentry, dentry);
+	DPRINTK("file=%p dentry=%p %pd", file, dentry, dentry);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
-- 
2.1.3

