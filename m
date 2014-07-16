From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 2/6] autofs4: remove a redundant assignment
Date: Wed, 16 Jul 2014 11:27:12 +0800
Message-ID: <1405481232.2527.12.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.3341.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=/nT+THOykBebeB4vDgwuYiYOnkE=; b=bZVtW4kLlyDt184DltZGjnDo/VeT
	mrbsrv7zRH2+SPDkJ4SirkHeVOuS4aaSx+p1upD8zyFqLEVnk1viTQfyKFjqSKq0
	lJpvVbZ6+RImoXucQeKG60Ge2K6SELnSQH7bf3CfiklYMQF0/lka6klzUSNW8MrE
	+UeNqw/CNxrYhdI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=/nT+THOykBebeB4vDgwuYi
	YOnkE=; b=tgaEW7uGd9SK2g/mIcUcSm8/pfuDn7jlwkAJTMuCkZAJS6RBmjBNzT
	cB1Sjb0kueFxjna5f8lR+ggfCyb2VC26QNjHxHSjEenasHp2dQq05eN1G39VlB2B
	hgDT5yyOWy7xzvL8d12S4TPOiTS8YiRVNg8QH+OOSTrzwdJUdcD24=
In-Reply-To: <20140709234114.4525.3341.stgit@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> The variable 'ino' already exists and already
> has the correct value.  The d_fsdata of a dentry
> is never changed after the d_fsdata is instantiated,
> so this new assignment cannot be necessary.
> 
> It was introduced in
> commit b5b801779d59165c4ecf1009009109545bd1f642
>     autofs4: Add d_manage() dentry operation
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

Again, an obvious cleanup, thanks for that.
Acked-by: Ian Kent <raven@themaw.net>

> ---
>  fs/autofs4/expire.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index 394e90b02c5e..a7be57e39be7 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -333,7 +333,6 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
>  	if (ino->flags & AUTOFS_INF_PENDING)
>  		goto out;
>  	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
> -		struct autofs_info *ino = autofs4_dentry_ino(root);
>  		ino->flags |= AUTOFS_INF_EXPIRING;
>  		init_completion(&ino->expire_complete);
>  		spin_unlock(&sbi->fs_lock);
> 
> 


