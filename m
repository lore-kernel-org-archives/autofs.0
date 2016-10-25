From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/37] autofs-5.1.2 - build: check for clock_gettime in librt
Date: Tue, 25 Oct 2016 09:17:35 +0800
Message-ID: <20161025011735.7778.1721.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=cVrN7uHrwQL2wa4F1C8Bvj99RY4=; b=e7I1DaB9UvgwnFlxk4
        BCjaFEOz1OMkKgIEhOmfgHJF6iPXlGHWtbyneenQ0UA6D9y9ZhfJMYp20k4MO2tA
        MTTcaKXVct11y6YwGzF8TydR4BJuoNWNhKdN4i/s9CARbfEyYwtZoe/7XXVZNibo
        Da2hThMGFIUOyRVOCnJORakd8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=cVrN7uHrwQL2wa4F1C8Bvj
        99RY4=; b=i89eOtfLZR/Iiu2Qb8+VpDyJTB/K7x9zUIZFgVBjEdnT/z3CuCExXS
        dYKWy2IYSq/DZVk764oZEiuJ3Raz6Wt2EtogRDh0myNp61NQbGMpOT9hJkc5xh9y
        Uu3qLjsevfQRbyyFFG7nwPg59kK9kvpgH9d/dDz3CLd2awl1qGGWs=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Gustavo Zacarias <gustavo@zacarias.com.ar>

Glibc versions older than 2.17 define clock_gettime() in librt, so add a
check for this.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 CHANGELOG        |    1 +
 Makefile.conf.in |    3 +++
 Makefile.rules   |    2 ++
 configure        |   44 ++++++++++++++++++++++++++++++++++++++++++++
 configure.in     |    4 ++++
 5 files changed, 54 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index d31bb80..2e51f62 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,6 +1,7 @@
 xx/xx/2016 autofs-5.1.3
 =======================
 - fix release date in CHANGELOG.
+- build: check for clock_gettime in librt.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/Makefile.conf.in b/Makefile.conf.in
index cb53e66..2bc3202 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -11,6 +11,9 @@
 DAEMON_CFLAGS  = @DAEMON_CFLAGS@
 DAEMON_LDFLAGS = @DAEMON_LDFLAGS@
 
+# Glibc < 2.17 requires librt for clock_gettime()
+LIBCLOCK_GETTIME = @LIBCLOCK_GETTIME@
+
 # Special parameters for glibc (libc 6)
 LIBNSL    = @LIBNSL@
 LIBRESOLV = @LIBRESOLV@
diff --git a/Makefile.rules b/Makefile.rules
index 6fa3e02..7d1af2e 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -56,6 +56,8 @@ endif
 
 LIBS += $(LIBNSL)
 
+LIBS += $(LIBCLOCK_GETTIME)
+
 # Standard rules
 
 .SUFFIXES: .c .o .s .so
diff --git a/configure b/configure
index 3e2de6f..6ae1f97 100755
--- a/configure
+++ b/configure
@@ -644,6 +644,7 @@ LIBHESIOD
 HAVE_HESIOD
 LIBRESOLV
 LIBNSL
+LIBCLOCK_GETTIME
 KRB5_CONFIG
 XML_CONFIG
 sssldir
@@ -4206,6 +4207,49 @@ $as_echo "#define WITHOUT_VERSIONSORT 1" >>confdefs.h
 
 fi
 
+# glibc < 2.17 needs librt for clock_gettime()
+{ $as_echo "$as_me:${as_lineno-$LINENO}: checking for clock_gettime in -lrt" >&5
+$as_echo_n "checking for clock_gettime in -lrt... " >&6; }
+if ${ac_cv_lib_rt_clock_gettime+:} false; then :
+  $as_echo_n "(cached) " >&6
+else
+  ac_check_lib_save_LIBS=$LIBS
+LIBS="-lrt  $LIBS"
+cat confdefs.h - <<_ACEOF >conftest.$ac_ext
+/* end confdefs.h.  */
+
+/* Override any GCC internal prototype to avoid an error.
+   Use char because int might match the return type of a GCC
+   builtin and then its argument prototype would still apply.  */
+#ifdef __cplusplus
+extern "C"
+#endif
+char clock_gettime ();
+int
+main ()
+{
+return clock_gettime ();
+  ;
+  return 0;
+}
+_ACEOF
+if ac_fn_c_try_link "$LINENO"; then :
+  ac_cv_lib_rt_clock_gettime=yes
+else
+  ac_cv_lib_rt_clock_gettime=no
+fi
+rm -f core conftest.err conftest.$ac_objext \
+    conftest$ac_exeext conftest.$ac_ext
+LIBS=$ac_check_lib_save_LIBS
+fi
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_lib_rt_clock_gettime" >&5
+$as_echo "$ac_cv_lib_rt_clock_gettime" >&6; }
+if test "x$ac_cv_lib_rt_clock_gettime" = xyes; then :
+  LIBCLOCK_GETTIME="-lrt"
+fi
+
+
+
 #
 # glibc/libc 6 new libraries
 #
diff --git a/configure.in b/configure.in
index 25d7c4e..a4318e8 100644
--- a/configure.in
+++ b/configure.in
@@ -177,6 +177,10 @@ if test "$ac_cv_search_versionsort" = "no"; then
 		[Define if your C library does not provide versionsort])
 fi
 
+# glibc < 2.17 needs librt for clock_gettime()
+AC_CHECK_LIB(rt, clock_gettime, LIBCLOCK_GETTIME="-lrt")
+AC_SUBST(LIBCLOCK_GETTIME)
+
 #
 # glibc/libc 6 new libraries
 #

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
