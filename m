From: Ian Kent <raven@themaw.net>
Subject: [PATCH 15/18] autofs: Add autofs_dev_ioctl_version() for
 AUTOFS_DEV_IOCTL_VERSION_CMD
Date: Fri, 12 Aug 2016 10:48:46 +0800
Message-ID: <20160812024846.12352.9885.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=lnQljWMjz8kTm9p6tN0vsLGtgX4=; b=jh89RN
	JTXNz/520GZpxzFxtE01TwmMA5s/Df/j6ewhA+rNggMD9lWp3uLcNbtLs8J8CP4U
	IBPuWn8qBS/8RPByYnk+jcY2h4D8g/yVjmhe5Eyyqpp+GVGIcmsfCdI7KjI84NSr
	e2PnByrncysHYg9Lgpm8NF+UDRLxKO2oiSrd0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lnQljWMjz8kTm9p
	6tN0vsLGtgX4=; b=Arq5w75/6423BODI43aDY0Mhy0Ohaozs/zj8dq7kSzQp1aJ
	mNkQ5y0Elp8qpRcqFm6BKLG0PX1z+khaMVrluHByHziYL1z3/UXMyVM5mV/0yPP/
	NQFgy7BV20seG5I99uvAtT7VRC+//EwWzBAWHOCVtoppTUfu6Jfd9c1eDCKE=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

No functional changes, based on the following justification.

1. Make the code more consistent using the ioctl vector _ioctls[],
   rather than assigning NULL only for this ioctl command.
2. Remove goto done; for better maintainability in the long run.
3. The existing code is based on the fact that validate_dev_ioctl()
   sets ioctl version for any command, but AUTOFS_DEV_IOCTL_VERSION_CMD
   should explicitly set it regardless of the default behavior.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/dev-ioctl.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 13e7517..7289216 100644
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

