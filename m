From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] VFS: allow ->d_manage() to declare -EISDIR in rcu_walk
 mode.
Date: Fri, 1 Aug 2014 11:33:18 +0300
Message-ID: <20140801083318.GA4907@mwanda>
References: <20140730160833.5eac00ec@notabene.brown>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140730160833.5eac00ec@notabene.brown>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, linux-fsdevel@vger.kernel.org

On Wed, Jul 30, 2014 at 04:08:33PM +1000, NeilBrown wrote:
> @@ -1110,11 +1110,16 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
>  		 * Don't forget we might have a non-mountpoint managed dentry
>  		 * that wants to block transit.
>  		 */
> -		if (unlikely(managed_dentry_might_block(path->dentry)))
> +		switch (managed_dentry_rcu(path->dentry)) {
> +		case -ECHILD:
> +		default:
>  			return false;
> +		case -EISDIR:
> +			return true;
> +		}
>  

Smatch says that any lines after that switch statement are unreachable.

Is the "default" intended?

>  		if (!d_mountpoint(path->dentry))
> -			return true;
> +			return !(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
>  
>  		mounted = __lookup_mnt(path->mnt, path->dentry);
>  		if (!mounted)

regards,
dan carpenter

