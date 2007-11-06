From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS / SASL support
Date: Tue, 06 Nov 2007 21:29:24 +0900
Message-ID: <1194352164.9373.32.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB750D@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB750D@MLNYC730MB.amrs.win.ml.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org

On Tue, 2007-11-06 at 06:41 -0500, Newman, Edward (GTI) wrote:
> Ian
> 
> Thanks. I was going to send you the attached patch which gets SASL
> working again. I will apply your patch and retest.
> 
> One thing I noticed in reviewing code is that three files have to be
> configured to set up LDAP - /etc/sysconfig/autofs,
> /etc/auto_ldap_auth.conf and /etc/openldap/ldap.conf. Is there a reason
> for this? Can I look at rationalising this? Not clear why there is made
> a dependency on XML libraries.
> 
> Edward
> 
> 
> 
> diff -U 3 -r --exclude-from=exclude-files a/configure.in b/configure.in
> --- a/configure.in	2007-11-05 17:53:01.000000000 -0500
> +++ b/configure.in	2007-11-05 16:18:59.000000000 -0500
> @@ -234,7 +234,7 @@
>  		SASL_FLAGS="-I${withval}/include"
>  	fi
>  )
> -if test -z "$HAVE_SASL" -a "$HAVE_LIBXML" == "1"
> +if test -n "$HAVE_SASL" -a "$HAVE_LIBXML" == "1"
>  then
>  	HAVE_SASL=0
>  	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1
> LIBSASL="$LIBSASL -lsasl2", , -lsasl2 $LIBS)

Mmmm ... not sure this is entirely what we want.

I suspect this will not enable SASL unless --with-sasl is given on the
configure line but I would rather it be configured by default and be
turned off with --without-sasl. That's likely what caused the confusion
in the first place.

I'll think about it a bit more.

Ian
