From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 16 Nov 2005 08:50:17 -0800
Message-ID: <1132159817.5720.33.camel@localhost>
References: <20051116101740.GA9551@RAM>
	 <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0511162009470.2593@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 2005-11-16 at 04:41, Ian Kent wrote:
> On Wed, 16 Nov 2005, Ram Pai wrote:
> 
> Thanks for you effort Ram.
> 
> > Autofs4 assumes that its ->revalidate() function gets called with the
> > parent_dentry's_inode_semaphore released. This is true mostly
> > but not in one particular case.
> 
> Yep. Certainly does.
> 
> Isn't my mistake not noticing that the inode semaphore is taken in 
> vfs_readdir?
> 
> It's been like that all along and I can't understand how I didn't notice 
> it before.
> 
> Help me out a bit here please Ram.
> 
> Aren't there other paths that enter revalidate without holding the 
> semaphore? chdir?

Looking at the code and it seemed to me that ->revalidate() function is
always with the semaphore held. Atleast VFS seem to have that
assumption.

And looking at the autofs4 code, I  get the impression, that it
assumes that the semaphore is released when it gets called. Which seems
to be inconsistent and wrong.

> 
> Does uping an open semaphore allow other undesirable side affects?
> 
> Do you think it would perhaps be better to release the semaphore in 
> autofs4_readdir ... hang on the stack trace doesn't look like a readdir 
> ... I'll have to check 2.6.15-rc1 ... ?
> 

One automounter process is in sys_mkdir() system call and the other if I
recollect correctly was in sys_getdent64() system call.

Yes this problem can be demonstrated on all versions of the 2.6 kernel.
Infact I reproduced it on 2.6.15-rc1 kernel.

> Apart from the above, looking at the patch and assuming that the semaphore 
> is always held it would probaby be better to move semaphore open/close 
> into try_to_fill_dentry as any control process using autofs, such as automount, 
> must never cause a mount wait to be called (oz_mode = 1).



> 
> Ideas?

One thing is sure, VFS assumes that the semaphore is held when
->revalidate() is called, and that convention is followed religiously by
all filesytems.  autofs4 has this special case of releasing the
semaphore if it is waiting to be woken up by the automounter daemon. So
as you said, may be the semaphore must be released just before sleeping
on the waitq?

RP

