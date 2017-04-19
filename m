From: kusumi.tomohiro@gmail.com
Subject: [PATCH] autofs: use unsigned int/long instead of uint/ulong for ioctl args
Date: Wed, 19 Apr 2017 23:26:36 +0300
Message-ID: <20170419202636.3402-1-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Oc4TFZR2C3OQaCV+bIX5RsJtjWyPZT3ty0DykdV7l5k=;
        b=upiHMhyUFXVIJyKMFFi05MHjZaV9aBW5jh8eDOXoInw19Yee2+2GBHHJPR9+JKEWvW
         dNJzMfBItMdZjfLTMUCh9JwCu5cylioEeSv80GwVWlI+PdMQi9N2qwrRMo0Na67IAS6+
         T8e3VlCkx+UIyhhA0V/0pCYey+pM22R5U4SQKHiecnooaifQUQ2+9+r8v1IZ+1+nW8jw
         dueHWq8XDUUX8LoH8p0vMMCyvK+MkD41R1OXIxkBBXHEuleXao53wrkWujW/mYMcRUnv
         2a5HXNzJJhPDyL28bY5B/efdymaul+A8mt3xS8N44Ojb9tHAZYYYgrzSWmJ0APzEePBc
         5nHA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

The standard types unsigned int and unsigned long should be used for
.compat_ioctl. autofs is the only fs using uing/ulong for this, and
these are even the only uint/ulong in the entire autofs code.

Drop unneeded long cast in return value of autofs_dev_ioctl_compat().
It's already long.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/autofs4/dev-ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index acc165d..26e6637 100644
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
 
@@ -701,7 +701,8 @@ static int _autofs_dev_ioctl(unsigned int command,
 	return err;
 }
 
-static long autofs_dev_ioctl(struct file *file, uint command, ulong u)
+static long autofs_dev_ioctl(struct file *file, unsigned int command,
+			     unsigned long u)
 {
 	int err;
 
@@ -710,9 +711,10 @@ static long autofs_dev_ioctl(struct file *file, uint command, ulong u)
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
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
