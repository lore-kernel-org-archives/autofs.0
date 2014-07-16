From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/6] autofs4: remove unused autofs4_ispending()
Date: Wed, 16 Jul 2014 11:26:02 +0800
Message-ID: <1405481162.2527.10.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.94513.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=RHpJxlpl0/3wMf09KqbOkIgUbBc=; b=WbMVOqsJQ9HZd6S5f5TAbFMHCSQG
	ojlJ4S1QBJMW0B0sHfgOJ7lm1WTejLNXA9+esXM5C2u/M5UGrO/zJMDfChtpPOkN
	um1/N06pW7O4Y31hu3VeJZkLZj03zvtIMlgp2z5DLrDYq5ScTT1p6u7EZNczH1KX
	7bGFGKFeLNVuO80=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=RHpJxlpl0/3wMf09KqbOkI
	gUbBc=; b=UHtCakog2Qt6t0lQK812T7SdEEAFfNx1tUxZ1Pmncs7YMggIslGh8C
	a/MYyohAzX5yOa+NsoukdjPJXZ0ATxrrsRMW0CYafV9JqBYx/Jcv2a940Rcrs+BD
	iGAWpHyEQsbW6p9bB9XxDdizw1cjBCLQcj2pQmcLiFCWWGNtUiWZQ=
In-Reply-To: <20140709234114.4525.94513.stgit@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> Signed-off-by: NeilBrown <neilb@suse.de>

Obviously straight forward.
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs4/autofs_i.h |   14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index acf32054edd8..22a280151e45 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -143,20 +143,6 @@ static inline int autofs4_oz_mode(struct autofs_sb_info *sbi) {
>  	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
>  }
>  
> -/* Does a dentry have some pending activity? */
> -static inline int autofs4_ispending(struct dentry *dentry)
> -{
> -	struct autofs_info *inf = autofs4_dentry_ino(dentry);
> -
> -	if (inf->flags & AUTOFS_INF_PENDING)
> -		return 1;
> -
> -	if (inf->flags & AUTOFS_INF_EXPIRING)
> -		return 1;
> -
> -	return 0;
> -}
> -
>  struct inode *autofs4_get_inode(struct super_block *, umode_t);
>  void autofs4_free_ino(struct autofs_info *);
>  
> 
> 


