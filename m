From: Waldemar Brodkorb <wbx@openadk.org>
Subject: fix cross-compile when libtirpc is used
Date: Tue, 27 Jun 2017 21:22:39 +0200
Message-ID: <20170627192239.GC26922@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M0YLxmUXciMpOLPE"
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org


--M0YLxmUXciMpOLPE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

I would like to suggest following patch, which uses pkg-config
to find libtirpc headers and libraries.
This allows to cross-compile autofs. The patch was suggested 
on the buildroot mailinglist, too.

Best regards
 Waldemar


--M0YLxmUXciMpOLPE
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0002-use-pkg-config-to-search-for-libtirpc-to-fix-cross-c.patch"

From 7582cb88121d1ca4431def9175469e1590e9c29f Mon Sep 17 00:00:00 2001
From: Waldemar Brodkorb <wbx@openadk.org>
Date: Tue, 27 Jun 2017 18:11:56 +0200
Subject: [PATCH] use pkg-config to search for libtirpc to fix
 cross-compilation

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
---
 Makefile.conf.in |  3 ++-
 Makefile.rules   |  2 +-
 aclocal.m4       | 48 ------------------------------------------------
 configure.in     | 11 +++++++++--
 4 files changed, 12 insertions(+), 52 deletions(-)

diff --git a/Makefile.conf.in b/Makefile.conf.in
index 2bc3202..f879e26 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -64,7 +64,8 @@ RPCGEN = @PATH_RPCGEN@
 RANLIB = @PATH_RANLIB@
 
 # Use libtirpc if requested and available
-TIRPCLIB = @TIRPCLIB@
+TIRPCLIB = @TIRPC_LIBS@
+TIRPCCFLAGS = @TIRPC_CFLAGS@
 
 # Use dmalloc for memory debuging
 DMALLOCLIB = @DMALLOCLIB@
diff --git a/Makefile.rules b/Makefile.rules
index 7d1af2e..0edf9bf 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -46,7 +46,7 @@ CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
 LIBS += -lpthread
 
 ifdef TIRPCLIB
-CFLAGS += -I/usr/include/tirpc
+CFLAGS += $(TIRPCCFLAGS)
 LIBS += $(TIRPCLIB)
 endif
 
diff --git a/aclocal.m4 b/aclocal.m4
index 00811e0..31ca602 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -399,51 +399,3 @@ fi
 LIBS="$af_check_ldap_parse_page_control_save_libs"
 ])
 
-dnl --------------------------------------------------------------------------
-dnl AF_CHECK_LIBTIRPC
-dnl
-dnl Use libtirpc for rpc transport
-dnl --------------------------------------------------------------------------
-AC_DEFUN([AF_CHECK_LIBTIRPC],
-[
-# save current flags
-af_check_libtirpc_save_cflags="$CFLAGS"
-af_check_libtirpc_save_libs="$LIBS"
-CFLAGS="$CFLAGS -I/usr/include/tirpc"
-LIBS="$LIBS -ltirpc"
-
-AC_TRY_LINK(
-    [ #include <rpc/rpc.h> ],
-    [ CLIENT *cl;
-      struct sockaddr_in addr;
-      int fd;
-      unsigned long ul; struct timeval t; unsigned int ui;
-      cl = clntudp_bufcreate(&addr,ul,ul,t,&fd,ui,ui); ],
-    [ af_have_libtirpc=yes
-      AC_MSG_RESULT(yes) ],
-    [ AC_MSG_RESULT(no) ])
-
-if test "$af_have_libtirpc" = "yes"; then
-    AC_DEFINE(WITH_LIBTIRPC,1, [Define to 1 if you have the libtirpc library installed])
-    AC_DEFINE(TIRPC_WORKAROUND,1, [Define to 1 to use the libtirpc tsd usage workaround])
-    TIRPCLIB="-ltirpc"
-fi
-
-AC_CHECK_FUNCS([getrpcbyname getservbyname])
-
-# restore flags
-CFLAGS="$af_check_libtirpc_save_cflags"
-LIBS="$af_check_libtirpc_save_libs"
-])
-
-AC_DEFUN([AF_WITH_LIBTIRPC],
-[AC_MSG_CHECKING([if libtirpc is requested and available])
-AC_ARG_WITH(libtirpc,
-[  --with-libtirpc         use libtirpc if available],
-[if test "$withval" = yes; then
-  AF_CHECK_LIBTIRPC()
-else
-  AC_MSG_RESULT(no)
-fi], [AC_MSG_RESULT(no)])
-])
-
diff --git a/configure.in b/configure.in
index 0521252..43a2776 100644
--- a/configure.in
+++ b/configure.in
@@ -11,6 +11,9 @@ define([AC_CACHE_LOAD], )dnl
 define([AC_CACHE_SAVE], )dnl
 AC_INIT(.autofs-5.1.3)
 
+# for pkg-config/pkconf
+m4_include([pkg.m4])
+
 #
 # autofs installs by default in /usr
 #
@@ -124,8 +127,12 @@ AC_SUBST(flagdir)
 #
 # Use libtirpc
 #
-AF_WITH_LIBTIRPC()
-AC_SUBST(TIRPCLIB)
+PKG_PROG_PKG_CONFIG()
+
+AC_ARG_WITH([libtirpc], AS_HELP_STRING([--with-libtirpc], [Build with the TIRPC library]))
+if test "x$with_libtirpc" = "xyes"; then
+  PKG_CHECK_MODULES([TIRPC],[libtirpc])
+fi
 
 #
 # Optional include dmalloc
-- 
2.1.4


--M0YLxmUXciMpOLPE--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
