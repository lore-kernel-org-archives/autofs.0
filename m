From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2] autofs: Add WARN_ON(1) for non dir/link inode case
Date: Thu, 07 Jul 2016 14:09:09 +0800
Message-ID: <1467871749.3206.25.camel@themaw.net>
References: <1467603603-1530-1-git-send-email-kusumi.tomohiro@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=7BpUvnCnhpODU25/vLLj2iD0wf4=; b=UsoOgW
	usp/cLO8xbeSk+NxvMTjOft2fikJvFXDf49dGmZ8XB4OTvJ5AJ2RgGrwm2XPVUIm
	W6E1r0gctHj5E893fr+Mx7ObOGG3Q5hRXuHhtwDicRdP4WkLCQ3WOJ1Uj2wnV+ou
	Dv32FODaoGOomBS69woHAxqsQQ8C0ySytMOyg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=7BpUvnCnhpODU25
	/vLLj2iD0wf4=; b=h5i5fGp6VgQEfF2J6P8KKHBRIavWD+wbHLnjaNaayN3AxK1
	7kgzM0eJdYV6QvFXXP4022HZjmiqUEiYhaWj6wEgo8h1mTarecqlfGk/vyXm4mcR
	TZklWL6M575DlPC3qUs+OoBqvXSTX8c8hRbxvix5e8liSTdRIPTsPe06K6ys=
In-Reply-To: <1467603603-1530-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, jeffm@suse.com
Cc: autofs@vger.kernel.org

On Mon, 2016-07-04 at 12:40 +0900, Tomohiro Kusumi wrote:
> It's invalid if the given mode is neither dir nor link,
> so warn on else case.

I've added this too.

But ....

> 
> (v2 changed BUG_ON to WARN_ON)
> 
> Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
> ---
>  fs/autofs4/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
> index ad0ee93..89174ec 100644
> --- a/fs/autofs4/inode.c
> +++ b/fs/autofs4/inode.c
> @@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void *data,
> int silent)
>  	if (autofs_type_trigger(sbi->type))
>  		__managed_dentry_set_managed(root);
>  
> +	WARN_ON(!root_inode->i_fop || !root_inode->i_op);

I'm dropping this.

We know for a fact that this is a directory inode because above it was created
with autofs4_get_inode(s, S_IFDIR | 0755) and here the operations are changed to
those specific to the root inode.

>  	root_inode->i_fop = &autofs4_root_operations;
>  	root_inode->i_op = &autofs4_dir_inode_operations;
>  
> @@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb,
> umode_t mode)
>  		inode->i_fop = &autofs4_dir_operations;
>  	} else if (S_ISLNK(mode)) {
>  		inode->i_op = &autofs4_symlink_inode_operations;
> -	}
> +	} else
> +		WARN_ON(1);
>  
>  	return inode;
>  }
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
