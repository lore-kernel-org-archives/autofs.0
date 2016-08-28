From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 3/3] autofs: fix "fix dev ioctl number range check"
Date: Sun, 28 Aug 2016 13:05:59 +0900
Message-ID: <1472357159-1871-3-git-send-email-kusumi.tomohiro@gmail.com>
References: <1472357159-1871-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IfuuulxjGhzlVg5XskpK3ElDtOMzRZZoTLEJ5qPwMmg=;
        b=Uw3uR42/7nP+mUZvzj3gTXXi3E5T11fFXJDAOm748x9DC7ZMozewMTnnrUkQV0FkmD
         uOGDHaqKhaIIolkRkHV47l0Wr2FpqltJ2rqWxuxu2yjyN5HUtqaXbejh7XRjt0RufxM/
         2PSg6UnGbkckKaQLI0nn6WlRkS4CqCbW6qUaUYA1jQmf8oq2o/oAUBLUIxe2UjWFKHF5
         4y2BzjegiuoL0YdP6e8mrChQjUPKwX/tEsnHvOa5YxffZPG8nXC9S22Cn8175VutdVH3
         fKEu4XYnlENH4qh53nFN/HkdgCDuWv+o1UFzfN1kaXdZsEp8Yf0Lpwt2Nnk6DCCIIXsX
         mF+A==
In-Reply-To: <1472357159-1871-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

102a340f had a typo that made the count macro negative (-13).
The acutal check used by ioctl is ((cmd - cmd_first) > COUNT),
so it needs to be positive (13).

* 102a340f is a commit in linux-next which hasn't been merged
to mainline upstream.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4404a22..a1fba42 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -21,7 +21,7 @@
 
 #define AUTOFS_DEV_IOCTL_IOC_FIRST	(AUTOFS_DEV_IOCTL_VERSION)
 #define AUTOFS_DEV_IOCTL_IOC_COUNT \
-	(AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
+	(AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD - AUTOFS_DEV_IOCTL_VERSION_CMD)
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
