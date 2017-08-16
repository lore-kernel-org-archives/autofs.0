From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/5] autofs: remove unused AUTOFS_IOC_EXPIRE_DIRECT/INDIRECT
Date: Wed, 16 Aug 2017 10:31:13 +0800
Message-ID: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

These are not used by either kernel or userspace, although
AUTOFS_IOC_EXPIRE_DIRECT once seems to have been used by userspace
in around 2006-2008, which was technically just an alias of the
existing ioctl AUTOFS_IOC_EXPIRE_MULTI.

ioctls for autofs are already complicated enough that they could
be removed unless these are staying here to be able to compile
userspace code of certain period of time from a decade ago.

Edit: imk
Yes, this is indeed very old and anything that still uses must
be updated becuase it will be using broken functionality.
End edit: imk

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/uapi/linux/auto_fs4.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 7c6da423d54e..9453e9a07c9d 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -155,8 +155,6 @@ enum {
 };
 
 #define AUTOFS_IOC_EXPIRE_MULTI    _IOW(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_MULTI_CMD, int)
-#define AUTOFS_IOC_EXPIRE_INDIRECT AUTOFS_IOC_EXPIRE_MULTI
-#define AUTOFS_IOC_EXPIRE_DIRECT   AUTOFS_IOC_EXPIRE_MULTI
 #define AUTOFS_IOC_PROTOSUBVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOSUBVER_CMD, int)
 #define AUTOFS_IOC_ASKUMOUNT       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_ASKUMOUNT_CMD, int)
 

