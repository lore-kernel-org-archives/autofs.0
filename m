From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 4/7] library should pass via variable $(LIBS), not $(LDFLAGS)
Date: Wed, 24 Jul 2013 10:38:15 +0800
Message-ID: <1374633498-28385-4-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KoFn1LkS1MyfsALi1ABw5LoFIJqWLty6/vMyuQ7sIzI=;
        b=a8iDkQy0LnU5SHEQ05Fpe7Y6U/zn2+GJwA0HVdew7Ty3Ki03wuhF31Mf1SMD/YSFbV
         mmhfA2mxZPfWm4E7Gsf3q2iSOw3EpoblzZPKx4b+Xtdll3LqiMJkG3l8CbY2mmtip1sH
         PilqhSnMH3KSwulfUZ8/ukkl8Vl4cRpN8MEXEjUbgoQKpsTmV3O7s4U+IM3idjqT9Elq
         OOj/LHe5P/WyNo9WOiYuVmt/Gl+nW9Nu+3oC8RawC5wrqLbrrNJiKVl+m44lGvPJBesh
         a6H6pS1XZlxe+9zuGx6YPVZIUa85dVZS0GT+gUwTrB09RCpae6ffmUnx58N0cEvY/xX2
         Otcw==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.rules | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.rules b/Makefile.rules
index b4fab4c..c431eca 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -49,13 +49,15 @@ LIBS += -lpthread
 
 ifdef TIRPCLIB
 CFLAGS += -I/usr/include/tirpc
-LDFLAGS += $(TIRPCLIB)
+LIBS += $(TIRPCLIB)
 endif
 
 ifdef DMALLOCLIB
-LDFLAGS += $(DMALLOCLIB)
+LIBS += $(DMALLOCLIB)
 endif
 
+LIBS += $(LIBNSL)
+
 # Standard rules
 
 .SUFFIXES: .c .o .s .so
@@ -67,5 +69,5 @@ endif
 	$(CC) $(CFLAGS) -S $<
 
 .c.so:
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(DMALLOCLIB) $(LIBNSL)
+	$(CC) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) $*.so
-- 
1.8.3.2

