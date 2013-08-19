From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/25] autofs-5.0.7 - fix hesiod check error and use correct
 $(LIBS) setting
Date: Mon, 19 Aug 2013 09:12:47 +0800
Message-ID: <20130819011246.6472.31430.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=0CIbW7YGBMvmCJX+812kMQ1hXKE=; b=touLeKrfKvllOXBy1Gx+u02K+ZKx
	OtcYFQAq+AcCNyq6n1nrV7Xqf5P7PUmr1LQws78GDx34M1FZ1gGIxwimBDpMup6l
	i6QFYzxJRny+Q83vE3l/M2tS96DcW8p8XOkkxB46Dky79M8RJBroPW+un2RBejcz
	JtoWlvOQCOYTFMs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=0CIbW7YGBMvmCJX+812kMQ
	1hXKE=; b=skFKS3hXDXL9dzHYiYaw+9pGl398kxTDH0dIVzZpprTZlHcgMek4Cu
	NERmVQvtR2kWGUey+Yy3dVgUocLxPLf78tOMsuwt3utFz23anv/GqrYal/axdDlK
	qp4tFjrfPjkWPZjTT9sTR2zhqJXtnWCtM//Bn/jwjcanmCmv954TQ=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

the problem here is that hesiod checking always fail due to wrong $(LDFLAGS),
no matter hesiod library is installed or not. moving "-lhesiod" into
$(LIBS) solve this problem.

1) convert "char *" -> "void *" to fix the compile warning
2) put "-lhesiod -lresolv" into $(LIBS), not into $(LDFLAGS), otherwise we got link error

Edited by: Ian Kent <raven@themaw.net>
- update configure to include change.
---
 CHANGELOG  |    1 +
 aclocal.m4 |   12 ++++++------
 configure  |   12 ++++++------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5265f6c..647504b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -60,6 +60,7 @@
 - fix crash due to thread unsafe use of libldap.
 - fix compile error with heimdal support enabled.
 - fix typo forced-shutdown should be force-shutdown.
+- fix hesiod check error and use correct $(LIBS) setting.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/aclocal.m4 b/aclocal.m4
index 7a8b03c..637a775 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -316,20 +316,20 @@ dnl --------------------------------------------------------------------------
 AC_DEFUN([AF_CHECK_LIBHESIOD],
 [AC_MSG_CHECKING(for libhesiod)
 
-# save current ldflags
-af_check_hesiod_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lhesiod -lresolv"
+# save current libs
+af_check_hesiod_save_libs="$LIBS"
+LIBS="$LIBS -lhesiod -lresolv"
 
 AC_TRY_LINK(
   [ #include <hesiod.h> ],
-  [ char *c; hesiod_init(&c); ],
+  [ void *c; hesiod_init(&c); ],
   [ HAVE_HESIOD=1
     LIBHESIOD="$LIBHESIOD -lhesiod -lresolv"
     AC_MSG_RESULT(yes) ],
   [ AC_MSG_RESULT(no) ])
 
-# restore ldflags
-LDFLAGS="$af_check_hesiod_save_ldflags"
+# restore libs
+LIBS="$af_check_hesiod_save_libs"
 ])
 
 dnl --------------------------------------------------------------------------
diff --git a/configure b/configure
index b8e74b7..e6d5d4a 100755
--- a/configure
+++ b/configure
@@ -4305,9 +4305,9 @@ then
 	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for libhesiod" >&5
 $as_echo_n "checking for libhesiod... " >&6; }
 
-# save current ldflags
-af_check_hesiod_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lhesiod -lresolv"
+# save current libs
+af_check_hesiod_save_libs="$LIBS"
+LIBS="$LIBS -lhesiod -lresolv"
 
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -4315,7 +4315,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 int
 main ()
 {
- char *c; hesiod_init(&c);
+ void *c; hesiod_init(&c);
   ;
   return 0;
 }
@@ -4332,8 +4332,8 @@ fi
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 
-# restore ldflags
-LDFLAGS="$af_check_hesiod_save_ldflags"
+# restore libs
+LIBS="$af_check_hesiod_save_libs"
 
 	if test "$HAVE_HESIOD" == "1"; then
 

