From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: fix libtirpc detection with -Wl,--as-needed
Date: Fri, 08 Jul 2016 09:43:59 +0800
Message-ID: <1467942239.3832.7.camel@themaw.net>
References: <20160706202914.26861-1-Martin.vGagern@gmx.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=X9DW0FnWiSuYrQoKqvcCg5sg/qA=; b=fDAGBF
	XrD6JPBXu8ok8SBTwBH+ve1ufQ4xCJBlBcrk6u0eEW0FeS1LPk3L9mMo0AFhyJJ2
	3MIW0eMqRacM6LRWHPNRZjHRbIOhL155ggs9fN2hRBo+IsXoPCwRHHRoMXuj2+Hy
	3w4xrBat1sCYNK0Y1Y+9JBus105SaPbPAS+1c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=X9DW0FnWiSuYrQo
	KqvcCg5sg/qA=; b=D91Sax7/IAc/m1BhRyzxNP1BlhDUZrTHM+XuUPAxnQ2RKkp
	vGIzE8EiBvU3cc9/Vxlz+jIwN8rikL7cH43WU9rXMnpROxs2iwCWszxsbsXJJeEv
	nv0W7Paqn+AkkIo5y6hzKLZBwzo4xFIvVhwdUwnkpLy5ehJC9LkfXagB2cRU=
In-Reply-To: <20160706202914.26861-1-Martin.vGagern@gmx.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin von Gagern <Martin.vGagern@gmx.net>, autofs@vger.kernel.org

On Wed, 2016-07-06 at 22:29 +0200, Martin von Gagern wrote:
> As reported in https://bugs.gentoo.org/show_bug.cgi?id=588106, the configure
> script will fail to detect the presence of libtirpc if -Wl,--as-needed is
> included in LDFLAGS.  That is because the check incorrectly includes the
> argument -ltircp in the LDFLAGS variable, instead of the LIBS variable where
> it belongs.  LIBS comes after the objects so it will be used to satisfy
> their dependencies.  LDFLAGS will come before them, causing the library to
> be skipped if the --as-needed linker flag is in effect.

Thanks for making the effort to send over the patch.

I've added it to my list for the next commit and push, don't know when that will
be though.

While having to use kernel.org majordomo mailing list is not my favourite I
particularly like having a place to put all the individual patches that make up
each release so autofs stays at kernel.org.

TBH I don't much like using github, perhaps one day I'll look into using gitlab.

> 
> Signed-off-by: Martin von Gagern <Martin.vGagern@gmx.net>
> ---
>  aclocal.m4 | 6 +++---
>  configure  | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/aclocal.m4 b/aclocal.m4
> index 2115204..fe949a2 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -413,9 +413,9 @@ AC_DEFUN([AF_CHECK_LIBTIRPC],
>  [
>  # save current flags
>  af_check_libtirpc_save_cflags="$CFLAGS"
> -af_check_libtirpc_save_ldflags="$LDFLAGS"
> +af_check_libtirpc_save_libs="$LIBS"
>  CFLAGS="$CFLAGS -I/usr/include/tirpc"
> -LDFLAGS="$LDFLAGS -ltirpc"
> +LIBS="$LIBS -ltirpc"
>  
>  AC_TRY_LINK(
>      [ #include <rpc/rpc.h> ],
> @@ -438,7 +438,7 @@ AC_CHECK_FUNCS([getrpcbyname getservbyname])
>  
>  # restore flags
>  CFLAGS="$af_check_libtirpc_save_cflags"
> -LDFLAGS="$af_check_libtirpc_save_ldflags"
> +LIBS="$af_check_libtirpc_save_libs"
>  ])
>  
>  AC_DEFUN([AF_WITH_LIBTIRPC],
> diff --git a/configure b/configure
> index 3e2de6f..3227c71 100755
> --- a/configure
> +++ b/configure
> @@ -3194,9 +3194,9 @@ if test "${with_libtirpc+set}" = set; then :
>  
>  # save current flags
>  af_check_libtirpc_save_cflags="$CFLAGS"
> -af_check_libtirpc_save_ldflags="$LDFLAGS"
> +af_check_libtirpc_save_libs="$LIBS"
>  CFLAGS="$CFLAGS -I/usr/include/tirpc"
> -LDFLAGS="$LDFLAGS -ltirpc"
> +LIBS="$LIBS -ltirpc"
>  
>  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
>  /* end confdefs.h.  */
> @@ -3249,7 +3249,7 @@ done
>  
>  # restore flags
>  CFLAGS="$af_check_libtirpc_save_cflags"
> -LDFLAGS="$af_check_libtirpc_save_ldflags"
> +LIBS="$af_check_libtirpc_save_libs"
>  
>  else
>    { $as_echo "$as_me:${as_lineno-$LINENO}: result: no" >&5
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
