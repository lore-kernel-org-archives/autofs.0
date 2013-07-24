From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 1/7] use compiler determined by configure instead of hard-coded ones
Date: Wed, 24 Jul 2013 10:38:12 +0800
Message-ID: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/i+FmRS9KH2iMqygWc+u3Ia6scHZIyYYdwfyIgPOfak=;
        b=gXrzsdb1ENrE6nKokKmAOTVPgB/eWE9M7mHD2Lv7bHmltCymgyAbas9T+UXDfWF/cM
         K8vKGQ1qXUVyDlT1YDjRqrzYzWCnIizO33cxxRIrvNaTvrjDHJ3F3ZZgj6B1nxSY+cWB
         QsrbBLO1kclv59r2bPG+2UCMwFdya/GNDuN5T/2L4JWb3gOaOl3CNyXwaaQGMrkBTzpo
         PcHFa7OWijeC6GDkrTDu8df5iWGVjZhAU5Stue/mrpp5dm4lfEketDGSccMlUykchIvV
         Pcp/cs/PpoOjZD2ZVydvRl25Ovz0cncjp7dD0CXJLv1zXO99ZqHGR+x2qSqIAWWeQp6c
         2o9g==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

the logic here is:
 if user pass compiler variable, then use it, otherwise fallback to default value

this will provide most flexibility, so user can set this variable
it would be even useful for cross-compile environment.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.conf.in | 3 +++
 Makefile.rules   | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile.conf.in b/Makefile.conf.in
index 3766d45..cb53e66 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -109,3 +109,6 @@ initdir = @initdir@
 
 # Location of systemd unit files
 systemddir = @systemddir@
+
+# Use the compiler determined by configure instead of hard-coded ones
+CC := @CC@
diff --git a/Makefile.rules b/Makefile.rules
index f2ba386..a05a6df 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -38,10 +38,10 @@ STRIP     = strip --strip-debug
 endif
 endif
 
-CC        = gcc
-CXX       = g++
-CXXFLAGS  = $(CFLAGS)
-LD        = ld
+CC        ?= gcc
+CXX       ?= g++
+CXXFLAGS  ?= $(CFLAGS)
+LD        ?= ld
 SOLDFLAGS = -shared
 
 CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
-- 
1.8.3.2

