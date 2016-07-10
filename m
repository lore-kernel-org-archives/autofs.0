From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 05/12] autofs: Remove AUTOFS_DEVID_LEN
Date: Sun, 10 Jul 2016 17:07:46 +0900
Message-ID: <1468138073-4870-5-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VkrcIiOffHrCuR/LFVN9OPeSYbo5jApLeQ2GAYwYseQ=;
        b=l95mSdf9qzZ0mVDHP/gR9lCWSdSEf8Z26uC5snrW0stYR5iVIkYp4hX560XbfapZz4
         CKP/U574YwIGP5xIjePCrhdVcNtl+HREj1HAa56yVD0E25ImnZaxR08JsC/7icjzZZld
         DIFSVcxEML8mkxkCkH8STx+M+RXN7QitBS6LYVHGcAzA6ZTWMv8UHbhJjj3ZbnJgxyRP
         EI7N8RTXlznkEdHi481+eCXwiNd5CjL6XKm41iPYo6kFLF7F8BUKGpShLL1GNx+/7lkh
         CjAFiU4gFRlFL05qWLPJYm6eBT0h6Uc6AwUEf5GxjtjrliDuSgw9gLvoWqvw9ROpRdrX
         niZA==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

This macro was never used by neither kernel nor userspace,
and also doesn't represent "devid length" in bytes.
(unless it was added to mean something else).

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 include/linux/auto_dev-ioctl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 7caaf29..bf82e3a 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -18,8 +18,6 @@
 #define AUTOFS_DEV_IOCTL_VERSION_MAJOR	1
 #define AUTOFS_DEV_IOCTL_VERSION_MINOR	0
 
-#define AUTOFS_DEVID_LEN		16
-
 #define AUTOFS_DEV_IOCTL_SIZE		sizeof(struct autofs_dev_ioctl)
 
 /*
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
