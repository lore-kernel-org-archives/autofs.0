From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] prevent autofs to try the wrong IP protocol
Date: Mon, 18 Jan 2016 15:40:14 +0800
Message-ID: <1453102814.3073.1.camel@themaw.net>
References: <1453065279.8867.21.camel@domdv.de>
	 <1453084618.3005.14.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=KiexiHaYZnHJLKrC7PcD8LHWVe0=; b=TZHsrm
	MoS3E7/elpWyZnYj8vsWzZ7VKwUUd0D2XxKQqtU5wDxC6aDjaLOx6l3TkO5b4Nh6
	oxfIonx8/3o8nOBCVeCsCrlAh3+Vh49AMwoaDPCb5blCXLbz8hhAkbrekOylqFXg
	XfK9HL5JdEVlqPwgThGwBYcLfVVY6qTbBXNbg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=KiexiHaYZnHJLKr
	C7PcD8LHWVe0=; b=cDAjJ0KrzCODZDYw00KpfpWHaYMZcYBQavkNUVP2v3w8zO3
	+DlB4uSzbCjSSv8zlQ/lR4DYEIxL4FQfJq8J1U2fF2sjTUqCQrenBGqC7Ob8DDee
	qrKfRXjuKitwJryU26isn79QYhVlz3l7bj3ZVFUjyuzWQ+nt/2BloXEhBRo8=
In-Reply-To: <1453084618.3005.14.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andreas Steinmetz <ast@domdv.de>, autofs@vger.kernel.org

On Mon, 2016-01-18 at 10:36 +0800, Ian Kent wrote:
>  
> +static int check_address_proto(unsigned logopt,
> +> 	> 	> 	>        struct host *host, unsigned int version)
> +{
> +> 	> int ipv6_requested = version & (TCP6_REQUESTED | UDP6_REQUESTED);
> +> 	> int ret = 1;
> +
> +> 	> /* If a protocol has been explicitly requested then don't
> +> 	>  * consider addresses that don't match the requested protocol.
> +> 	>  */
> +> 	> if (version & ipv6_requested) {

Umm .. I think this should just be:
if (ipv6_requested) {

> +		if (host->addr_len == INET_ADDRSTRLEN)
> +> 	> 	> 	> ret = 0;
> +> 	> } else {
> +> 	> 	> if (host->addr_len == INET6_ADDRSTRLEN)
> +> 	> 	> 	> ret = 0;
> +> 	> }
> +
> +> 	> if (!ret)
> +> 	> 	> debug(logopt, "requested protocol does not match address");
> +
> +> 	> return ret;
> +}
> +

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
