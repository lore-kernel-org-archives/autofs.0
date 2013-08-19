From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/25] autofs-5.0.7 - use compiler determined by configure
 instead of hard-coded ones
Date: Mon, 19 Aug 2013 09:13:08 +0800
Message-ID: <20130819011307.6472.44334.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=MwXmQuSsbOuN0El/N0Wir/fEw94=; b=k2dDdcWnbjg6Ki60lg3MAKGJlezR
	57WcFlKjCf9GytYWnHrW25G5PS4PtXSu52vWCHRdpwrmfq4FICGNO0RBkssvMn3G
	05dr7vE7RCjJdAhdTPHQ+mHo3VIFPQ5AiveQt/6XJqSeAvO8JKn07UzsYT7FnM+K
	1ifeOBVJ68aWLV0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=MwXmQuSsbOuN0El/N0Wir/
	fEw94=; b=lTUxvDYiS8pv40yZJZFMhJdl28U6KR38rBVs7E5Xmmi7CkcFwz1QYn
	eocGwQz22r8/ogXWkCHEWLTMQZCkzWV/1fRIRsGcyKX8FQHhfaqE+Pe17SKGUdI/
	Ncj4slV9mvmzXyc9OfeTdqOOzcqNOzGO2zG2CJ6STbEi0qBaNYazw=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

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
index 679a469..8f349a2 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -63,6 +63,7 @@
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

