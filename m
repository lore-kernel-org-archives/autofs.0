From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/5] autofs: use unsigned int/long instead of uint/ulong for
 ioctl args
Date: Wed, 16 Aug 2017 10:31:37 +0800
Message-ID: <150285069709.4670.3884827966280147529.stgit@pluto.themaw.net>
References: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

The standard types unsigned int and unsigned long should be used for
.compat_ioctl. autofs is the only fs using uing/ulong for this, and
these are even the only uint/ulong in the entire autofs code.

Drop unneeded long cast in return value of autofs_dev_ioctl_compat().
It's already long.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index a990c9d0f893..b7c816f39404 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -93,7 +93,7 @@ static int check_dev_ioctl_version(int cmd, struct autofs_dev_ioctl *param)
  * at the end of the struct.
  */
 static struct autofs_dev_ioctl *
-		copy_dev_ioctl(struct autofs_dev_ioctl __user *in)
+copy_dev_ioctl(struct autofs_dev_ioctl __user *in)
 {
 	struct autofs_dev_ioctl tmp, *res;
 
@@ -705,7 +705,8 @@ static int _autofs_dev_ioctl(unsigned int command,
 	return err;
 }
 
-static long autofs_dev_ioctl(struct file *file, uint command, ulong u)
+static long autofs_dev_ioctl(struct file *file, unsigned int command,
+			     unsigned long u)
 {
 	int err;
 
@@ -714,9 +715,10 @@ static long autofs_dev_ioctl(struct file *file, uint command, ulong u)
 }
 
 #ifdef CONFIG_COMPAT
-static long autofs_dev_ioctl_compat(struct file *file, uint command, ulong u)
+static long autofs_dev_ioctl_compat(struct file *file, unsigned int command,
+				    unsigned long u)
 {
-	return (long) autofs_dev_ioctl(file, command, (ulong) compat_ptr(u));
+	return autofs_dev_ioctl(file, command, (unsigned long) compat_ptr(u));
 }
 #else
 #define autofs_dev_ioctl_compat NULL

