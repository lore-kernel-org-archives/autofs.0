From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/9] autofs-5.0.7 - fix hesiod check error and use correct
 $(LIBS) setting
Date: Wed, 24 Jul 2013 16:53:13 +0800
Message-ID: <20130724085311.3884.83336.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=wl2llen1O9+jHv4F3RhuAobuTkU=; b=F4bwRWvSIB98j3TJ8OIiNb8OgmAt
	SKfCc7naqdz8L1evw/knQ8nJn740zjdIA8IdyP+lUyuJVWEp+J0iBgwYA262hdQT
	0kODs9x4EiParXFSd4o1FwHHJCPTLVp3MNU4dkYnb+u0Qgf9DMgPwwPNu0820vwe
	WncjbJ8Xi5KYAOA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=wl2llen1O9+jHv4F3RhuAo
	buTkU=; b=cofI66Oteo7TMXb5meXZPKTsr3DM8H/3oOXeepc83Aoup7qQ6acQoN
	Ita2ogNwYBoj33OVULfJwdVVudtlpSOWhutquO9+6huz1P6kz6xL6qYGHxe3Ra6e
	GPSxf3H2hiS4fdKYdiSrIhJaebObSdhFWMED7EUgk5xyR+oKQkYFs=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

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
index 5751805..3c829cf 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -58,6 +58,7 @@
 - add after sssd dependency to unit file.
 - dont start readmap unless ready.
 - fix typo forced-shutdown should be force-shutdown.
+- fix hesiod check error and use correct $(LIBS) setting.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/aclocal.m4 b/aclocal.m4
index c5de159..110d106 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -309,20 +309,20 @@ dnl --------------------------------------------------------------------------
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
index e412734..3801e9d 100755
--- a/configure
+++ b/configure
@@ -4221,9 +4221,9 @@ then
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
@@ -4231,7 +4231,7 @@ cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 int
 main ()
 {
- char *c; hesiod_init(&c);
+ void *c; hesiod_init(&c);
   ;
   return 0;
 }
@@ -4248,8 +4248,8 @@ fi
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 
-# restore ldflags
-LDFLAGS="$af_check_hesiod_save_ldflags"
+# restore libs
+LIBS="$af_check_hesiod_save_libs"
 
 	if test "$HAVE_HESIOD" == "1"; then
 

