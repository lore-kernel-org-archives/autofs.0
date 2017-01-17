From: kusumi.tomohiro@gmail.com
Subject: [PATCH 5/6] autofs: add command enum/macros for root-dir ioctls
Date: Tue, 17 Jan 2017 23:42:32 +0900
Message-ID: <1484664153-20478-5-git-send-email-tkusumi@tuxera.com>
References: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=td+j0puFj18FfGa+BW1OnGwVCPQyPZANLFDYDKLbpiw=;
        b=enuXAqKBmrGyo7x+4oGUyGaQw6uvczjtyQuNttbIdr7synhzIBrJvljUYbPBLyv402
         GhCUqkenAL01cLFgTUJCSc1ELhmyaaWMIN7zjTvLz0hY8FSroNQ40viJqPfb8hBHWcWK
         OzAWltaxPCE4I0+dl0rk6DxLUb+8hPXPELHYvA//u1yvqih4OR9AcTc1TOqeX2WTQa3k
         QPq7GJNV8sCt+ZT7rDiNzGOybmzr0XzfNzsZsPa63yao7dy+IWeCeRLjV8o4A5rG72v7
         m+SwHflh7YIVj+t57gB3SL6tL6MXpHeWCgDZv2U4dz0YKL642R58ZHXjFY6R0ZkE8tw9
         9JPg==
In-Reply-To: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Sync root-dir ioctl with misc-char-dev ioctl's enum/macro format
since these two types of ioctls aren't completely independent of
each other in terms of command nr. No functional changes.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 include/uapi/linux/auto_dev-ioctl.h |  2 --
 include/uapi/linux/auto_fs.h        | 25 ++++++++++++++++++-------
 include/uapi/linux/auto_fs4.h       | 16 +++++++++++-----
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 388739b..af107aa 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -156,8 +156,6 @@ enum {
 	AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD,
 };
 
-#define AUTOFS_IOCTL 0x93
-
 #define AUTOFS_DEV_IOCTL_VERSION \
 	_IOWR(AUTOFS_IOCTL, \
 	      AUTOFS_DEV_IOCTL_VERSION_CMD, struct autofs_dev_ioctl)
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 1bfc3ed..aa63451 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -61,12 +61,23 @@ struct autofs_packet_expire {
 	char name[NAME_MAX+1];
 };
 
-#define AUTOFS_IOC_READY      _IO(0x93, 0x60)
-#define AUTOFS_IOC_FAIL       _IO(0x93, 0x61)
-#define AUTOFS_IOC_CATATONIC  _IO(0x93, 0x62)
-#define AUTOFS_IOC_PROTOVER   _IOR(0x93, 0x63, int)
-#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93, 0x64, compat_ulong_t)
-#define AUTOFS_IOC_SETTIMEOUT _IOWR(0x93, 0x64, unsigned long)
-#define AUTOFS_IOC_EXPIRE     _IOR(0x93, 0x65, struct autofs_packet_expire)
+#define AUTOFS_IOCTL 0x93
+
+enum {
+	AUTOFS_IOC_READY_CMD = 0x60,
+	AUTOFS_IOC_FAIL_CMD,
+	AUTOFS_IOC_CATATONIC_CMD,
+	AUTOFS_IOC_PROTOVER_CMD,
+	AUTOFS_IOC_SETTIMEOUT_CMD,
+	AUTOFS_IOC_EXPIRE_CMD,
+};
+
+#define AUTOFS_IOC_READY        _IO(AUTOFS_IOCTL, AUTOFS_IOC_READY_CMD)
+#define AUTOFS_IOC_FAIL         _IO(AUTOFS_IOCTL, AUTOFS_IOC_FAIL_CMD)
+#define AUTOFS_IOC_CATATONIC    _IO(AUTOFS_IOCTL, AUTOFS_IOC_CATATONIC_CMD)
+#define AUTOFS_IOC_PROTOVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOVER_CMD, int)
+#define AUTOFS_IOC_SETTIMEOUT32 _IOWR(AUTOFS_IOCTL, AUTOFS_IOC_SETTIMEOUT_CMD, compat_ulong_t)
+#define AUTOFS_IOC_SETTIMEOUT   _IOWR(AUTOFS_IOCTL, AUTOFS_IOC_SETTIMEOUT_CMD, unsigned long)
+#define AUTOFS_IOC_EXPIRE       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_CMD, struct autofs_packet_expire)
 
 #endif /* _UAPI_LINUX_AUTO_FS_H */
diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 8f8f1bd..7c6da42 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -148,10 +148,16 @@ union autofs_v5_packet_union {
 	autofs_packet_expire_direct_t expire_direct;
 };
 
-#define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93, 0x66, int)
-#define AUTOFS_IOC_EXPIRE_INDIRECT	AUTOFS_IOC_EXPIRE_MULTI
-#define AUTOFS_IOC_EXPIRE_DIRECT	AUTOFS_IOC_EXPIRE_MULTI
-#define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93, 0x67, int)
-#define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93, 0x70, int)
+enum {
+	AUTOFS_IOC_EXPIRE_MULTI_CMD = 0x66, /* AUTOFS_IOC_EXPIRE_CMD + 1 */
+	AUTOFS_IOC_PROTOSUBVER_CMD,
+	AUTOFS_IOC_ASKUMOUNT_CMD = 0x70, /* AUTOFS_DEV_IOCTL_VERSION_CMD - 1 */
+};
+
+#define AUTOFS_IOC_EXPIRE_MULTI    _IOW(AUTOFS_IOCTL, AUTOFS_IOC_EXPIRE_MULTI_CMD, int)
+#define AUTOFS_IOC_EXPIRE_INDIRECT AUTOFS_IOC_EXPIRE_MULTI
+#define AUTOFS_IOC_EXPIRE_DIRECT   AUTOFS_IOC_EXPIRE_MULTI
+#define AUTOFS_IOC_PROTOSUBVER     _IOR(AUTOFS_IOCTL, AUTOFS_IOC_PROTOSUBVER_CMD, int)
+#define AUTOFS_IOC_ASKUMOUNT       _IOR(AUTOFS_IOCTL, AUTOFS_IOC_ASKUMOUNT_CMD, int)
 
 #endif /* _LINUX_AUTO_FS4_H */
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
