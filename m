From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs and mount namespaces
Date: Fri, 08 Apr 2016 09:04:23 +0800
Message-ID: <1460077463.3135.45.camel@themaw.net>
References: <20160407181911.GA9018@vader>
	 <1460076663.3135.37.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=I0v2Y5rGdl3fjaVt5crgzZnVRsc=; b=Gl5PvQ
	6ZWbhXjMf5uM+SK0HnQlc/7LKF0la2daAvh3SNvAn2GIopqFvBAKLstNXSGzOoZJ
	RnIVmBg06RFIqPbwPuvm7LHPTZv8ZfaMrYQfIld+LiNINLXfHjPe9PhyB9QPWkFy
	jgQWTTzA/y5ZYM1ezgMCYj1RWti0tJoYxjO1k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=I0v2Y5rGdl3fjaV
	t5crgzZnVRsc=; b=SKgSf1raNOQzCs3NtRYPriIUzUMYKd4ZQMHZibJnrMyTyxY
	h/d22sfV0Ut2VqsKVT9PWM59cimsWFFRObN0hZDEhAwn9c/0m8bCxZ2e5Q+lUAeU
	AkuOoiw+89ggsLZsVz6B39NbAxqEnyBq3szyFJsfiakF/z/d2miwe2PAkuQQ=
In-Reply-To: <1460076663.3135.37.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

