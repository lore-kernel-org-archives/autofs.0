From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 6/6] fix typo, forced-shutdown should be force-shutdown
Date: Mon, 22 Jul 2013 22:59:54 +0800
Message-ID: <1374505194-22668-7-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GarQ7jV/Ihz3c3WenvTntofWQfrfYkm9yqDJkoDoejc=;
        b=LrUfM7//RkA9y9NXAmtSiPFtfNHDVSTmDYTZAuvEX4Z3EHKwP2CBCQsTqwOlNf9wDT
         GWkYJu83BbUYlQAMz2VY8dDBDCys1vGDymYCIxauRlOoSnoXjTEldf/KFfbWw08zC3cv
         S4ZbG/cT0R8P5PBvpR6Mbyfr5g6dO82Q2KrSdYaSrsOmEiWg1OaCNJjGOJzKKZuAs6Oc
         XvWLCukj4FtyfMRySa8ARLCf5NClieJa9EwyAfCN0POkRj9XoIG1uMxe0ZQQuopUowYC
         YbkrrTFUjIL41ZiEoC4ga/X5IJTVMQPoG+YqdRFnNbtTgddVMfrsynwjqINFtcxQl680
         KvoA==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

it will confuse user when they found what shows with "./configure --help"
differ from what it should be.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 configure.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.in b/configure.in
index 559045a..0013a39 100644
--- a/configure.in
+++ b/configure.in
@@ -363,7 +363,7 @@ fi
 #
 # Enable forced shutdown on USR1 signal (unlink umounts all mounts).
 #
-AC_ARG_ENABLE(forced-shutdown,
+AC_ARG_ENABLE(force-shutdown,
 [  --enable-force-shutdown enable USR1 signal to force unlink umount of any
 			  busy mounts during shutdown],,
 	enableval=no)
-- 
1.8.2.1

