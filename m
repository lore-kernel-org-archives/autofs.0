From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/6] fix compile error with heimdal support enabled
Date: Tue, 23 Jul 2013 17:44:35 +0800
Message-ID: <1374572675.3418.2.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-2-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=JIbT+c9w5WmMvP4wzXTJeQXlO9M=; b=BH6m/Kw6FZjSeI7qMTGpihbdYhrZ
	SfTjPShe8mLZy7BC5xuniW3V83CNqQmXv+ICiWaYtysLAhQslfrJ4tBQyrJ18Mn+
	DwUN3rby6ZdegMm6MmUsyzbaCrp77pkofU61N0u+pSIdB2IqbaErOeNZXZi8lmEy
	hNMqB2P8+YmLtFs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=JIbT+c9w5WmMvP4wzXTJeQ
	XlO9M=; b=BUoJDGcGKBuwKNuTwcUQE3hSPOQI8mz3nBLDsDWCodAnPu/Lz9nGcD
	Ko4rUc4+i8tU1hdrb4IOuAr39ZhgIIJNAS+ZKp9Uo2xWuRoNJ5/hxpXeFVxvkp4U
	NqCxJoF2gseQLS9HCNV6j8Rf1tADi4gmQVQR7aAG7XreAj+HfGjak=
In-Reply-To: <1374505194-22668-2-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> this patch instroduce a compatible layer between Heimdal and MTT Krb5.
> And I slightly rework the original patch to make it more readable.
> 
> ---
> Upstream Discussion:
>   http://thread.gmane.org/gmane.linux.kernel.autofs/4203
> 
> Gentoo Bugs:
>   https://bugs.gentoo.org/show_bug.cgi?id=210762
> 
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  aclocal.m4           |  7 +++++++
>  modules/cyrus-sasl.c | 35 ++++++++++++++++++++++++++++++-----
>  2 files changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/aclocal.m4 b/aclocal.m4
> index c5de159..7a8b03c 100644
> --- a/aclocal.m4
> +++ b/aclocal.m4
> @@ -299,6 +299,13 @@ else
>    HAVE_KRB5=1
>    KRB5_LIBS=`$KRB5_CONFIG --libs`
>    KRB5_FLAGS=`$KRB5_CONFIG --cflags`
> +
> +  SAVE_CFLAGS=$CFLAGS
> +  SAVE_LIBS=$LIBS
> +  CFLAGS="$CFLAGS $KRB5_FLAGS"
> +  LIBS="$LIBS $KRB5_LIBS"
> +
> +  AC_CHECK_FUNCS([krb5_principal_get_realm])
>  fi])
>  
>  dnl --------------------------------------------------------------------------
> diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
> index 68f9242..6115f90 100644
> --- a/modules/cyrus-sasl.c
> +++ b/modules/cyrus-sasl.c
> @@ -64,6 +64,31 @@
>  #endif
>  #endif
>  
> +#ifdef HAVE_KRB5_PRINCIPAL_GET_REALM
> +void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
> +                          const char **realm, int *len)
> +{
> +    *realm = krb5_principal_get_realm(context, princ);
> +    *len = strlen(*realm);

So krb5_principal_get_realm() never fails, or does it return NULL, what
about strlen(NULL) .... SEGV.

> +}
> +#else
> +void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
> +                          const char **realm, int *len)
> +{
> +    const krb5_data *data;
> +
> +    data = krb5_princ_realm(context, princ);
> +    if (data) {
> +        *realm = data->data;
> +        *len = data->length;
> +    } else {
> +        *realm = NULL;
> +        *len = 0;
> +    }
> +}
> +#endif
> +
> +
>  /*
>   *  Once a krb5 credentials cache is setup, we need to set the KRB5CCNAME
>   *  environment variable so that the library knows where to find it.
> @@ -379,7 +404,8 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
>  	krb5_principal tgs_princ, krb5_client_princ;
>  	krb5_creds my_creds;
>  	char *tgs_name;
> -	int status;
> +	const char *realm_name;
> +	int status, realm_length;
>  
>  	if (ctxt->kinit_done)
>  		return 0;
> @@ -450,12 +476,11 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
>  	}
>  
>  	/* setup a principal for the ticket granting service */
> +	_krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ, &realm_name, &realm_length);
>  	ret = krb5_build_principal_ext(ctxt->krb5ctxt, &tgs_princ,
> -		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
> -		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
> +		realm_length, realm_name,
>  		strlen(KRB5_TGS_NAME), KRB5_TGS_NAME,
> -		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
> -		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
> +		realm_length, realm_name,
>  		0);
>  	if (ret) {
>  		error(logopt,


