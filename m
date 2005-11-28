From: Badari Pulavarty <pbadari@gmail.com>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Mon, 28 Nov 2005 15:12:52 -0800
Message-ID: <1133219572.27824.24.camel@localhost.localdomain>
References: <20051116101740.GA9551@RAM>
	 <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>
	 <438B3C34.2050509@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-8zn/UaTFYQ9fb5bhVpdQ"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <438B3C34.2050509@us.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
To: "William H. Taber" <wtaber@us.ibm.com>
Cc: Ian Kent <raven@themaw.net>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


--=-8zn/UaTFYQ9fb5bhVpdQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-11-28 at 12:19 -0500, William H. Taber wrote:
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
> 

Here is the patch Will Taber proposed and I am posting on his behalf.

Thanks,
Badari




--=-8zn/UaTFYQ9fb5bhVpdQ
Content-Disposition: attachment; filename=autofs.patch
Content-Type: text/x-patch; name=autofs.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

This patch changes the semantics of d_revalidate so that it is always called 
with the parent i_sem lock held.  This allows the autofs4 code to release the
lock if it needs to pend.  Without this patch the autofs has a race condition
in which it pends in the revalidate code while holding the parent i_sem lock 
which prevents the mount from ever completing.  There have been other patches
proposed for this problem which check to see if the parent i_sem lock is held
before releasing it but those solutions ignore the possibility that the lock
may be held by another process.

diff -ur linux-2.6.13.3/fs/autofs4/root.c linux-2.6.13.3-autofspatch/fs/autofs4/root.c
--- linux-2.6.13.3/fs/autofs4/root.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/autofs4/root.c	2005-11-28 04:22:52.000000000 -0800
@@ -302,7 +302,9 @@
 		DPRINTK("waiting for expire %p name=%.*s",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_NONE);
+		down(&dentry->d_parent->d_inode->i_sem);
 		
 		DPRINTK("expire done status=%d", status);
 		
@@ -324,7 +326,9 @@
 		DPRINTK("waiting for mount name=%.*s",
 			 dentry->d_name.len, dentry->d_name.name);
 
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+		down(&dentry->d_parent->d_inode->i_sem);
 		 
 		DPRINTK("mount done status=%d", status);
 
@@ -351,7 +355,9 @@
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
+		up(&dentry->d_parent->d_inode->i_sem);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+		down(&dentry->d_parent->d_inode->i_sem);
 
 		DPRINTK("mount done status=%d", status);
 
diff -ur linux-2.6.13.3/fs/namei.c linux-2.6.13.3-autofspatch/fs/namei.c
--- linux-2.6.13.3/fs/namei.c	2005-10-03 16:27:35.000000000 -0700
+++ linux-2.6.13.3-autofspatch/fs/namei.c	2005-11-28 04:22:52.000000000 -0800
@@ -393,7 +393,6 @@
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
 
-	down(&dir->i_sem);
 	/*
 	 * First re-do the cached lookup just in case it was created
 	 * while we waited for the directory semaphore..
@@ -419,7 +418,6 @@
 			else
 				result = dentry;
 		}
-		up(&dir->i_sem);
 		return result;
 	}
 
@@ -427,7 +425,6 @@
 	 * Uhhuh! Nasty case: the cache was re-populated while
 	 * we waited on the semaphore. Need to revalidate.
 	 */
-	up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
 		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
 			dput(result);
@@ -676,13 +673,16 @@
 		     struct path *path)
 {
 	struct vfsmount *mnt = nd->mnt;
+	struct inode *parent = nd->dentry->d_inode;
 	struct dentry *dentry = __d_lookup(nd->dentry, name);
 
+	down(&parent->i_sem);
 	if (!dentry)
 		goto need_lookup;
 	if (dentry->d_op && dentry->d_op->d_revalidate)
 		goto need_revalidate;
 done:
+	up(&parent->i_sem);
 	path->mnt = mnt;
 	path->dentry = dentry;
 	__follow_mount(path);
@@ -703,6 +703,7 @@
 	goto need_lookup;
 
 fail:
+	up(&parent->i_sem);
 	return PTR_ERR(dentry);
 }
 
@@ -718,7 +719,7 @@
 {
 	struct path next;
 	struct inode *inode;
-	int err;
+	int err, reval;
 	unsigned int lookup_flags = nd->flags;
 	
 	while (*name=='/')
@@ -893,9 +894,17 @@
 		 */
 		if (nd->dentry && nd->dentry->d_sb &&
 		    (nd->dentry->d_sb->s_type->fs_flags & FS_REVAL_DOT)) {
+			struct dentry *nparent;
+
 			err = -ESTALE;
 			/* Note: we do not d_invalidate() */
-			if (!nd->dentry->d_op->d_revalidate(nd->dentry, nd))
+			/* Revalidate requires us to lock the parent.
+			 */
+			nparent = nd->dentry->d_parent;
+			down(&nparent->d_inode->i_sem);
+			reval = nd->dentry->d_op->d_revalidate(nd->dentry, nd);
+			up(&nparent->d_inode->i_sem);
+			if (!reval)
 				break;
 		}
 return_base:

--=-8zn/UaTFYQ9fb5bhVpdQ--

