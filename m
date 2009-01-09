From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [PATCH 4/4] Replace <linux/string.h> with <string.h>
Date: Fri,  9 Jan 2009 13:47:03 -0500
Message-ID: <1231526823-18595-5-git-send-email-vaurora@redhat.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231526823-18595-3-git-send-email-vaurora@redhat.com>
	<1231526823-18595-4-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231526823-18595-4-git-send-email-vaurora@redhat.com>
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

If installed, <linux/string.h> just includes the user-level
string.h.  If it's not installed, the compile fails.

From: Paul Wankadia <junyer@google.com>
Signed-off-by: Valerie Aurora Henson <vaurora@redhat.com>
---
 include/linux/auto_dev-ioctl.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 91a7739..78f4b47 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -10,7 +10,7 @@
 #ifndef _LINUX_AUTO_DEV_IOCTL_H
 #define _LINUX_AUTO_DEV_IOCTL_H
 
-#include <linux/string.h>
+#include <string.h>
 #include <linux/types.h>
 
 #define AUTOFS_DEVICE_NAME		"autofs"
-- 
1.6.0.4
