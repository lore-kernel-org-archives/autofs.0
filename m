From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs and mount namespaces
Date: Wed, 14 Sep 2016 08:56:57 +0800
Message-ID: <1473814617.3333.11.camel@themaw.net>
References: <20160407181911.GA9018@vader>
         <1460076663.3135.37.camel@themaw.net>
         <20160705184754.GA28931@vader.DHCP.thefacebook.com>
         <1467761756.4580.1.camel@themaw.net>
         <20160913181921.GA4124@vader.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=XulNAqlEHAvG2knVGtGzpB0w3UQ=; b=knDm90
        oSnEkSVpqrNKr5/zO1L++jdZsep5ewFIfy384DEPTy7q/HYwe7lopp+Ped26p7aU
        LwmX7BbeOe/8PKMXpGc9l/kq5fdBFRQIm9M0rwWmkev7wvlaj7VfjvSAb9vsLFqq
        0n58eRHw0QqJwxV2xGRCsRIFJuWmvB78PBadg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XulNAqlEHAvG2kn
        VGtGzpB0w3UQ=; b=rX90Xg6j84RJbzTuug5qlPGNOrX4DBQmcnJF9EYjS6iy0jW
        qe+ob+5Or9pdxyV+ERFbyncT4QmXwtDAuIyYcvG0yaXaqJOG8QgaMHEBDSFLIuB8
        bD2apa7+PXaZQ4sXJYeuxu8Vn7terWX2zM1VaHC2jSilHUrN+cXEvt9L1Pr4=
In-Reply-To: <20160913181921.GA4124@vader.dhcp.thefacebook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>

