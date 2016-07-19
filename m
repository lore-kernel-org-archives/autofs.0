From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/2] autofs-5.1.2 - Fix a typo in CREDITS
Date: Tue, 19 Jul 2016 11:26:39 +0800
Message-ID: <1468898799.5120.34.camel@themaw.net>
References: <1468138220-4952-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=5TifY6xXSIz1B4mbc4/MjfFvrlY=; b=CeXaEI
	e/DHBdjW/Ilagl7nl2sQWfKibwD6FURO0l4X31VY1pF++GawN/cZhVElMVuJHKpH
	TM+9xOSclyOaD11ts0rGwSQxjRr7r/bzEXGBCUhmTqUMDgFfBSwv4KsD5a+jE+2J
	+atdT80AY7bN2iDCHMXYnz4NdyjvmvdvxpkTw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=5TifY6xXSIz1B4m
	bc4/MjfFvrlY=; b=qVLdHJUwx3G0Skbe53olsiZx5wNYkZYru1MWVsbgpYpUNCY
	ZeIBv8T3aDSWmQTMP6qx7wDhJ4W7zWTBxcwoCJ3Kgyar6unhapZ8Yrpu+fuEiYfR
	vlbHFmkSMcQlrIq1pEIyRjHU4vbA0Wi9kuaHvVCgI/7/w7G9sK+T88yUcnT8=
In-Reply-To: <1468138220-4952-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs@vger.kernel.org

On Sun, 2016-07-10 at 17:10 +0900, Tomohiro Kusumi wrote:
> Fix a typo in a contributor's name.
> Two other parts of this file says "Aaron".

Added to the patches list.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  CREDITS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 8d5057a..a931de1 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2,7 +2,7 @@
>  CREDITS
>  =======
>  
> -Arron Ogden
> +Aaron Ogden
>  -----------
>  
>  While other people have contributed to autofs in various ways
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
