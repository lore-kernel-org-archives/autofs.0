From: Waldemar Brodkorb <wbx@openadk.org>
Subject: [PATCH v2] use pkg-config to search for libtirpc to fix
 cross-compilation
Date: Wed, 28 Jun 2017 12:29:50 +0200
Message-ID: <20170628102950.GA7247@waldemar-brodkorb.de>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>

When trying to cross-compile autofs for example with a buildsystem
like buildroot, the compilation fails in case the user wants to use
libtirpc library as RPC implementation. A hard coded include path
in aclocal.m4 is used. Other opensource software like rpcbind or
nfs-utils are suing autotools pkgconfig infrastructure to find
the libtirpc headers and to pass the correct linker flags.

Convert configure.in to use PKG_CHECK_MODULES and remove the
hand written autoconf macros from aclocal.m4.

To autoreconf the package you need pkg-config or pkgconf installed,
which provides the needed autoconf macros in pkg.m4. For an
non-automake project a full path to pkg.m4 is required.

This fixes cross-compilation of autofs and allows to use
alternative C libraries as uClibc-ng without internal RPC
support to be used in cross-compiling environments.

Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
---
v1 -> v2:
  - add a better commit decription
  - add back missing TIRPC_WORKAROUND/WITH_LIBTIRPC defines
  - add back AC_CHECK_FUNCS([getrpcbyname getservbyname])

For autoheader/autoconf to generate configure/config.h you
need to have pkg-config installed on your development machine.
When the user does not have installed pkg-config later, he
can use autofs without libtirpc as before. 
Configure will fail when the user use --with-libtirpc and
pkg-config is not installed.

---
 Makefile.conf.in |  3 ++-
 Makefile.rules   |  2 +-
 aclocal.m4       | 48 ------------------------------------------------
 configure.in     | 16 ++++++++++++++--
 4 files changed, 17 insertions(+), 52 deletions(-)

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
index 0521252..71e9573 100644
--- a/configure.in
+++ b/configure.in
@@ -11,6 +11,9 @@ define([AC_CACHE_LOAD], )dnl
 define([AC_CACHE_SAVE], )dnl
 AC_INIT(.autofs-5.1.3)
 
+# for pkg-config macros
+m4_include([/usr/share/aclocal/pkg.m4])
+
 #
 # autofs installs by default in /usr
 #
@@ -124,8 +127,17 @@ AC_SUBST(flagdir)
 #
 # Use libtirpc
 #
-AF_WITH_LIBTIRPC()
-AC_SUBST(TIRPCLIB)
+PKG_PROG_PKG_CONFIG()
+AC_ARG_WITH([libtirpc], AS_HELP_STRING([--with-libtirpc], [use libtirpc if available]))
+if test "x$with_libtirpc" = "xyes"; then
+  PKG_CHECK_MODULES([TIRPC],[libtirpc],[
+		AC_DEFINE(WITH_LIBTIRPC,1,
+			[Define to 1 if you have the libtirpc library installed])
+		AC_DEFINE(TIRPC_WORKAROUND,1,
+			[Define to 1 to use the libtirpc tsd usage workaround])
+    ])
+  AC_CHECK_FUNCS([getrpcbyname getservbyname])
+fi
 
 #
 # Optional include dmalloc
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
