From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/4] autofs-5.0.4 - fix kernel includes
Date: Mon, 19 Jan 2009 21:24:55 +0900
Message-ID: <20090119122455.31454.95235.stgit@zeus.themaw.net>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090119121918.31454.61737.stgit@zeus.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Valerie Aurora Henson <vaurora@redhat.com>, Paul Wankadia <junyer@google.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

From: Valerie Aurora Henson <vaurora@redhat.com>

autofs_dev-ioctl.h is included by both the kernel module and the
userland tools, and it includes two kernel include files.  The compile
worked if you had kernel headers installed but failed otherwise.

imk: there are a couple of other instances were we include kernel-headers
includes. I've tried to fix that up.
---

 include/automount.h            |    2 +-
 include/linux/auto_dev-ioctl.h |   10 ++++++++++
 include/linux/auto_fs.h        |    5 ++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/automount.h b/include/automount.h
index 005d209..8a83fb4 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -13,7 +13,7 @@
 #include <limits.h>
 #include <time.h>
 #include <syslog.h>
-#include <linux/types.h>
+#include <sys/types.h>
 #include <pthread.h>
 #include <sched.h>
 #include <errno.h>
diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 91a7739..8c5b71a 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -10,8 +10,18 @@
 #ifndef _LINUX_AUTO_DEV_IOCTL_H
 #define _LINUX_AUTO_DEV_IOCTL_H
 
+/* This file is shared by both user and kernel space */
+#ifdef __KERNEL__
 #include <linux/string.h>
 #include <linux/types.h>
+#else
+#include <string.h>
+#ifndef _LINUX_AUTO_FS_H
+#include <sys/types.h>
+typedef		u_int32_t	__u32;
+typedef		u_int64_t	__u64;
+#endif
+#endif /* __KERNEL__ */
 
 #define AUTOFS_DEVICE_NAME		"autofs"
 
diff --git a/include/linux/auto_fs.h b/include/linux/auto_fs.h
index bd39f09..5340fc6 100644
--- a/include/linux/auto_fs.h
+++ b/include/linux/auto_fs.h
@@ -18,9 +18,12 @@
 #include <linux/fs.h>
 #include <linux/limits.h>
 #include <asm/types.h>
+#else
+typedef		u_int32_t	__u32;
+typedef		u_int64_t	__u64;
 #endif /* __KERNEL__ */
 
-#include <linux/ioctl.h>
+#include <asm/ioctl.h>
 
 /* This file describes autofs v3 */
 #define AUTOFS_PROTO_VERSION	3
