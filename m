From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/25] autofs-5.0.7 - fix typo forced-shutdown should be
 force-shutdown
Date: Mon, 19 Aug 2013 09:12:40 +0800
Message-ID: <20130819011239.6472.70778.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=fQhvmjj7PfAs/sKcUdZ6ghm2mYs=; b=uHPhQTAeyDSf2nvRTMczhff/mZzG
	rZOPkAmI+tin+dBKnvBnKgNaBdxDNioF/IGBBcxOKGFwbEbvs6QppWwRN/x04c2f
	Pduy8z2nn0aK0Exo1RecyCDTJvsixmEGhlVmlQIPau/PjUHx+edjKHYaRDPdcEc8
	c1kZoVPtIRhku3Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=fQhvmjj7PfAs/sKcUdZ6gh
	m2mYs=; b=bvbH8NiSdVby+N/i75ThyJbSVyb2C/4+uk4X222bMxe62gVA0ayqfH
	BKvPV5wUKrAuVqNoVxmh5M/xXk/P8kbscGXU+Kp1cJfrO3CijNwDnuqPO13WwnQd
	YMTSGWpscVYPxPH7OdZGtNCst1IZ5bZRMepu04EsYhgpk0oKOxWTs=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

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
index c77be18..5265f6c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -59,6 +59,7 @@
 - dont start readmap unless ready.
 - fix crash due to thread unsafe use of libldap.
 - fix compile error with heimdal support enabled.
+- fix typo forced-shutdown should be force-shutdown.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/configure b/configure
index 1086eba..b8e74b7 100755
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
@@ -5637,9 +5637,9 @@ fi
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

