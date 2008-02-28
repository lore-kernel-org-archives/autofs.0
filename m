From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/4] autofs4 - track uid and gid of last mount requestor
Date: Wed, 27 Feb 2008 20:45:46 -0800
Message-ID: <20080227204546.72e16e8d.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
	<Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802261208400.8490@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Pavel Emelyanov <xemul@openvz.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, 26 Feb 2008 12:23:20 +0900 (WST) Ian Kent <raven@themaw.net> wrote:

> Hi Andrew,
> 
> Patch to track the uid and gid of the last process to request
> a mount for on an autofs dentry.
> 
> Signed-off-by: Ian Kent < raven@themaw.net>
> 
> Ian
> 
> ---
> diff -up linux-2.6.25-rc2-mm1/fs/autofs4/inode.c.track-last-mount-ids linux-2.6.25-rc2-mm1/fs/autofs4/inode.c
> --- linux-2.6.25-rc2-mm1/fs/autofs4/inode.c.track-last-mount-ids	2008-02-20 13:11:28.000000000 +0900
> +++ linux-2.6.25-rc2-mm1/fs/autofs4/inode.c	2008-02-20 13:12:23.000000000 +0900
> @@ -43,6 +43,8 @@ struct autofs_info *autofs4_init_ino(str
>  
>  	ino->flags = 0;
>  	ino->mode = mode;
> +	ino->uid = 0;
> +	ino->gid = 0;
>  	ino->inode = NULL;
>  	ino->dentry = NULL;
>  	ino->size = 0;
> diff -up linux-2.6.25-rc2-mm1/fs/autofs4/autofs_i.h.track-last-mount-ids linux-2.6.25-rc2-mm1/fs/autofs4/autofs_i.h
> --- linux-2.6.25-rc2-mm1/fs/autofs4/autofs_i.h.track-last-mount-ids	2008-02-20 13:14:03.000000000 +0900
> +++ linux-2.6.25-rc2-mm1/fs/autofs4/autofs_i.h	2008-02-20 13:14:34.000000000 +0900
> @@ -58,6 +58,9 @@ struct autofs_info {
>  	unsigned long last_used;
>  	atomic_t count;
>  
> +	uid_t uid;
> +	gid_t gid;
> +
>  	mode_t	mode;
>  	size_t	size;
>  
> diff -up linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.track-last-mount-ids linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c
> --- linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.track-last-mount-ids	2008-02-20 13:06:20.000000000 +0900
> +++ linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c	2008-02-20 13:10:23.000000000 +0900
> @@ -363,6 +363,38 @@ int autofs4_wait(struct autofs_sb_info *
>  
>  	status = wq->status;
>  
> +	/*
> +	 * For direct and offset mounts we need to track the requestor
> +	 * uid and gid in the dentry info struct. This is so it can be
> +	 * supplied, on request, by the misc device ioctl interface.
> +	 * This is needed during daemon resatart when reconnecting
> +	 * to existing, active, autofs mounts. The uid and gid (and
> +	 * related string values) may be used for macro substitution
> +	 * in autofs mount maps.
> +	 */
> +	if (!status) {
> +		struct dentry *de = NULL;
> +
> +		/* direct mount or browsable map */
> +		ino = autofs4_dentry_ino(dentry);
> +		if (!ino) {
> +			/* If not lookup actual dentry used */
> +			de = d_lookup(dentry->d_parent, &dentry->d_name);
> +			ino = autofs4_dentry_ino(de);
> +		}
> +
> +		/* Set mount requestor */
> +		if (ino) {
> +			if (ino) {
> +				ino->uid = wq->uid;
> +				ino->gid = wq->gid;
> +			}
> +		}
> +
> +		if (de)
> +			dput(de);
> +	}
> +

But uids and gids are no longer system-wide-unique.  Two different users
can have the same identifiers in different namespaces.  What happens then?
