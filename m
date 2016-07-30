From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 1/3] autofs-5.1.2 - Remove unused local 2KB buffer
Date: Sat, 30 Jul 2016 13:35:37 +0900
Message-ID: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aM2P0z/XgAoQ9zlBk7SDYYgrP6g6f1GYR7aiLtJPodE=;
        b=QT1/T/rDXv8QyqwgSmwwoG5EbmNHPBcdpJVWodjbEnE60BaGHev/z6qn/ypbaKVpdg
         DsGO1RDUNU1X/9UPsbDT1Ow3o3x0kJoxmeDazA08wDFt+VcXK/ZWyel5Kt7UuBBMtE4N
         rWUqbw5ZqaYphGyMmJoBM3ZBDaSrZfQK5DmIKvz0pVZzUnVTGuPFCxFHF6IaFhRv93r8
         u1AK3PDJjYn57zJQAWJ/ve6eWHnru13RpBcsmvY0HH+xrfy3b+5+wbe6oKCHRpw0xwcr
         GhFeHAN8D5efId/bNfKg80xBXZmR4vS1luD6njb9Cel/+RpWIEDsy6pvZ8r+CVHxLjhc
         VwJg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/automount.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index ad5cafd..3afa860 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1901,7 +1901,6 @@ static void usage(void)
 
 static void show_build_info(void)
 {
-	char buf[2048];
 	int count = 0;
 
 	printf("\nLinux automount version %s\n", version);
@@ -1913,8 +1912,6 @@ static void show_build_info(void)
 
 	printf("\nCompile options:\n  ");
 
-	memset(buf, 0, 2048);
-
 #ifndef ENABLE_MOUNT_LOCKING
 	printf("DISABLE_MOUNT_LOCKING ");
 	count = 22;
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
