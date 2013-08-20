From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 06/25] autofs-5.0.7 - fix compile error with heimdal
 support enabled
Date: Tue, 20 Aug 2013 15:34:12 +0800
Message-ID: <1376984052.2426.35.camel@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
	 <20130819011233.6472.31453.stgit@perseus.fritz.box>
	 <CAF1ZMEcU=yb6FEO7RV_E4xRHKg_ZUkaN+JbcFxwfNq0vQDFs5A@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=XYXcv4tY2by5eOgnud+DtyInHek=; b=I/d3Pfg4PNN1cf1lkP5XojmlRniL
	PXZR0HfeyjQOPE7o5aOYOUaTLtRq3M2nyyc6E0BIToesWRL/rwops5T50CLWYyQT
	LQ6Icx7HitdPYZf9cJLRpJ86Lbvr+kxvolLQxK76ZlMB9gQu+3J6X7tptde1sXYe
	TuVqZ8lKngD4fOA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=XYXcv4tY2by5eOgnud+Dty
	InHek=; b=o0FNZIfEKF2bADrB2Envkhl779xU7X7PBH8Q5w3SIv9bS4pdX4z7NI
	1lvwWmNhXX8ONiUYquT2+vMgCBpqXycfUdcbRrqIbJyldvbU3mP2QxlfvYuvtvd6
	lvdq7mcqG1ldfue+uqtPb6njtoeMi+NrYs/3Gz7Y5HtvhF+0JDtZY=
In-Reply-To: <CAF1ZMEcU=yb6FEO7RV_E4xRHKg_ZUkaN+JbcFxwfNq0vQDFs5A@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Gordon Lack <gordon.m.lack@gsk.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

