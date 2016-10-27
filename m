From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 6/8] autofs - use path_is_mountpoint() to fix unreliable
 d_mountpoint() checks
Date: Thu, 27 Oct 2016 03:17:53 +0100
Message-ID: <20161027021753.GJ19539@ZenIV.linux.org.uk>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
 <20161011053418.27645.15241.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011053418.27645.15241.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Tue, Oct 11, 2016 at 01:34:18PM +0800, Ian Kent wrote:
> +	path = file->f_path;
> +
>  	/*
>  	 * An empty directory in an autofs file system is always a
>  	 * mount point. The daemon must have failed to mount this
> @@ -123,7 +126,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
>  	 * it.
>  	 */
>  	spin_lock(&sbi->lookup_lock);
> -	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
> +	if (!path_is_mountpoint(&path) && simple_empty(dentry)) {

Why not &file->f_path, provided that you constify that thing properly?

> +		if (rcu_walk) {
> +			if (!path_is_mountpoint_rcu(path))
> +				return -EISDIR;
> +		} else {
> +			if (!path_is_mountpoint(path))
> +				return -EISDIR;

IDGI.  What's the point of _having_ the _rcu() variant, anyway?  Here you
are probably paying more in terms of i-cache footprint/branch prediction
than you win on not doing that rcu_read_lock()/rcu_read_unlock()...

_rcu variants make sense when non-RCU case does something you can't do
under RCU; here your path_is_mountpoint() is pretty close to being
rcu_read_lock()+path_is_mountpoint_rcu()+rcu_read_unlock() anyway...

