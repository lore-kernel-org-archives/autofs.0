From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/7] autofs4 - indirect dentry must almost always be positive
Date: Fri, 18 Jul 2008 07:56:34 -0400
Message-ID: <x49k5fje77x.fsf@segfault.boston.devel.redhat.com>
References: <20080718023651.12802.59107.stgit@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080718023651.12802.59107.stgit@raven.themaw.net> (Ian Kent's
	message of "Fri, 18 Jul 2008 10:36:53 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Ian Kent <raven@themaw.net> writes:

> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Cheers,

Jeff

>
> ---
>
>  fs/autofs4/waitq.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
>
>
> diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> index bcb6c52..35216d1 100644
> --- a/fs/autofs4/waitq.c
> +++ b/fs/autofs4/waitq.c
> @@ -328,9 +328,20 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
>  	if (sbi->catatonic)
>  		return -ENOENT;
>  
> -	if (!dentry->d_inode &&
> -	    (sbi->type & (AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET)))
> -		return -ENOENT;
> +	if (!dentry->d_inode) {
> +		/*
> +		 * A wait for a negative dentry is invalid for certain
> +		 * cases. A direct or offset mount "always" has its mount
> +		 * point directory created and so the request dentry must
> +		 * be positive or the map key doesn't exist. The situation
> +		 * is very similar for indirect mounts except only dentrys
> +		 * in the root of the autofs file system may be negative.
> +		 */
> +		if (sbi->type & (AUTOFS_TYPE_DIRECT|AUTOFS_TYPE_OFFSET))
> +			return -ENOENT;
> +		else if (!IS_ROOT(dentry->d_parent))
> +			return -ENOENT;
> +	}
>  
>  	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
>  	if (!name)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
