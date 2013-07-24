From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/6] fix compile error with heimdal support enabled
Date: Wed, 24 Jul 2013 18:32:32 +0800
Message-ID: <1374661952.2358.42.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-2-git-send-email-dennis.yxun@gmail.com>
	 <1374572675.3418.2.camel@perseus.fritz.box>
	 <CAF1ZMEcgiABZ+gbxfRj3GLM9X2U2b_awq8+M6m_nwxPW+3uzCg@mail.gmail.com>
	 <1374576609.3418.21.camel@perseus.fritz.box>
	 <CAF1ZMEcrUuair2Gw3WucoUv=5eVy=4cxv8tSqcaCYqNqNvRm7g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=n5xhlgMQ3Ic9XcTcMZEUrOaUglQ=; b=aw24W6BhUOiRAKCQKzDxms7PwkyK
	UzLApwGH7L6IPpV+oshrQUstC16k0jroQ4PwtWpc/egzywoB60ycdG+Ct7LD7b7E
	BbX4lpzusKBDE7otrzPXdZaomva3zJo6A1ILMiDW7hsNBCvr4RjEVUFOPPdh+6R5
	MypVrWT28Sxou20=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=n5xhlgMQ3Ic9XcTcMZEUrO
	aUglQ=; b=CDOUFHtLiRRwxzRj/GX/V7znEqkd0BUhWf5DVfW5gdQqHn+sJSFqMP
	itakmM0WPv3Q6rAZITPb8f4NDIZL0hfe9Y0P89ZWv5Uh/bhZRczaLLG+VdFFwsM1
	UfBhc5ROmrxP+ezgbsIoPGRiUgf6vFe0R7u1CLrU35fG3tNlffqV4=
