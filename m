From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/35] autofs-5.1.3 - use pkg-config to search for libtirpc
 to fix cross-compilation
Date: Mon, 16 Oct 2017 13:06:54 +0800
Message-ID: <150813041486.25695.10622775620387865810.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Waldemar Brodkorb <wbx@openadk.org>

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
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 
 Makefile.conf.in |    3 
 Makefile.rules   |    2 
 aclocal.m4       |   48 --------
 configure        |  329 +++++++++++++++++++++++++++++++++++++++++++-----------
 configure.in     |   16 ++-
 6 files changed, 281 insertions(+), 118 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 257e3501..72c3ee70 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -8,6 +8,7 @@ xx/xx/2017 autofs-5.1.4
 - add version parameter to rpc_ping().
 - fix typo in autofs config file comments.
 - fix typos in autofs man pages.
+- use pkg-config to search for libtirpc to fix cross-compilation.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/Makefile.conf.in b/Makefile.conf.in
index 2bc3202e..f879e262 100644
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
index 7d1af2e0..0edf9bfe 100644
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
index 40e1ee97..51772043 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -417,51 +417,3 @@ fi
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
diff --git a/configure b/configure
index 9ba26707..c8b8da3c 100755
--- a/configure
+++ b/configure
@@ -672,7 +672,6 @@ MOUNT_NFS
 HAVE_MOUNT
 MOUNT
 DMALLOCLIB
-TIRPCLIB
 OBJEXT
 EXEEXT
 ac_ct_CC
@@ -680,6 +679,11 @@ CPPFLAGS
 LDFLAGS
 CFLAGS
 CC
+TIRPC_LIBS
+TIRPC_CFLAGS
+PKG_CONFIG_LIBDIR
+PKG_CONFIG_PATH
+PKG_CONFIG
 flagdir
 fifodir
 mapdir
@@ -750,6 +754,11 @@ enable_limit_getgrgid_size
       ac_precious_vars='build_alias
 host_alias
 target_alias
+PKG_CONFIG
+PKG_CONFIG_PATH
+PKG_CONFIG_LIBDIR
+TIRPC_CFLAGS
+TIRPC_LIBS
 CC
 CFLAGS
 LDFLAGS
@@ -1393,6 +1402,14 @@ Optional Packages:
   --with-sasl=DIR	  enable SASL support for LDAP maps (libs and includes in DIR)
 
 Some influential environment variables:
+  PKG_CONFIG  path to pkg-config utility
+  PKG_CONFIG_PATH
+              directories to add to pkg-config's search path
+  PKG_CONFIG_LIBDIR
+              path overriding pkg-config's built-in search path
+  TIRPC_CFLAGS
+              C compiler flags for TIRPC, overriding pkg-config
+  TIRPC_LIBS  linker flags for TIRPC, overriding pkg-config
   CC          C compiler command
   CFLAGS      C compiler flags
   LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
@@ -2166,6 +2183,25 @@ ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
 
+# for pkg-config macros
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
 #
 # autofs installs by default in /usr
 #
@@ -2400,7 +2436,232 @@ $as_echo "$flagdir" >&6; }
 #
 # Use libtirpc
 #
