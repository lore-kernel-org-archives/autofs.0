From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/25] autofs-5.0.7 - unbundle NOTSTRIP from DEBUG so they
 dont depend on each other
Date: Mon, 19 Aug 2013 09:13:28 +0800
Message-ID: <20130819011327.6472.98647.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=gb/mYPtzhOEjqVbAPvfmPwoMJzs=; b=H4PehtYR/H3mTae9DwylUZzG4NCu
	debZkiIQhYTEL0MI6l9LJPwK269wnWDWW1HwvhcC3YCImuSGVL4X65pZGxje5k5j
	qT32XynFjE4niOCD8u69unSfbZ7oTjsMGvX245x3FdYz0sFt4lsznUl9q/1afohP
	5bJQwlFXytdmUgY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=gb/mYPtzhOEjqVbAPvfmPw
	oMJzs=; b=OjKxSJcr8qCQoXRPUUB/sqzzkscQd89ueaTDZ8PyoVAlKJLcFlljca
	gomnhTl1XUX7cgSLou4X4Dr8eVpTg4lZUohtKlEi4T9nGScgGDTzba9SwH6XDroQ
	29ykvm2hQ13kSGnD5Icb2VkIaVEWYuJsQTHbK9Kn+WGk1/AhfkRXo=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

Gentoo build system expects unstripped elf image from the build system,
seperate this, will allow us to better control the strip operation.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG      |    1 +
 Makefile.rules |   10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3af7ece..dd6fc1a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -66,6 +66,7 @@
 - use compiler determined by configure instead of hard-coded ones.
 - remove hard-coded STRIP variable.
 - use LIBS for link libraries.
+- unbundle NOTSTRIP from DEBUG so they dont depend on each other.
 
 25/07/2012 autofs-5.0.7
 =======================
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

