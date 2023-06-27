From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 13/79] autofs: switch to new ctime accessors
Date: Tue, 27 Jun 2023 09:48:40 +0800
Message-ID: <d01379c1-46d9-af26-21a1-1312a51920fa@themaw.net>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-12-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687830527; x=1687916927; bh=XVzYIeQy8/TNTff2J5SjjLTTLWxENUsswH0
        8mHorDqY=; b=Ja1NYfvmSLrwC83DRWjbIp5XdjAh0n+Q/7S9f7tISKx37mUJ9xJ
        s4WEUxH+KjToyS4xM4RyJj5+nKI0Vj5bDFZAiiJOMCg3QIgOYwj/Y01tsMBFI7RT
        PjLMVbvVUs5iwDUN1grMyqv52d2scvTG6HYjNIR2Te3UyOBLl/Pd98VyUErAaP/B
        IWusewKVMBGGrYtOzdaBdVAKM7W9uNM8QzUHtai3nxXtreUza0xyhwtSskr0JqSv
        RcIbnE3BGWVoOsIjl1dhRAz6tW34aOR+BpKbNK2j3UF+bXQhBuuZmzclyBskAzdY
        c8MZaak3o9tiQ+P06VMhVzpjEqme9TThY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687830527; x=1687916927; bh=XVzYIeQy8/TNTff2J5SjjLTTLWxENUsswH0
        8mHorDqY=; b=YU3sek6CkQ83uDGINE5llUaCUxrtWvJoaSDn6zGhlLNO5L5p+xy
        V/1iDSfJjJIIuPe8wwXnM5fhIFRz3ZCQf4f1VzL9BoKevx1U1U1VQMZQBAQK54NH
        QgFcHuDOC+3JEa34saGJAHFo8othDHYAk5bM45elKz0Nh0pSHBa9f9Pg8hYL9Lo7
        iMgF7zzS+tQCzuhpJhnCL7YjsDicBO8O5huwynMLNOHJsk01hMfPKTg4214c3MTt
        LC8C8PxSfmEmyewsRzi/kCx6VuksbSJGQGiO74C5/P5CZr1Czr8bOZpAbmgDHK4r
        f2f6HvmZFBDc7VtRhr78L21UxaeEM/XOFtw==
Content-Language: en-US
In-Reply-To: <20230621144735.55953-12-jlayton@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

On 21/623 22:45, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks fine to me.

Please feel free to add my Acked-by or even Signed-off-by as

you need dictates.


Ian

> ---
>   fs/autofs/inode.c | 2 +-
>   fs/autofs/root.c  | 6 +++---
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index affa70360b1f..47e3054b29dc 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
>   		inode->i_uid = d_inode(sb->s_root)->i_uid;
>   		inode->i_gid = d_inode(sb->s_root)->i_gid;
>   	}
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
>   	inode->i_ino = get_next_ino();
>   
>   	if (S_ISDIR(mode)) {
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 93046c9dc461..4c0fc0f8d688 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
>   	p_ino = autofs_dentry_ino(dentry->d_parent);
>   	p_ino->count++;
>   
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	return 0;
>   }
> @@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
>   	d_inode(dentry)->i_size = 0;
>   	clear_nlink(d_inode(dentry));
>   
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	spin_lock(&sbi->lookup_lock);
>   	__autofs_add_expiring(dentry);
> @@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
>   	p_ino = autofs_dentry_ino(dentry->d_parent);
>   	p_ino->count++;
>   	inc_nlink(dir);
> -	dir->i_mtime = dir->i_ctime = current_time(dir);
> +	dir->i_mtime = inode_ctime_set_current(dir);
>   
>   	return 0;
>   }
