From: Gustavo Zacarias <gustavo@zacarias.com.ar>
Subject: [PATCH] autofs: build: check for clock_gettime in librt
Date: Sun, 19 Jun 2016 00:19:13 -0300
Message-ID: <1466306353-11612-1-git-send-email-gustavo@zacarias.com.ar>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zacarias.com.ar;
	s=dkey; t=1466306361;
	bh=lCMsKAG2JZbq/XDKIm7A0fhd/u/4k0+zdWfGf7yNiPA=;
	h=From:To:Cc:Subject:Date;
	b=WiuQ9RKoCYPG/QbhXxsr3T1j7VbL+9P28gisIqb32gNxH6IDwJMNmRNwAQwh9/WH+
	 GKMhSOJQASgGInAPE6XsF0m5WnH4yZQxc0F8zKdexwXtRJP3Pt+vsUEYFGmdD+CdgL
	 Ni6robkDsecyPcX69/fnlKA5tUYzxS8TFRbWGpak=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: Gustavo Zacarias <gustavo@zacarias.com.ar>

Glibc versions older than 2.17 define clock_gettime() in librt, so add a
check for this.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 Makefile.conf.in | 3 +++
 Makefile.rules   | 2 ++
 configure.in     | 4 ++++
 3 files changed, 9 insertions(+)

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
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