> 
> > 
> > Process P1  calls autofs4's ->lookup(). The lookup finds that the dentry
> > does not exist. It creates a dentry and adds to the cache. Releases
> > the parent's inode's semaphore and than calls ->revalidate().
> > 
> > Process P2 meanwhile comes in and cached_lookup() gets called. It finds
> > the dentry in the cache and finds ->revalidate() function exists. So
> > it calls ->revalidate() holding the parent's inode's semaphore.
> > 
> > Now the automounter daemon comes in and tries to hold the same semaphore
> > in order to mount. But since the semaphore is held by P2 it
> > goes to sleep.
> > 
> > Process P1 and P2 continue waiting for the mount to complete and it never
> > happens. Deadlock.
> > 
> > The stack of the deadlock is as follows:
> > 
> > ls            S 00000000     0 13049  11954                     (NOTLB)
> > f5221df0 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > 00000000 f5d44a70 c721b520 00000000 d4f33800 003d0990 c721b9d8 f5d44030
> > f5d44164 f5220000 f5221e3c f3dd6880 f5221e68 c0215207 f3b95580 80000000
> > Call Trace:
> > [<c0215207>] autofs4_wait+0x307/0x3d0
> > [<c02141d3>] try_to_fill_dentry+0xf3/0x150
> > [<c0214389>] autofs4_revalidate+0x159/0x170
> > [<c02144e0>] autofs4_lookup+0x110/0x150
> > [<c016f3f5>] __lookup_hash+0x85/0xb0
> > [<c016f42a>] lookup_hash+0xa/0x10
> > [<c016f483>] lookup_one_len+0x53/0x70
> > [<f8851293>] stubfs_readdir+0x113/0x170 [stubfs]
> > [<c0172fcb>] vfs_readdir+0x8b/0xa0
> > [<c01733b3>] sys_getdents64+0x63/0xb5
> > [<c010464d>] syscall_call+0x7/0xb
> > 
> > ls            S C011B1AF     0 13050  11898                     (NOTLB)
> > f1337df0 00000082 f1337e04 c011b1af 06ce3f60 00000027 00000027 00000080
> > 06d03f60 00000000 c721b520 00000000 d4f33800 003d0990 f1337df0 f5d44a70
> > f5d44ba4 f1336000 f1337e3c f3dd6880 f1337e68 c0215207 f3b95580 80000000
> > Call Trace:
> > [<c0215207>] autofs4_wait+0x307/0x3d0
> > [<c02141d3>] try_to_fill_dentry+0xf3/0x150
> > [<c0214389>] autofs4_revalidate+0x159/0x170
> > [<c016dc77>] cached_lookup+0x47/0x80
> > [<c016f3ca>] __lookup_hash+0x5a/0xb0
> > [<c016f42a>] lookup_hash+0xa/0x10
> > [<c016f483>] lookup_one_len+0x53/0x70  
> > [<f88512e3>] stubfs_readdir+0x163/0x170 [stubfs]
> > [<c0172fcb>] vfs_readdir+0x8b/0xa0  
> > [<c01733b3>] sys_getdents64+0x63/0xb5
> > [<c010464d>] syscall_call+0x7/0xb
> > 
> > automount     D 00000010     0 13052  13016                     (NOTLB)
> > f3321f00 fff80000 00000007 00000010 f3321f68 c7b1cd20 00000000 f3321f34
> > f3321ee8 f5e92a70 c7233520 00000000 d5304100 003d0990 c7233560 f1e31a70
> > f1e31ba4 f5f59914 f5f5991c 00000296 f3321f38 c03b4cd3 f1e31a70 00000001
> > Call Trace:
> > [<c03b4cd3>] __down+0x83/0xe0
> > [<c03b3632>] __down_failed+0xa/0x10
> > [<c0171e6d>] .text.lock.namei+0xeb/0x1de
> > [<c0170482>] sys_mkdir+0x52/0xd0
> > [<c010464d>] syscall_call+0x7/0xb
> > BUG: soft lockup detected on CPU#0!
> > 
> > 
> > I have coded up a tentative fix. The patch releases the semaphore in
> > ->revalidate() function, instead of the caller of that function.  Not
> > sure if this is the right fix. Tested it and verified that the deadlock
> > is fixed.  But I am not sure if it opens up other bugs. Please validate.
> > 
> > 
> >  fs/autofs4/root.c |   26 +++++++++++++++-----------
> >  1 files changed, 15 insertions(+), 11 deletions(-)
> > 
> > Index: 2.6.15-rc1/fs/autofs4/root.c
> > ===================================================================
> > --- 2.6.15-rc1.orig/fs/autofs4/root.c
> > +++ 2.6.15-rc1/fs/autofs4/root.c
> > @@ -386,40 +386,47 @@ static int autofs4_revalidate(struct den
> >  	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
> >  	int oz_mode = autofs4_oz_mode(sbi);
> >  	int flags = nd ? nd->flags : 0;
> >  	int status = 1;
> >  
> > +	up(&dir->i_sem);
> >  	/* Pending dentry */
> >  	if (autofs4_ispending(dentry)) {
> >  		if (!oz_mode)
> > -			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, flags);
> > -		return status;
> > +			status = try_to_fill_dentry(dentry, dir->i_sb,
> > +					sbi, flags);
> > +		goto out;
> >  	}
> >  
> >  	/* Negative dentry.. invalidate if "old" */
> > -	if (dentry->d_inode == NULL)
> > -		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
> > +	if (dentry->d_inode == NULL) {
> > +		status = (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
> > +		goto out;
> > +	}
> >  
> >  	/* Check for a non-mountpoint directory with no contents */
> >  	spin_lock(&dcache_lock);
> >  	if (S_ISDIR(dentry->d_inode->i_mode) &&
> >  	    !d_mountpoint(dentry) && 
> >  	    list_empty(&dentry->d_subdirs)) {
> >  		DPRINTK("dentry=%p %.*s, emptydir",
> >  			 dentry, dentry->d_name.len, dentry->d_name.name);
> >  		spin_unlock(&dcache_lock);
> >  		if (!oz_mode)
> > -			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, flags);
> > -		return status;
> > +			status = try_to_fill_dentry(dentry, dir->i_sb, sbi,
> > +					flags);
> > +		goto out;
> >  	}
> >  	spin_unlock(&dcache_lock);
> >  
> >  	/* Update the usage list */
> >  	if (!oz_mode)
> >  		autofs4_update_usage(dentry);
> >  
> > -	return 1;
> > +out:
> > +	down(&dir->i_sem);
> > +	return status;
> >  }
> >  
> >  static void autofs4_dentry_release(struct dentry *de)
> >  {
> >  	struct autofs_info *inf;
> > @@ -485,15 +492,12 @@ static struct dentry *autofs4_lookup(str
> >  		spin_unlock(&dentry->d_lock);
> >  	}
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
> >  	 * a signal. If so we can force a restart..
> >  	 */
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

