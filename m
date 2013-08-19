From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 2/2] introduce new '--with-systemdsystemunitdir'
Date: Mon, 19 Aug 2013 14:23:18 +0800
Message-ID: <1376893398-11765-3-git-send-email-dennis.yxun@gmail.com>
References: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JycDq3msIIkj+P/wi88Jy+1iRQkf3/y9xyer2X+Wwo=;
        b=l+g9lqtbEVm6uBUoluydFF/Idcx4iLDKqtHpqvZjl/crvl8NCVgIFz9uCz/PLhzc2W
         8lFLTiC9ItaPDKLOw2naik7mwT6vfBhuNXKx603Uul4USwCreNGv71nYsxv7n4IhfcMg
         3g6YN3EDxtKYYEgVyeYcuy2rIJdFlng81tntaJeMq/6vzqFjvbdTMx7akEjs+w6xBof5
         6s55bDM4RAPNHE9EUksjjv1Ts8vJmI+NFJQ0TxsN8yYHsKCXemumJb1nA/fDMSrj6VWI
         mxP3JTBbOGIRrRKvz0/ikg8IPUVLo8sw0buhm94wSiRiYDrA2wDFKyIx2uD2AS3TGJd7
         keTw==
In-Reply-To: <1376893398-11765-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

this option only control the path where the systemd unit file wll be installed
and it's seperated from --with-systemd option, so it can be always installed alone.

use cases:
1) if this option is not specificed, default option is
'--with-systemdsystemunitdir=yes'
will auto probe the directory of unit file
2) --with-systemdsystemunitdir=no, or --without-systemdsystemunitdir
no unit file will be installed
3) --with-systemdsystemunitdir=/my/unit/file/directory/
will install unit file into /my/unit/file/directory/
(gentoo linux goes the 3nd way)

this patch doesn't alter previous behavior, so should be compatible with previous
version.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.conf.in |  4 ++--
 aclocal.m4       | 43 +++++++++++++++++++++++++++++++++++++++++++
 configure.in     |  9 +++++++--
 samples/Makefile |  6 +++---
 4 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/Makefile.conf.in b/Makefile.conf.in
index 3766d45..75f6dec 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -107,5 +107,5 @@ mandir = @mandir@
 # Location for init.d files
 initdir = @initdir@
 
-# Location of systemd unit files
-systemddir = @systemddir@
+# Location of systemd unit dir
+systemdsystemunitdir = @systemdsystemunitdir@
diff --git a/aclocal.m4 b/aclocal.m4
index 5cdc7e4..cee7125 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -246,6 +246,49 @@ fi],
 ])
 
 dnl --------------------------------------------------------------------------
+dnl AF_WITH_SYSTEMD_UNITS_DIR
+dnl
+dnl Check the location of the systemd unit files directory
+dnl --------------------------------------------------------------------------
+AC_DEFUN([SYSTEMD_SYSTEM_UNITS],
+[AC_ARG_WITH(systemdsystemunitdir,
+[  --with-systemdsystemunitdir         install systemd unit file if systemd unit directory
+			  is found on system],
+[
+AC_MSG_CHECKING([location of the systemd unit files directory])
+if test "$withval" = yes -o x"$withval" = x""; then
+    for systemd_d in /usr/lib/systemd/system /usr/lib64/systemd/system /lib/systemd/system /lib64/systemd/system; do
+      if test -z "$systemdsystemunitdir"; then
+        if test -d "$systemd_d"; then
+          systemdsystemunitdir="$systemd_d"
+          AC_MSG_RESULT($systemdsystemunitdir)
+        fi
+      fi
+    done
+else
+  if test "$withval" = no; then
+    AC_MSG_RESULT(not found)
+  else
+    systemdsystemunitdir=$withval
+    AC_MSG_RESULT($systemdsystemunitdir)
+  fi
+fi
+],
+[
+AC_MSG_CHECKING([location of the systemd unit files directory, default yes])
+    for systemd_d in /usr/lib/systemd/system /usr/lib64/systemd/system /lib/systemd/system /lib64/systemd/system; do
+      if test -z "$systemdsystemunitdir"; then
+        if test -d "$systemd_d"; then
+          systemdsystemunitdir="$systemd_d"
+          AC_MSG_RESULT($systemdsystemunitdir)
+        fi
+      fi
+    done
+]
+)
+])
+
+dnl --------------------------------------------------------------------------
 dnl AF_CHECK_LIBXML
 dnl
 dnl Check for lib xml
diff --git a/configure.in b/configure.in
index 559045a..3cc43ab 100644
--- a/configure.in
+++ b/configure.in
@@ -47,11 +47,16 @@ AF_PID_D()
 AC_SUBST(piddir)
 
 #
+# Check for systemd support is requested
+#
+AF_WITH_SYSTEMD()
+
+#
 # Check for systemd unit files direectory exists if unit file installation
 # is requested
 #
-AF_WITH_SYSTEMD()
-AC_SUBST(systemddir)
+SYSTEMD_SYSTEM_UNITS
+AC_SUBST(systemdsystemunitdir)
 
 #
 # Location of system config script directory?
diff --git a/samples/Makefile b/samples/Makefile
index 91c1d6b..4cf8bf3 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -32,9 +32,9 @@ dirs:
 .PHONY: autofs.init
 autofs.init:
 	@echo
-ifneq ($(systemddir),)
-	install -d -m 755 $(INSTALLROOT)$(systemddir)
-	install autofs.service -m 644 $(INSTALLROOT)$(systemddir)/autofs.service
+ifneq ($(systemdsystemunitdir),)
+	install -d -m 755 $(INSTALLROOT)$(systemdsystemunitdir)
+	install autofs.service -m 644 $(INSTALLROOT)$(systemdsystemunitdir)/autofs.service
 else
    ifneq ($(initdir),)
 	install -d -m 755 $(INSTALLROOT)$(initdir)
-- 
1.8.3.2

