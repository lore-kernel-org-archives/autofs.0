From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 7/7] unbundle NOTSTRIP from DEBUG, so they won't depend on each other
Date: Wed, 24 Jul 2013 10:38:18 +0800
Message-ID: <1374633498-28385-7-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h1uuJydWjWeyVHX163DaWpMbN5zTHmYVFFZ30lqItrw=;
        b=Uha7c75FREAzJa6Lcxx3E2xzF1bJgK5+Ur3iq/jTBlnUA0QxIHlshR3V5gZ72IGRAz
         VrWdLOd+08J7Q7mPTAL8RPGmVgNNKBQCbeRJeZ7UaBpgtoRElZfKU133n4uUH7Br6+jN
         DuyHSWp2Qf+xSycZ1be3otT8aL93iQxtN+m7qmfWC5mY//6qJq+0x6Ftt8DjAL9vQEtA
         YyH3iWl/C8XcASzEgm5Nr4bs40/kBbrw06oAmmPglLf+dxLTbCmWVGPRx7S/MezRwz40
         I2LnQWlJNr2TmEuuUljnTUsHBzXqVKlI24kKdkYdymirEbrsFlMM16xMm1AUh1QHubvy
         ruuw==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

gentoo build system expects unstripped elf image from the build system,
seperate this, will allow us to better control the strip operation.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.rules | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Makefile.rules b/Makefile.rules
index fa53459..0754a00 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -25,18 +25,16 @@ endif
 ifdef DEBUG
 CFLAGS    ?= -g -Wall -DDEBUG
 LDFLAGS   ?= -g
-STRIP     ?= :
 else
+CFLAGS    ?= -O2 -Wall
+LDFLAGS   ?= -s
+endif
+
 ifdef DONTSTRIP
-CFLAGS    ?= -O2 -g
-LDFLAGS   ?= -g
 STRIP     ?= :
 else
-CFLAGS    ?= -O2 -Wall
-LDFLAGS   ?= -s
 STRIP     ?= strip --strip-debug
 endif
-endif
 
 CC        ?= gcc
 CXX       ?= g++
-- 
1.8.3.2

