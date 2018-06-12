From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] autofs: Fix typo s/thenew new/the new/ in AUTOFS4_FS description
Date: Tue, 12 Jun 2018 08:05:55 +0200
Message-ID: <1528783555-19275-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Fixes: a2225d931f75ddd3 ("autofs: remove left-over autofs4 stubs")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/autofs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/Kconfig b/fs/autofs/Kconfig
index 55c3930a907b395e..eaebcd430cc3d404 100644
--- a/fs/autofs/Kconfig
+++ b/fs/autofs/Kconfig
@@ -4,7 +4,7 @@ config AUTOFS4_FS
 	help
 	   This name exists for people to just automatically pick up the
 	   new name of the autofs Kconfig option. All it does is select
-	   thenew new option name.
+	   the new option name.
 
 	   It will go away in a release or two as people have
 	   transitioned to just plain AUTOFS_FS.
-- 
2.7.4

