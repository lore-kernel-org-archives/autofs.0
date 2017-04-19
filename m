From: kusumi.tomohiro@gmail.com
Subject: [PATCH] autofs: drop wrong comment
Date: Wed, 19 Apr 2017 18:58:17 +0300
Message-ID: <20170419155817.21654-1-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wAbdqPgUgRbJKgnY6vBo9EX41HYVAJeuCrpjKxLEKb4=;
        b=NNIj/csmTYzqSmK1xulx+Gqt1/120zdZA7aRO7fjnbf4wGSmdJI7a59Cnp/U6H21Me
         3tOL4psM5LIbnEsnmQkE7rgbYPSDN6WgYxKhfQ6jeXSsByGHDsiO79j8zOFfrC7BHpfp
         7rJyHq1IOsEKJvGmDHaHZWpoxx4lyb1fgAirh+bYt8Tazx/Hl0XXwvNjcPR6cmHlx0Zq
         vTjfnpgGMyzl0DLQtwpr3H9rV/fjcTJlIN6ZhMZhuJ5r5iOavB6BjFUjh4F/j1h3ieEB
         BKV6vGtoIb21VTZ1MLH9RXbh/FXY1k5gmHvtHwOPIKBUH2BpqyWI4ZC/DsllVohEuIEX
         ZoLQ==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This comment was correct when it was added in 8d7b48e0 in 2008,
but not after 4e44b685 in 2009 which introduced find_autofs_mount().

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/autofs4/dev-ioctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 734cbf8..acc165d 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -258,11 +258,6 @@ static int autofs_dev_ioctl_open_mountpoint(const char *name, dev_t devid)
 		if (err)
 			goto out;
 
-		/*
-		 * Find autofs super block that has the device number
-		 * corresponding to the autofs fs we want to open.
-		 */
-
 		filp = dentry_open(&path, O_RDONLY, current_cred());
 		path_put(&path);
 		if (IS_ERR(filp)) {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
