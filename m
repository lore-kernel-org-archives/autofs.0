From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - fix kernel includes
Date: Mon, 16 Mar 2009 12:17:17 +0900
Message-ID: <20090316031717.26901.79534.stgit@zeus.themaw.net>
References: <20090316031712.26901.52109.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20090316031712.26901.52109.stgit@zeus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

autofs_dev-ioctl.h is included by both the kernel module and user
space tools and it includes two kernel header files. Compiles
work if the kernel headers are installed but fail otherwise.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 include/linux/auto_dev-ioctl.h |    7 ++++++-
 include/linux/auto_fs.h        |    6 ++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 91a7739..850f39b 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -10,8 +10,13 @@
 #ifndef _LINUX_AUTO_DEV_IOCTL_H
 #define _LINUX_AUTO_DEV_IOCTL_H
 
+#include <linux/auto_fs.h>
+
+#ifdef __KERNEL__
 #include <linux/string.h>
-#include <linux/types.h>
+#else
+#include <string.h>
+#endif /* __KERNEL__ */
 
 #define AUTOFS_DEVICE_NAME		"autofs"
 
diff --git a/include/linux/auto_fs.h b/include/linux/auto_fs.h
index c21e597..6326585 100644
--- a/include/linux/auto_fs.h
+++ b/include/linux/auto_fs.h
@@ -17,11 +17,13 @@
 #ifdef __KERNEL__
 #include <linux/fs.h>
 #include <linux/limits.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+#else
 #include <asm/types.h>
+#include <sys/ioctl.h>
 #endif /* __KERNEL__ */
 
-#include <linux/ioctl.h>
-
 /* This file describes autofs v3 */
 #define AUTOFS_PROTO_VERSION	3
 

