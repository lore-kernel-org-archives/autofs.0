From: kusumi.tomohiro@gmail.com
Subject: [PATCH 2/3] autofs: non functional header inclusion cleanup
Date: Mon, 27 Mar 2017 03:00:36 +0300
Message-ID: <20170327000037.2179-2-tkusumi@tuxera.com>
References: <20170327000037.2179-1-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R8TZNyrvlICKi0zLZ5uI1GSQccJaGNssJ/hNFBoyZbc=;
        b=snBnSGoiGjAO7bgO6ozuEXb4f75G7aIt+6evkva4xGXiANp9kDwWgojpppX8sn7Cvr
         NH/7oyADLOxf/Q/ZurQnQPtXGRYEmBgsR+0BHGDWt+YCpbSYsbo2mdu7tC1L6GP6nW0N
         48qIjjAtHWDDaE9oUdqEDkqboit9ByFzFqr4gouy5n0b44P8Zg4ulRdVPV5Rx5F7/jDI
         tM0s+wQ45P7uFk6NzZpynKb6bJFCyylz2OOtwcnTXHqvf7p5dS126fIigEEiOjVuBBfY
         vujgj3ec2Q+oFF+DNoeYGI0jbhg06udurtXrXkwC5cERazNeD4525eorpC4maQGtN2TP
         CEIg==
In-Reply-To: <20170327000037.2179-1-tkusumi@tuxera.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Having header includes before any macro (without any dependency)
simply looks normal. No reason to have these macros in between.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/autofs4/autofs_i.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index beef981..4737615 100644
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
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