On Tue, 2016-09-13 at 11:19 -0700, Omar Sandoval wrote:
> On Wed, Jul 06, 2016 at 07:35:56AM +0800, Ian Kent wrote:
> > On Tue, 2016-07-05 at 11:47 -0700, Omar Sandoval wrote:
> > > On Fri, Apr 08, 2016 at 08:51:03AM +0800, Ian Kent wrote:
> > > [snip]
> > > > 
> > > > I think this is a better approach (beware, not even compile tested so it
> > > > almost certainly doesn't work properly) and I'm not even sure that
> > > > exposing __is_local_mountpoint() is ok from a VFS POV but something
> > > > needs to be done:
> > > > 
> > > > autofs4 - make mountpoint checks namespace aware
> > > > 
> > > > From: Ian Kent <ikent@redhat.com>
> > > > 
> > > > If an automount mount is clone(2)ed into a file system that is
> > > > propagation private, when it later expires the mount subsequent
> > > > calls to autofs ->d_automount() for in that dentry in that
> > > > namespace will return ELOOP until the mount is manually umounted.
> > > > 
> > > > In the same way, if an autofs mount is triggered by automount(8)
> > > > within a container the dentry will be seen as mounted in the
> > > > root init namespace and calls to ->d_automount() in that namespace
> > > > will return ELOOP until the mount is umounted within the container.
> > > > 
> > > > Also, have_submounts() can return an incorect result when a mount
> > > > exists in a namespace other than the one being checked.
> > > > 
> > > > Signed-off-by: Ian Kent <ikent@redhat.com>
> > > > Cc: Al Viro <viro@ZenIV.linux.org.uk>
> > > > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > > > ---
> > > >  fs/autofs4/expire.c   |    4 ++--
> > > >  fs/autofs4/root.c     |   14 +++++++-------
> > > >  fs/dcache.c           |    2 +-
> > > >  fs/mount.h            |    9 ---------
> > > >  fs/namespace.c        |    1 +
> > > >  include/linux/mount.h |    9 +++++++++
> > > >  6 files changed, 20 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
> > > > index 9510d8d..23b9701 100644
> > > > --- a/fs/autofs4/expire.c
> > > > +++ b/fs/autofs4/expire.c
> > > > @@ -236,7 +236,7 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
> > > >  		 * count for the autofs dentry.
> > > >  		 * If the fs is busy update the expiry counter.
> > > >  		 */
> > > > -		if (d_mountpoint(p)) {
> > > > +		if (is_local_mountpoint(p)) {
> > > >  			if (autofs4_mount_busy(mnt, p)) {
> > > >  				top_ino->last_used = jiffies;
> > > >  				dput(p);
> > > > @@ -280,7 +280,7 @@ static struct dentry *autofs4_check_leaves(struct
> > > > vfsmount *mnt,
> > > >  	while ((p = get_next_positive_dentry(p, parent))) {
> > > >  		pr_debug("dentry %p %pd\n", p, p);
> > > >  
> > > > -		if (d_mountpoint(p)) {
> > > > +		if (is_local_mountpoint(p)) {
> > > >  			/* Can we umount this guy */
> > > >  			if (autofs4_mount_busy(mnt, p))
> > > >  				continue;
> > > > diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
> > > > index 7ab9239..9ba487a 100644
> > > > --- a/fs/autofs4/root.c
> > > > +++ b/fs/autofs4/root.c
> > > > @@ -123,7 +123,7 @@ static int autofs4_dir_open(struct inode *inode,
> > > > struct
> > > > file *file)
> > > >  	 * it.
> > > >  	 */
> > > >  	spin_lock(&sbi->lookup_lock);
> > > > -	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
> > > > +	if (!is_local_mountpoint(dentry) && simple_empty(dentry)) {
> > > >  		spin_unlock(&sbi->lookup_lock);
> > > >  		return -ENOENT;
> > > >  	}
> > > > @@ -370,15 +370,15 @@ static struct vfsmount *autofs4_d_automount(struct
> > > > path *path)
> > > >  
> > > >  	/*
> > > >  	 * If the dentry is a symlink it's equivalent to a directory
> > > > -	 * having d_mountpoint() true, so there's no need to call back
> > > > -	 * to the daemon.
> > > > +	 * having is_local_mountpoint() true, so there's no need to
> > > > +	 * call back to the daemon.
> > > >  	 */
> > > >  	if (d_really_is_positive(dentry) && d_is_symlink(dentry)) {
> > > >  		spin_unlock(&sbi->fs_lock);
> > > >  		goto done;
> > > >  	}
> > > >  
> > > > -	if (!d_mountpoint(dentry)) {
> > > > +	if (!is_local_mountpoint(dentry)) {
> > > >  		/*
> > > >  		 * It's possible that user space hasn't removed
> > > > directories
> > > >  		 * after umounting a rootless multi-mount, although it
> > > > @@ -431,7 +431,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> > > > bool
> > > > rcu_walk)
> > > >  
> > > >  	/* The daemon never waits. */
> > > >  	if (autofs4_oz_mode(sbi)) {
> > > > -		if (!d_mountpoint(dentry))
> > > > +		if (!is_local_mountpoint(dentry))
> > > >  			return -EISDIR;
> > > >  		return 0;
> > > >  	}
> > > > @@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> > > > bool
> > > > rcu_walk)
> > > >  
> > > >  		if (ino->flags & (AUTOFS_INF_EXPIRING |
> > > > AUTOFS_INF_NO_RCU))
> > > >  			return 0;
> > > > -		if (d_mountpoint(dentry))
> > > > +		if (is_local_mountpoint(dentry))
> > > >  			return 0;
> > > >  		inode = d_inode_rcu(dentry);
> > > >  		if (inode && S_ISLNK(inode->i_mode))
> > > > @@ -487,7 +487,7 @@ static int autofs4_d_manage(struct dentry *dentry,
> > > > bool
> > > > rcu_walk)
> > > >  		 * we can avoid needless calls ->d_automount() and
> > > > avoid
> > > >  		 * an incorrect ELOOP error return.
> > > >  		 */
> > > > -		if ((!d_mountpoint(dentry) && !simple_empty(dentry)) ||
> > > > +		if ((!is_local_mountpoint(dentry) &&
> > > > !simple_empty(dentry))
> > > > > > 
> > > >  		    (d_really_is_positive(dentry) &&
> > > > d_is_symlink(dentry)))
> > > >  			status = -EISDIR;
> > > >  	}
> > > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > > index 32ceae3..9c42dc9 100644
> > > > --- a/fs/dcache.c
> > > > +++ b/fs/dcache.c
> > > > @@ -1271,7 +1271,7 @@ rename_retry:
> > > >  static enum d_walk_ret check_mount(void *data, struct dentry *dentry)
> > > >  {
> > > >  	int *ret = data;
> > > > -	if (d_mountpoint(dentry)) {
> > > > +	if (is_local_mountpoint(dentry)) {
> > > >  		*ret = 1;
> > > >  		return D_WALK_QUIT;
> > > >  	}
> > > > diff --git a/fs/mount.h b/fs/mount.h
> > > > index 14db05d..c25e6e8 100644
> > > > --- a/fs/mount.h
> > > > +++ b/fs/mount.h
> > > > @@ -127,12 +127,3 @@ struct proc_mounts {
> > > >  };
> > > >  
> > > >  extern const struct seq_operations mounts_op;
> > > > -
> > > > -extern bool __is_local_mountpoint(struct dentry *dentry);
> > > > -static inline bool is_local_mountpoint(struct dentry *dentry)
> > > > -{
> > > > -	if (!d_mountpoint(dentry))
> > > > -		return false;
> > > > -
> > > > -	return __is_local_mountpoint(dentry);
> > > > -}
> > > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > > index 4fb1691..9e1bc00 100644
> > > > --- a/fs/namespace.c
> > > > +++ b/fs/namespace.c
> > > > @@ -725,6 +725,7 @@ bool __is_local_mountpoint(struct dentry *dentry)
> > > >  out:
> > > >  	return is_covered;
> > > >  }
> > > > +EXPORT_SYMBOL(__is_local_mountpoint);
> > > >  
> > > >  static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
> > > >  {
> > > > diff --git a/include/linux/mount.h b/include/linux/mount.h
> > > > index f822c3c..7419c0c 100644
> > > > --- a/include/linux/mount.h
> > > > +++ b/include/linux/mount.h
> > > > @@ -15,6 +15,7 @@
> > > >  #include <linux/spinlock.h>
> > > >  #include <linux/seqlock.h>
> > > >  #include <linux/atomic.h>
> > > > +#include <linux/dcache.h>
> > > >  
> > > >  struct super_block;
> > > >  struct vfsmount;
> > > > @@ -95,4 +96,12 @@ extern void mark_mounts_for_expiry(struct list_head
> > > > *mounts);
> > > >  
> > > >  extern dev_t name_to_dev_t(const char *name);
> > > >  
> > > > +extern bool __is_local_mountpoint(struct dentry *dentry);
> > > > +static inline bool is_local_mountpoint(struct dentry *dentry)
> > > > +{
> > > > +	if (!d_mountpoint(dentry))
> > > > +		return false;
> > > > +
> > > > +	return __is_local_mountpoint(dentry);
> > > > +}
> > > >  #endif /* _LINUX_MOUNT_H */
> > > 
> > > Hi, Ian,
> > > 
> > > Just wanted to check on the status of this fix. Is this still the
> > > approach you wanted to take/is there anything else you wanted to do with
> > > this?
> > 
> > The problem is that someone tested this back ported to an older kernel and
> > claimed it caused file system corruption.
> > 
> > That leaves me in a bad place indeed.
> > 
> > Ian
> 
> Hi, Ian,
> 
> Dredging this up again because I forgot to reply in a timely manner last
> time. Do you have more details on that report? I'm having a hard time
> seeing how this change would cause filesystem corruption, and I still
> think a fix for this really needs to go in.

You and me both.

I recently re-factored the patch a bit and I'm thinking the best thing to do is
to send it to Andrew Morton so it can get plenty of testing before being
considered for mainline.

I ran the kernel with the patches for several days without problem but didn't do
a lot with autofs during that time.

I'll also have another look at it based on a comment from All Viro but I
couldn't see anything wrong with it myself, perhaps he will comment further when
I send it over to Andrew.

Ian
