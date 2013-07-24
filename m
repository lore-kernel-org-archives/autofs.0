From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 2/7] remove hard-coded CFLAGS, LDFLAGS
Date: Wed, 24 Jul 2013 10:38:13 +0800
Message-ID: <1374633498-28385-2-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ng0+VkUkXvBBYYfOGAY5DTZGORu1+sdp2S47Ya325Sc=;
        b=hav5Sa4ica71vqeRYUp6jAzL7Nv6pyJNDXxDyZ/IcRvJqVSHSMyz+gqztPl50bDptz
         R7WWSxDOWTIQ+p3v4FwAXUNClsnTNxFrnfI4C/AsYr3N7nTnhdNKfgnIMOtlvHpSQOtK
         LIoC+ARXwX5l67f8LTIpSyQxxtHRBrzLJJCPfB/9PDr+oBCbkBINg2yfotrqBOyPvkqQ
         FWrN40j9osRrkXxfmM5HO+7gXdAU/6At6YnSxKOfllqqlWTATdZ2Dl64f9EOHMSAR+m9
         iu5qeV40zrtH/BIFJWGu6FSjLFz1XtPJOvxfWXkMO+mNGs9Yiq7RmFDWOA2mYISc5ouI
         N4tQ==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

according to autoconf manual[1], build script should allow user override the CFLAGS, LDFLAGS
varible (passed via ./configure). And actually, we should not directly use CFLAGS,
LDFLAGS, but have to create another one (eg. AUTOFS_CFLAGS). FYI, see section "Variable: CFLAGS",
the last paragraph.

Here, I slightly modify the code so that we can still fallback to the default one.

[1] http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Preset-Output-Variables.html#Preset-Output-Variables

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.rules | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile.rules b/Makefile.rules
index a05a6df..d00ba3c 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -24,17 +24,17 @@ endif
 
 ifdef DEBUG
 CFLAGS    ?= -g -Wall -DDEBUG
-LDFLAGS   = -g
-STRIP     = :
+LDFLAGS   ?= -g
+STRIP     ?= :
 else
 ifdef DONTSTRIP
 CFLAGS    ?= -O2 -g
-LDFLAGS   = -g
-STRIP     = :
+LDFLAGS   ?= -g
+STRIP     ?= :
 else
 CFLAGS    ?= -O2 -Wall
-LDFLAGS   = -s
-STRIP     = strip --strip-debug
+LDFLAGS   ?= -s
+STRIP     ?= strip --strip-debug
 endif
 endif
 
-- 
1.8.3.2

