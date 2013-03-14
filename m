From: Andreas Oberritter <obi@saftware.de>
Subject: [PATCH 2/3] autofs-5.0.7 - pass -pthread flag to gcc
Date: Thu, 14 Mar 2013 16:20:59 +0100
Message-ID: <1363274460-27237-2-git-send-email-obi@saftware.de>
References: <1363274460-27237-1-git-send-email-obi@saftware.de>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1363274460-27237-1-git-send-email-obi@saftware.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Fixes linker error on Ubuntu 12.10 due to unresolved symbols.

Signed-off-by: Andreas Oberritter <obi@saftware.de>
---
 Makefile.rules |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.rules b/Makefile.rules
index f2ba386..58b4bb2 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -44,8 +44,8 @@ CXXFLAGS  = $(CFLAGS)
 LD        = ld
 SOLDFLAGS = -shared
 
-CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
-LDFLAGS += -lpthread
+CFLAGS += -pthread -D_FILE_OFFSET_BITS=64
+LDFLAGS += -pthread
 
 ifdef TIRPCLIB
 CFLAGS += -I/usr/include/tirpc
-- 
1.7.10.4

