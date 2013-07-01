From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 2/7] autofs4 - fix string.h include in auto_dev-ioctl.h
Date: Mon, 01 Jul 2013 11:14:15 +0800
Message-ID: <20130701031414.4423.25878.stgit@perseus.fritz.box>
References: <20130701031335.4423.6154.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=T4Ic1k1qfJUWlTUokaJz+ygtTOg=; b=pZO9N24TZpDfrSEe4vDjWzB3fUOk
	42a4R60Azwzmod3QzSfBUyXQHVqg8GTzpRH2vE5Rt9veus+APBp2W1jktmlUvdNQ
	LETxOpRTRa9JPF595oh5GnIPJGuThzRYOi4wCcq4bx0zGQ5wIDEx4OKGRH0mDRRe
	AgZeBzrUsPqvQPA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=T4Ic1k1qfJUWlTUokaJz+y
	gtTOg=; b=h/S4l3NHTIb3sMM2BbFdgv2+nIvY3i1k1roIa95wpWAL4Lq7NKCkvj
	ZitH1q6DL8k5673/FHBlV1FVbLwDWqPpYQOD8Ptq+0gkDqIOC7RcbRTHyEF9VGxq
	05ms7zfEzjiw0uXBy2IGET7T8FXbGl3O1hQOXg9alhnf4XU7bPUXY=
In-Reply-To: <20130701031335.4423.6154.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-next@vger.kernel.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Since including linux/string.h will now do the right thing remove the
conditional check.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/linux/auto_dev-ioctl.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 850f39b..fe4f373 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -11,12 +11,7 @@
 #define _LINUX_AUTO_DEV_IOCTL_H
 
 #include <linux/auto_fs.h>
-
-#ifdef __KERNEL__
 #include <linux/string.h>
-#else
-#include <string.h>
-#endif /* __KERNEL__ */
 
 #define AUTOFS_DEVICE_NAME		"autofs"
 

