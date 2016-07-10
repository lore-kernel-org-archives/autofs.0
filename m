From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 08/12] autofs: Fix pr_debug() message
Date: Sun, 10 Jul 2016 17:07:49 +0900
Message-ID: <1468138073-4870-8-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KWtZbhR3JZ8dJOtL17PV5wY7seZGT+XOcdSwksyrDIk=;
        b=hpBc3I8Y7Z8/xTXYjRX2Gtj3TeFV7gRAg7QKydGARGjuyLDFn3ZtBP4ZCd2A3rpiTL
         1X8AA9YCzePlx8oBVQrLImNxgpxOIrK+6pRola5NfcVL9jr8dRf1IIElF4I2I686KPhV
         Lu+laQamT1yMkL7IJ/9nRw5ChDROAv3RpMD9f73BJvvwCY+RXbAt/AfoGO/iDs7nlBsX
         IkSA1CYgWkHdOWmV2pjVY0Dk+EvhvFR6cD14opTOVvQZ3gr+U08q5vr4Q8+wG9z6DfME
         LCEd0fxHM8Wxl/Iu702Ob4zDXI78QHYRMPAW8vaBCOAkThvRKTDNjsnFRjOFzipdtyZr
         mRvg==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

This isn't a return value, so change the message to indicate
the status is the result of may_umount().

(or locate pr_debug() after put_user() with the same message)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 5a877bf..b5e6f64 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -842,7 +842,7 @@ static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
 	if (may_umount(mnt))
 		status = 1;
 
-	pr_debug("returning %d\n", status);
+	pr_debug("may umount %d\n", status);
 
 	status = put_user(status, p);
 
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
