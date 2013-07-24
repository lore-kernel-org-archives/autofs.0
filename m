From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/9] autofs-5.0.7 - use compiler determined by configure
 instead of hard-coded ones
Date: Wed, 24 Jul 2013 16:53:34 +0800
Message-ID: <20130724085333.3884.30723.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=9B61E2RwkmfV5CNJJW0VWVl5UZc=; b=WeJ5F8Qe6Opgyhum5SzLg+ghXdoO
	ikskd4LScpFqQUyAvYjpXbuh9/ue/YjI3bg+ESIjRV1KUTxwMMsb/sjL8A1YOBzu
	dWYwQ03gdRjMCitRqfn2cZl9lHxKhq1YRhp4Wg/6QbnO+zSogLGyNGt1Qnw/9SEj
	5+0lnKOaUAavTtQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=9B61E2RwkmfV5CNJJW0VWV
	l5UZc=; b=Dr2DAGtFo4+PaWSSREEEhjm8iKIIzCQ1NsmcJSddLVoIsq3DOdPf8Y
	p1YB2JgHSB8Ey6wpE0kuiNuDYDhhuNFQPl+O8lZ/5grwHUXeifb57SMAqNW0WaAB
	arMdNszoFDQKE6YPHiBaHzLhBPU/lOJFH72IoLaiEMx7dclY0VDSY=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

the logic here is:
 if user pass compiler variable, then use it, otherwise fallback to default value

this will provide most flexibility, so user can set this variable
it would be even useful for cross-compile environment.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG        |    1 +
 Makefile.conf.in |    3 +++
 Makefile.rules   |    8 ++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 72d9135..ebabf21 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -61,6 +61,7 @@
 - fix hesiod check error and use correct $(LIBS) setting.
 - fix dead LDAP symbolic link when LDAP support is disabled.
 - add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
+- use compiler determined by configure instead of hard-coded ones.
 
 25/07/2012 autofs-5.0.7
 =======================
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
index 6b5b2bd..9aebd19 100644
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

