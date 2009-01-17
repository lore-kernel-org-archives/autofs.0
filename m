From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [RFC PATCH 3/3] Don't include kernel header files during
	userspace compiles
Date: Fri, 16 Jan 2009 19:58:50 -0800
Message-ID: <1232164730-9397-4-git-send-email-vaurora@redhat.com>
References: <1232164730-9397-1-git-send-email-vaurora@redhat.com>
	<1232164730-9397-2-git-send-email-vaurora@redhat.com>
	<1232164730-9397-3-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232164730-9397-3-git-send-email-vaurora@redhat.com>
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
To: autofs@linux.kernel.org
Cc: Paul Wankadia <junyer@google.com>

autofs_dev-ioctl.h is included by both the kernel module and the
userland tools, and it includes two kernel include files.  The compile
worked if you had kernel headers installed but failed otherwise.

We could also push these includes into the kernel module entirely, but
then we'd have to work harder to keep autofs userland and kernel
versions in sync, so I chose to just #ifdef it out.
---
 include/linux/auto_dev-ioctl.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 91a7739..c943c1e 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -10,8 +10,11 @@
 #ifndef _LINUX_AUTO_DEV_IOCTL_H
 #define _LINUX_AUTO_DEV_IOCTL_H
 
+/* This file is shared by both user and kernel space */
+#ifdef __KERNEL__
 #include <linux/string.h>
 #include <linux/types.h>
+#endif /* __KERNEL__ */
 
 #define AUTOFS_DEVICE_NAME		"autofs"
 
-- 
1.6.0.3
