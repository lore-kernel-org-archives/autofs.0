From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 6/6] fix typo, forced-shutdown should be force-shutdown
Date: Tue, 23 Jul 2013 18:37:07 +0800
Message-ID: <1374575827.3418.12.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-7-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=SAYBWuO7UyJQ5stYmdPPnppb4/o=; b=IbB38Cqh5RGg+hYcwOyLMTdHKciF
	qewAIY5twOYaKo9k1IMwd/HYPk6F7xRHxyRFYX1qyKTlK/CoukqvN6B3K2s70/L4
	Cni+eYfDvl/WXNjPkV9b6YRsOHT/TdlDfrJWYUBP1eFdiCk9ouodk4A7HJpmOxk5
	r7imsZUUvit5N5o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=SAYBWuO7UyJQ5stYmdPPnp
	pb4/o=; b=Y2nDxOvzKf5duik8HTeiBvZmso3fWe4uu8NEbPaVxjDdOaKHTypSXY
	+PaS/BRMKRP91XdY5JvftjVMIkwPqXyqBKbmbyYNvna496xHTN1INCZNDtkkKtTB
	MJ6wbm6QzQLGlAj0ZUMAZA4F19ACGuanPQjRs52JBJtC20Mf2fdDs=
In-Reply-To: <1374505194-22668-7-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> it will confuse user when they found what shows with "./configure --help"
> differ from what it should be.

This one looks sensible, ;)

> 
> Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
> ---
>  configure.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.in b/configure.in
> index 559045a..0013a39 100644
> --- a/configure.in
> +++ b/configure.in
> @@ -363,7 +363,7 @@ fi
>  #
>  # Enable forced shutdown on USR1 signal (unlink umounts all mounts).
>  #
> -AC_ARG_ENABLE(forced-shutdown,
> +AC_ARG_ENABLE(force-shutdown,
>  [  --enable-force-shutdown enable USR1 signal to force unlink umount of any
>  			  busy mounts during shutdown],,
>  	enableval=no)


