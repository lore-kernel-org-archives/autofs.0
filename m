From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 03/12] autofs: Fix AUTOFS_DEV_IOCTL_IOC_COUNT value
Date: Sun, 10 Jul 2016 17:07:44 +0900
Message-ID: <1468138073-4870-3-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nwpVlf+egOoGgXLTDbc4zx1nwbPgwKZ/FsXf5eMnDyI=;
        b=LxY0G7OiWlEUroRXQkPTL1hjxzYVRAHh96wipxFfySIc/jj/RVHuO2thKz+OcMItDM
         lwu0mmCwxXwepP7oiC/JLBRxTvHU+sB/nWNEViQ9ZHQAWoluwxs4a5xCYccYk8UVNfri
         ss0icatQsRT/55l3u7s7ItwoyICIXn+TSmpk17Yy1MQfrRkpTjxgA24nhdNR+8Q9gabm
         d2On6k1uF6WGLKbv5kSnOJNleERIkLJrULaS1yKFL6lzyDm2d85Hx3m018klskqhiaif
         ZiOrBPcZdPdbGrF5IW/OQr9gSJPJktkJjRcVXL4KVQ96TddhtYPeeQJZvPWGrnH+tav6
         S9vA==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

According to include/uapi/linux/auto_fs.h, include/uapi/linux/auto_fs4.h,
and include/linux/auto_dev-ioctl.h, nr part of
AUTOFS_IOC_XXX starts off from 0x60 and
AUTOFS_DEV_IOCTL_XXX starts off from 0x71 which is 0x60+0x11.

From the way above macros are defined, it seems
AUTOFS_DEV_IOCTL_IOC_COUNT should be (0x20-0x11) instead of (0x20-11).
(Otherwise it's hard to figure out where 11 comes from)

COUNT macros are being used to test distance of an ioctl command
in question from the smallest one, so we don't want it to be
larger than necessary.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 73e3d38..7ef4d08 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -20,7 +20,7 @@
 #define AUTOFS_IOC_COUNT     32
 
 #define AUTOFS_DEV_IOCTL_IOC_FIRST	(AUTOFS_DEV_IOCTL_VERSION)
-#define AUTOFS_DEV_IOCTL_IOC_COUNT	(AUTOFS_IOC_COUNT - 11)
+#define AUTOFS_DEV_IOCTL_IOC_COUNT	(AUTOFS_IOC_COUNT - 0x11)
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
