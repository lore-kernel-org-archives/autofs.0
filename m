From: Ian Kent <raven@themaw.net>
Subject: [PATCH 15/37] autofs-5.1.2 - configure: add cache variable for
 Linux proc filesystem check
Date: Tue, 25 Oct 2016 09:18:45 +0800
Message-ID: <20161025011845.7778.50151.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=IVDVa2Dflqcnhc5gGzqL/ylfjbE=; b=DGaqc9cnNBdAF6hZww
        lpZFEqOzutd9/Vn9IUu1IAwPEHGAvp7r0b2O8I5Sf4US6uHNJKWdLTe4XgS/TjUx
        PYRXyTwCljOrI70d0TxJb7ok5k/ebyuunlWd+58g7Pk/3dkknbwACf988Jfd/u2y
        byaQ1ElwmGp9rjbFHLQx2LCoo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=IVDVa2Dflqcnhc5gGzqL/y
        lfjbE=; b=GtgrnipoTPc3OMTpWZtEL+cD4QgtPQpxX/K9LdZGGJsdZpX2z2lpBL
        x3ScbMYReWRP7xuKNsORmFY30wbPlWxUYkNYWv7l9u5keiSOA2ErH4x139yausvq
        77hq4lo1q/CCtzXFZ93BLMlX77n5IGdHoSmcaxTX8jhVctfU+xCdI=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

When cross-compiling, whether the /proc filesystem is available in the
build environment does not give any indication as to whether it will
be available in the execution environment.

This commit therefore adjust the AF_LINUX_PROCFS macro to use
AC_CACHE_CHECK(), so that an ac_cv_linux_procfs variable can be
preseeded in the environment to force the result of this check.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG  |    1 +
 aclocal.m4 |   15 +++++----------
 configure  |   16 ++++++++--------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5fcd123..ec1812a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -14,6 +14,7 @@ xx/xx/2016 autofs-5.1.3
 - Fix fgets(3) size argument (another one).
 - fix short memory allocation in lookup_amd_instance().
 - fix count_mounts() function.
+- configure: add cache variable for Linux proc filesystem check.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/aclocal.m4 b/aclocal.m4
index fe949a2..00811e0 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -80,16 +80,11 @@ dnl
 dnl Check for the Linux /proc filesystem
 dnl --------------------------------------------------------------------------
 AC_DEFUN(AF_LINUX_PROCFS,
-[AC_MSG_CHECKING(for Linux proc filesystem)
-if test "x`cat /proc/sys/kernel/ostype 2>&-`" = "xLinux"
-then
-	linux_procfs=yes
-else
-	linux_procfs=no
-fi
-AC_MSG_RESULT($linux_procfs)
-if test $linux_procfs = yes
-then
+[AC_CACHE_CHECK([for Linux proc filesystem], [ac_cv_linux_procfs],
+	[ac_cv_linux_procfs=no
+	 test "x`cat /proc/sys/kernel/ostype 2>&-`" = "xLinux" && ac_cv_linux_procfs=yes])
+ if test $ac_cv_linux_procfs = yes
+ then
 	AC_DEFINE(HAVE_LINUX_PROCFS, 1,
 		[Define if you have the Linux /proc filesystem.])
 fi])
diff --git a/configure b/configure
index 5a05fe1..8467582 100755
--- a/configure
+++ b/configure
@@ -2194,16 +2194,16 @@ $as_echo "$searchpath" >&6; }
 #
 { $as_echo "$as_me:${as_lineno-$LINENO}: checking for Linux proc filesystem" >&5
 $as_echo_n "checking for Linux proc filesystem... " >&6; }
-if test "x`cat /proc/sys/kernel/ostype 2>&-`" = "xLinux"
-then
-	linux_procfs=yes
+if ${ac_cv_linux_procfs+:} false; then :
+  $as_echo_n "(cached) " >&6
 else
-	linux_procfs=no
+  ac_cv_linux_procfs=no
+	 test "x`cat /proc/sys/kernel/ostype 2>&-`" = "xLinux" && ac_cv_linux_procfs=yes
 fi
-{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $linux_procfs" >&5
-$as_echo "$linux_procfs" >&6; }
-if test $linux_procfs = yes
-then
+{ $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_cv_linux_procfs" >&5
+$as_echo "$ac_cv_linux_procfs" >&6; }
+ if test $ac_cv_linux_procfs = yes
+ then
 
 $as_echo "#define HAVE_LINUX_PROCFS 1" >>confdefs.h
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