On Tue, 2013-08-20 at 11:36 +0800, Dennis Lan (dlan) wrote:
> On Mon, Aug 19, 2013 at 9:12 AM, Ian Kent <raven@themaw.net> wrote:
> > From: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> >
> > this patch instroduce a compatible layer between Heimdal and MTT Krb5.
> > And I slightly rework the original patch to make it more readable.
> >
> > Upstream Discussion:
> >   http://thread.gmane.org/gmane.linux.kernel.autofs/4203
> >
> > Gentoo Bugs:
> >   https://bugs.gentoo.org/show_bug.cgi?id=210762
> >
> > Edited by: Ian Kent <raven@themaw.net>
> > - fix code indentation.
> > - update configure to include change.
> >
> > Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> > ---
> >  CHANGELOG            |    1 +
> >  aclocal.m4           |    7 ++++
> >  configure            |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/config.h.in  |    3 ++
> >  modules/cyrus-sasl.c |   39 ++++++++++++++++++++---
> >  5 files changed, 129 insertions(+), 5 deletions(-)
> >
> > diff --git a/CHANGELOG b/CHANGELOG
> > index fe232f4..c77be18 100644
> > --- a/CHANGELOG
> > +++ b/CHANGELOG
> > @@ -58,6 +58,7 @@
> >  - add after sssd dependency to unit file.
> >  - dont start readmap unless ready.
> >  - fix crash due to thread unsafe use of libldap.
> > +- fix compile error with heimdal support enabled.
> >
> >  25/07/2012 autofs-5.0.7
> >  =======================
> > diff --git a/aclocal.m4 b/aclocal.m4
> > index c5de159..7a8b03c 100644
> > --- a/aclocal.m4
> > +++ b/aclocal.m4
> > @@ -299,6 +299,13 @@ else
> >    HAVE_KRB5=1
> >    KRB5_LIBS=`$KRB5_CONFIG --libs`
> >    KRB5_FLAGS=`$KRB5_CONFIG --cflags`
> > +
> > +  SAVE_CFLAGS=$CFLAGS
> > +  SAVE_LIBS=$LIBS
> > +  CFLAGS="$CFLAGS $KRB5_FLAGS"
> > +  LIBS="$LIBS $KRB5_LIBS"
> > +
> > +  AC_CHECK_FUNCS([krb5_principal_get_realm])
> >  fi])
> >
> >  dnl --------------------------------------------------------------------------
> > diff --git a/configure b/configure
> > index 08b7ccc..1086eba 100755
> > --- a/configure
> > +++ b/configure
> > @@ -1559,6 +1559,73 @@ fi
> >
> >  } # ac_fn_c_try_link
> >
> > +# ac_fn_c_check_func LINENO FUNC VAR
> > +# ----------------------------------
> > +# Tests whether FUNC exists, setting the cache variable VAR accordingly
> > +ac_fn_c_check_func ()
> > +{
> > +  as_lineno=${as_lineno-"$1"} as_lineno_stack=as_lineno_stack=$as_lineno_stack
> > +  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for $2" >&5
> > +$as_echo_n "checking for $2... " >&6; }
> > +if eval \${$3+:} false; then :
> > +  $as_echo_n "(cached) " >&6
> > +else
> > +  cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> > +/* end confdefs.h.  */
> > +/* Define $2 to an innocuous variant, in case <limits.h> declares $2.
> > +   For example, HP-UX 11i <limits.h> declares gettimeofday.  */
> > +#define $2 innocuous_$2
> > +
> > +/* System header to define __stub macros and hopefully few prototypes,
> > +    which can conflict with char $2 (); below.
> > +    Prefer <limits.h> to <assert.h> if __STDC__ is defined, since
> > +    <limits.h> exists even on freestanding compilers.  */
> > +
> > +#ifdef __STDC__
> > +# include <limits.h>
> > +#else
> > +# include <assert.h>
> > +#endif
> > +
> > +#undef $2
> > +
> > +/* Override any GCC internal prototype to avoid an error.
> > +   Use char because int might match the return type of a GCC
> > +   builtin and then its argument prototype would still apply.  */
> > +#ifdef __cplusplus
> > +extern "C"
> > +#endif
> > +char $2 ();
> > +/* The GNU C library defines this for functions which it implements
> > +    to always fail with ENOSYS.  Some functions are actually named
> > +    something starting with __ and the normal name is an alias.  */
> > +#if defined __stub_$2 || defined __stub___$2
> > +choke me
> > +#endif
> > +
> > +int
> > +main ()
> > +{
> > +return $2 ();
> > +  ;
> > +  return 0;
> > +}
> > +_ACEOF
> > +if ac_fn_c_try_link "$LINENO"; then :
> > +  eval "$3=yes"
> > +else
> > +  eval "$3=no"
> > +fi
> > +rm -f core conftest.err conftest.$ac_objext \
> > +    conftest$ac_exeext conftest.$ac_ext
> > +fi
> > +eval ac_res=\$$3
> > +              { $as_echo "$as_me:${as_lineno-$LINENO}: result: $ac_res" >&5
> > +$as_echo "$ac_res" >&6; }
> > +  eval $as_lineno_stack; ${as_lineno_stack:+:} unset as_lineno
> > +
> > +} # ac_fn_c_check_func
> > +
> >  # ac_fn_c_try_cpp LINENO
> >  # ----------------------
> >  # Try to preprocess conftest.$ac_ext, and return whether this succeeded.
> > @@ -4039,6 +4106,23 @@ $as_echo "yes" >&6; }
> >    HAVE_KRB5=1
> >    KRB5_LIBS=`$KRB5_CONFIG --libs`
> >    KRB5_FLAGS=`$KRB5_CONFIG --cflags`
> > +
> > +  SAVE_CFLAGS=$CFLAGS
> > +  SAVE_LIBS=$LIBS
> > +  CFLAGS="$CFLAGS $KRB5_FLAGS"
> > +  LIBS="$LIBS $KRB5_LIBS"
> > +
> > +  for ac_func in krb5_principal_get_realm
> > +do :
> > +  ac_fn_c_check_func "$LINENO" "krb5_principal_get_realm" "ac_cv_func_krb5_principal_get_realm"
> > +if test "x$ac_cv_func_krb5_principal_get_realm" = xyes; then :
> > +  cat >>confdefs.h <<_ACEOF
> > +#define HAVE_KRB5_PRINCIPAL_GET_REALM 1
> > +_ACEOF
> > +
> > +fi
> > +done
> > +
> >  fi
> >
> >  { $as_echo "$as_me:${as_lineno-$LINENO}: checking for library containing versionsort" >&5
> > diff --git a/include/config.h.in b/include/config.h.in
> > index a2a05a8..8a52080 100644
> > --- a/include/config.h.in
> > +++ b/include/config.h.in
> > @@ -24,6 +24,9 @@
> >  /* Define to 1 if you have the <inttypes.h> header file. */
> >  #undef HAVE_INTTYPES_H
> >
> > +/* Define to 1 if you have the `krb5_principal_get_realm' function. */
> > +#undef HAVE_KRB5_PRINCIPAL_GET_REALM
> > +
> >  /* Define to 1 if you have the `ldap_create_page_control' function. */
> >  #undef HAVE_LDAP_CREATE_PAGE_CONTROL
> >
> > diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
> > index 68f9242..b9c16f3 100644
> > --- a/modules/cyrus-sasl.c
> > +++ b/modules/cyrus-sasl.c
> > @@ -64,6 +64,35 @@
> >  #endif
> >  #endif
> >
> > +#ifdef HAVE_KRB5_PRINCIPAL_GET_REALM
> > +void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
> > +                          const char **realm, int *len)
> > +{
> > +       *realm = krb5_principal_get_realm(context, princ);
> > +       if (*realm)
> > +               *len = strlen(*realm);
> > +       else
> > +               *len = 0;
> > +       return;
> 
> missed  '}' here

Fixed and pushed to temporary pending branch, patch also updated in
master branch.

Ian


