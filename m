From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 6/6] autofs4: don't take spinlock when not needed in
 autofs4_lookup_expiring
Date: Wed, 16 Jul 2014 11:42:12 +0800
Message-ID: <1405482132.2527.26.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.70534.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=PPnbsDDCjAjWI2ULMslFFLDs75Q=; b=GPj1xe+OHnElJlZSKiKgeHC9DFqB
	RBO2VVt48ol88CGvCg/UAAsvbFGLALXGwAQOtEZYUlS4sYdzrl/V2P3iZTeBFx1r
	MnfQYEj48qlqhQBpDjXWxjrOPY/DVWUkGXlnoGNi/j2aPRMSAX5/OEogEf4XQTsy
	qdqHZSbXvMJ0vRk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=PPnbsDDCjAjWI2ULMslFFL
	Ds75Q=; b=SZzE/1BzhcTTx+HYApu8s3URKQYU1zzmHAFG4FJ2mQk4la5qT8paLn
	NLEUYHBLDwtWf43rWtuXlrwiiLFfjjZs/mHSVCNUmPNMHl13yQ9MF67A9tsOlM7h
	K7/Cbe3WnWcMlg2w62vuQLzasg6ygf3mI7RgpIgmM0FalM5GZPvDM=
In-Reply-To: <20140709234114.4525.70534.stgit@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> If the expiring_list is empty, we can avoid a costly spinlock
> in the rcu-walk path through authfs4_d_manage.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

I know it should be straight forward to say this is OK but I always
think twice and again about areas that are subject to race pressure,
such as the expire to mount pressure of this code.

After thinking about it for a while now I don't have any reason to think
this would be a problem. Perhaps later pressure testing will reveal
something I missed.

It occurs to me that autofs4_lookup_active() might benefit from a
similar addition. Multiple calls to ->lookup() made while the dentry is
still unhashed should have enforced ordering due to the directory
i_mutex so there shouldn't be a problem adding this. But perhaps you
haven't seen delays in that function.

Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs4/root.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index 1ad119407e2f..774c2dab331b 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -219,6 +219,8 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
>  	const unsigned char *str = name->name;
>  	struct list_head *p, *head;
>  
> +	if (list_empty(&sbi->expiring_list))
> +		return NULL;
>  	spin_lock(&sbi->lookup_lock);
>  	head = &sbi->expiring_list;
>  	list_for_each(p, head) {
> 
> 


