From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 1/2] autofs-5.1.2 - Fix a typo in CREDITS
Date: Sun, 10 Jul 2016 17:10:19 +0900
Message-ID: <1468138220-4952-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=15cewT3c7SRtOuEUsDk/k8GJXluOZxHQVtqevIlMuFI=;
        b=EoDRiEfOGPJNOSBkC1OBgj/LHpvoaDFHiiW7N6FFjJcfpXaV5hSFdu3ub3jk3kjlz7
         +KfV0gHJq7bWDVEqMPjAxq91p1IvHQfRJ4zogdKZcLCctM/rlsVtdkxljkvap+Uzio5j
         rowah31mkp2Zv8UxwtWCIuVpzbNYofLYOtj6RPLNHFFYZReJYd3la4N2097apxZDbns6
         SnU4s2si+O2m803YpefoFv2prCWU7pNtTsZD0vsdPDORPzjRzUd1ZJ1hdr4abWq8uD2I
         +twBnJyXgAYv0Pc2Wb+bFzeblm+e2XASya4RzJPy37nSW1TGcUvZhljoritg8vtSfNxb
         Ep+Q==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Fix a typo in a contributor's name.
Two other parts of this file says "Aaron".

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 CREDITS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 8d5057a..a931de1 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2,7 +2,7 @@
 CREDITS
 =======
 
-Arron Ogden
+Aaron Ogden
 -----------
 
 While other people have contributed to autofs in various ways
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
