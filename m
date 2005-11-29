From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Tue, 29 Nov 2005 09:20:59 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0511290920380.26303@wombat.indigo.net.au>
References: <20051116101740.GA9551@RAM> <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>
 <438B3C34.2050509@us.ibm.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <438B3C34.2050509@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Mon, 28 Nov 2005, William H. Taber wrote:

> Ian Kent wrote:
> 
> > My thoughts:
> > 
> > The cause of this issue is user space programs using autofs4 need to 
> > call services that must be able to take the inode semaphore. Notably 
> > sys_mkdir and sys_symlink in order to complete their task.
> > 
> > I believe that, in this case, releasing the semaphore is ok since the 
> > entry is part of the autofs filesystem and so autofs is responsible for 
> > taking care of it, provided that it is done carefully. The semaphore is 
> > meant to serialize changes being to the directory and these changes are 
> > done in autofs by asking the user space process to do it. Which are 
> > themselves serialized by the same semaphore.
> > 
> > The only tricky thing I can think of here is that care must be taken to 
> > ensure that the semaphore is not released before the DCACHE_AUTOFS_PENDING 
> > flag is set to make sure that other incoming requests are sent to the wait 
> > queue.
> > 
> > The attached patch does this and opts for a conservative approach by 
> > broadening the critical region instead of narrowing it.
> > 
> > It may also be necessary to review the return codes from revaliate but I'm 
> > only part way through that.
> > 
> > Please review and test this patch and offer further comment.
> > Sorry guys but I haven't been able to test this at all save verifying that 
> > it compiles.
> > 
> > Hopefully I haven't missed anything completely obvious ... DOH!
> > 
> > Ian
> > 
> > --- linux-2.6.15-rc1/fs/autofs4/root.c.lookup-deadlock	2005-11-17 18:58:38.000000000 +0800
> > +++ linux-2.6.15-rc1/fs/autofs4/root.c	2005-11-27 17:00:40.000000000 +0800
> > @@ -487,11 +487,8 @@ static struct dentry *autofs4_lookup(str
> >  	dentry->d_fsdata = NULL;
> >  	d_add(dentry, NULL);
> >  
> > -	if (dentry->d_op && dentry->d_op->d_revalidate) {
> > -		up(&dir->i_sem);
> > +	if (dentry->d_op && dentry->d_op->d_revalidate)
> >  		(dentry->d_op->d_revalidate)(dentry, nd);
> > -		down(&dir->i_sem);
> > -	}
> >  
> >  	/*
> >  	 * If we are still pending, check if we had to handle
> > --- linux-2.6.15-rc1/fs/autofs4/waitq.c.lookup-deadlock	2005-11-27 17:09:42.000000000 +0800
> > +++ linux-2.6.15-rc1/fs/autofs4/waitq.c	2005-11-27 17:17:34.000000000 +0800
> > @@ -161,6 +161,8 @@ int autofs4_wait(struct autofs_sb_info *
> >  		enum autofs_notify notify)
> >  {
> >  	struct autofs_wait_queue *wq;
> > +	struct inode *dir = dentry->d_parent->d_inode;
> > +	int i_sem_held;
> >  	char *name;
> >  	int len, status;
> >  
> > @@ -227,6 +229,14 @@ int autofs4_wait(struct autofs_sb_info *
> >  			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
> >  	}
> >  
> > +	/*
> > +	 * If we are called from lookup or lookup_hash the
> > +	 * the inode semaphore needs to be released for
> > +	 * userspace to do its thing.
> > +	 */
> > +	i_sem_held = down_trylock(&dir->i_sem);
> > +	up(&dir->i_sem);
> > +
> >  	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
> >  		int type = (notify == NFY_MOUNT ?
> >  			autofs_ptype_missing : autofs_ptype_expire_multi);
> > @@ -268,6 +278,10 @@ int autofs4_wait(struct autofs_sb_info *
> >  		DPRINTK("skipped sleeping");
> >  	}
> >  
> > +	/* Re-take the inode semaphore if it was held */
> > +	if (i_sem_held)
> > +		down(&dir->i_sem);
> > +
> >  	status = wq->status;
> >  
> >  	/* Are we the last process to need status? */
> > -
> Ian,
> I have not tested this patch but it seems to have a serious flaw.  Given 
> that do_lookup does not get the parent i_sem lock before calling 
> revalidate, you have the possibility that you are being called without 
> having gotten the lock but the lock may be held by another process.  In 
> that case you do not want to be releasing their lock while they are 
> relying on it.

Oops.

