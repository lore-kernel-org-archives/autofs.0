From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 3/3] autofs-5.1.2 - Fix fgets(3) size argument (another one)
Date: Sat, 30 Jul 2016 13:35:39 +0900
Message-ID: <1469853339-2291-3-git-send-email-kusumi.tomohiro@gmail.com>
References: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fQKaSUwFz8h401VWS8Kmr/4KZaxIryv4ZkNIOPGDsiA=;
        b=GiKj0abiSJP1qOz0WHOofXDs35/pxR4ADTdjdjQJ9qKPFxkvs+OFso0loQo9xaQIS9
         6VNslTU6i49KiR78tA3q9b4y6EkSUF5KgXBFqLjUNTlcgPdze2niOh99GvBeq7vV6uUb
         JeRRXdTjBAqnc9QxkocK7NJuK/c7frXVHPZ9/ZiagEQhwXc6NAfxDgwWzMAun0U0aSkm
         M2zeNKpg+dzL0x4gf1ftr+892s5ZbzM36k/yfMg7e1y7+0xAgnKVa7je+53vTxSgH9Fh
         4PaiinM5BVMYDKP4FHdg4O7PCzGqS/dvMkztdZSbRx/ER3DvXx6bv8LmHjiM9j0A89oj
         TLyA==
In-Reply-To: <1469853339-2291-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

1. fgets(3) reads at most 1 less then the size argument.
2. Each line of /proc/filesystem isn't a filesystem path.

So it doesn't really matter if the size argument is PATH_MAX-1
or PATH_MAX (=sizeof(buf)) as long as the buffer is large enough.
We can just use sizeof(buf).

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daemon/module.c b/daemon/module.c
index bed8f7a..6cf7b7b 100644
--- a/daemon/module.c
+++ b/daemon/module.c
@@ -38,7 +38,7 @@ int load_autofs4_module(void)
 		return 0;
 	}
 
-	while (fgets(buf, PATH_MAX - 1, fp)) {
+	while (fgets(buf, sizeof(buf), fp)) {
 		if (strstr(buf, "autofs")) {
 			fclose(fp);
 			return 1;
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
