From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: [PATCH] avoid calling mount during configure
Date: Sun, 21 Apr 2013 11:12:52 +0200
Message-ID: <5173AD94.9080301@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030905070305080805020709"
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org

This is a multi-part message in MIME format.
--------------030905070305080805020709
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

The configure script unconditionally calls "mount -s" in an attempt to
figure out whether the command supports that option or not. This can
cause trouble in cases where the configure script is executed in some
kind of restricted environment, e.g. a sandbox or small chroot. For
these cases, it would be nice to have a way to avoid that
auto-detection, and instead specify explicitely whether or not the mount
command can be expected to support the -s option.

The attached patch does just that. I wrote it for Gentoo, but in such a
way that it should maintain current behaviour as the default, and allow
overriding in both directions. I would welcome inclusion of this option
into future builds of autofs.

Greetings,
 Martin von Gagern

--------------030905070305080805020709
Content-Type: text/x-patch;
 name="gentoo453778a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gentoo453778a.patch"

Add an option --enable-sloppy-mount or --disable-sloppy-mount to force
or prevent the use of the -s option to mount, thus avoiding the
autodetection. This can be useful in setups where executing mount
might be undesirable, particularly in packaging environments.

2013-04-04 Martin von Gagern

References:
 * https://bugs.gentoo.org/453778

Index: autofs-5.0.7/aclocal.m4
===================================================================
--- autofs-5.0.7.orig/aclocal.m4
+++ autofs-5.0.7/aclocal.m4
@@ -66,7 +66,7 @@ AC_DEFUN(AF_SLOPPY_MOUNT,
 [if test -n "$MOUNT" ; then
   AC_MSG_CHECKING([if mount accepts the -s option])
   if "$MOUNT" -s > /dev/null 2>&1 ; then
-    AC_DEFINE(HAVE_SLOPPY_MOUNT, 1, [define if the mount command supports the -s option])
+    enable_sloppy_mount=yes
     AC_MSG_RESULT(yes)
   else
     AC_MSG_RESULT(no)
Index: autofs-5.0.7/configure.in
===================================================================
--- autofs-5.0.7.orig/configure.in
+++ autofs-5.0.7/configure.in
@@ -157,7 +157,15 @@ AC_SUBST(sssldir)
 # Newer mounts have the -s (sloppy) option to ignore unknown options,
 # good for portability
 #
-AF_SLOPPY_MOUNT()
+AC_ARG_ENABLE(sloppy-mount,
+[  --enable-sloppy-mount   enable the use of the -s option to mount],,
+	enable_sloppy_mount=auto)
+if test x$enable_sloppy_mount = xauto; then
+	AF_SLOPPY_MOUNT()
+fi
+if test x$enable_sloppy_mount = xyes; then
+	AC_DEFINE(HAVE_SLOPPY_MOUNT, 1, [define if the mount command supports the -s option])
+fi
 
 # LDAP SASL auth needs libxml and Kerberos
 AF_CHECK_LIBXML()

--------------030905070305080805020709--
