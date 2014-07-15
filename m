From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 4/6 v2] autofs4: factor should_expire() out of
 autofs4_expire_indirect.
Date: Tue, 15 Jul 2014 11:48:33 +0800
Message-ID: <1405396113.3112.17.camel@perseus.fritz.box>
References: <20140709233541.4525.25151.stgit@notabene.brown>
	 <20140709234114.4525.25725.stgit@notabene.brown>
	 <20140714105359.4415aab4@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=vl4VSTqIWK9YD2dxxdHuvIFOttQ=; b=E74ouwgxnCt30e4onaPTWA+/vJzt
	u1C/SFbpg1QWGZLBuwgAVd5Ef57rIeqe4iXX9/7aNtFoprKZpWHCMEZoDGi99nuK
	r6lw3bqhc6MCCLXY3kCjbOwO6y3USorZ63uqcy4hLiA5GTZYTLMDL/6yK6FawVQZ
	okbxRy3kHyKvz4c=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=vl4VSTqIWK9YD2dxxdHuvI
	FOttQ=; b=AKnEGzRPrAOVLKNIV0s7c6NQHNfn33Veyiuykxct6+IQrJBRhnojc/
	rPJjPmNugqCcKewYOVBbh/UNxx2TN+ARuu3wyeEz4skVUr1XKu/rDWSByn0R6pAJ
	VyIEbFzxoZpnL7PxyVGBPZQj7SPf5rFsvDPEn62/FtSLiRTNImX7o=
In-Reply-To: <20140714105359.4415aab4@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.de>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2014-07-14 at 10:53 +1000, NeilBrown wrote:
> Here is a revised version of this one patch.
> This one fixes a problem with refcounts on dentry and adds a comment to
> clarify the behaviour of should_expire().

I have some bad news I'm afraid, not about the patches.

As I mentioned I'm well behind in some time sensitive work I need to do
and I've suddenly run into a completely unexpected and quite serious
problem related to the amd map format parser I've added to autofs.

I did most of the development for that on the 3.10 series kernel and
that worked fine, and since I made hardly any kernel changes, I expected
there wouldn't be further problems.

Now I come to develop RHEL-6 tests for it for QA purposes (which I
started to do on Fedora 20, 3.14 series kernel) and the symlink handling
is suddenly broken.

