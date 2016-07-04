From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] automount: Fix compiler warning
Date: Mon,  4 Jul 2016 18:32:23 +0900
Message-ID: <1467624743-7222-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=uoGH/R6272Za0l94HR0mJanRqWT1HwYKJ0Q9ErA8yvU=;
        b=UUF2NSW49XW2ohFUtrWAYC48Jx3QPfcGnJ/5JopSMV5DH4qxMCh1l8vKhfL7GMRHu/
         +3IOgdhLBkSL6BI6ulov2RWaLgUBz5V1x4QONkLHTq6e9DXlYf4IehcNNPvboQu3TRx8
         0ZIqQt51esbir26huGuWDvWdr06pBYm8Rq9RRAf2tRfR08fDfFAR0YT/99U53J5zUbtR
         L448Whq1AOt/00CRCUDoQC7OizmM98EV3ZYWalXU/bmZRNfv7cGaF7fetqhNvZxc5MmE
         VmSKWuqz3KQTqTrIUR3u6325odRai6fflUiUfT1aKv/tjyA4y44GoDn6nZQZFxe+sgxN
         hj/w==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Fix below compiler (gcc5) warning which isn't autoconf result dependent.
mounts.c:1779:7: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 lib/mounts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/mounts.c b/lib/mounts.c
index 1d1b4da..c67548e 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1776,16 +1776,15 @@ static int remount_active_mount(struct autofs_point *ap,
 			*ioctlfd = -1;
 		}
 	} else {
-		int ret;
 		/*
 		 * What can I do if we can't remount the existing
 		 * mount(s) (possibly a partial failure), everything
 		 * following will be broken?
 		 */
 		if (type == t_indirect)
-			ret = do_remount_indirect(ap, fd, path);
+			do_remount_indirect(ap, fd, path);
 		else
-			ret = do_remount_direct(ap, fd, path);
+			do_remount_direct(ap, fd, path);
 	}
 
 	debug(ap->logopt, "re-connected to mount %s", path);
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
