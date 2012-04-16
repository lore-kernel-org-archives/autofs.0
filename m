From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] fs/autofs4/dev-ioctl.c: add missing free_dev_ioctl
Date: Mon, 16 Apr 2012 09:19:59 +0800
Message-ID: <1334539199.2250.1.camel@perseus.themaw.net>
References: <1334396928-17537-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=mesmtp;
	 bh=4XeXda05j+LLDRhWPR6EwOuZhrE=; b=twpIp9KQiNmZTzDHppb2MyAIIi4e
	AKTfV2I7ghUbAh1CCewrOEyRlxL2U7SO6qp51TGU84DPXNbjDCTTe7EiEpdXIoJY
	KDSoKGuWMvZt5TXls+z4yiiQit1kIGOufqUeQ8g0XB+4YRqSzwuEk+OyBDti3yCG
	ENgAH/CalDsVwgs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:content-transfer-encoding
	:mime-version; s=smtpout; bh=4XeXda05j+LLDRhWPR6EwOuZhrE=; b=Cvk
	EaFrD2B4oOQT180ZvV2GgobnSmtFGb/wTbaxHku4BkE7qBGZgh/XY97aVN7c3xbV
	Rs/Xkedya8f7hazR15VbHcy9Mn1ndRIkY5PhEe2S8k92DKu2TFvu2DbLFE6WpqPE
	Nf5uKxpaCTrbZnPNTD++rrzZnexzeI6L+kPt02b8=
In-Reply-To: <1334396928-17537-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2012-04-14 at 11:48 +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Free param as done in the other error-handling code.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Oops!
Acked-by: Ian Kent <raven@themaw.net>

> 
> ---
>  fs/autofs4/dev-ioctl.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
> index 9dacb85..f99c2ce 100644
> --- a/fs/autofs4/dev-ioctl.c
> +++ b/fs/autofs4/dev-ioctl.c
> @@ -651,7 +651,8 @@ static int _autofs_dev_ioctl(unsigned int command, struct autofs_dev_ioctl __use
>  	fn = lookup_dev_ioctl(cmd);
>  	if (!fn) {
>  		AUTOFS_WARN("unknown command 0x%08x", command);
> -		return -ENOTTY;
> +		err = -ENOTTY;
> +		goto out;
>  	}
>  
>  	fp = NULL;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

