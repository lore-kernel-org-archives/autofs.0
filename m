From: kusumi.tomohiro@gmail.com
Subject: [PATCH 1/3] autofs: remove unused AUTOFS_IOC_EXPIRE_DIRECT/INDIRECT
Date: Mon, 27 Mar 2017 03:00:35 +0300
Message-ID: <20170327000037.2179-1-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q0qZfe1ZqmfSMkgVF53o+r4y2oR9tlIaNt9kff44zKY=;
        b=WmlJzFYxVDI/MWDi65beIqXg72QYFd8MeOAmCcvztGdLcXOf01pH0KZ/i89zReAMpx
         9Oz20UQW1KjfCP8+zZOKNBDus3RzsQ445sq0dzMpX09t4ZiDLGjtTNifVqP3zu3ZJaBS
         j63wSBn6bGqRFxQFbglhcG2wTCXJXAXhf4HdGp94bF36k2PxspgOgIsgiqo3eolhluhs
         szeQeSuCK0FqC6GPBhxzV+eqOWtdw9cvGUsmuLvAVhEZfSilBvtTk0DhQEKppUs3yztF
         pOgcZkl6QA0yGRMX2RaY9SDnU/3JSyIRVQPYajG2wMR/RZsVaWhzYn+pWaZzRiDyaGiZ
         EIRA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

These are not used by either kernel or userspace, although
AUTOFS_IOC_EXPIRE_DIRECT once seems to have been used by userspace
in around 2006-2008, which was technically just an alias of the
existing ioctl AUTOFS_IOC_EXPIRE_MULTI.

ioctls for autofs are already complicated enough that they could
be removed unless these are staying here to be able to compile
userspace code of certain period of time from a decade ago.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 include/uapi/linux/auto_fs4.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 7c6da42..9453e9a 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -155,8 +155,6 @@ enum {
 };
 
 #define AUTOFS_IOC_EXPIRE_MULTI    _IOW(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_MULTI_CMD, int)
-#define AUTOFS_IOC_EXPIRE_INDIRECT AUTOFS_IOC_EXPIRE_MULTI
-#define AUTOFS_IOC_EXPIRE_DIRECT   AUTOFS_IOC_EXPIRE_MULTI
 #define AUTOFS_IOC_PROTOSUBVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOSUBVER_CMD, int)
 #define AUTOFS_IOC_ASKUMOUNT       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_ASKUMOUNT_CMD, int)
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
