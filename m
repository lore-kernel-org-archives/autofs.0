From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/9] autofs-5.0.7 - fix typo forced-shutdown should be
 force-shutdown
Date: Wed, 24 Jul 2013 16:53:05 +0800
Message-ID: <20130724085304.3884.43652.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=eqvqu2Wcy82invtOcZZHPRjTH/w=; b=teGigYWQt/AvefQSR2kxWUyEuYk2
	gkm1jKIH2529I47RlkKV1wxRsGGW9g8ulRXY8Ds25zs9NoJMBgpyjqMXUCy0ahqQ
	TvmPN/zU+ehKFeDQYEVqB+C+E//aY1rSVMmeR6FM3hv3x7o47CrKCHj6riXUulvs
	ZH9IgWImXbjFiw4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=eqvqu2Wcy82invtOcZZHPR
	jTH/w=; b=IBN5yoECVk3mZFoNztRr/MZCIHMNL24lJsFKISibpM8c62j3sI6W1S
	hDDe7nekQ8kcxLUi1/dx4PTqmsfGQIhP//LBKeX0OdcY5M+FLPRyoOaqt7dx/NXL
	jAYPs1D+hWRl+LwgIYgnFBTWhELE0KC7TSwusJ8MAz1ecizeI4LCY=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

This will confuse people when they find what shows with "./configure --help"
is different from what is actually used.

Edited by: Ian Kent <raven@themaw.net>
- make description a little more readable.
- update configure to include change.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG    |    1 +
 configure    |    8 ++++----
 configure.in |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3228d6b..5751805 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -57,6 +57,7 @@
 - fix a couple of compiler warnings.
 - add after sssd dependency to unit file.
 - dont start readmap unless ready.
+- fix typo forced-shutdown should be force-shutdown.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/configure b/configure
index 08b7ccc..e412734 100755
--- a/configure
+++ b/configure
@@ -741,7 +741,7 @@ with_openldap
 with_sasl
 enable_ext_env
 enable_mount_locking
-enable_forced_shutdown
+enable_force_shutdown
 enable_ignore_busy
 '
       ac_precious_vars='build_alias
@@ -5553,9 +5553,9 @@ fi
 #
 # Enable forced shutdown on USR1 signal (unlink umounts all mounts).
 #
-# Check whether --enable-forced-shutdown was given.
-if test "${enable_forced_shutdown+set}" = set; then :
-  enableval=$enable_forced_shutdown;
+# Check whether --enable-force-shutdown was given.
+if test "${enable_force_shutdown+set}" = set; then :
+  enableval=$enable_force_shutdown;
 else
   enableval=no
 fi
diff --git a/configure.in b/configure.in
index 559045a..0013a39 100644
--- a/configure.in
+++ b/configure.in
@@ -363,7 +363,7 @@ fi
 #
 # Enable forced shutdown on USR1 signal (unlink umounts all mounts).
 #
-AC_ARG_ENABLE(forced-shutdown,
+AC_ARG_ENABLE(force-shutdown,
 [  --enable-force-shutdown enable USR1 signal to force unlink umount of any
 			  busy mounts during shutdown],,
 	enableval=no)

