From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 2/8] autofs: Pushdown the bkl from ioctl
Date: Wed, 19 May 2010 19:24:09 +0200
Message-ID: <1274289855-10001-3-git-send-regression-fweisbec@gmail.com>
References: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:x-mailer-version:in-reply-to:references;
        bh=uY+mJzDRM5Ag8apG1J+dHaaJ9oZHrpZCCciI06mP+fA=;
        b=nYFjI4NlVOfvCPczqPIryFOLG4mNAYsY6+WlHcAOvzR8eJ0kNj4UZdpVemMalrbD9D
         H6YVCrWFFrKyyCXu3bFiN39O71PnjOc253O8QoukF+IHVqKG+4yojbW3s0dUer4E/2qh
         YgWKx3ALhngL6J1esjpAYYRsFuhPf6sf1BmIc=
In-Reply-To: <1274289855-10001-1-git-send-regression-fweisbec@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Autofs <autofs@linux.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, John Kacur <jkacur@redhat.com>, Arnd Bergmann <arnd@arndb.de>

Pushdown the bkl to autofs_root_ioctl.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Autofs <autofs@linux.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Kacur <jkacur@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 fs/autofs/root.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 8713c7c..dc16b3c 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -25,12 +25,12 @@ static int autofs_root_symlink(struct inode *,struct dentry *,const char *);
 static int autofs_root_unlink(struct inode *,struct dentry *);
 static int autofs_root_rmdir(struct inode *,struct dentry *);
 static int autofs_root_mkdir(struct inode *,struct dentry *,int);
-static int autofs_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
+static long autofs_root_ioctl(struct file *, unsigned int, unsigned long);
 
 const struct file_operations autofs_root_operations = {
 	.read		= generic_read_dir,
 	.readdir	= autofs_root_readdir,
-	.ioctl		= autofs_root_ioctl,
+	.unlocked_ioctl	= autofs_root_ioctl,
 };
 
 const struct inode_operations autofs_root_inode_operations = {
@@ -545,7 +545,7 @@ static inline int autofs_expire_run(struct super_block *sb,
  * ioctl()'s on the root directory is the chief method for the daemon to
  * generate kernel reactions
  */
-static int autofs_root_ioctl(struct inode *inode, struct file *filp,
+static int autofs_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 			     unsigned int cmd, unsigned long arg)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
@@ -579,3 +579,16 @@ static int autofs_root_ioctl(struct inode *inode, struct file *filp,
 		return -ENOSYS;
 	}
 }
+
+static long autofs_root_ioctl(struct file *filp,
+			     unsigned int cmd, unsigned long arg)
+{
+	long ret;
+	struct inode *inode = filp->f_dentry->d_inode;
+
+	lock_kernel();
+	ret = autofs_root_ioctl_unlocked(inode, filp, cmd, arg);
+	unlock_kernel();
+
+	return ret;
+}
-- 
1.6.2.3
