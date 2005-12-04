From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Sun, 4 Dec 2005 17:52:37 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0512041740480.1564@donald.themaw.net>
References: <20051116101740.GA9551@RAM>
	<17292.64892.680738.833917@segfault.boston.redhat.com>
	<1133315771.8978.65.camel@lade.trondhjem.org>
	<438E0C66.6040607@us.ibm.com>
	<1133384015.8974.35.camel@lade.trondhjem.org>
	<438E1A05.7000308@us.ibm.com>
	<Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	<438F251B.7060602@us.ibm.com>
	<Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	<17296.28812.390586.101214@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0512030131240.2632@donald.themaw.net>
	<4390938E.3050502@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4390938E.3050502@us.ibm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Will Taber <wtaber@us.ibm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Trond Myklebust <trond.myklebust@fys.uio.no>

On Fri, 2 Dec 2005, Will Taber wrote:

> > > 
> > > Well, I think we've determined that the reported problem doesn't happen
> > > with any in-tree callers.  The question, then, is do you want to fix the
> > > locking problem?  Two approaches were presented in this thread.  I don't
> > > really like the idea of the hack used by devfs, since it relies on
> > > implicit
> > > semantics.  I haven't given much thought to the second approach, though
> > > (are we sure it can be made to work?).  It may require a good deal of
> > > effort, but if it makes things work properly, it's worth considering.  I'm
> > > just not sure where it sits in the list of priorities, as I know you've
> > > got
> > > a lot on your plate, Ian.
> > 
> > 
> > It appears to me that the unhashed directory approach proposed by Will does
> > not account for directories that exist but don't have current mounts.
> > 
> > I will re-read the posts, I expect I missed something, and give it more
> > thought.
> > 
> It doesn't consider that case.  You had mentioned it but I had forgotten.
> 

OK so I decided to give Wills recommendation a bit of a run and I've come 
up with a first cut patch which of course doesn't work.

The approach is to force all callbacks to go through lookup instead of 
some through revalidate as well. The patch basically posts the dentry to a 
pending list and unhashs it, then picks it up from the list in the lookup 
and rehash it. Should be fairly simple really but I'm doing something 
obviously wrong somewhere.

I'm seeing slab corruption and I really can't see why this should be the 
case. Anyone got any ideas. The patch is against 2.6.15-rc1 but the kernel 
I'm compliling against is a RedHat patched 2.6.11 (Aurora).

