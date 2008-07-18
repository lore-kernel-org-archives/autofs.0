From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 3/7] autofs4 - fix pending checks
Date: Fri, 18 Jul 2008 10:51:04 -0400
Message-ID: <x491w1rdz53.fsf@segfault.boston.devel.redhat.com>
References: <20080718023651.12802.59107.stgit@raven.themaw.net>
	<20080718023708.12802.82980.stgit@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080718023708.12802.82980.stgit@raven.themaw.net> (Ian Kent's
	message of "Fri, 18 Jul 2008 10:37:10 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Ian Kent <raven@themaw.net> writes:

> There are two cases for which a dentry that has a pending mount request
> does not wait for completion. One is via autofs4_revalidate() and the
> other via autofs4_follow_link().
>
> In revalidate, after the mount point directory is created, but before
> the mount is done, the check in try_to_fill_dentry() can can fail to
> send the dentry to the wait queue since the dentry is positive and the
> lookup flags may contain only LOOKUP_FOLLOW. Although we don't trigger
> a mount for the LOOKUP_FOLLOW flag, if ther's one pending we might as
> well wait and use the mounted dentry for the lookup.
>
> In autofs4_follow_link() the dentry is not checked to see if it is
> pending so it may fail to call try_to_fill_dentry() and not wait
> for mount completion.
>
> A dentry that is pending must always be sent to the wait queue.
>
> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>


>
> ---
>
>  fs/autofs4/root.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
>
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index e842b0a..2944b28 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -177,7 +177,8 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
>  			return status;
>  		}
>  	/* Trigger mount for path component or follow link */
> -	} else if (flags & (TRIGGER_FLAGS | TRIGGER_INTENTS) ||
> +	} else if (dentry->d_flags & DCACHE_AUTOFS_PENDING ||
> +			flags & (TRIGGER_FLAGS | TRIGGER_INTENTS) ||
>  			current->link_count) {
>  		DPRINTK("waiting for mount name=%.*s",
>  			dentry->d_name.len, dentry->d_name.name);
> @@ -223,7 +224,8 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>  
>  	/* If it's our master or we shouldn't trigger a mount we're done */
>  	lookup_type = nd->flags & (TRIGGER_FLAGS | TRIGGER_INTENTS);
> -	if (oz_mode || !lookup_type)
> +	if (oz_mode ||
> +	    !(lookup_type || dentry->d_flags & DCACHE_AUTOFS_PENDING))
>  		goto done;
>  
>  	/* If an expire request is pending wait for it. */
> @@ -242,7 +244,8 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
>  	 * don't try to mount it again.
>  	 */
>  	spin_lock(&dcache_lock);
> -	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
> +	if (dentry->d_flags & DCACHE_AUTOFS_PENDING ||
> +	    (!d_mountpoint(dentry) && __simple_empty(dentry))) {
>  		spin_unlock(&dcache_lock);
>  
>  		status = try_to_fill_dentry(dentry, 0);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
