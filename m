From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 3/8] autofs4: Pushdown the bkl from ioctl
Date: Wed, 19 May 2010 19:24:10 +0200
Message-ID: <1274289855-10001-4-git-send-regression-fweisbec@gmail.com>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:x-mailer-version:in-reply-to:references;
        bh=YMtp/PzK/TJz2rtdlioDoNE/ZSfZw7xILySVo4ufTzE=;
        b=OMKmBynX+QT6vc73NVnbEiwL4dlorbXTcAICneCQ4XlGKSeabtYE5VfJraAHZYD5Ya
         Mq2uTMdw5p4Db+jD6Qv615c5DtGv+dFZWlOlBBJbJzd5SrWAiB2Fj0U+VpGfdydy9KVy
         eq5HzFzwTx848k5/c6T+ZK3Mq5o0UhSF0zGXs=
In-Reply-To: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ian Kent <raven@themaw.net>, Autofs <autofs@linux.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>

Pushdown the bkl to autofs4_root_ioctl.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ian Kent <raven@themaw.net>
Cc: Autofs <autofs@linux.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 fs/autofs4/root.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index e8e5e63..db4117e 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -18,13 +18,14 @@
 #include <linux/slab.h>
 #include <linux/param.h>
 #include <linux/time.h>
+#include <linux/smp_lock.h>
 #include "autofs_i.h"
 
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
-static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
+static long autofs4_root_ioctl(struct file *,unsigned int,unsigned long);
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static void *autofs4_follow_link(struct dentry *, struct nameidata *);
@@ -38,7 +39,7 @@ const struct file_operations autofs4_root_operations = {
 	.read		= generic_read_dir,
 	.readdir	= dcache_readdir,
 	.llseek		= dcache_dir_lseek,
-	.ioctl		= autofs4_root_ioctl,
+	.unlocked_ioctl	= autofs4_root_ioctl,
 };
 
 const struct file_operations autofs4_dir_operations = {
@@ -902,8 +903,8 @@ int is_autofs4_dentry(struct dentry *dentry)
  * ioctl()'s on the root directory is the chief method for the daemon to
  * generate kernel reactions
  */
-static int autofs4_root_ioctl(struct inode *inode, struct file *filp,
-			     unsigned int cmd, unsigned long arg)
+static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
+				       unsigned int cmd, unsigned long arg)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
 	void __user *p = (void __user *)arg;
@@ -947,3 +948,16 @@ static int autofs4_root_ioctl(struct inode *inode, struct file *filp,
 		return -ENOSYS;
 	}
 }
+
+static long autofs4_root_ioctl(struct file *filp,
+			       unsigned int cmd, unsigned long arg)
+{
+	long ret;
+	struct inode *inode = filp->f_dentry->d_inode;
+
+	lock_kernel();
+	ret = autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
+	unlock_kernel();
+
+	return ret;
+}
-- 
1.6.2.3
