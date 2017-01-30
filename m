From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/7] autofs: add command enum/macros for root-dir ioctls
Date: Mon, 30 Jan 2017 18:21:01 +0800
Message-ID: <148577166143.9801.15511796506678428145.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=e8WJ8JaIIKCYc3v
        U86eSsfBNo8U=; b=cmsf1+LYji9bVP/GyS3ZDMhQXiKxvf2l6h6AR8rvrLWjkRu
        juXe+PtpxaRKXAVgXba8ZsrjW2BN400tSia9f7klOBQmfGRXpPgq8aOpgD0PIAbu
        7w//9vS+E4duz+kwFj2HX9R250AjoEdiMdj+ynr+DRUxHY18BmjbuIMGA0wQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=e8WJ8JaIIKCYc3vU86eSsfBNo8U=; b=mIv9OvQ1ro73BdcnXgkW
        GibwdBY9A4F83tsDHt8U7CU3E6kRAek8EbjB9BUij/hdYZbjcGFY+d1wba112xl0
        E1LNfHTD63CNa67hhur9lS60XCxbp6GilRofWCriLuFtnHac1Bi5rEixImQ6ScVe
        gq8vDsK/rv2yO3C7TdBt0XU=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Sync root-dir ioctl with misc-char-dev ioctl's enum/macro format
since these two types of ioctls aren't completely independent of
each other in terms of command nr. No functional changes.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/uapi/linux/auto_dev-ioctl.h |    2 --
 include/uapi/linux/auto_fs.h        |   25 ++++++++++++++++++-------
 include/uapi/linux/auto_fs4.h       |   16 +++++++++++-----
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

