From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/10] autofs4 - fix string.h include in auto_dev-ioctl.h
Date: Sat, 31 Aug 2013 19:42:31 +0800
Message-ID: <20130831114231.11807.17131.stgit@perseus.themaw.net>
References: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=T4Ic1k1qfJUWlTUokaJz+ygtTOg=; b=LCRI7/9QE1KG19oVecZiA/GxAdfc
	zR4DTlZTNLYNchdJhyc407LsQnlReYRyU2bOQ60URS+U1LECeuD5SIMcmqqYIpsb
	6xO6N2bOWvj1XtoM31b5JIRAS+yiZ1c7lpfJSm4OtjsKI4tHKZYEUM8OObfclDoX
	Vke777SJ6gUly20=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=T4Ic1k1qfJUWlTUokaJz+y
	gtTOg=; b=VLHNCIIq9NFTiiBib9/kQZ6csHUJod6kSxGlsqo9uVg0ul6VzfZoKt
	9IBXdKkyKAQJNlXo5ChrCFmlNaqwmPKd39zXMCdBK/iP0yqex7PGAKFQo1tDzdpm
	uIxXsaw1SrCcXukBqjJCTMXckOaPSIwz1M8I8dglRGWrRaByBXejU=
In-Reply-To: <20130831114133.11807.35953.stgit@perseus.themaw.net>
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
 

