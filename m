From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: build: check for clock_gettime in librt
Date: Sun, 19 Jun 2016 18:11:34 +0800
Message-ID: <1466331094.4761.27.camel@themaw.net>
References: <1466306353-11612-1-git-send-email-gustavo@zacarias.com.ar>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=lb9akGORDbv4vUHVtLPHlZfzr6Y=; b=C7VHNh
	2B96np8YdtFrtqrAGRcQDIJt5phi2kIbz055HZON2TlaZ+cDx/oo/3k8P6iv6IpU
	IhCr2L29/1u4ncAe7zklJgMebXyl5O7Z64930EB6w9SKBoSgRfOiRQcMeRS/I7/a
	yL6UDWgtIYOfHZqlVNn/yS7Punq3FNpLn1JFc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lb9akGORDbv4vUH
	VtLPHlZfzr6Y=; b=BnRHpuzqsV0m3Symu0VqzjHUSMnxNe4h6jMT0ew1wEh661d
	YuW0vv6wrAasKofajmvLEjulLVJdAwO/g2o5FoS888waQXb7JXtliLLBTErEKXal
	hFC3aGRo74uUYgCADgmjlaSyOtqKbhwfuumUZLcjHX4IgEMXhpGUFXGQF890=
In-Reply-To: <1466306353-11612-1-git-send-email-gustavo@zacarias.com.ar>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Gustavo Zacarias <gustavo@zacarias.com.ar>, autofs@vger.kernel.org

On Sun, 2016-06-19 at 00:19 -0300, Gustavo Zacarias wrote:
> Glibc versions older than 2.17 define clock_gettime() in librt, so add a
> check for this.

I'll include this the next time I push to the repo.

I'll check the build output before then but it doesn't look like I'll see a
problem.

Thanks
Ian
 
> 
> Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
> ---
>  Makefile.conf.in | 3 +++
>  Makefile.rules   | 2 ++
>  configure.in     | 4 ++++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/Makefile.conf.in b/Makefile.conf.in
> index cb53e66..2bc3202 100644
> --- a/Makefile.conf.in
> +++ b/Makefile.conf.in
> @@ -11,6 +11,9 @@
>  DAEMON_CFLAGS  = @DAEMON_CFLAGS@
>  DAEMON_LDFLAGS = @DAEMON_LDFLAGS@
>  
> +# Glibc < 2.17 requires librt for clock_gettime()
> +LIBCLOCK_GETTIME = @LIBCLOCK_GETTIME@
> +
>  # Special parameters for glibc (libc 6)
>  LIBNSL    = @LIBNSL@
>  LIBRESOLV = @LIBRESOLV@
> diff --git a/Makefile.rules b/Makefile.rules
> index 6fa3e02..7d1af2e 100644
> --- a/Makefile.rules
> +++ b/Makefile.rules
> @@ -56,6 +56,8 @@ endif
>  
>  LIBS += $(LIBNSL)
>  
> +LIBS += $(LIBCLOCK_GETTIME)
> +
>  # Standard rules
>  
>  .SUFFIXES: .c .o .s .so
> diff --git a/configure.in b/configure.in
> index 25d7c4e..a4318e8 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -177,6 +177,10 @@ if test "$ac_cv_search_versionsort" = "no"; then
>  		[Define if your C library does not provide versionsort])
>  fi
>  
> +# glibc < 2.17 needs librt for clock_gettime()
> +AC_CHECK_LIB(rt, clock_gettime, LIBCLOCK_GETTIME="-lrt")
> +AC_SUBST(LIBCLOCK_GETTIME)
> +
>  #
>  # glibc/libc 6 new libraries
>  #
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
