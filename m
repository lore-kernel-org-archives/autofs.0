From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 10/12] autofs: Add autofs_dev_ioctl_version() for AUTOFS_DEV_IOCTL_VERSION_CMD
Date: Sun, 10 Jul 2016 17:07:51 +0900
Message-ID: <1468138073-4870-10-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lUi3L9OGXl7/0I1GcwOOkENZaPgwZItZxzuCjNradXg=;
        b=g9bA4/x9cAGrijRTqDh/v2jQfeaSYG+PszQUdBZ9u+d7q8YNK2Zd85IEUYW1rzWkOv
         Ksv8Rexg0ZgdhvDt3w3ucElR5yo6XIjkTtpoCru2P6aPtc/sKt1uWm+gU1va7MYqxIS/
         Q28comDInT90xOB0qA+r0y6mFli1ojwtc4juq/L74GP5VMo2r4p+Un5r7tGBG06mtKan
         yMYGUlbr/5l8pw+emxqny7+mkIiz1FLDg0HKRZjFlkTiHOBr/fK24ZNM5wOBhAoFu9D4
         dow7zIvUNy8SaNaL8KFDafg5PqR5NmW7RTDMUuR5fjDPrEz6hKfaN+GJKJOFzn5DSSJE
         EWVw==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

No functional changes, based on the following justification.

1. Make the code more consistent using the ioctl vector _ioctls[],
   rather than assigning NULL only for this ioctl command.
2. Remove goto done; for better maintainability in the long run.
3. The existing code is based on the fact that validate_dev_ioctl()
   sets ioctl version for any command, but AUTOFS_DEV_IOCTL_VERSION_CMD
   should explicitly set it regardless of the default behavior.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/dev-ioctl.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index d47b35a..3a1a969 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -172,6 +172,17 @@ static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
 	return sbi;
 }
 
+/* Return autofs dev ioctl version */
+static int autofs_dev_ioctl_version(struct file *fp,
+				    struct autofs_sb_info *sbi,
+				    struct autofs_dev_ioctl *param)
+{
+	/* This should have already been set. */
+	param->ver_major = AUTOFS_DEV_IOCTL_VERSION_MAJOR;
+	param->ver_minor = AUTOFS_DEV_IOCTL_VERSION_MINOR;
+	return 0;
+}
+
 /* Return autofs module protocol version */
 static int autofs_dev_ioctl_protover(struct file *fp,
 				     struct autofs_sb_info *sbi,
@@ -590,7 +601,8 @@ static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 		int cmd;
 		ioctl_fn fn;
 	} _ioctls[] = {
-		{cmd_idx(AUTOFS_DEV_IOCTL_VERSION_CMD), NULL},
+		{cmd_idx(AUTOFS_DEV_IOCTL_VERSION_CMD),
+			 autofs_dev_ioctl_version},
 		{cmd_idx(AUTOFS_DEV_IOCTL_PROTOVER_CMD),
 			 autofs_dev_ioctl_protover},
 		{cmd_idx(AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD),
@@ -655,10 +667,6 @@ static int _autofs_dev_ioctl(unsigned int command,
 	if (err)
 		goto out;
 
-	/* The validate routine above always sets the version */
-	if (cmd == AUTOFS_DEV_IOCTL_VERSION_CMD)
-		goto done;
-
 	fn = lookup_dev_ioctl(cmd);
 	if (!fn) {
 		pr_warn("unknown command 0x%08x\n", command);
@@ -672,9 +680,11 @@ static int _autofs_dev_ioctl(unsigned int command,
 	/*
 	 * For obvious reasons the openmount can't have a file
 	 * descriptor yet. We don't take a reference to the
-	 * file during close to allow for immediate release.
+	 * file during close to allow for immediate release,
+	 * and the same for retrieving ioctl version.
 	 */
-	if (cmd != AUTOFS_DEV_IOCTL_OPENMOUNT_CMD &&
+	if (cmd != AUTOFS_DEV_IOCTL_VERSION_CMD &&
+	    cmd != AUTOFS_DEV_IOCTL_OPENMOUNT_CMD &&
 	    cmd != AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD) {
 		fp = fget(param->ioctlfd);
 		if (!fp) {
@@ -707,7 +717,6 @@ cont:
 
 	if (fp)
 		fput(fp);
-done:
 	if (err >= 0 && copy_to_user(user, param, AUTOFS_DEV_IOCTL_SIZE))
 		err = -EFAULT;
 out:
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
