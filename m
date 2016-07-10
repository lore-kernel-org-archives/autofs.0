From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 04/12] autofs: Change _LINUX_AUTO_FS4_H to _UAPI_LINUX_AUTO_FS4_H
Date: Sun, 10 Jul 2016 17:07:45 +0900
Message-ID: <1468138073-4870-4-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cenv+OL5008GdGW4fpflUQwqp+EtvrfuIhg7r+/z+sg=;
        b=Gjz1r3ld9vs4V8PdEVsfx+J5XX1klvVU/RQHtPsoWaSGpKJ325rto5BGyhBblYPnnK
         Fhq6gx2NF0L7viXbmWdAUyZxR6wGfH+ZQ8F7T7rAClUfGLyaWhXAJf+EPJ8aGyHPEmVr
         S+TEPC5i6bCLRLNkhZyQXhiH1+rx6r45NzD7Xt0Eofvz4DzxJUkMpCr7CMawi6qQXlWp
         dS+zCC3y+GTl1LAqvdBcxRH4StvsA/3oZ5lA0PuNYBEBfDAEuQlvFxdJispYUpVQ9Loy
         urbxwnUtxUh/LBX0/PuFajWzb8J8wG9T8qBgtk5RQEANX0hC67f6Ae3HDpo4IAhjsLUu
         cmbw==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

607ca46e which introduced uapi to Linux kernel added "_UAPI" to
include/uapi/linux/auto_fs.h, but not to include/uapi/linux/auto_fs4.h.

Headers under include/linux which only include uapi headers
generally have different names for include guard without "_UAPI",
so follow that.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 include/uapi/linux/auto_fs4.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/auto_fs4.h b/include/uapi/linux/auto_fs4.h
index 8f8f1bd..3c7ed14 100644
--- a/include/uapi/linux/auto_fs4.h
+++ b/include/uapi/linux/auto_fs4.h
@@ -6,8 +6,8 @@
  * option, any later version, incorporated herein by reference.
  */
 
-#ifndef _LINUX_AUTO_FS4_H
-#define _LINUX_AUTO_FS4_H
+#ifndef _UAPI_LINUX_AUTO_FS4_H
+#define _UAPI_LINUX_AUTO_FS4_H
 
 /* Include common v3 definitions */
 #include <linux/types.h>
@@ -154,4 +154,4 @@ union autofs_v5_packet_union {
 #define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93, 0x67, int)
 #define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93, 0x70, int)
 
-#endif /* _LINUX_AUTO_FS4_H */
+#endif /* _UAPI_LINUX_AUTO_FS4_H */
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