--- linux-2.6.15-rc1/fs/autofs4/root.c.lookup-deadlock	2005-11-17 18:58:38.000000000 +0800
+++ linux-2.6.15-rc1/fs/autofs4/root.c	2005-12-04 11:15:51.000000000 +0800
@@ -290,15 +290,20 @@ out:
 
 static int try_to_fill_dentry(struct dentry *dentry, 
 			      struct super_block *sb,
-			      struct autofs_sb_info *sbi, int flags)
+			      struct autofs_sb_info *sbi)
 {
-	struct autofs_info *de_info = autofs4_dentry_ino(dentry);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status = 0;
 
-	/* Block on any pending expiry here; invalidate the dentry
-           when expiration is done to trigger mount request with a new
-           dentry */
-	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
+	DPRINTK("dentry=%p %.*s ino=%p",
+		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
+
+	/*
+	 * Block on any pending expiry here; invalidate the dentry
+	 * when expiration is done to trigger mount request with a new
+	 * dentry
+	 */
+	if (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
 		DPRINTK("waiting for expire %p name=%.*s",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 
@@ -308,70 +313,34 @@ static int try_to_fill_dentry(struct den
 		
 		/*
 		 * If the directory still exists the mount request must
-		 * continue otherwise it can't be followed at the right
-		 * time during the walk.
+		 * continue otherwise it can't be followed during the walk.
 		 */
-		status = d_invalidate(dentry);
-		if (status != -EBUSY)
-			return 0;
+		if (d_invalidate(dentry) != -EBUSY)
+			return status;
 	}
 
-	DPRINTK("dentry=%p %.*s ino=%p",
-		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
-
 	/* Wait for a pending mount, triggering one if there isn't one already */
-	if (dentry->d_inode == NULL) {
-		DPRINTK("waiting for mount name=%.*s",
+	DPRINTK("waiting for mount name=%.*s",
 			 dentry->d_name.len, dentry->d_name.name);
 
-		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
-		 
-		DPRINTK("mount done status=%d", status);
+	status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 
-		if (status && dentry->d_inode)
-			return 0; /* Try to get the kernel to invalidate this dentry */
-		
-		/* Turn this into a real negative dentry? */
-		if (status == -ENOENT) {
-			dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
-			spin_lock(&dentry->d_lock);
-			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-			spin_unlock(&dentry->d_lock);
-			return 1;
-		} else if (status) {
-			/* Return a negative dentry, but leave it "pending" */
-			return 1;
-		}
-	/* Trigger mount for path component or follow link */
-	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
-			current->link_count) {
-		DPRINTK("waiting for mount name=%.*s",
-			dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("mount done status=%d", status);
+
+	/*
+	 * We don't update the usages for the autofs daemon itself, this
+	 * is necessary for recursive autofs mounts
+	 */
+	if (!autofs4_oz_mode(sbi))
+		autofs4_update_usage(dentry);
 
+	if (!status || status == -ENOENT) {
 		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
-		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
-
-		DPRINTK("mount done status=%d", status);
-
-		if (status) {
-			spin_lock(&dentry->d_lock);
-			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-			spin_unlock(&dentry->d_lock);
-			return 0;
-		}
 	}
 
-	/* We don't update the usages for the autofs daemon itself, this
-	   is necessary for recursive autofs mounts */
-	if (!autofs4_oz_mode(sbi))
-		autofs4_update_usage(dentry);
-
-	spin_lock(&dentry->d_lock);
-	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-	spin_unlock(&dentry->d_lock);
-	return 1;
+	return status;
 }
 
 /*
@@ -382,22 +351,25 @@ static int try_to_fill_dentry(struct den
  */
 static int autofs4_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
-	struct inode * dir = dentry->d_parent->d_inode;
+	struct inode *dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int oz_mode = autofs4_oz_mode(sbi);
-	int flags = nd ? nd->flags : 0;
-	int status = 1;
+	int need_lookup;
 
-	/* Pending dentry */
-	if (autofs4_ispending(dentry)) {
-		if (!oz_mode)
-			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, flags);
-		return status;
-	}
+	DPRINTK("name = %.*s oz_mode = %d",
+		dentry->d_name.len, dentry->d_name.name, oz_mode);
+
+	if (oz_mode || autofs4_ispending(dentry))
+		return 1;
 
-	/* Negative dentry.. invalidate if "old" */
-	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+	need_lookup = nd ? nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY): 1;
+
+	/*
+	 * Clean up those pesky stale dentrys before checking for
+	 * an empty directory
+	 */
+	d_invalidate(dentry);
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
@@ -406,16 +378,21 @@ static int autofs4_revalidate(struct den
 	    list_empty(&dentry->d_subdirs)) {
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
-		spin_unlock(&dcache_lock);
-		if (!oz_mode)
-			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, flags);
-		return status;
+
+		if (ino && (need_lookup || current->link_count)) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
+			list_add(&ino->request, &sbi->pending);
+			spin_unlock(&dcache_lock);
+			return 0;
+		}
 	}
 	spin_unlock(&dcache_lock);
 
 	/* Update the usage list */
-	if (!oz_mode)
-		autofs4_update_usage(dentry);
+	autofs4_update_usage(dentry);
 
 	return 1;
 }
@@ -449,11 +426,40 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
+static struct autofs_info *autofs4_lookup_pending(struct autofs_sb_info *sbi, struct qstr *name)
+{
+	unsigned int len = name->len;
+	unsigned int hash = name->hash;
+	const unsigned char *str = name->name;
+	struct list_head *p;
+	struct autofs_info *rq_ino = NULL;
+
+	list_for_each(p, &sbi->pending) {
+		struct autofs_info *this;
+		struct qstr *name;
+
+		this = list_entry(p, struct autofs_info, request);
+		name = &this->dentry->d_name;
+
+		if (name->hash != hash)
+			continue;
+		if(name->len != len)
+			continue;
+		if (!memcmp(name->name, str, len)) {
+			rq_ino = this;
+			break;
+		}
+	}
+	return rq_ino;
+}
+
 /* Lookups in the root directory */
 static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
-	struct autofs_sb_info *sbi;
-	int oz_mode;
+	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
+	int oz_mode = autofs4_oz_mode(sbi);
+	struct autofs_info *rq_ino;
+	int status = 0;
 
 	DPRINTK("name = %.*s",
 		dentry->d_name.len, dentry->d_name.name);
@@ -461,36 +467,52 @@ static struct dentry *autofs4_lookup(str
 	if (dentry->d_name.len > NAME_MAX)
 		return ERR_PTR(-ENAMETOOLONG);/* File name too long to exist */
 
-	sbi = autofs4_sbi(dir->i_sb);
-
-	oz_mode = autofs4_oz_mode(sbi);
 	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
 		 current->pid, process_group(current), sbi->catatonic, oz_mode);
 
-	/*
-	 * Mark the dentry incomplete, but add it. This is needed so
-	 * that the VFS layer knows about the dentry, and we can count
-	 * on catching any lookups through the revalidate.
-	 *
-	 * Let all the hard work be done by the revalidate function that
-	 * needs to be able to do this anyway..
-	 *
-	 * We need to do this before we release the directory semaphore.
-	 */
-	dentry->d_op = &autofs4_root_dentry_operations;
-
-	if (!oz_mode) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
-		spin_unlock(&dentry->d_lock);
-	}
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
-
-	if (dentry->d_op && dentry->d_op->d_revalidate) {
+	spin_lock(&dcache_lock);
+	rq_ino = autofs4_lookup_pending(sbi, &dentry->d_name);
+	if (!oz_mode && rq_ino && autofs4_ispending(rq_ino->dentry)) {
+		/*
+		 * Revalidate has sent this to us to post a mount request.
+		 *
+		 * This must be done via lookup so we can be sure that it
+		 * was this path that aquired the directory semaphore.
+		 */
+		list_del_init(&rq_ino->request);
+		dentry = rq_ino->dentry;
+		spin_unlock(&dcache_lock);
+		d_rehash(dentry);
 		up(&dir->i_sem);
-		(dentry->d_op->d_revalidate)(dentry, nd);
+		status = try_to_fill_dentry(dentry, dir->i_sb, sbi);
 		down(&dir->i_sem);
+
+		/* If the mount suceeded we're done */
+		if (!status)
+			return dentry;
+	} else {
+		spin_unlock(&dcache_lock);
+		/*
+		 * Mark the dentry incomplete, but add it. This is needed
+		 * so that the VFS layer knows about the dentry, and we
+		 * can count on catching any lookups through the revalidate.
+		 *
+		 * We need to do this before we release the directory
+		 * semaphore.
+		 */
+		dentry->d_op = &autofs4_root_dentry_operations;
+
+		dentry->d_fsdata = NULL;
+		d_add(dentry, NULL);
+
+		if (!oz_mode) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+			spin_unlock(&dentry->d_lock);
+			up(&dir->i_sem);
+			status = try_to_fill_dentry(dentry, dir->i_sb, sbi);
+			down(&dir->i_sem);
+		}
 	}
 
 	/*
@@ -498,6 +520,9 @@ static struct dentry *autofs4_lookup(str
 	 * a signal. If so we can force a restart..
 	 */
 	if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
 		/* See if we were interrupted */
 		if (signal_pending(current)) {
 			sigset_t *sigset = &current->pending.signal;
@@ -515,9 +540,13 @@ static struct dentry *autofs4_lookup(str
 	 * doesn't do the right thing for all system calls, but it should
 	 * be OK for the operations we permit from an autofs.
 	 */
-	if ( dentry->d_inode && d_unhashed(dentry) )
+	if (dentry->d_inode && d_unhashed(dentry))
 		return ERR_PTR(-ENOENT);
 
+	/* Otherwise try to get the VFS to report the error */
+	if (status)
+		return ERR_PTR(status);
+
 	return NULL;
 }
 
--- linux-2.6.15-rc1/fs/autofs4/autofs_i.h.lookup-deadlock	2005-12-03 10:32:19.000000000 +0800
+++ linux-2.6.15-rc1/fs/autofs4/autofs_i.h	2005-12-04 09:59:52.000000000 +0800
@@ -63,6 +63,8 @@ struct autofs_info {
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
 
+	struct list_head request;
+
 	mode_t	mode;
 	size_t	size;
 
@@ -105,6 +107,7 @@ struct autofs_sb_info {
 	struct semaphore wq_sem;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
+	struct list_head pending;
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
--- linux-2.6.15-rc1/fs/autofs4/inode.c.lookup-deadlock	2005-12-03 20:27:17.000000000 +0800
+++ linux-2.6.15-rc1/fs/autofs4/inode.c	2005-12-04 09:59:16.000000000 +0800
@@ -49,6 +49,8 @@ struct autofs_info *autofs4_init_ino(str
 
 	ino->sbi = sbi;
 
+	INIT_LIST_HEAD(&ino->request);
+
 	if (reinit && ino->free)
 		(ino->free)(ino);
 
@@ -272,6 +274,7 @@ int autofs4_fill_super(struct super_bloc
 	init_MUTEX(&sbi->wq_sem);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
+	INIT_LIST_HEAD(&sbi->pending);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