On Fri, 2016-04-08 at 08:51 +0800, Ian Kent wrote:
> On Thu, 2016-04-07 at 11:19 -0700, Omar Sandoval wrote:
> > Hi, Ian,
> > 
> > I wanted to bring up the issue of autofs and mount namespaces again,
> > which recently resurfaced in the thread here [1]. In that thread,
> > you
> > mentioned that you had some patches to make autofs namespace-aware
> > that
> > you were holding on to. Do you think you could put those up so we
> > can
> > all work out the issues you mentioned?
> 
> I can but I haven't tested them at all.
> 
> Possibly I could post them to the autofs list if you want to test and
> probably make changes to get them working.
> 
> Would that be ok .... umm, I think I need to post the patch now anyway
> as it's the easiest way to demonstrate what I think is a better
> approach
> than the patch below ....
> 
> I'm struggling to get back to work on this but I'm getting there and
> hope to return to it soon.
> 
> > 
> > For some background, we've also been bitten by the lack of
> > namespace-awareness in autofs many times. The simple case that
> > breaks
> > can be reproduced as follows, assuming that /mnt/foo is an indirect
> > mount:
> > 
> > ls /mnt/foo            # do the initial automount
> > unshare -m sleep 10 &  # hold the automount in a new namespace
> > umount /mnt/foo        # pretend the mount timed out
> > ls /mnt/foo            # try to access it again
> > ls: cannot open directory '/mnt/foo': Too many levels of symbolic
> > links
> > 
> > For us, the unshare step is actually setting up a container. Our
> > workaround was to make sure that we clean up all of the base
> > system's
> > mounts when setting up the container, but in the general case this
> > is
> > still broken.
> 
> Yeah, that looks like a simple test I can use to test my change.
> I'll use this.
> 
> > 
> > In this particular case, I believe the problem is that we're using
> > `d_mountpoint()` (or `have_submounts()`) in several places to check
> > whether something is already mounted, and that's not namespace
> > -aware.
> > This hack mitigates the problem I saw above, although it probably
> > ignores edge cases that the old code was handling:
> > 
> > ----
> > diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> > index 7ab923940d18..a620822342c8 100644
> > --- a/fs/autofs4/root.c
> > +++ b/fs/autofs4/root.c
> > @@ -378,39 +378,29 @@ static struct vfsmount
> > *autofs4_d_automount(struct path *path)
> >  		goto done;
> >  	}
> >  
> > -	if (!d_mountpoint(dentry)) {
> > -		/*
> > -		 * It's possible that user space hasn't removed
> > directories
> > -		 * after umounting a rootless multi-mount, although
> > it
> > -		 * should. For v5 have_submounts() is sufficient to
> > handle
> > -		 * this because the leaves of the directory tree
> > under the
> > -		 * mount never trigger mounts themselves (they have
> > an autofs
> > -		 * trigger mount mounted on them). But v4 pseudo
> > direct mounts
> > -		 * do need the leaves to trigger mounts. In this
> > case
> > we
> > -		 * have no choice but to use the list_empty() check
> > and
> > -		 * require user space behave.
> > -		 */
> > -		if (sbi->version > 4) {
> > -			if (have_submounts(dentry)) {
> > -				spin_unlock(&sbi->fs_lock);
> > -				goto done;
> > -			}
> > -		} else {
> > -			if (!simple_empty(dentry)) {
> > -				spin_unlock(&sbi->fs_lock);
> > -				goto done;
> > -			}
> > -		}
> > -		ino->flags |= AUTOFS_INF_PENDING;
> > -		spin_unlock(&sbi->fs_lock);
> > -		status = autofs4_mount_wait(dentry, 0);
> > -		spin_lock(&sbi->fs_lock);
> > -		ino->flags &= ~AUTOFS_INF_PENDING;
> > -		if (status) {
> > +	if (d_mountpoint(dentry)) {
> > +		/* Make sure this is a mountpoint in this
> > namespace.
> > */
> > +		struct vfsmount *mounted = lookup_mnt(path);
> > +		if (mounted) {
> > +			mntput(mounted);
> >  			spin_unlock(&sbi->fs_lock);
> > -			return ERR_PTR(status);
> > +			goto done;
> >  		}
> >  	}
> > +
> > +	if (!simple_empty(dentry)) {
> > +		spin_unlock(&sbi->fs_lock);
> > +		goto done;
> > +	}
> > +	ino->flags |= AUTOFS_INF_PENDING;
> > +	spin_unlock(&sbi->fs_lock);
> > +	status = autofs4_mount_wait(dentry, 0);
> > +	spin_lock(&sbi->fs_lock);
> > +	ino->flags &= ~AUTOFS_INF_PENDING;
> > +	if (status) {
> > +		spin_unlock(&sbi->fs_lock);
> > +		return ERR_PTR(status);
> > +	}
> >  	spin_unlock(&sbi->fs_lock);
> >  done:
> >  	/* Mount succeeded, check if we ended up with a new dentry
> > */
> > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> > index 0146d911f468..b4e901d2aa6b 100644
> > --- a/fs/autofs4/waitq.c
> > +++ b/fs/autofs4/waitq.c
> > @@ -332,8 +332,6 @@ static int validate_request(struct
> > autofs_wait_queue **wait,
> >  					dentry = new;
> >  			}
> >  		}
> > -		if (have_submounts(dentry))
> > -			valid = 0;
> >  
> >  		if (new)
> >  			dput(new);
> > diff --git a/fs/internal.h b/fs/internal.h
> > index b71deeecea17..c26ba59eec1b 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -58,7 +58,6 @@ extern int vfs_path_lookup(struct dentry *, struct
> > vfsmount *,
> >  extern void *copy_mount_options(const void __user *);
> >  extern char *copy_mount_string(const void __user *);
> >  
> > -extern struct vfsmount *lookup_mnt(struct path *);
> >  extern int finish_automount(struct vfsmount *, struct path *);
> >  
> >  extern int sb_prepare_remount_readonly(struct super_block *);
> > diff --git a/include/linux/mount.h b/include/linux/mount.h
> > index f822c3c11377..ff971448152f 100644
> > --- a/include/linux/mount.h
> > +++ b/include/linux/mount.h
> > @@ -72,6 +72,7 @@ struct vfsmount {
> >  struct file; /* forward dec */
> >  struct path;
> >  
> > +extern struct vfsmount *lookup_mnt(struct path *);
> 
> Can't say I like this.
> 
> If I thought making lookup_mnt() visible was acceptable (from a VFS
> POV)
> that would have made a bunch of things much easier over the years.
> 
> There's also expiration and the have_submounts() VFS check to
> consider.
> The have_submounts() check is used when validating a request before
> sending it. I'm not certain about the expire, but consider independent
> automount daemons in different containers using overlapping automount
> name spaces (ie. paths or mounts with the same super block).

And for the multiple daemon expire case I'm not sure about side effects
and I'm not sure if anything else needs to be done about it.

Since the last used field used to check expiry is contained in the
dentry mount point usage in any name space will prevent it from
expiring.

Perhaps that's not a bad thing as it prevents some churn of umount to
mount but ....

When it does expire in a namespace I'm not sure what effect that will
have in other name space instances ....

There are more cases ....

> 
> In any case I don't think you don't need lookup_mnt(), see blow.
> 
> >  extern int mnt_want_write(struct vfsmount *mnt);
> >  extern int mnt_want_write_file(struct file *file);
> >  extern int mnt_clone_write(struct vfsmount *mnt);
> > ----
> 
> I think this is a better approach (beware, not even compile tested so
> it
> almost certainly doesn't work properly) and I'm not even sure that
> exposing __is_local_mountpoint() is ok from a VFS POV but something
> needs to be done:
> 
> autofs4 - make mountpoint checks namespace aware
> 
> From: Ian Kent <ikent@redhat.com>
> 
> If an automount mount is clone(2)ed into a file system that is
> propagation private, when it later expires the mount subsequent
> calls to autofs ->d_automount() for in that dentry in that
> namespace will return ELOOP until the mount is manually umounted.
> 
> In the same way, if an autofs mount is triggered by automount(8)
> within a container the dentry will be seen as mounted in the
> root init namespace and calls to ->d_automount() in that namespace
> will return ELOOP until the mount is umounted within the container.
> 
> Also, have_submounts() can return an incorect result when a mount
> exists in a namespace other than the one being checked.
> 
> Signed-off-by: Ian Kent <ikent@redhat.com>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/autofs4/expire.c   |    4 ++--
>  fs/autofs4/root.c     |   14 +++++++-------
>  fs/dcache.c           |    2 +-
>  fs/mount.h            |    9 ---------
>  fs/namespace.c        |    1 +
>  include/linux/mount.h |    9 +++++++++
>  6 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> index 9510d8d..23b9701 100644
> --- a/fs/autofs4/expire.c
> +++ b/fs/autofs4/expire.c
> @@ -236,7 +236,7 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
>  		 * count for the autofs dentry.
>  		 * If the fs is busy update the expiry counter.
>  		 */
> -		if (d_mountpoint(p)) {
> +		if (is_local_mountpoint(p)) {
>  			if (autofs4_mount_busy(mnt, p)) {
>  				top_ino->last_used = jiffies;
>  				dput(p);
> @@ -280,7 +280,7 @@ static struct dentry *autofs4_check_leaves(struct
> vfsmount *mnt,
>  	while ((p = get_next_positive_dentry(p, parent))) {
>  		pr_debug("dentry %p %pd\n", p, p);
>  
> -		if (d_mountpoint(p)) {
> +		if (is_local_mountpoint(p)) {
>  			/* Can we umount this guy */
>  			if (autofs4_mount_busy(mnt, p))
>  				continue;
> diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> index 7ab9239..9ba487a 100644
> --- a/fs/autofs4/root.c
> +++ b/fs/autofs4/root.c
> @@ -123,7 +123,7 @@ static int autofs4_dir_open(struct inode *inode,
> struct file *file)
>  	 * it.
>  	 */
>  	spin_lock(&sbi->lookup_lock);
> -	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
> +	if (!is_local_mountpoint(dentry) && simple_empty(dentry)) {
>  		spin_unlock(&sbi->lookup_lock);
>  		return -ENOENT;
>  	}
> @@ -370,15 +370,15 @@ static struct vfsmount
> *autofs4_d_automount(struct path *path)
>  
>  	/*
>  	 * If the dentry is a symlink it's equivalent to a directory
> -	 * having d_mountpoint() true, so there's no need to call
> back
> -	 * to the daemon.
> +	 * having is_local_mountpoint() true, so there's no need to
> +	 * call back to the daemon.
>  	 */
>  	if (d_really_is_positive(dentry) && d_is_symlink(dentry)) {
>  		spin_unlock(&sbi->fs_lock);
>  		goto done;
>  	}
>  
> -	if (!d_mountpoint(dentry)) {
> +	if (!is_local_mountpoint(dentry)) {
>  		/*
>  		 * It's possible that user space hasn't removed
> directories
>  		 * after umounting a rootless multi-mount, although
> it
> @@ -431,7 +431,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> bool rcu_walk)
>  
>  	/* The daemon never waits. */
>  	if (autofs4_oz_mode(sbi)) {
> -		if (!d_mountpoint(dentry))
> +		if (!is_local_mountpoint(dentry))
>  			return -EISDIR;
>  		return 0;
>  	}
> @@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> bool rcu_walk)
>  
>  		if (ino->flags & (AUTOFS_INF_EXPIRING |
> AUTOFS_INF_NO_RCU))
>  			return 0;
> -		if (d_mountpoint(dentry))
> +		if (is_local_mountpoint(dentry))
>  			return 0;
>  		inode = d_inode_rcu(dentry);
>  		if (inode && S_ISLNK(inode->i_mode))
> @@ -487,7 +487,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> bool rcu_walk)
>  		 * we can avoid needless calls ->d_automount() and
> avoid
>  		 * an incorrect ELOOP error return.
>  		 */
> -		if ((!d_mountpoint(dentry) && !simple_empty(dentry))
> ||
> +		if ((!is_local_mountpoint(dentry) &&
> !simple_empty(dentry)) ||
>  		    (d_really_is_positive(dentry) &&
> d_is_symlink(dentry)))
>  			status = -EISDIR;
>  	}
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 32ceae3..9c42dc9 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1271,7 +1271,7 @@ rename_retry:
>  static enum d_walk_ret check_mount(void *data, struct dentry *dentry)
>  {
>  	int *ret = data;
> -	if (d_mountpoint(dentry)) {
> +	if (is_local_mountpoint(dentry)) {
>  		*ret = 1;
>  		return D_WALK_QUIT;
>  	}
> diff --git a/fs/mount.h b/fs/mount.h
> index 14db05d..c25e6e8 100644
> --- a/fs/mount.h
> +++ b/fs/mount.h
> @@ -127,12 +127,3 @@ struct proc_mounts {
>  };
>  
>  extern const struct seq_operations mounts_op;
> -
> -extern bool __is_local_mountpoint(struct dentry *dentry);
> -static inline bool is_local_mountpoint(struct dentry *dentry)
> -{
> -	if (!d_mountpoint(dentry))
> -		return false;
> -
> -	return __is_local_mountpoint(dentry);
> -}
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4fb1691..9e1bc00 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -725,6 +725,7 @@ bool __is_local_mountpoint(struct dentry *dentry)
>  out:
>  	return is_covered;
>  }
> +EXPORT_SYMBOL(__is_local_mountpoint);
>  
>  static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
>  {
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index f822c3c..7419c0c 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -15,6 +15,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/seqlock.h>
>  #include <linux/atomic.h>
> +#include <linux/dcache.h>
>  
>  struct super_block;
>  struct vfsmount;
> @@ -95,4 +96,12 @@ extern void mark_mounts_for_expiry(struct list_head
> *mounts);
>  
>  extern dev_t name_to_dev_t(const char *name);
>  
> +extern bool __is_local_mountpoint(struct dentry *dentry);
> +static inline bool is_local_mountpoint(struct dentry *dentry)
> +{
> +	if (!d_mountpoint(dentry))
> +		return false;
> +
> +	return __is_local_mountpoint(dentry);
> +}
>  #endif /* _LINUX_MOUNT_H */
> 
