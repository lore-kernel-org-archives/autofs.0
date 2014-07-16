From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 5/6] autofs4: avoid taking fs_lock during rcu-walk
Date: Wed, 16 Jul 2014 17:52:30 +0800
Message-ID: <1405504350.2527.95.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.24652.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=MeFYHo2r3aYhUAZrK9Fkmw4w5Pc=; b=EnY+wttmRjkEmMq/VHgOBaVXqTUh
	kNcz61CW/zEDSvPLVG5U+v94bXehymlWGnT8V0GsLjQnVn9dzdzp6S+wFZnJ9eLV
	zFxzo8JyyNenmMp/hDEECzhuRgtjoZg1Q/krqn0nYgqpXLPsxwjPNCRz4QEsrqBS
	W9Q1+8TvDEf8QrE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=MeFYHo2r3aYhUAZrK9Fkmw
	4w5Pc=; b=CnTzkg9Cb8LJT9Q5uUOxrgYvQ6u4voUSUrtErV1lrtXG41DQKmk15F
	G9OziLwHTcQ96bhsV8GcDUTnmT+1xwc3BIUwLg6XXvd6JOuKOh8/eP1Mo5p/r6BU
	LlFd2+qkAAXIKKBKA+VF4EuOtC8rngkoNj75VlK73ceFWrqInbXIs=
In-Reply-To: <20140709234114.4525.24652.stgit@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2014-07-10 at 09:41 +1000, NeilBrown wrote:
> ->fs_lock protects AUTOFS_INF_EXPIRING.  We need to be sure
> that once the flag is set, no new references beneath the dentry
> are taken.  So rcu-walk currently needs to take fs_lock before
> checking the flag.  This hurts performance.
> 
> Change the expiry to a two-stage process.
> First set AUTHFS_INF_NO_RCU which forces any path walk into
> ref-walk mode, then drop the lock and call synchronize_rcu().
> Once that returns we can be sure no rcu-walk is active beneath
> the dentry and we can check reference counts again.
> 
> Now during an RCU-walk we can test AUTHFS_INF_EXPIRING without
> taking the lock as along as we test AUTHFS_INF_NO_RCU too.

Couple of typos above, eeek!

> If either are set, we must abort the RCU-walk
> If neither are set, we know that refcounts will be tested again
> after we finish the RCU-walk so we are safe to continue.

I believe the idea is sound and the patch looks good.
Nevertheless I think this is probably the tricky bit and if there is a
problem I'm not seeing it's probably in this patch.

The submount-test will probably help with that.

> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/autofs4/autofs_i.h |    4 ++++
>  fs/autofs4/expire.c   |   46 ++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index 99dbb05d6148..469724d7568c 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -79,6 +79,10 @@ struct autofs_info {
>  };
>  
>  #define AUTOFS_INF_EXPIRING	(1<<0) /* dentry is in the process of expiring */
> +#define AUTOFS_INF_NO_RCU	(1<<1) /* the dentry is being considered
> +					* for expiry, so RCU_walk is
> +					* not permitted
> +					*/
>  #define AUTOFS_INF_PENDING	(1<<2) /* dentry pending mount */
>  
>  struct autofs_wait_queue {
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index fb0b5003353f..98a6fd4957f8 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -333,10 +333,19 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
>  	if (ino->flags & AUTOFS_INF_PENDING)
>  		goto out;
>  	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
> -		ino->flags |= AUTOFS_INF_EXPIRING;
> -		init_completion(&ino->expire_complete);
> +		ino->flags |= AUTOFS_INF_NO_RCU;
>  		spin_unlock(&sbi->fs_lock);
> -		return root;
> +		synchronize_rcu();
> +		spin_lock(&sbi->fs_lock);
> +		if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
> +			ino->flags |= AUTOFS_INF_EXPIRING;
> +			smp_mb()
> +			ino->flags &= ~AUTOFS_INF_NO_RCU;
> +			init_completion(&ino->expire_complete);
> +			spin_unlock(&sbi->fs_lock);
> +			return root;
> +		}
> +		ino->flags &= ~AUTOFS_INF_NO_RCU;
>  	}
>  out:
>  	spin_unlock(&sbi->fs_lock);
> @@ -445,12 +454,29 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  	dentry = NULL;
>  	while ((dentry = get_next_positive_subdir(dentry, root))) {
>  		spin_lock(&sbi->fs_lock);
> -		expired = should_expire(dentry, mnt, timeout, how);
> -		if (expired) {
> +		ino = autofs4_dentry_ino(dentry);
> +		if (ino->flags & AUTOFS_INF_NO_RCU)
> +			expired = NULL;
> +		else
> +			expired = should_expire(dentry, mnt, timeout, how);
> +		if (!expired) {
> +			spin_unlock(&sbi->fs_lock);
> +			continue;
> +		}
> +		ino = autofs4_dentry_ino(expired);
> +		ino->flags |= AUTOFS_INF_NO_RCU;
> +		spin_unlock(&sbi->fs_lock);
> +		synchronize_rcu();
> +		spin_lock(&sbi->fs_lock);
> +		if (should_expire(expired, mnt, timeout, how)) {
>  			if (expired != dentry)
>  				dput(dentry);
>  			goto found;
>  		}
> +
> +		ino->flags &= ~AUTOFS_INF_NO_RCU;
> +		if (expired != dentry)
> +			dput(expired);
>  		spin_unlock(&sbi->fs_lock);
>  	}
>  	return NULL;
> @@ -458,8 +484,9 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  found:
>  	DPRINTK("returning %p %.*s",
>  		expired, (int)expired->d_name.len, expired->d_name.name);
> -	ino = autofs4_dentry_ino(expired);
>  	ino->flags |= AUTOFS_INF_EXPIRING;
> +	smp_mb()
> +	ino->flags &= ~AUTOFS_INF_NO_RCU;
>  	init_completion(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
>  	spin_lock(&sbi->lookup_lock);
> @@ -479,11 +506,14 @@ int autofs4_expire_wait(struct dentry *dentry, int rcu_walk)
>  	int status;
>  
>  	/* Block on any pending expire */
> +	if (!(ino->flags & (AUTOFS_INF_EXPIRING | AUTOFS_INF_NO_RCU)))
> +		return 0;
> +
> +	if (rcu_walk)
> +		return -ECHILD;

Be nice to add a blank line here.

>  	spin_lock(&sbi->fs_lock);
>  	if (ino->flags & AUTOFS_INF_EXPIRING) {
>  		spin_unlock(&sbi->fs_lock);
> -		if (rcu_walk)
> -			return -ECHILD;
>  
>  		DPRINTK("waiting for expire %p name=%.*s",
>  			 dentry, dentry->d_name.len, dentry->d_name.name);
> 
> 


