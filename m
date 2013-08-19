From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/25] autofs-5.0.7 - don't override LDFLAGS in make rules
Date: Mon, 19 Aug 2013 09:11:59 +0800
Message-ID: <20130819011158.6472.68774.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=3JYRm3nCH7iSvQRepnMlEYnRpWo=; b=Lc4cj3dT11L24/vV19ZNpNpQb8tj
	wI8eqNkTdxFjF8DiaghQHyDqHDbcLiVO699PMyn/OyklgjCAUYv1wRsgZZdr5g8e
	5ha4mUdX0fp69jzo/cpXo4p2e+7MJssQOpea2GQBce8PIjfMs9lkYcSafvm0y3dE
	bDdzEhY9/y/aPk4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=3JYRm3nCH7iSvQRepnMlEY
	nRpWo=; b=kUd0T9ejxQCYBzAcdaWmxHQvUEWhs4lvXUaYPsd04fqxSAxy+F0z4I
	9NnkoduxzbF5W+hvwIm5b77sBFRHLa0DVAOh6Qv1uLPEBUj0zOp3Y12S0RgZ+vIk
	1Drbzxgsj9BvedfIA+xCppOd11P8UALMnMeTzZGvSEwKb+M9K/MFM=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Ian Kent <ikent@redhat.com>

Ensure that externally defined LDFLAGS is not overridden and ensure
binary is linked as RELRO in tar spec file.
---
 CHANGELOG      |    1 +
 Makefile.rules |    6 +++---
 autofs.spec    |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5d90139..37eac72 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -53,6 +53,7 @@
 - fix probe each nfs version in turn for singleton mounts.
 - misc man page fixes.
 - fix add null check in parse_server_string().
+- don't override LDFLAGS in make rules.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/Makefile.rules b/Makefile.rules
index f2ba386..6b5b2bd 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -24,16 +24,16 @@ endif
 
 ifdef DEBUG
 CFLAGS    ?= -g -Wall -DDEBUG
-LDFLAGS   = -g
+LDFLAGS   ?= -g
 STRIP     = :
 else
 ifdef DONTSTRIP
 CFLAGS    ?= -O2 -g
-LDFLAGS   = -g
+LDFLAGS   ?= -g
 STRIP     = :
 else
 CFLAGS    ?= -O2 -Wall
-LDFLAGS   = -s
+LDFLAGS   ?= -s
 STRIP     = strip --strip-debug
 endif
 endif
diff --git a/autofs.spec b/autofs.spec
index a768e44..9a2bf6e 100644
--- a/autofs.spec
+++ b/autofs.spec
@@ -85,12 +85,13 @@ echo %{version}-%{release} > .version
 
 %build
 CFLAGS="$RPM_OPT_FLAGS -Wall" \
+LDFLAGS="-Wl,-z,now" \
 ./configure --libdir=%{_libdir} \
 	--disable-mount-locking \
 	--enable-ignore-busy \
 	%{?systemd_configure_arg:} \
 	%{?libtirpc_configure_arg:}
-CFLAGS="$RPM_OPT_FLAGS -Wall" make initdir=/etc/rc.d/init.d DONTSTRIP=1
+CFLAGS="$RPM_OPT_FLAGS -Wall" LDFLAGS="-Wl,-z,now" make initdir=/etc/rc.d/init.d DONTSTRIP=1
 
 %install
 rm -rf $RPM_BUILD_ROOT

