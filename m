From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - remove ioctl mutex (bz23142)
Date: Tue, 07 Dec 2010 13:04:00 +0800
Message-ID: <20101207050400.21567.73170.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, autofs mailing list <autofs@linux.kernel.org>

With the recent changes to remove the BKL a mutex was added to the
ioctl entry point for calls to the old ioctl interface. This mutex
needs to be removed because of the need for the expire ioctl to call
back to the daemon to perform a umount and receive a completion
status (via another ioctl).

This should be fine as the new ioctl interface uses much of the same
code and it has been used without a mutex for around a year without
issue, as was the original intention.

Ref: Bugzilla bug 23142

Signed-off-by: Ian Kent <raven@themaw.net>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---

 fs/autofs4/root.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index d5c1401..d34896c 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -980,19 +980,11 @@ static int autofs4_root_ioctl_unlocked(struct inode *inode, struct file *filp,
 	}
 }
 
-static DEFINE_MUTEX(autofs4_ioctl_mutex);
-
 static long autofs4_root_ioctl(struct file *filp,
 			       unsigned int cmd, unsigned long arg)
 {
-	long ret;
 	struct inode *inode = filp->f_dentry->d_inode;
-
-	mutex_lock(&autofs4_ioctl_mutex);
-	ret = autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
-	mutex_unlock(&autofs4_ioctl_mutex);
-
-	return ret;
+	return autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1002,13 +994,11 @@ static long autofs4_root_compat_ioctl(struct file *filp,
 	struct inode *inode = filp->f_path.dentry->d_inode;
 	int ret;
 
-	mutex_lock(&autofs4_ioctl_mutex);
 	if (cmd == AUTOFS_IOC_READY || cmd == AUTOFS_IOC_FAIL)
 		ret = autofs4_root_ioctl_unlocked(inode, filp, cmd, arg);
 	else
 		ret = autofs4_root_ioctl_unlocked(inode, filp, cmd,
 			(unsigned long)compat_ptr(arg));
-	mutex_unlock(&autofs4_ioctl_mutex);
 
 	return ret;
 }

