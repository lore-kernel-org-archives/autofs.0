From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/5] autofs: non functional header inclusion cleanup
Date: Wed, 16 Aug 2017 10:31:20 +0800
Message-ID: <150285068011.4670.10271483982093996996.stgit@pluto.themaw.net>
References: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150285067347.4670.11494624644273072003.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Having header includes before any macro (without any dependency)
simply looks normal. No reason to have these macros in between.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index beef981aa54f..4737615f0eaa 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -11,10 +11,21 @@
 
 #include <linux/auto_fs4.h>
 #include <linux/auto_dev-ioctl.h>
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/string.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/uaccess.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/completion.h>
+#include <asm/current.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -24,17 +35,6 @@
 #define AUTOFS_DEV_IOCTL_IOC_COUNT \
 	(AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD - AUTOFS_DEV_IOCTL_VERSION_CMD)
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/time.h>
-#include <linux/string.h>
-#include <linux/wait.h>
-#include <linux/sched.h>
-#include <linux/mount.h>
-#include <linux/namei.h>
-#include <asm/current.h>
-#include <linux/uaccess.h>
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif

