From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/6] fix no "libxml/tree.h" error in modules
 lookup_ldap.c
Date: Tue, 23 Jul 2013 18:17:38 +0800
Message-ID: <1374574658.3418.7.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=ajxUZgdNhlE93epHKh5PtItXX2M=; b=OTydcF7va292ybTDRp3GNWEb/8iI
	qKP/e1JBx22khZWiW8236PYvZLm6Bhp0lu46aQeNLu0n8ASF55losBBP2Xl2hL0j
	4d9AyJ5BoVCCnfEKytlgw1H78ub94gAt6OzgClhBBMTwRVFNYxa+ulNOJhmF0BTY
	c/+DYfZDJWxdIU0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=ajxUZgdNhlE93epHKh5PtI
	tXX2M=; b=XqZXym89iJGrzdPmStUdIJOX6y8jJjb49nd6PQIb1qSWB76T5KB6MM
	S7/hAzhuQHn5X+O/HQ9xW/nuH/lMsV6paPcgVunf3vP7/h558EpVnJ5rQrUZaPmj
	Ze76yUC2w8KT843hxONljvaykGSx7jq3Q8HVbN4Hxun1eTKvt6DBk=
In-Reply-To: <1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> make "libxml/tree.h" controlled by WITH_SASL, also move it beind line of
> #include "automount.h", since WITH_SASL is defined in config.h which is
> included by automout.h

Same again, WITH_LDAP defined and WITH_SASL not.
I agree there appears to be a problem but not sure what to do about it.

> 
> ---
> Gentoo Bugs:
>  https://bugs.gentoo.org/show_bug.cgi?id=468606
> 
> gcc -shared -O2 -pipe -march=core2  -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_REENTRANT
> -D_FILE_OFFSET_BITS=
> 64 -I../include -I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
> -DAUTOFS_MAP_DIR=\"/e
> tc/autofs\" -DLDAP_DEPRECATED=1 -o lookup_ldap.so \
>         lookup_ldap.c dclist.o base64.o  \
>         ../lib/autofs.a -lldap -llber -lresolv
> : lookup_yp.so
> lookup_ldap.c:31:25: fatal error: libxml/tree.h: No such file or directory
>  #include <libxml/tree.h>
>                          ^
> compilation terminated.
> 
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  modules/lookup_ldap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> index b8970a6..fad558d 100644
> --- a/modules/lookup_ldap.c
> +++ b/modules/lookup_ldap.c
> @@ -28,7 +28,6 @@
>  #include <arpa/nameser.h>
>  #include <resolv.h>
>  #include <lber.h>
> -#include <libxml/tree.h>
>  
>  #define MODULE_LOOKUP
>  #include "automount.h"
> @@ -36,6 +35,10 @@
>  #include "lookup_ldap.h"
>  #include "base64.h"
>  
> +#ifdef WITH_SASL
> +#include <libxml/tree.h>
> +#endif
> +
>  #define MAPFMT_DEFAULT "sun"
>  
>  #define MODPREFIX "lookup(ldap): "


