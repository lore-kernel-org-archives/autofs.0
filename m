From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 13/79] autofs: switch to new ctime accessors
Date: Wed, 21 Jun 2023 18:43:47 +0200
Message-ID: <20230621164347.qfzqyxdu6k3t3unc@quack3>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-12-jlayton@kernel.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687365827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SW8r+78YHL2HQQT/A92GF4QTN/9RpyRtse9JVJJVsr4=;
        b=KVhYCJZZ3Mzn9nHTbc+LDWEW89VaXSt0bSvd/kuuKaH85N8X3N+oZHuzK7pGediSc/IeNW
        0D7bOR367bXgqEc6rvwu8uv9jtQGj2/+tsESknVYoSVfXrstNGVQRajPrPJXT+IAzFSaDe
        5UJKhvIGQHOhQO54h1hsW1lAaYO/gxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687365827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SW8r+78YHL2HQQT/A92GF4QTN/9RpyRtse9JVJJVsr4=;
        b=iX9fn4sOORitLAx5Z+Ye3zUVvAvkdD62b53ou8MesfRr3sqK1URmEN+C5MRuigIGvZE6l1
        P5ovOrhr/bIIotDQ==
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-12-jlayton@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed 21-06-23 10:45:26, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/autofs/inode.c | 2 +-
>  fs/autofs/root.c  | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index affa70360b1f..47e3054b29dc 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
>  		inode->i_uid = d_inode(sb->s_root)->i_uid;
>  		inode->i_gid = d_inode(sb->s_root)->i_gid;
>  	}
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>  	inode->i_ino = get_next_ino();
>  
>  	if (S_ISDIR(mode)) {
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 93046c9dc461..4c0fc0f8d688 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>  	p_ino = autofs_dentry_ino(dentry->d_parent);
>  	p_ino->count++;
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	return 0;
>  }
> @@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
>  	d_inode(dentry)->i_size = 0;
>  	clear_nlink(d_inode(dentry));
>  
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	spin_lock(&sbi->lookup_lock);
>  	__autofs_add_expiring(dentry);
> @@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
>  	p_ino = autofs_dentry_ino(dentry->d_parent);
>  	p_ino->count++;
>  	inc_nlink(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>  
>  	return 0;
>  }
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
