From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: [PATCH] autofs: fix libtirpc detection with -Wl,--as-needed
Date: Wed,  6 Jul 2016 22:29:14 +0200
Message-ID: <20160706202914.26861-1-Martin.vGagern@gmx.net>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Martin von Gagern <Martin.vGagern@gmx.net>

As reported in https://bugs.gentoo.org/show_bug.cgi?id=588106, the configure
script will fail to detect the presence of libtirpc if -Wl,--as-needed is
included in LDFLAGS.  That is because the check incorrectly includes the
argument -ltircp in the LDFLAGS variable, instead of the LIBS variable where
it belongs.  LIBS comes after the objects so it will be used to satisfy
their dependencies.  LDFLAGS will come before them, causing the library to
be skipped if the --as-needed linker flag is in effect.

Signed-off-by: Martin von Gagern <Martin.vGagern@gmx.net>
---
 aclocal.m4 | 6 +++---
 configure  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index 2115204..fe949a2 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -413,9 +413,9 @@ AC_DEFUN([AF_CHECK_LIBTIRPC],
 [
 # save current flags
 af_check_libtirpc_save_cflags="$CFLAGS"
-af_check_libtirpc_save_ldflags="$LDFLAGS"
+af_check_libtirpc_save_libs="$LIBS"
 CFLAGS="$CFLAGS -I/usr/include/tirpc"
-LDFLAGS="$LDFLAGS -ltirpc"
+LIBS="$LIBS -ltirpc"
 
 AC_TRY_LINK(
     [ #include <rpc/rpc.h> ],
@@ -438,7 +438,7 @@ AC_CHECK_FUNCS([getrpcbyname getservbyname])
 
 # restore flags
 CFLAGS="$af_check_libtirpc_save_cflags"
-LDFLAGS="$af_check_libtirpc_save_ldflags"
+LIBS="$af_check_libtirpc_save_libs"
 ])
 
 AC_DEFUN([AF_WITH_LIBTIRPC],
diff --git a/configure b/configure
index 3e2de6f..3227c71 100755
--- a/configure
+++ b/configure
@@ -3194,9 +3194,9 @@ if test "${with_libtirpc+set}" = set; then :
 
 # save current flags
 af_check_libtirpc_save_cflags="$CFLAGS"
-af_check_libtirpc_save_ldflags="$LDFLAGS"
+af_check_libtirpc_save_libs="$LIBS"
 CFLAGS="$CFLAGS -I/usr/include/tirpc"
-LDFLAGS="$LDFLAGS -ltirpc"
+LIBS="$LIBS -ltirpc"
 
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -3249,7 +3249,7 @@ done
 
 # restore flags
 CFLAGS="$af_check_libtirpc_save_cflags"
-LDFLAGS="$af_check_libtirpc_save_ldflags"
+LIBS="$af_check_libtirpc_save_libs"
 
 else
   { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
