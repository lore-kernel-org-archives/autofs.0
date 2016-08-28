From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs-5.1.2: Avoid local variable name shadowing another
Date: Sun, 28 Aug 2016 13:06:52 +0900
Message-ID: <1472357212-1920-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UhEJgmseLZBhZuCOFqeEIVDdZQBMvVLTJ8acRPKZPi4=;
        b=NGVk+yERlaeD3LdpDLG68zv6suWJ9YLBvZMqU3VKhqcnV5DYjZE/wtlLdeXKgW3eSa
         c3xAaqKqkD1efYCJf7/9r06zfa6gZ4ZIoPutyMqYhDL3RSw3FeCBVoa5yAdakUeNy12f
         6W30EwCs66rP60y/s5CHsceQHmq8TpyYU79J+xZYSIAjTVdazvTuxgX7GE+nmjd4TA9d
         nkCIuLWSzkAU2Xl0YHJ4/1neeBrbY+8ONMC8AQn8vWjCaZVIg0YokrMB+ZNIqqkNZ/aT
         pqRCJd3S8WKuyif4C2E3OoLD9FN6ldZmcKqiSEqwB8+YNfFIoFhApjQRth+ILVJn47Ko
         3ypA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

There are two local variabls int ret, and the one in the
inner scope doesn't need to be named as int ret.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 daemon/automount.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index ca5e090..63e139d 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -310,17 +310,13 @@ static int walk_tree(const char *base, int (*fn) (struct autofs_point *ap,
 				return -1;
 
 			while (n--) {
-				int ret, size;
-
 				if (strcmp(de[n]->d_name, ".") == 0 ||
 				    strcmp(de[n]->d_name, "..") == 0) {
 					free(de[n]);
 					continue;
 				}
 
-				size = sizeof(buf);
-				ret = cat_path(buf, size, base, de[n]->d_name);
-				if (!ret) {
+				if (!cat_path(buf, sizeof(buf), base, de[n]->d_name)) {
 					do {
 						free(de[n]);
 					} while (n--);
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