-ac_ext=c
+
+
+
+
+
+
+
+if test "x$ac_cv_env_PKG_CONFIG_set" != "xset"; then
+	if test -n "$ac_tool_prefix"; then
+  # Extract the first word of "${ac_tool_prefix}pkg-config", so it can be a program name with args.
+set dummy ${ac_tool_prefix}pkg-config; ac_word=$2
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
+$as_echo_n "checking for $ac_word... " >&6; }
+if ${ac_cv_path_PKG_CONFIG+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  case $PKG_CONFIG in
+  [\\/]* | ?:[\\/]*)
+  ac_cv_path_PKG_CONFIG="$PKG_CONFIG" # Let the user override the test with a path.
+  ;;
+  *)
+  as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+    for ac_exec_ext in '' $ac_executable_extensions; do
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
+    ac_cv_path_PKG_CONFIG="$as_dir/$ac_word$ac_exec_ext"
+    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+  done
+IFS=$as_save_IFS
+
+  ;;
+esac
+fi
+PKG_CONFIG=$ac_cv_path_PKG_CONFIG
+if test -n "$PKG_CONFIG"; then
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $PKG_CONFIG" >&5
+$as_echo "$PKG_CONFIG" >&6; }
+else
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+fi
+
+
+fi
+if test -z "$ac_cv_path_PKG_CONFIG"; then
+  ac_pt_PKG_CONFIG=$PKG_CONFIG
+  # Extract the first word of "pkg-config", so it can be a program name with args.
+set dummy pkg-config; ac_word=$2
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for $ac_word" >&5
+$as_echo_n "checking for $ac_word... " >&6; }
+if ${ac_cv_path_ac_pt_PKG_CONFIG+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  case $ac_pt_PKG_CONFIG in
+  [\\/]* | ?:[\\/]*)
+  ac_cv_path_ac_pt_PKG_CONFIG="$ac_pt_PKG_CONFIG" # Let the user override the test with a path.
+  ;;
+  *)
+  as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
+for as_dir in $PATH
+do
+  IFS=$as_save_IFS
+  test -z "$as_dir" && as_dir=.
+    for ac_exec_ext in '' $ac_executable_extensions; do
+  if as_fn_executable_p "$as_dir/$ac_word$ac_exec_ext"; then
+    ac_cv_path_ac_pt_PKG_CONFIG="$as_dir/$ac_word$ac_exec_ext"
+    $as_echo "$as_me:${as_lineno-$LINENO}: found $as_dir/$ac_word$ac_exec_ext" >&5
+    break 2
+  fi
+done
+  done
+IFS=$as_save_IFS
+
+  ;;
+esac
+fi
+ac_pt_PKG_CONFIG=$ac_cv_path_ac_pt_PKG_CONFIG
+if test -n "$ac_pt_PKG_CONFIG"; then
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_pt_PKG_CONFIG" >&5
+$as_echo "$ac_pt_PKG_CONFIG" >&6; }
+else
+  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+fi
+
+  if test "x$ac_pt_PKG_CONFIG" = x; then
+    PKG_CONFIG=""
+  else
+    case $cross_compiling:$ac_tool_warned in
+yes:)
+{ $as_echo "$as_me:${as_lineno-$LINENO}: WARNING: using cross tools not prefixed with host triplet" >&5
+$as_echo "$as_me: WARNING: using cross tools not prefixed with host triplet" >&2;}
+ac_tool_warned=yes ;;
+esac
+    PKG_CONFIG=$ac_pt_PKG_CONFIG
+  fi
+else
+  PKG_CONFIG="$ac_cv_path_PKG_CONFIG"
+fi
+
+fi
+if test -n "$PKG_CONFIG"; then
+	_pkg_min_version=0.9.0
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: checking pkg-config is at least version $_pkg_min_version" >&5
+$as_echo_n "checking pkg-config is at least version $_pkg_min_version... " >&6; }
+	if $PKG_CONFIG --atleast-pkgconfig-version $_pkg_min_version; then
+		{ $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+$as_echo "yes" >&6; }
+	else
+		{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+		PKG_CONFIG=""
+	fi
+fi
+
+# Check whether --with-libtirpc was given.
+if test "${with_libtirpc+set}" = set; then :
+  withval=$with_libtirpc;
+fi
+
+if test "x$with_libtirpc" = "xyes"; then
+
+pkg_failed=no
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for TIRPC" >&5
+$as_echo_n "checking for TIRPC... " >&6; }
+
+if test -n "$TIRPC_CFLAGS"; then
+    pkg_cv_TIRPC_CFLAGS="$TIRPC_CFLAGS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { $as_echo "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"libtirpc\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "libtirpc") 2>&5
+  ac_status=$?
+  $as_echo "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_TIRPC_CFLAGS=`$PKG_CONFIG --cflags "libtirpc" 2>/dev/null`
+		      test "x$?" != "x0" && pkg_failed=yes
+else
+  pkg_failed=yes
+fi
+ else
+    pkg_failed=untried
+fi
+if test -n "$TIRPC_LIBS"; then
+    pkg_cv_TIRPC_LIBS="$TIRPC_LIBS"
+ elif test -n "$PKG_CONFIG"; then
+    if test -n "$PKG_CONFIG" && \
+    { { $as_echo "$as_me:${as_lineno-$LINENO}: \$PKG_CONFIG --exists --print-errors \"libtirpc\""; } >&5
+  ($PKG_CONFIG --exists --print-errors "libtirpc") 2>&5
+  ac_status=$?
+  $as_echo "$as_me:${as_lineno-$LINENO}: \$? = $ac_status" >&5
+  test $ac_status = 0; }; then
+  pkg_cv_TIRPC_LIBS=`$PKG_CONFIG --libs "libtirpc" 2>/dev/null`
+		      test "x$?" != "x0" && pkg_failed=yes
+else
+  pkg_failed=yes
+fi
+ else
+    pkg_failed=untried
+fi
+
+
+
+if test $pkg_failed = yes; then
+   	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+
+if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then
+        _pkg_short_errors_supported=yes
+else
+        _pkg_short_errors_supported=no
+fi
+        if test $_pkg_short_errors_supported = yes; then
+	        TIRPC_PKG_ERRORS=`$PKG_CONFIG --short-errors --print-errors --cflags --libs "libtirpc" 2>&1`
+        else
+	        TIRPC_PKG_ERRORS=`$PKG_CONFIG --print-errors --cflags --libs "libtirpc" 2>&1`
+        fi
+	# Put the nasty error message in config.log where it belongs
+	echo "$TIRPC_PKG_ERRORS" >&5
+
+	as_fn_error $? "Package requirements (libtirpc) were not met:
+
+$TIRPC_PKG_ERRORS
+
+Consider adjusting the PKG_CONFIG_PATH environment variable if you
+installed software in a non-standard prefix.
+
+Alternatively, you may set the environment variables TIRPC_CFLAGS
+and TIRPC_LIBS to avoid the need to call pkg-config.
+See the pkg-config man page for more details." "$LINENO" 5
+elif test $pkg_failed = untried; then
+     	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
+$as_echo "no" >&6; }
+	{ { $as_echo "$as_me:${as_lineno-$LINENO}: error: in \`$ac_pwd':" >&5
+$as_echo "$as_me: error: in \`$ac_pwd':" >&2;}
+as_fn_error $? "The pkg-config script could not be found or is too old.  Make sure it
+is in your PATH or set the PKG_CONFIG environment variable to the full
+path to pkg-config.
+
+Alternatively, you may set the environment variables TIRPC_CFLAGS
+and TIRPC_LIBS to avoid the need to call pkg-config.
+See the pkg-config man page for more details.
+
+To get pkg-config, see <http://pkg-config.freedesktop.org/>.
+See \`config.log' for more details" "$LINENO" 5; }
+else
+	TIRPC_CFLAGS=$pkg_cv_TIRPC_CFLAGS
+	TIRPC_LIBS=$pkg_cv_TIRPC_LIBS
+        { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
+$as_echo "yes" >&6; }
+
+
+$as_echo "#define WITH_LIBTIRPC 1" >>confdefs.h
+
+
+$as_echo "#define TIRPC_WORKAROUND 1" >>confdefs.h
+
+
+fi
+  ac_ext=c
 ac_cpp='$CPP $CPPFLAGS'
 ac_compile='$CC -c $CFLAGS $CPPFLAGS conftest.$ac_ext >&5'
 ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $LIBS >&5'
@@ -3190,55 +3451,6 @@ ac_link='$CC -o conftest$ac_exeext $CFLAGS $CPPFLAGS $LDFLAGS conftest.$ac_ext $
 ac_compiler_gnu=$ac_cv_c_compiler_gnu
 
 
-{ $as_echo "$as_me:${as_lineno-$LINENO}: checking if libtirpc is requested and available" >&5
-$as_echo_n "checking if libtirpc is requested and available... " >&6; }
-
-# Check whether --with-libtirpc was given.
-if test "${with_libtirpc+set}" = set; then :
-  withval=$with_libtirpc; if test "$withval" = yes; then
-
-# save current flags
-af_check_libtirpc_save_cflags="$CFLAGS"
-af_check_libtirpc_save_libs="$LIBS"
-CFLAGS="$CFLAGS -I/usr/include/tirpc"
-LIBS="$LIBS -ltirpc"
-
-cat confdefs.h - <<_ACEOF >conftest.$ac_ext
-/* end confdefs.h.  */
- #include <rpc/rpc.h>
-int
-main ()
-{
- CLIENT *cl;
-      struct sockaddr_in addr;
-      int fd;
-      unsigned long ul; struct timeval t; unsigned int ui;
-      cl = clntudp_bufcreate(&addr,ul,ul,t,&fd,ui,ui);
-  ;
-  return 0;
-}
-_ACEOF
-if ac_fn_c_try_link "$LINENO"; then :
-   af_have_libtirpc=yes
-      { $as_echo "$as_me:${as_lineno-$LINENO}: result: yes" >&5
-$as_echo "yes" >&6; }
-else
-   { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-rm -f core conftest.err conftest.$ac_objext \
-    conftest$ac_exeext conftest.$ac_ext
-
-if test "$af_have_libtirpc" = "yes"; then
-
-$as_echo "#define WITH_LIBTIRPC 1" >>confdefs.h
-
-
-$as_echo "#define TIRPC_WORKAROUND 1" >>confdefs.h
-
-    TIRPCLIB="-ltirpc"
-fi
-
 for ac_func in getrpcbyname getservbyname
 do :
   as_ac_var=`$as_echo "ac_cv_func_$ac_func" | $as_tr_sh`
@@ -3251,23 +3463,8 @@ _ACEOF
 fi
 done
 
-
-# restore flags
-CFLAGS="$af_check_libtirpc_save_cflags"
-LIBS="$af_check_libtirpc_save_libs"
-
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
-fi
-else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
-$as_echo "no" >&6; }
 fi
 
-
-
-
 #
 # Optional include dmalloc
 #
diff --git a/configure.in b/configure.in
index d408b209..085b34d5 100644
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
To unsubscribe from this list: send the line "unsubscribe autofs" in