The symptom is an autofs mount that has contained a symlink (whether
it's still present or not) can't be umounted and I use symlinks a lot
with the amd parser.

So far I've tracked this to something that was introduced between 3.11
and 3.12. One change that went into 3.12 was Jeff Laytons' umount
specific path resolution for umount. I've found this is also broken on
recent RHEL-6 kernels and that change is present in them too so the
evidence is leaning toward that being the problem. Just how could happen
with this change I have no clue so far, it just doesn't make sense.

Anyway that's going to make testing these patches impossible until I can
work out what the problem is and fix it.

Very sorry to hold you up on this but it can't be avoided. 

> 
> thanks,
> NeilBrown
> 
> 
> From: NeilBrown <neilb@suse.de>Date: Tue, 8 Jul 2014 17:14:53 +1000
> Subject: [PATCH] autofs4: factor should_expire() out of autofs4_expire_indirect.
> 
> Future patch will potentially call this twice, so make it
> separate.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index 7e2f22ce6954..402ee7f1461a 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -345,6 +345,89 @@ out:
>  	return NULL;
>  }
>  
> +/* Check if 'dentry' should expire, or return a nearby
> + * dentry that is suitable.
> + * If returned dentry is different from arg dentry,
> + * then a dget() reference was taken, else not.
> + */
> +static struct dentry *should_expire(struct dentry *dentry,
> +				    struct vfsmount *mnt,
> +				    unsigned long timeout,
> +				    int how)
> +{
> +	int do_now = how & AUTOFS_EXP_IMMEDIATE;
> +	int exp_leaves = how & AUTOFS_EXP_LEAVES;
> +	struct autofs_info *ino = autofs4_dentry_ino(dentry);
> +	unsigned int ino_count;
> +
> +	/* No point expiring a pending mount */
> +	if (ino->flags & AUTOFS_INF_PENDING)
> +		return NULL;
> +
> +	/*
> +	 * Case 1: (i) indirect mount or top level pseudo direct mount
> +	 *	   (autofs-4.1).
> +	 *	   (ii) indirect mount with offset mount, check the "/"
> +	 *	   offset (autofs-5.0+).
> +	 */
> +	if (d_mountpoint(dentry)) {
> +		DPRINTK("checking mountpoint %p %.*s",
> +			dentry, (int)dentry->d_name.len, dentry->d_name.name);
> +
> +		/* Can we umount this guy */
> +		if (autofs4_mount_busy(mnt, dentry))
> +			return NULL;
> +
> +		/* Can we expire this guy */
> +		if (autofs4_can_expire(dentry, timeout, do_now))
> +			return dentry;
> +		return NULL;
> +	}
> +
> +	if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
> +		DPRINTK("checking symlink %p %.*s",
> +			dentry, (int)dentry->d_name.len, dentry->d_name.name);
> +		/*
> +		 * A symlink can't be "busy" in the usual sense so
> +		 * just check last used for expire timeout.
> +		 */
> +		if (autofs4_can_expire(dentry, timeout, do_now))
> +			return dentry;
> +		return NULL;
> +	}
> +
> +	if (simple_empty(dentry))
> +		return NULL;
> +
> +	/* Case 2: tree mount, expire iff entire tree is not busy */
> +	if (!exp_leaves) {
> +		/* Path walk currently on this dentry? */
> +		ino_count = atomic_read(&ino->count) + 1;
> +		if (d_count(dentry) > ino_count)
> +			return NULL;
> +
> +		if (!autofs4_tree_busy(mnt, dentry, timeout, do_now))
> +			return dentry;
> +		/*
> +		 * Case 3: pseudo direct mount, expire individual leaves
> +		 *	   (autofs-4.1).
> +		 */
> +	} else {
> +		/* Path walk currently on this dentry? */
> +		struct dentry *expired;
> +		ino_count = atomic_read(&ino->count) + 1;
> +		if (d_count(dentry) > ino_count)
> +			return NULL;
> +
> +		expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
> +		if (expired) {
> +			if (expired == dentry)
> +				dput(dentry);
> +			return dentry;
> +		}
> +	}
> +	return NULL;
> +}
>  /*
>   * Find an eligible tree to time-out
>   * A tree is eligible if :-
> @@ -359,11 +442,8 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  	unsigned long timeout;
>  	struct dentry *root = sb->s_root;
>  	struct dentry *dentry;
> -	struct dentry *expired = NULL;
> -	int do_now = how & AUTOFS_EXP_IMMEDIATE;
> -	int exp_leaves = how & AUTOFS_EXP_LEAVES;
> +	struct dentry *expired;
>  	struct autofs_info *ino;
> -	unsigned int ino_count;
>  
>  	if (!root)
>  		return NULL;
> @@ -374,78 +454,12 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  	dentry = NULL;
>  	while ((dentry = get_next_positive_subdir(dentry, root))) {
>  		spin_lock(&sbi->fs_lock);
> -		ino = autofs4_dentry_ino(dentry);
> -		/* No point expiring a pending mount */
> -		if (ino->flags & AUTOFS_INF_PENDING)
> -			goto next;
> -
> -		/*
> -		 * Case 1: (i) indirect mount or top level pseudo direct mount
> -		 *	   (autofs-4.1).
> -		 *	   (ii) indirect mount with offset mount, check the "/"
> -		 *	   offset (autofs-5.0+).
> -		 */
> -		if (d_mountpoint(dentry)) {
> -			DPRINTK("checking mountpoint %p %.*s",
> -				dentry, (int)dentry->d_name.len, dentry->d_name.name);
> -
> -			/* Can we umount this guy */
> -			if (autofs4_mount_busy(mnt, dentry))
> -				goto next;
> -
> -			/* Can we expire this guy */
> -			if (autofs4_can_expire(dentry, timeout, do_now)) {
> -				expired = dentry;
> -				goto found;
> -			}
> -			goto next;
> -		}
> -
> -		if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
> -			DPRINTK("checking symlink %p %.*s",
> -				dentry, (int)dentry->d_name.len, dentry->d_name.name);
> -			/*
> -			 * A symlink can't be "busy" in the usual sense so
> -			 * just check last used for expire timeout.
> -			 */
> -			if (autofs4_can_expire(dentry, timeout, do_now)) {
> -				expired = dentry;
> -				goto found;
> -			}
> -			goto next;
> -		}
> -
> -		if (simple_empty(dentry))
> -			goto next;
> -
> -		/* Case 2: tree mount, expire iff entire tree is not busy */
> -		if (!exp_leaves) {
> -			/* Path walk currently on this dentry? */
> -			ino_count = atomic_read(&ino->count) + 1;
> -			if (d_count(dentry) > ino_count)
> -				goto next;
> -
> -			if (!autofs4_tree_busy(mnt, dentry, timeout, do_now)) {
> -				expired = dentry;
> -				goto found;
> -			}
> -		/*
> -		 * Case 3: pseudo direct mount, expire individual leaves
> -		 *	   (autofs-4.1).
> -		 */
> -		} else {
> -			/* Path walk currently on this dentry? */
> -			ino_count = atomic_read(&ino->count) + 1;
> -			if (d_count(dentry) > ino_count)
> -				goto next;
> -
> -			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
> -			if (expired) {
> +		expired = should_expire(dentry, mnt, timeout, how);
> +		if (expired) {
> +			if (expired != dentry)
>  				dput(dentry);
> -				goto found;
> -			}
> +			goto found;
>  		}
> -next:
>  		spin_unlock(&sbi->fs_lock);
>  	}
>  	return NULL;


