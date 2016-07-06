From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] automount: Drop redundant \n in logerr()
Date: Wed, 06 Jul 2016 17:55:13 +0800
Message-ID: <1467798913.4580.53.camel@themaw.net>
References: <1467629332-8581-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8KhMu10h27j4Eq/6wO9/+EHi0MM=; b=fUpmRI
	ChkDzLrgKa8549I/P2GFyZ59IIVjS2sL57Kzwa/LzC+2dOZam1tGOWc3j7mPwZO9
	SPnMsIiaDf77GBo2sad7EvMy+GN/CNSNcdNCjJ2dS+bhAb7mP7XaIVv2ytTwcmMj
	nMIoojwaoaodY50npa2UmieVM9CY+pqh9elj8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8KhMu10h27j4Eq/
	6wO9/+EHi0MM=; b=gDIXSU8pYRKiSpvN8UYTHn8E6ZTnlWB80Fo2TDqnPqBFr7G
	H9RhssP0ORc/kTuDI15V5fv2bXYCrI70Q0TLeNFgqGt9KaUWngAyfv8bf7gU4aF5
	+bxpuXMtk1dK3C9GWVvKMkrSnIGSz1wp/sZ5FHkImGex6eZjJIVHvwHiaZT4=
In-Reply-To: <1467629332-8581-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2016-07-04 at 19:48 +0900, Tomohiro Kusumi wrote:
> Line break isn't necessary from the way logerr (and logmsg) is implemented,
> and these two probably aren't intentional.

Added to the list, same as the previous in terms of pushing it to the repo.

> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  daemon/module.c | 2 +-
>  lib/nss_parse.y | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/daemon/module.c b/daemon/module.c
> index bed8f7a..db01db8 100644
> --- a/daemon/module.c
> +++ b/daemon/module.c
> @@ -34,7 +34,7 @@ int load_autofs4_module(void)
>  	 */
>  	fp = open_fopen_r("/proc/filesystems");
>  	if (!fp) {
> -		logerr("cannot open /proc/filesystems\n");
> +		logerr("cannot open /proc/filesystems");
>  		return 0;
>  	}
>  
> diff --git a/lib/nss_parse.y b/lib/nss_parse.y
> index 055e9d7..0721ba1 100644
> --- a/lib/nss_parse.y
> +++ b/lib/nss_parse.y
> @@ -169,7 +169,7 @@ int nsswitch_parse(struct list_head *list)
>  
>  	nsswitch = open_fopen_r(NSSWITCH_FILE);
>  	if (!nsswitch) {
> -		logerr("couldn't open %s\n", NSSWITCH_FILE);
> +		logerr("couldn't open %s", NSSWITCH_FILE);
>  		return 1;
>  	}
>  
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
