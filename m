From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: krb5 required when building with sasl support
Date: Wed, 04 Feb 2009 17:58:33 +0100
Message-ID: <4989C939.7090106@s3group.cz>
References: <n7xy6wmw3uu.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xy6wmw3uu.fsf@sor.suse.de>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

+1 - I have spotted this, too....
O.
Matthias Koenig wrote:
> Hi,
>
> it seems that it is necessary to link also against krb5 when
> building the LDAP lookup module with SASL support.
> This is missing currently in the configure.in it only
> links with -lsasl.
> The following patch should fix this.
>
> Regards,
> Matthias
>
> Index: autofs-5.0.4/configure.in
> ===================================================================
> --- autofs-5.0.4.orig/configure.in	2008-11-04 02:36:48.000000000 +0100
> +++ autofs-5.0.4/configure.in	2009-02-04 17:30:01.000000000 +0100
> @@ -256,8 +256,13 @@ AC_ARG_WITH(sasl,
>  if test -z "$HAVE_SASL" -o "$HAVE_SASL" != "0" -a "$HAVE_LIBXML" == "1"
>  then
>  	HAVE_SASL=0
> -	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1 LIBSASL="$LIBSASL -lsasl2", , -lsasl2 $LIBS)
> +        HAVE_KRB5=0
> +	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1,, -lsasl2 $LIBS)
> +        AC_CHECK_LIB(krb5, krb5_mk_req_extended, HAVE_KRB5=1,, $LIBS)
>  	if test "$HAVE_SASL" == "1"; then
> +		test "$HAVE_KRB5" != "1" && \
> +                    AC_MSG_FAILURE([You need krb5 libs to build with SASL support])
> +                LIBSASL="$LIBSASL -lsasl2 -lkrb5"
>  		AC_DEFINE(WITH_SASL,1,
>  			[Define if using SASL authentication with the LDAP module])
>  	fi
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>   
