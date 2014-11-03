From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/13] autofs4 - fix string.h include in auto_dev-ioctl.h
Date: Mon, 03 Nov 2014 16:12:39 +0800
Message-ID: <20141103081239.6215.96771.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=vXgMeXywLdMAp7Msf3m5oMFo/1M=; b=ioqr/JZ0NIEVJFfXmy
	JYkwwibmCTLxoq0Z1ucoHlgiHwvUwetemont2QWJiKG8HlPk1jTuA8zXjdlvCHQO
	RuMQCIBbWO0U//J8it1H6M9PQL8ShWL/c0VrOAtrq+zXixAT2HwCerqJnL6b0JOY
	SJaZD5yH6VQ+4wmuX8Fb4z+HU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=vXgMeXywLdMAp7Msf3m5oM
	Fo/1M=; b=pj6zEdro+A5fKe/CEVqnU1go6mzt0Fb7tHzQbanBt9JnFIMphCUteA
	Z1HkD/y2tjlWSe+EIXvGMiI+fjLH4IjjZpIRiev7HiaN/gJ+LaNOBzwX38jzagyz
	b1hLzaFKMuCsEbJY5pwyL6Yjgm0pPRz7CkKwvtoSCkjVoQNkjHlOI=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Since including linux/string.h will now do the right thing remove the
conditional check.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/linux/auto_dev-ioctl.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 6427816..7caaf29 100644
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
 
