From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/37] autofs-5.1.2 - fix libtirpc detection with -Wl,
 --as-needed
Date: Tue, 25 Oct 2016 09:17:57 +0800
Message-ID: <20161025011756.7778.41762.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=a/cd+4YcK3NdMh/HfmcyUELUZMI=; b=h3/8Gj5F/QnBA2JE+1
        +QXph0pN9aSgEXEk31HuEF3NVwxaZ7Halt0F3mUvGZ/1r6gyXktXyK29OdHf4oap
        3ZsScm8O9hlKxEjqYB055l1SDpYysMoZRdZ2+cHnl9xI+Js5MUQ/mSQxMb0BevAY
        ycxxEE8JItpF9KWTCacCfCRVg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=a/cd+4YcK3NdMh/HfmcyUE
        LUZMI=; b=OsArb9GFSzLPb4xEUBf9rPnVt3SdfanwxXl/MR6/PSGTlPfEdLBjxT
        kghKjxP6WCVlFbimDulw1UFHqURjHVa4fq8ggZosVU71seRnZsB9ogdrSveGmYMT
        XsNGd3hLbeKCDsERDxDYyrcKMK3fmjz1RqeODoD63xsHKo7OgvTX0=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Martin von Gagern <Martin.vGagern@gmx.net>

As reported in https://bugs.gentoo.org/show_bug.cgi?id=588106, the configure
script will fail to detect the presence of libtirpc if -Wl,--as-needed is
included in LDFLAGS.  That is because the check incorrectly includes the
argument -ltircp in the LDFLAGS variable, instead of the LIBS variable where
it belongs.  LIBS comes after the objects so it will be used to satisfy
their dependencies.  LDFLAGS will come before them, causing the library to
be skipped if the --as-needed linker flag is in effect.

Signed-off-by: Martin von Gagern <Martin.vGagern@gmx.net>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG  |    1 +
 aclocal.m4 |    6 +++---
 configure  |    6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index cb895c4..9291c20 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -5,6 +5,7 @@ xx/xx/2016 autofs-5.1.3
 - fix compiler warning in try_remount().
 - drop redundant \n in logerr().
 - Fix size arg of fgets(3).
+- fix libtirpc detection with -Wl,--as-needed.
 
 15/06/2016 autofs-5.1.2
 =======================
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
index 6ae1f97..5a05fe1 100755
--- a/configure
+++ b/configure
@@ -3195,9 +3195,9 @@ if test "${with_libtirpc+set}" = set; then :
 
 # save current flags
 af_check_libtirpc_save_cflags="$CFLAGS"
-af_check_libtirpc_save_ldflags="$LDFLAGS"
+af_check_libtirpc_save_libs="$LIBS"
 CFLAGS="$CFLAGS -I/usr/include/tirpc"
-LDFLAGS="$LDFLAGS -ltirpc"
+LIBS="$LIBS -ltirpc"
 
 cat confdefs.h - <<_ACEOF >conftest.$ac_ext
 /* end confdefs.h.  */
@@ -3250,7 +3250,7 @@ done
 
 # restore flags
 CFLAGS="$af_check_libtirpc_save_cflags"
-LDFLAGS="$af_check_libtirpc_save_ldflags"
+LIBS="$af_check_libtirpc_save_libs"
 
 else
   { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
