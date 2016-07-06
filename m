From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] automount: Fix compiler warning
Date: Wed, 06 Jul 2016 17:24:34 +0800
Message-ID: <1467797074.4580.51.camel@themaw.net>
References: <1467624743-7222-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=uUqaezZ8UMhbQf+OhtuYzvfiaWY=; b=ETLIcM
	I7D1VM1/GcxYPeDLPxzEaJkWvboF2T+oal83G0M0kBnvUvuNTlAdyQ7JIlqZDHsQ
	MuviDEdKmZkzA+fO8WU1WXGK1xIEb8yxbMJt9v0NbK9GkJkRqR5ssrHNmN87Nrmi
	Xb9RUiSIuOuFcFMG2PU/TqMQjvqS5JxNAUUW4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=uUqaezZ8UMhbQf+
	OhtuYzvfiaWY=; b=Osbh+4NPSTtGdvZ/vq4DaFE568hZQhsHtfqDbnv1gapXEqy
	Xn+8hBRVn8ukbTLkHyVfP/pBZnrrbJJjfaceFc7cfCgrE04aI2KCe6uMO2yss1fb
	fj1nwAnpB7hdKBpMZXrgWDxY1xjQHJU10yPp3dI93I2JfRG4aZSYqvfl3bOk=
In-Reply-To: <1467624743-7222-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2016-07-04 at 18:32 +0900, Tomohiro Kusumi wrote:
> Fix below compiler (gcc5) warning which isn't autoconf result dependent.
> mounts.c:1779:7: warning: variable 'ret' set but not used [-Wunused-but-set
> -variable]

Indeed, I've been meaning to fix that but I like to have a return assigned even
when it's not used so I can easily identify functions that return status when
changes are needed, so I've left it alone.

I'm adding this to my list of patches (as is).

Unless there is a pressing need for this to be committed to the upstream
repository it will be done the next time I push changes and I can't say when
that will be.
 
> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  lib/mounts.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/mounts.c b/lib/mounts.c
> index 1d1b4da..c67548e 100644
> --- a/lib/mounts.c
> +++ b/lib/mounts.c
> @@ -1776,16 +1776,15 @@ static int remount_active_mount(struct autofs_point
> *ap,
>  			*ioctlfd = -1;
>  		}
>  	} else {
> -		int ret;
>  		/*
>  		 * What can I do if we can't remount the existing
>  		 * mount(s) (possibly a partial failure), everything
>  		 * following will be broken?
>  		 */
>  		if (type == t_indirect)
> -			ret = do_remount_indirect(ap, fd, path);
> +			do_remount_indirect(ap, fd, path);
>  		else
> -			ret = do_remount_direct(ap, fd, path);
> +			do_remount_direct(ap, fd, path);
>  	}
>  
>  	debug(ap->logopt, "re-connected to mount %s", path);
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
