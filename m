From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 3/7] variable "-lpthread" should put into LIBS, not LDFLAGS
Date: Wed, 24 Jul 2013 10:38:14 +0800
Message-ID: <1374633498-28385-3-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=08RfvWKtFT8Ai0lW9vERl4WDTmWMZBopY57Rv9koej4=;
        b=QdbuUgAlsdaSr8MxQ5x+WvEQF/KCj1ohQfNFSaSQZD1I33O17vu3HmhPLlns+IFzp2
         oh4iM8QoazIrfupWbwfDPL2q/qPBy+hi9lWLrgwkgPZ6eKcd5O0BRczBTGVizzWDNbhh
         Rpz43bN5g6tlqda+x8L6vSF+ptAW0sLmskG0qeK3ZlvDNBbsOKeWdpsefh+NN+iiMzuZ
         /P4e3qzXRwPfil1eZj5P0Lb7Sid1G1yWabXhWFvcW3NniRtXEtPX65LgnXAv0uoROwZ0
         Gofd2htO15Hugq7jz672j4Q807bx2u8sQdTLa5rxK/r71/NqT1OFpw06OU6aCidrwLoj
         wqeA==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

quote:
 "Don't use this variable to pass library names (-l) to the linker; use LIBS instead."

see the section "Variable: LDFLAGS"

[1] http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Preset-Output-Variables.html#Preset-Output-Variables

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.rules b/Makefile.rules
index d00ba3c..b4fab4c 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -45,7 +45,7 @@ LD        ?= ld
 SOLDFLAGS = -shared
 
 CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
-LDFLAGS += -lpthread
+LIBS += -lpthread
 
 ifdef TIRPCLIB
 CFLAGS += -I/usr/include/tirpc
-- 
1.8.3.2