In-Reply-To: <CAF1ZMEcrUuair2Gw3WucoUv=5eVy=4cxv8tSqcaCYqNqNvRm7g@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, 2013-07-24 at 18:25 +0800, Dennis Lan (dlan) wrote:
> On Tue, Jul 23, 2013 at 6:50 PM, Ian Kent <raven@themaw.net> wrote:
> > On Tue, 2013-07-23 at 18:19 +0800, Dennis Lan (dlan) wrote:
> >> On Tue, Jul 23, 2013 at 5:44 PM, Ian Kent <raven@themaw.net> wrote:
> >> > On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> >> >> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> >> >>
> >> >> this patch instroduce a compatible layer between Heimdal and MTT Krb5.
> >> >> And I slightly rework the original patch to make it more readable.
> >> >>
> >> >> ---
> >> >> Upstream Discussion:
> >> >>   http://thread.gmane.org/gmane.linux.kernel.autofs/4203
> >> >>
> >> >> Gentoo Bugs:
> >> >>   https://bugs.gentoo.org/show_bug.cgi?id=210762
> >> >>
> >> >> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> >> >> ---
> >> >>  aclocal.m4           |  7 +++++++
> >> >>  modules/cyrus-sasl.c | 35 ++++++++++++++++++++++++++++++-----
> >> >>  2 files changed, 37 insertions(+), 5 deletions(-)
> >> >>
> >> >> diff --git a/aclocal.m4 b/aclocal.m4
> >> >> index c5de159..7a8b03c 100644
> >> >> --- a/aclocal.m4
> >> >> +++ b/aclocal.m4
> >> >> @@ -299,6 +299,13 @@ else
> >> >>    HAVE_KRB5=1
> >> >>    KRB5_LIBS=`$KRB5_CONFIG --libs`
> >> >>    KRB5_FLAGS=`$KRB5_CONFIG --cflags`
> >> >> +
> >> >> +  SAVE_CFLAGS=$CFLAGS
> >> >> +  SAVE_LIBS=$LIBS
> >> >> +  CFLAGS="$CFLAGS $KRB5_FLAGS"
> >> >> +  LIBS="$LIBS $KRB5_LIBS"
> >> >> +
> >> >> +  AC_CHECK_FUNCS([krb5_principal_get_realm])
> >> >>  fi])
> >> >>
> >> >>  dnl --------------------------------------------------------------------------
> >> >> diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
> >> >> index 68f9242..6115f90 100644
> >> >> --- a/modules/cyrus-sasl.c
> >> >> +++ b/modules/cyrus-sasl.c
> >> >> @@ -64,6 +64,31 @@
> >> >>  #endif
> >> >>  #endif
> >> >>
> >> >> +#ifdef HAVE_KRB5_PRINCIPAL_GET_REALM
> >> >> +void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
> >> >> +                          const char **realm, int *len)
> >> >> +{
> >> >> +    *realm = krb5_principal_get_realm(context, princ);
> >> >> +    *len = strlen(*realm);
> >> >
> >> > So krb5_principal_get_realm() never fails, or does it return NULL, what
> >> > about strlen(NULL) .... SEGV.
> >> >
> >> >> +}
> >> >> +#else
> >> >> +void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
> >> >> +                          const char **realm, int *len)
> >> >> +{
> >> >> +    const krb5_data *data;
> >> >> +
> >> >> +    data = krb5_princ_realm(context, princ);
> >> >> +    if (data) {
> >> >> +        *realm = data->data;
> >> >> +        *len = data->length;
> >> >> +    } else {
> >> >> +        *realm = NULL;
> >> >> +        *len = 0;
> >> >> +    }
> >> >> +}
> >> >> +#endif
> >> >> +
> >> >> +
> >> >>  /*
> >> >>   *  Once a krb5 credentials cache is setup, we need to set the KRB5CCNAME
> >> >>   *  environment variable so that the library knows where to find it.
> >> >> @@ -379,7 +404,8 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
> >> >>       krb5_principal tgs_princ, krb5_client_princ;
> >> >>       krb5_creds my_creds;
> >> >>       char *tgs_name;
> >> >> -     int status;
> >> >> +     const char *realm_name;
> >> >> +     int status, realm_length;
> >> >>
> >> >>       if (ctxt->kinit_done)
> >> >>               return 0;
> >> >> @@ -450,12 +476,11 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
> >> >>       }
> >> >>
> >> >>       /* setup a principal for the ticket granting service */
> >> >> +     _krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ, &realm_name, &realm_length);
> >> >>       ret = krb5_build_principal_ext(ctxt->krb5ctxt, &tgs_princ,
> >> >> -             krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
> >> >> -             krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
> >> >> +             realm_length, realm_name,
> >> >>               strlen(KRB5_TGS_NAME), KRB5_TGS_NAME,
> >> >> -             krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
> >> >> -             krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
> >> >> +             realm_length, realm_name,
> >> >>               0);
> >> >>       if (ret) {
> >> >>               error(logopt,
> >> >
> >> >
> >> HI Ian:
> >>   As I looking into the code (krb5_principal_get_realm) which provided
> >> by heimdal, there is no grantee that *realm will always be valid
> >> (does't do internal check, and does't return "" empty string if fail).
> >> But, as my knowledge here, I guess we should already grantee that
> >> *realm is valid before calling this function,
> >>   It won't hurt if we add add a check here, so how about this?
> >>
> >>  *len = (*realm == NULL) ? 0 : strlen(*realm);
> >
> > Yeah, so we should be able to be sure it will always never return "".
> >
> > That's probably a fair assumption ... although maybe *realm should be
> > initialized to NULL on entry to avoid odd arch specific initialization
> > issues.
> >
> >>
> >> Dennis
> >
> >
> 
> HI Ian:
>   How about this one? for the three types of patches ;-)
> which should this one belong to?

All the patches in the series we are discussing, except for patch 9
since it's not finished yet, I want to commit next time I do one. I want
to finish patch 9 as well so I can commit it.

The patches are mostly straight forward so I'd like to include them in
the 5.0.8 release, which I want to do some time soon. It's overdue ...

>   Thanks
> 
> Dennis Lan (dlan)


