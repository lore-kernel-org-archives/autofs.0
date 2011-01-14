From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 09/18] autofs4: Add d_manage() dentry operation [ver #4]
Date: Fri, 14 Jan 2011 21:51:39 +0800
Message-ID: <1295013099.2794.6.camel@perseus>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	 <20110113215448.19406.58770.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=yjEAiUcCCjicRAY2qAQJVBf1FBg=; b=c279YVOTb2fOE2WWaCebhl+7RL85H0jX4JDwbJZXFRyWKwbeCBRk3k2Fkk7nljv1gkFT4XtkyKnX36+1mmaT8qNcDmSAPND6p/0+oRopxzt1tXtl+djzQ02GK0D79XwO32BsMZ8kch36A//Z5RoGi43VPkqBNCMK5psQ4WnyHDk=
In-Reply-To: <20110113215448.19406.58770.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: viro@zeniv.linux.org.uk, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, 2011-01-13 at 21:54 +0000, David Howells wrote:
> From: Ian Kent <raven@themaw.net>
> 
> This patch required a previous patch to add the ->d_automount()
> dentry operation.
> 
> Add a function to use the newly defined ->d_manage() dentry operation
> for blocking during mount and expire.
> 
> Whether the VFS calls the dentry operations d_automount() and d_manage()
> is controled by the DMANAGED_AUTOMOUNT and DMANAGED_TRANSIT flags. autofs
> uses the d_automount() operation to callback to user space to request
> mount operations and the d_manage() operation to block walks into mounts
> that are under construction or destruction.
> 
> In order to prevent these functions from being called unnecessarily the
> DMANAGED_* flags are cleared for cases which would cause this. In the
> common case the DMANAGED_AUTOMOUNT and DMANAGED_TRANSIT flags are both
> set for dentrys waiting to be mounted. The DMANAGED_TRANSIT flag is
> cleared upon successful mount request completion and set during expire
> runs, both during the dentry expire check, and if selected for expire,
> is left set until a subsequent successful mount request completes.
> 
> The exception to this is the so-called rootless multi-mount which has
> no actual mount at its base. In this case the DMANAGED_AUTOMOUNT flag
> is cleared upon successful mount request completion as well and set
> again after a successful expire.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/autofs4/autofs_i.h |   50 ++++++++++++++++++++++++-
>  fs/autofs4/expire.c   |   51 +++++++++++++------------
>  fs/autofs4/inode.c    |    3 +
>  fs/autofs4/root.c     |  100 +++++++++++++++++++++++++++++++++++++++++++------
>  4 files changed, 164 insertions(+), 40 deletions(-)
> 
> diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
> index 1ebfe53..7eff538 100644
> --- a/fs/autofs4/autofs_i.h
> +++ b/fs/autofs4/autofs_i.h
> @@ -99,7 +99,6 @@ struct autofs_info {
>  };
>  
>  #define AUTOFS_INF_EXPIRING	(1<<0) /* dentry is in the process of expiring */
> -#define AUTOFS_INF_MOUNTPOINT	(1<<1) /* mountpoint status for direct expire */
>  #define AUTOFS_INF_PENDING	(1<<2) /* dentry pending mount */
>  
>  struct autofs_wait_queue {
> @@ -221,6 +220,7 @@ extern const struct file_operations autofs4_root_operations;
>  /* Operations methods */
>  
>  struct vfsmount *autofs4_d_automount(struct path *);
> +int autofs4_d_manage(struct path *, bool);
>  
>  /* VFS automount flags management functions */
>  
> @@ -248,6 +248,54 @@ static inline void managed_dentry_clear_automount(struct dentry *dentry)
>  	spin_unlock(&dentry->d_lock);
>  }
>  
> +static inline void __managed_dentry_set_transit(struct dentry *dentry)
> +{
> +	dentry->d_flags |= DCACHE_MANAGE_TRANSIT;
> +}
> +
> +static inline void managed_dentry_set_transit(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	__managed_dentry_set_transit(dentry);
> +	spin_unlock(&dentry->d_lock);
> +}
> +
> +static inline void __managed_dentry_clear_transit(struct dentry *dentry)
> +{
> +	dentry->d_flags &= ~DCACHE_MANAGE_TRANSIT;
> +}
> +
> +static inline void managed_dentry_clear_transit(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	__managed_dentry_clear_transit(dentry);
> +	spin_unlock(&dentry->d_lock);
> +}
> +
> +static inline void __managed_dentry_set_managed(struct dentry *dentry)
> +{
> +	dentry->d_flags |= (DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT);
> +}
> +
> +static inline void managed_dentry_set_managed(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	__managed_dentry_set_managed(dentry);
> +	spin_unlock(&dentry->d_lock);
> +}
> +
> +static inline void __managed_dentry_clear_managed(struct dentry *dentry)
> +{
> +	dentry->d_flags &= ~(DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT);
> +}
> +
> +static inline void managed_dentry_clear_managed(struct dentry *dentry)
> +{
> +	spin_lock(&dentry->d_lock);
> +	__managed_dentry_clear_managed(dentry);
> +	spin_unlock(&dentry->d_lock);
> +}
> +
>  /* Initializing function */
>  
>  int autofs4_fill_super(struct super_block *, void *, int);
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index 0571ec8..3ed79d7 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -26,10 +26,6 @@ static inline int autofs4_can_expire(struct dentry *dentry,
>  	if (ino == NULL)
>  		return 0;
>  
> -	/* No point expiring a pending mount */
> -	if (ino->flags & AUTOFS_INF_PENDING)
> -		return 0;
> -
>  	if (!do_now) {
>  		/* Too young to die */
>  		if (!timeout || time_after(ino->last_used + timeout, now))
> @@ -283,6 +279,7 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
>  	unsigned long timeout;
>  	struct dentry *root = dget(sb->s_root);
>  	int do_now = how & AUTOFS_EXP_IMMEDIATE;
> +	struct autofs_info *ino;
>  
>  	if (!root)
>  		return NULL;
> @@ -291,20 +288,21 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
>  	timeout = sbi->exp_timeout;
>  
>  	spin_lock(&sbi->fs_lock);
> +	ino = autofs4_dentry_ino(root);
> +	/* No point expiring a pending mount */
> +	if (ino->flags & AUTOFS_INF_PENDING) {
> +		spin_unlock(&sbi->fs_lock);
> +		return NULL;
> +	}
> +	managed_dentry_set_transit(root);
>  	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
>  		struct autofs_info *ino = autofs4_dentry_ino(root);
> -		if (d_mountpoint(root)) {
> -			ino->flags |= AUTOFS_INF_MOUNTPOINT;
> -			spin_lock(&root->d_lock);
> -			root->d_flags &= ~DCACHE_MOUNTED;
> -			spin_unlock(&root->d_lock);
> -		}
>  		ino->flags |= AUTOFS_INF_EXPIRING;
> -		managed_dentry_set_automount(root);
>  		init_completion(&ino->expire_complete);
>  		spin_unlock(&sbi->fs_lock);
>  		return root;
>  	}
> +	managed_dentry_clear_transit(root);
>  	spin_unlock(&sbi->fs_lock);
>  	dput(root);
>  
> @@ -341,6 +339,10 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  	while ((dentry = get_next_positive_dentry(dentry, root))) {
>  		spin_lock(&sbi->fs_lock);
>  		ino = autofs4_dentry_ino(dentry);
> +		/* No point expiring a pending mount */
> +		if (ino->flags & AUTOFS_INF_PENDING)
> +			goto cont;
> +		managed_dentry_set_transit(dentry);
>  
>  		/*
>  		 * Case 1: (i) indirect mount or top level pseudo direct mount
> @@ -400,6 +402,8 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
>  			}
>  		}
>  next:
> +		managed_dentry_clear_transit(dentry);
> +cont:
>  		spin_unlock(&sbi->fs_lock);
>  	}
>  	return NULL;
> @@ -409,7 +413,6 @@ found:
>  		expired, (int)expired->d_name.len, expired->d_name.name);
>  	ino = autofs4_dentry_ino(expired);
>  	ino->flags |= AUTOFS_INF_EXPIRING;
> -	managed_dentry_set_automount(expired);
>  	init_completion(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
>  	spin_lock(&autofs4_lock);
> @@ -482,7 +485,7 @@ int autofs4_expire_run(struct super_block *sb,
>  	ino = autofs4_dentry_ino(dentry);
>  	ino->flags &= ~AUTOFS_INF_EXPIRING;
>  	if (!d_unhashed(dentry))
> -		managed_dentry_clear_automount(dentry);
> +		managed_dentry_clear_transit(dentry);
>  	complete_all(&ino->expire_complete);
>  	spin_unlock(&sbi->fs_lock);
>  
> @@ -508,20 +511,18 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
>  		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
>  
>  		spin_lock(&sbi->fs_lock);
> -		if (ino->flags & AUTOFS_INF_MOUNTPOINT) {
> -			spin_lock(&sb->s_root->d_lock);
> -			/*
> -			 * If we haven't been expired away, then reset
> -			 * mounted status.
> -			 */
> -			if (mnt->mnt_parent != mnt)
> -				sb->s_root->d_flags |= DCACHE_MOUNTED;
> -			spin_unlock(&sb->s_root->d_lock);
> -			ino->flags &= ~AUTOFS_INF_MOUNTPOINT;
> -		}
>  		ino->flags &= ~AUTOFS_INF_EXPIRING;
> +		spin_lock(&dentry->d_lock);
>  		if (ret)
> -			managed_dentry_clear_automount(dentry);
> +			__managed_dentry_clear_transit(dentry);
> +		else {
> +			if ((IS_ROOT(dentry) ||
> +			    (autofs_type_indirect(sbi->type) &&
> +			     IS_ROOT(dentry->d_parent))) &&
> +			    !(dentry->d_flags & DCACHE_NEED_AUTOMOUNT))
> +				__managed_dentry_set_automount(dentry);
> +		}
> +		spin_unlock(&dentry->d_lock);
>  		complete_all(&ino->expire_complete);
>  		spin_unlock(&sbi->fs_lock);
>  		dput(dentry);
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index d0aa38c..75c1ed8 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -253,6 +253,7 @@ static struct autofs_info *autofs4_mkroot(struct autofs_sb_info *sbi)
>  
>  static const struct dentry_operations autofs4_sb_dentry_operations = {
>  	.d_automount	= autofs4_d_automount,
> +	.d_manage	= autofs4_d_manage,
>  	.d_release      = autofs4_dentry_release,
>  };
>  
> @@ -322,7 +323,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
>  	}
>  
>  	if (autofs_type_trigger(sbi->type))
> -		__managed_dentry_set_automount(root);
> +		__managed_dentry_set_managed(root);
>  
>  	root_inode->i_fop = &autofs4_root_operations;
>  	root_inode->i_op = autofs_type_trigger(sbi->type) ?
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index bf8a69d..b2cc422 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -424,6 +424,7 @@ static const struct dentry_operations autofs4_root_dentry_operations = {
>  /* For other dentries */
>  static const struct dentry_operations autofs4_dentry_operations = {
>  	.d_automount	= autofs4_d_automount,
> +	.d_manage	= autofs4_d_manage,
>  	.d_release	= autofs4_dentry_release,
>  };
>  
> @@ -604,6 +605,20 @@ struct vfsmount *autofs4_d_automount(struct path *path)
>  	DPRINTK("dentry=%p %.*s",
>  		dentry, dentry->d_name.len, dentry->d_name.name);
>  
> +	/*
> +	 * Someone may have manually umounted this or it was a submount
> +	 * that has gone away.
> +	 */
> +	//spin_lock(&dcache_lock);  /////////////// JUST DELETE THIS LOCK?
> +	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
> +		spin_lock(&dentry->d_lock);
> +		if (!(dentry->d_flags & DCACHE_MANAGE_TRANSIT) &&
> +		     (dentry->d_flags & DCACHE_NEED_AUTOMOUNT))
> +			__managed_dentry_set_transit(path->dentry);
> +		spin_unlock(&dentry->d_lock);
> +	}
> +	//spin_unlock(&dcache_lock);

In this case I think the dcache_lock needs to be deleted and the d_lock
moved out of the if to protect the d_subdirs access.

Ian


