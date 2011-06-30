From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Fix non-IPv6 host name lookups (5.0.6)
Date: Thu, 30 Jun 2011 14:37:59 +0800
Message-ID: <1309415879.3183.3.camel@perseus.themaw.net>
References: <20110629143911.GA11914@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=YBaob7M5sUuO4z1HvwOiWFCH0sk=;
	b=YD8kxvo7tfBdGEwgDHE4kbQIAyu8i7T/UxuNCh3RCz+fECVJFOuwRAoHY+GgSCXXeQl3dxgJFB/XlpszgJbFKtAhdnS8ev5x/JlaQr4OGExq9ixA5co/KcHUnHXukifgk/KCfIN15cPznbH2rqhwJUFWcOLw9gxtpHDRafwNm5E=
In-Reply-To: <20110629143911.GA11914@libre.l.ngdn.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2011-06-29 at 11:39 -0300, Leonardo Chiquitto wrote:
> Fix non-IPv6 host name lookups
> 
> Commit 5b083026 ("fix ipv6 name for lookup") causes a regression
> in regular (non-IPv6) host name lookups: it trims the first host
> name character even when it's not a "[". This patch fixes the issue.

Gaah .... yep.

> 
> ---
>  modules/replicated.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Index: autofs/modules/replicated.c
> ===================================================================
> --- autofs.orig/modules/replicated.c
> +++ autofs/modules/replicated.c
> @@ -1125,15 +1125,17 @@ static int add_host_addrs(struct host **
>  	}
>  	len = strlen(name);
>  
> -	if (name[0] == '[' && name[--len] == ']')
> +	if (name[0] == '[' && name[--len] == ']') {
>  		name[len] = '\0';
> +		memmove(name, name + 1, len);
> +	}
>  
>  	memset(&hints, 0, sizeof(hints));
>  	hints.ai_flags = AI_NUMERICHOST;
>  	hints.ai_family = AF_UNSPEC;
>  	hints.ai_socktype = SOCK_DGRAM;
>  
> -	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
> +	ret = getaddrinfo(name, NULL, &hints, &ni);
>  	if (ret)
>  		goto try_name;
>  
> @@ -1153,7 +1155,7 @@ try_name:
>  	hints.ai_family = AF_UNSPEC;
>  	hints.ai_socktype = SOCK_DGRAM;
>  
> -	ret = getaddrinfo(name + 1, NULL, &hints, &ni);
> +	ret = getaddrinfo(name, NULL, &hints, &ni);
>  	if (ret) {
>  		error(LOGOPT_ANY, "hostname lookup failed: %s",
>  		      gai_strerror(ret));
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
