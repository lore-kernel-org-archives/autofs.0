From: Ian Kent <raven@themaw.net>
Subject: Re: More autofs problems
Date: Mon, 30 Jun 2008 18:35:41 +0800
Message-ID: <1214822142.3008.18.camel@raven.themaw.net>
References: <4868946B.7050801@aei.mpg.de>
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4868B0BA.9040208@aei.mpg.de>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org


On Mon, 2008-06-30 at 12:08 +0200, Carsten Aulbert wrote:
> Hi Ian,
> 
> Ian Kent wrote:
> f  4.1.4-13 on amd64.
> > 
> > I can produce patches for 2.6.24.4 if you would like to test them.
> > They are quite recent and haven't been posted for inclusion in any
> > kernel yet. I would also include some other patches, that I hope will
> > get into mainline, in the series.
> 
> I think that would be a good option. I do hope there are not that many
> side effects with the other patches, but I definitely would like to get
> away from this bug.

This patch is a combined diff of the current bug fixes for autofs4,
against 2.6.24 (it applied OK to vanilla 2.6.24.4).

See how it goes.

Ian

--- linux-2.6.24.orig/fs/autofs4/waitq.c
+++ linux-2.6.24/fs/autofs4/waitq.c
@@ -28,6 +28,12 @@ void autofs4_catatonic_mode(struct autof
 {
 	struct autofs_wait_queue *wq, *nwq;
 
+	mutex_lock(&sbi->wq_mutex);
+	if (sbi->catatonic) {
+		mutex_unlock(&sbi->wq_mutex);
+		return;
+	}
+
 	DPRINTK("entering catatonic mode");
 
 	sbi->catatonic = 1;
@@ -36,13 +42,18 @@ void autofs4_catatonic_mode(struct autof
 	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
-		kfree(wq->name);
-		wq->name = NULL;
+		if (wq->name.name) {
+			kfree(wq->name.name);
+			wq->name.name = NULL;
+		}
+		wq->wait_ctr--;
 		wake_up_interruptible(&wq->queue);
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
 	sbi->pipe = NULL;
+	sbi->pipefd = -1;
+	mutex_unlock(&sbi->wq_mutex);
 }
 
 static int autofs4_write(struct file *file, const void *addr, int bytes)
@@ -89,10 +100,11 @@ static void autofs4_notify_daemon(struct
 		union autofs_packet_union v4_pkt;
 		union autofs_v5_packet_union v5_pkt;
 	} pkt;
+	struct file *pipe = NULL;
 	size_t pktsz;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
-		wq->wait_queue_token, wq->len, wq->name, type);
+		wq->wait_queue_token, wq->name.len, wq->name.name, type);
 
 	memset(&pkt,0,sizeof pkt); /* For security reasons */
 
@@ -107,9 +119,9 @@ static void autofs4_notify_daemon(struct
 		pktsz = sizeof(*mp);
 
 		mp->wait_queue_token = wq->wait_queue_token;
-		mp->len = wq->len;
-		memcpy(mp->name, wq->name, wq->len);
-		mp->name[wq->len] = '\0';
+		mp->len = wq->name.len;
+		memcpy(mp->name, wq->name.name, wq->name.len);
+		mp->name[wq->name.len] = '\0';
 		break;
 	}
 	case autofs_ptype_expire_multi:
@@ -119,9 +131,9 @@ static void autofs4_notify_daemon(struct
 		pktsz = sizeof(*ep);
 
 		ep->wait_queue_token = wq->wait_queue_token;
-		ep->len = wq->len;
-		memcpy(ep->name, wq->name, wq->len);
-		ep->name[wq->len] = '\0';
+		ep->len = wq->name.len;
+		memcpy(ep->name, wq->name.name, wq->name.len);
+		ep->name[wq->name.len] = '\0';
 		break;
 	}
 	/*
@@ -138,9 +150,9 @@ static void autofs4_notify_daemon(struct
 		pktsz = sizeof(*packet);
 
 		packet->wait_queue_token = wq->wait_queue_token;
-		packet->len = wq->len;
-		memcpy(packet->name, wq->name, wq->len);
-		packet->name[wq->len] = '\0';
+		packet->len = wq->name.len;
+		memcpy(packet->name, wq->name.name, wq->name.len);
+		packet->name[wq->name.len] = '\0';
 		packet->dev = wq->dev;
 		packet->ino = wq->ino;
 		packet->uid = wq->uid;
@@ -154,8 +166,19 @@ static void autofs4_notify_daemon(struct
 		return;
 	}
 
-	if (autofs4_write(sbi->pipe, &pkt, pktsz))
-		autofs4_catatonic_mode(sbi);
+	/* Check if we have become catatonic */
+	mutex_lock(&sbi->wq_mutex);
+	if (!sbi->catatonic) {
+		pipe = sbi->pipe;
+		get_file(pipe);
+	}
+	mutex_unlock(&sbi->wq_mutex);
+
+	if (pipe) {
+		if (autofs4_write(pipe, &pkt, pktsz))
+			autofs4_catatonic_mode(sbi);
+		fput(pipe);
+	}
 }
 
 static int autofs4_getpath(struct autofs_sb_info *sbi,
@@ -171,7 +194,7 @@ static int autofs4_getpath(struct autofs
 	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
 		len += tmp->d_name.len + 1;
 
-	if (--len > NAME_MAX) {
+	if (!len || --len > NAME_MAX) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
@@ -191,58 +214,55 @@ static int autofs4_getpath(struct autofs
 }
 
 static struct autofs_wait_queue *
-autofs4_find_wait(struct autofs_sb_info *sbi,
-		  char *name, unsigned int hash, unsigned int len)
+autofs4_find_wait(struct autofs_sb_info *sbi, struct qstr *qstr)
 {
 	struct autofs_wait_queue *wq;
 
 	for (wq = sbi->queues; wq; wq = wq->next) {
-		if (wq->hash == hash &&
-		    wq->len == len &&
-		    wq->name && !memcmp(wq->name, name, len))
+		if (wq->name.hash == qstr->hash &&
+		    wq->name.len == qstr->len &&
+		    wq->name.name &&
+			 !memcmp(wq->name.name, qstr->name, qstr->len))
 			break;
 	}
 	return wq;
 }
 
-int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
-		enum autofs_notify notify)
+/*
+ * Check if we have a valid request.
+ * Returns
+ * 1 if the request should continue.
+ *   In this case we can return an autofs_wait_queue entry if one is
+ *   found or NULL to idicate a new wait needs to be created.
+ * 0 or a negative errno if the request shouldn't continue.
+ */
+static int validate_request(struct autofs_wait_queue **wait,
+			    struct autofs_sb_info *sbi,
+			    struct qstr *qstr,
+			    struct dentry*dentry, enum autofs_notify notify)
 {
-	struct autofs_info *ino;
 	struct autofs_wait_queue *wq;
-	char *name;
-	unsigned int len = 0;
-	unsigned int hash = 0;
-	int status, type;
-
-	/* In catatonic mode, we don't wait for nobody */
-	if (sbi->catatonic)
-		return -ENOENT;
-	
-	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
-	if (!name)
-		return -ENOMEM;
+	struct autofs_info *ino;
 
-	/* If this is a direct mount request create a dummy name */
-	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYPE_DIRECT))
-		len = sprintf(name, "%p", dentry);
-	else {
-		len = autofs4_getpath(sbi, dentry, &name);
-		if (!len) {
-			kfree(name);
-			return -ENOENT;
-		}
+	/* Wait in progress, continue; */
+	wq = autofs4_find_wait(sbi, qstr);
+	if (wq) {
+		*wait = wq;
+		return 1;
 	}
-	hash = full_name_hash(name, len);
 
-	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
-		kfree(name);
-		return -EINTR;
-	}
+	*wait = NULL;
 
-	wq = autofs4_find_wait(sbi, name, hash, len);
+	/* If we don't yet have any info this is a new request */
 	ino = autofs4_dentry_ino(dentry);
-	if (!wq && ino && notify == NFY_NONE) {
+	if (!ino)
+		return 1;
+
+	/*
+	 * If we've been asked to wait on an existing expire (NFY_NONE)
+	 * but there is no wait in the queue ...
+	 */
+	if (notify == NFY_NONE) {
 		/*
 		 * Either we've betean the pending expire to post it's
 		 * wait or it finished while we waited on the mutex.
@@ -253,13 +273,14 @@ int autofs4_wait(struct autofs_sb_info *
 		while (ino->flags & AUTOFS_INF_EXPIRING) {
 			mutex_unlock(&sbi->wq_mutex);
 			schedule_timeout_interruptible(HZ/10);
-			if (mutex_lock_interruptible(&sbi->wq_mutex)) {
-				kfree(name);
+			if (mutex_lock_interruptible(&sbi->wq_mutex))
 				return -EINTR;
+
+			wq = autofs4_find_wait(sbi, qstr);
+			if (wq) {
+				*wait = wq;
+				return 1;
 			}
-			wq = autofs4_find_wait(sbi, name, hash, len);
-			if (wq)
-				break;
 		}
 
 		/*
@@ -267,18 +288,85 @@ int autofs4_wait(struct autofs_sb_info *
 		 * cases where we wait on NFY_NONE neither depend on the
 		 * return status of the wait.
 		 */
-		if (!wq) {
+		return 0;
+	}
+
+	/*
+	 * If we've been asked to trigger a mount and the request
+	 * completed while we waited on the mutex ...
+	 */
+	if (notify == NFY_MOUNT) {
+		/*
+		 * If the dentry isn't hashed just go ahead and try the
+		 * mount again with a new wait (not much else we can do).
+		*/
+		if (!d_unhashed(dentry)) {
+			/*
+			 * But if the dentry is hashed, that means that we
+			 * got here through the revalidate path.  Thus, we
+			 * need to check if the dentry has been mounted
+			 * while we waited on the wq_mutex. If it has,
+			 * simply return success.
+			 */
+			if (d_mountpoint(dentry))
+				return 0;
+		}
+	}
+
+	return 1;
+}
+
+int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
+		enum autofs_notify notify)
+{
+	struct autofs_wait_queue *wq;
+	struct qstr qstr;
+	char *name;
+	int status, ret, type;
+
+	/* In catatonic mode, we don't wait for nobody */
+	if (sbi->catatonic)
+		return -ENOENT;
+
+	if (!dentry->d_inode &&
+	    (sbi->type & (AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET)))
+		return -ENOENT;
+
+	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	/* If this is a direct mount request create a dummy name */
+	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYPE_DIRECT))
+		qstr.len = sprintf(name, "%p", dentry);
+	else {
+		qstr.len = autofs4_getpath(sbi, dentry, &name);
+		if (!qstr.len) {
 			kfree(name);
-			mutex_unlock(&sbi->wq_mutex);
-			return 0;
+			return -ENOENT;
 		}
 	}
+	qstr.name = name;
+	qstr.hash = full_name_hash(name, qstr.len);
+
+	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
+		kfree(qstr.name);
+		return -EINTR;
+	}
+
+	ret = validate_request(&wq, sbi, &qstr, dentry, notify);
+	if (ret <= 0) {
+		if (ret == 0)
+			mutex_unlock(&sbi->wq_mutex);
+		kfree(qstr.name);
+		return ret;
+	}
 
 	if (!wq) {
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
 		if (!wq) {
-			kfree(name);
+			kfree(qstr.name);
 			mutex_unlock(&sbi->wq_mutex);
 			return -ENOMEM;
 		}
@@ -289,9 +377,7 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->next = sbi->queues;
 		sbi->queues = wq;
 		init_waitqueue_head(&wq->queue);
-		wq->hash = hash;
-		wq->name = name;
-		wq->len = len;
+		memcpy(&wq->name, &qstr, sizeof(struct qstr));
 		wq->dev = autofs4_get_dev(sbi);
 		wq->ino = autofs4_get_ino(sbi);
 		wq->uid = current->uid;
@@ -299,7 +385,7 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->pid = current->pid;
 		wq->tgid = current->tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
-		atomic_set(&wq->wait_ctr, 2);
+		wq->wait_ctr = 2;
 		mutex_unlock(&sbi->wq_mutex);
 
 		if (sbi->version < 5) {
@@ -319,28 +405,25 @@ int autofs4_wait(struct autofs_sb_info *
 		}
 
 		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
+			(unsigned long) wq->wait_queue_token, wq->name.len,
+			wq->name.name, notify);
 
 		/* autofs4_notify_daemon() may block */
 		autofs4_notify_daemon(sbi, wq, type);
 	} else {
-		atomic_inc(&wq->wait_ctr);
+		wq->wait_ctr++;
 		mutex_unlock(&sbi->wq_mutex);
-		kfree(name);
+		kfree(qstr.name);
 		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
-			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
+			(unsigned long) wq->wait_queue_token, wq->name.len,
+			wq->name.name, notify);
 	}
 
-	/* wq->name is NULL if and only if the lock is already released */
-
-	if (sbi->catatonic) {
-		/* We might have slept, so check again for catatonic mode */
-		wq->status = -ENOENT;
-		kfree(wq->name);
-		wq->name = NULL;
-	}
-
-	if (wq->name) {
+	/*
+	 * wq->name.name is NULL iff the lock is already released
+	 * or the mount has been made catatonic.
+	 */
+	if (wq->name.name) {
 		/* Block all but "shutdown" signals while waiting */
 		sigset_t oldset;
 		unsigned long irqflags;
@@ -351,7 +434,7 @@ int autofs4_wait(struct autofs_sb_info *
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 
-		wait_event_interruptible(wq->queue, wq->name == NULL);
+		wait_event_interruptible(wq->queue, wq->name.name == NULL);
 
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
@@ -364,8 +447,10 @@ int autofs4_wait(struct autofs_sb_info *
 	status = wq->status;
 
 	/* Are we the last process to need status? */
-	if (atomic_dec_and_test(&wq->wait_ctr))
+	mutex_lock(&sbi->wq_mutex);
+	if (!--wq->wait_ctr)
 		kfree(wq);
+	mutex_unlock(&sbi->wq_mutex);
 
 	return status;
 }
@@ -387,16 +472,13 @@ int autofs4_wait_release(struct autofs_s
 	}
 
 	*wql = wq->next;	/* Unlink from chain */
-	mutex_unlock(&sbi->wq_mutex);
-	kfree(wq->name);
-	wq->name = NULL;	/* Do not wait on this queue */
-
+	kfree(wq->name.name);
+	wq->name.name = NULL;	/* Do not wait on this queue */
 	wq->status = status;
-
-	if (atomic_dec_and_test(&wq->wait_ctr))	/* Is anyone still waiting for this guy? */
+	wake_up_interruptible(&wq->queue);
+	if (!--wq->wait_ctr)
 		kfree(wq);
-	else
-		wake_up_interruptible(&wq->queue);
+	mutex_unlock(&sbi->wq_mutex);
 
 	return 0;
 }
--- linux-2.6.24.orig/fs/autofs4/expire.c
+++ linux-2.6.24/fs/autofs4/expire.c
@@ -73,8 +73,8 @@ static int autofs4_mount_busy(struct vfs
 	status = 0;
 done:
 	DPRINTK("returning = %d", status);
-	mntput(mnt);
 	dput(dentry);
+	mntput(mnt);
 	return status;
 }
 
@@ -333,7 +333,7 @@ static struct dentry *autofs4_expire_ind
 			/* Can we expire this guy */
 			if (autofs4_can_expire(dentry, timeout, do_now)) {
 				expired = dentry;
-				break;
+				goto found;
 			}
 			goto next;
 		}
@@ -352,7 +352,7 @@ static struct dentry *autofs4_expire_ind
 				inf->flags |= AUTOFS_INF_EXPIRING;
 				spin_unlock(&sbi->fs_lock);
 				expired = dentry;
-				break;
+				goto found;
 			}
 			spin_unlock(&sbi->fs_lock);
 		/*
@@ -363,7 +363,7 @@ static struct dentry *autofs4_expire_ind
 			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
 			if (expired) {
 				dput(dentry);
-				break;
+				goto found;
 			}
 		}
 next:
@@ -371,18 +371,16 @@ next:
 		spin_lock(&dcache_lock);
 		next = next->next;
 	}
-
-	if (expired) {
-		DPRINTK("returning %p %.*s",
-			expired, (int)expired->d_name.len, expired->d_name.name);
-		spin_lock(&dcache_lock);
-		list_move(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
-		spin_unlock(&dcache_lock);
-		return expired;
-	}
 	spin_unlock(&dcache_lock);
-
 	return NULL;
+
+found:
+	DPRINTK("returning %p %.*s",
+		expired, (int)expired->d_name.len, expired->d_name.name);
+	spin_lock(&dcache_lock);
+	list_move(&expired->d_parent->d_subdirs, &expired->d_u.d_child);
+	spin_unlock(&dcache_lock);
+	return expired;
 }
 
 /* Perform an expiry operation */
--- linux-2.6.24.orig/fs/autofs4/root.c
+++ linux-2.6.24/fs/autofs4/root.c
@@ -25,25 +25,25 @@ static int autofs4_dir_rmdir(struct inod
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
 static int autofs4_dir_open(struct inode *inode, struct file *file);
-static int autofs4_dir_close(struct inode *inode, struct file *file);
-static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static void *autofs4_follow_link(struct dentry *, struct nameidata *);
 
+#define TRIGGER_FLAGS   (LOOKUP_CONTINUE | LOOKUP_DIRECTORY)
+#define TRIGGER_INTENTS (LOOKUP_OPEN | LOOKUP_ACCESS | LOOKUP_CREATE)
+
 const struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
 	.read		= generic_read_dir,
-	.readdir	= autofs4_root_readdir,
+	.readdir	= dcache_readdir,
 	.ioctl		= autofs4_root_ioctl,
 };
 
 const struct file_operations autofs4_dir_operations = {
 	.open		= autofs4_dir_open,
-	.release	= autofs4_dir_close,
+	.release	= dcache_dir_close,
 	.read		= generic_read_dir,
-	.readdir	= autofs4_dir_readdir,
+	.readdir	= dcache_readdir,
 };
 
 const struct inode_operations autofs4_indirect_root_inode_operations = {
@@ -70,42 +70,10 @@ const struct inode_operations autofs4_di
 	.rmdir		= autofs4_dir_rmdir,
 };
 
-static int autofs4_root_readdir(struct file *file, void *dirent,
-				filldir_t filldir)
-{
-	struct autofs_sb_info *sbi = autofs4_sbi(file->f_path.dentry->d_sb);
-	int oz_mode = autofs4_oz_mode(sbi);
-
-	DPRINTK("called, filp->f_pos = %lld", file->f_pos);
-
-	/*
-	 * Don't set reghost flag if:
-	 * 1) f_pos is larger than zero -- we've already been here.
-	 * 2) we haven't even enabled reghosting in the 1st place.
-	 * 3) this is the daemon doing a readdir
-	 */
-	if (oz_mode && file->f_pos == 0 && sbi->reghost_enabled)
-		sbi->needs_reghost = 1;
-
-	DPRINTK("needs_reghost = %d", sbi->needs_reghost);
-
-	return dcache_readdir(file, dirent, filldir);
-}
-
 static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
-	struct vfsmount *mnt = file->f_path.mnt;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct dentry *cursor;
-	int status;
-
-	status = dcache_dir_open(inode, file);
-	if (status)
-		goto out;
-
-	cursor = file->private_data;
-	cursor->d_fsdata = NULL;
 
 	DPRINTK("file=%p dentry=%p %.*s",
 		file, dentry, dentry->d_name.len, dentry->d_name.name);
@@ -113,136 +81,27 @@ static int autofs4_dir_open(struct inode
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
-	if (autofs4_ispending(dentry)) {
-		DPRINTK("dentry busy");
-		dcache_dir_close(inode, file);
-		status = -EBUSY;
-		goto out;
-	}
-
-	status = -ENOENT;
-	if (!d_mountpoint(dentry) && dentry->d_op && dentry->d_op->d_revalidate) {
-		struct nameidata nd;
-		int empty, ret;
-
-		/* In case there are stale directory dentrys from a failed mount */
-		spin_lock(&dcache_lock);
-		empty = list_empty(&dentry->d_subdirs);
-		spin_unlock(&dcache_lock);
-
-		if (!empty)
-			d_invalidate(dentry);
-
-		nd.flags = LOOKUP_DIRECTORY;
-		ret = (dentry->d_op->d_revalidate)(dentry, &nd);
-
-		if (ret <= 0) {
-			if (ret < 0)
-				status = ret;
-			dcache_dir_close(inode, file);
-			goto out;
-		}
-	}
-
-	if (d_mountpoint(dentry)) {
-		struct file *fp = NULL;
-		struct vfsmount *fp_mnt = mntget(mnt);
-		struct dentry *fp_dentry = dget(dentry);
-
-		if (!autofs4_follow_mount(&fp_mnt, &fp_dentry)) {
-			dput(fp_dentry);
-			mntput(fp_mnt);
-			dcache_dir_close(inode, file);
-			goto out;
-		}
-
-		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
-		status = PTR_ERR(fp);
-		if (IS_ERR(fp)) {
-			dcache_dir_close(inode, file);
-			goto out;
-		}
-		cursor->d_fsdata = fp;
-	}
-	return 0;
-out:
-	return status;
-}
-
-static int autofs4_dir_close(struct inode *inode, struct file *file)
-{
-	struct dentry *dentry = file->f_path.dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct dentry *cursor = file->private_data;
-	int status = 0;
-
-	DPRINTK("file=%p dentry=%p %.*s",
-		file, dentry, dentry->d_name.len, dentry->d_name.name);
-
-	if (autofs4_oz_mode(sbi))
-		goto out;
-
-	if (autofs4_ispending(dentry)) {
-		DPRINTK("dentry busy");
-		status = -EBUSY;
-		goto out;
-	}
-
-	if (d_mountpoint(dentry)) {
-		struct file *fp = cursor->d_fsdata;
-		if (!fp) {
-			status = -ENOENT;
-			goto out;
-		}
-		filp_close(fp, current->files);
-	}
-out:
-	dcache_dir_close(inode, file);
-	return status;
-}
-
-static int autofs4_dir_readdir(struct file *file, void *dirent, filldir_t filldir)
-{
-	struct dentry *dentry = file->f_path.dentry;
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct dentry *cursor = file->private_data;
-	int status;
-
-	DPRINTK("file=%p dentry=%p %.*s",
-		file, dentry, dentry->d_name.len, dentry->d_name.name);
-
-	if (autofs4_oz_mode(sbi))
-		goto out;
-
-	if (autofs4_ispending(dentry)) {
-		DPRINTK("dentry busy");
-		return -EBUSY;
-	}
-
-	if (d_mountpoint(dentry)) {
-		struct file *fp = cursor->d_fsdata;
-
-		if (!fp)
-			return -ENOENT;
-
-		if (!fp->f_op || !fp->f_op->readdir)
-			goto out;
+	/*
+	 * An empty directory in an autofs file system is always a
+	 * mount point. The daemon must have failed to mount this
+	 * during lookup so it doesn't exist. This can happen, for
+	 * example, if user space returns an incorrect status for a
+	 * mount request. Otherwise we're doing a readdir on the
+	 * autofs file system so just let the libfs routines handle
+	 * it.
+	 */
+	if (!d_mountpoint(dentry) && __simple_empty(dentry))
+		return -ENOENT;
 
-		status = vfs_readdir(fp, filldir, dirent);
-		file->f_pos = fp->f_pos;
-		if (status)
-			autofs4_copy_atime(file, fp);
-		return status;
-	}
 out:
-	return dcache_readdir(file, dirent, filldir);
+	return dcache_dir_open(inode, file);
 }
 
 static int try_to_fill_dentry(struct dentry *dentry, int flags)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-	int status = 0;
+	int status;
 
 	/* Block on any pending expiry here; invalidate the dentry
            when expiration is done to trigger mount request with a new
@@ -291,7 +150,7 @@ static int try_to_fill_dentry(struct den
 			return status;
 		}
 	/* Trigger mount for path component or follow link */
-	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
+	} else if (flags & (TRIGGER_FLAGS | TRIGGER_INTENTS) ||
 			current->link_count) {
 		DPRINTK("waiting for mount name=%.*s",
 			dentry->d_name.len, dentry->d_name.name);
@@ -318,7 +177,8 @@ static int try_to_fill_dentry(struct den
 	spin_lock(&dentry->d_lock);
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	spin_unlock(&dentry->d_lock);
-	return status;
+
+	return 0;
 }
 
 /* For autofs direct mounts the follow link triggers the mount */
@@ -335,7 +195,7 @@ static void *autofs4_follow_link(struct 
 		nd->flags);
 
 	/* If it's our master or we shouldn't trigger a mount we're done */
-	lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+	lookup_type = nd->flags & (TRIGGER_FLAGS | TRIGGER_INTENTS);
 	if (oz_mode || !lookup_type)
 		goto done;
 
@@ -470,10 +330,12 @@ void autofs4_dentry_release(struct dentr
 		struct autofs_sb_info *sbi = autofs4_sbi(de->d_sb);
 
 		if (sbi) {
-			spin_lock(&sbi->rehash_lock);
-			if (!list_empty(&inf->rehash))
-				list_del(&inf->rehash);
-			spin_unlock(&sbi->rehash_lock);
+			spin_lock(&sbi->lookup_lock);
+			if (!list_empty(&inf->active))
+				list_del(&inf->active);
+			if (!list_empty(&inf->expiring))
+				list_del(&inf->expiring);
+			spin_unlock(&sbi->lookup_lock);
 		}
 
 		inf->dentry = NULL;
@@ -495,7 +357,7 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
-static struct dentry *autofs4_lookup_unhashed(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
+static struct dentry *autofs4_lookup_active(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
 {
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
@@ -503,14 +365,66 @@ static struct dentry *autofs4_lookup_unh
 	struct list_head *p, *head;
 
 	spin_lock(&dcache_lock);
-	spin_lock(&sbi->rehash_lock);
-	head = &sbi->rehash_list;
+	spin_lock(&sbi->lookup_lock);
+	head = &sbi->active_list;
 	list_for_each(p, head) {
 		struct autofs_info *ino;
 		struct dentry *dentry;
 		struct qstr *qstr;
 
-		ino = list_entry(p, struct autofs_info, rehash);
+		ino = list_entry(p, struct autofs_info, active);
+		dentry = ino->dentry;
+
+		spin_lock(&dentry->d_lock);
+
+		/* Already gone? */
+		if (atomic_read(&dentry->d_count) == 0)
+			goto next;
+
+		qstr = &dentry->d_name;
+
+		if (dentry->d_name.hash != hash)
+			goto next;
+		if (dentry->d_parent != parent)
+			goto next;
+
+		if (qstr->len != len)
+			goto next;
+		if (memcmp(qstr->name, str, len))
+			goto next;
+
+		if (d_unhashed(dentry)) {
+			dget(dentry);
+			spin_unlock(&dentry->d_lock);
+			spin_unlock(&sbi->lookup_lock);
+			spin_unlock(&dcache_lock);
+			return dentry;
+		}
+next:
+		spin_unlock(&dentry->d_lock);
+	}
+	spin_unlock(&sbi->lookup_lock);
+	spin_unlock(&dcache_lock);
+
+	return NULL;
+}
+
+static struct dentry *autofs4_lookup_expiring(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
+{
+	unsigned int len = name->len;
+	unsigned int hash = name->hash;
+	const unsigned char *str = name->name;
+	struct list_head *p, *head;
+
+	spin_lock(&dcache_lock);
+	spin_lock(&sbi->lookup_lock);
+	head = &sbi->expiring_list;
+	list_for_each(p, head) {
+		struct autofs_info *ino;
+		struct dentry *dentry;
+		struct qstr *qstr;
+
+		ino = list_entry(p, struct autofs_info, expiring);
 		dentry = ino->dentry;
 
 		spin_lock(&dentry->d_lock);
@@ -532,33 +446,17 @@ static struct dentry *autofs4_lookup_unh
 			goto next;
 
 		if (d_unhashed(dentry)) {
-			struct autofs_info *ino = autofs4_dentry_ino(dentry);
-			struct inode *inode = dentry->d_inode;
-
-			list_del_init(&ino->rehash);
+			list_del_init(&ino->expiring);
 			dget(dentry);
-			/*
-			 * Make the rehashed dentry negative so the VFS
-			 * behaves as it should.
-			 */
-			if (inode) {
-				dentry->d_inode = NULL;
-				list_del_init(&dentry->d_alias);
-				spin_unlock(&dentry->d_lock);
-				spin_unlock(&sbi->rehash_lock);
-				spin_unlock(&dcache_lock);
-				iput(inode);
-				return dentry;
-			}
 			spin_unlock(&dentry->d_lock);
-			spin_unlock(&sbi->rehash_lock);
+			spin_unlock(&sbi->lookup_lock);
 			spin_unlock(&dcache_lock);
 			return dentry;
 		}
 next:
 		spin_unlock(&dentry->d_lock);
 	}
-	spin_unlock(&sbi->rehash_lock);
+	spin_unlock(&sbi->lookup_lock);
 	spin_unlock(&dcache_lock);
 
 	return NULL;
@@ -568,7 +466,8 @@ next:
 static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
-	struct dentry *unhashed;
+	struct autofs_info *ino;
+	struct dentry *expiring, *unhashed;
 	int oz_mode;
 
 	DPRINTK("name = %.*s",
@@ -584,8 +483,28 @@ static struct dentry *autofs4_lookup(str
 	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
 		 current->pid, task_pgrp_nr(current), sbi->catatonic, oz_mode);
 
-	unhashed = autofs4_lookup_unhashed(sbi, dentry->d_parent, &dentry->d_name);
-	if (!unhashed) {
+	expiring = autofs4_lookup_expiring(sbi, dentry->d_parent, &dentry->d_name);
+	if (expiring) {
+		/*
+		 * If we are racing with expire the request might not
+		 * be quite complete but the directory has been removed
+		 * so it must have been successful, so just wait for it.
+		 */
+		ino = autofs4_dentry_ino(expiring);
+		while (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
+			DPRINTK("wait for incomplete expire %p name=%.*s",
+				expiring, expiring->d_name.len,
+				expiring->d_name.name);
+			autofs4_wait(sbi, expiring, NFY_NONE);
+			DPRINTK("request completed");
+		}
+		dput(expiring);
+	}
+
+	unhashed = autofs4_lookup_active(sbi, dentry->d_parent, &dentry->d_name);
+	if (unhashed)
+		dentry = unhashed;
+	else {
 		/*
 		 * Mark the dentry incomplete but don't hash it. We do this
 		 * to serialize our inode creation operations (symlink and
@@ -599,39 +518,34 @@ static struct dentry *autofs4_lookup(str
 		 */
 		dentry->d_op = &autofs4_root_dentry_operations;
 
-		dentry->d_fsdata = NULL;
-		d_instantiate(dentry, NULL);
-	} else {
-		struct autofs_info *ino = autofs4_dentry_ino(unhashed);
-		DPRINTK("rehash %p with %p", dentry, unhashed);
 		/*
-		 * If we are racing with expire the request might not
-		 * be quite complete but the directory has been removed
-		 * so it must have been successful, so just wait for it.
-		 * We need to ensure the AUTOFS_INF_EXPIRING flag is clear
-		 * before continuing as revalidate may fail when calling
-		 * try_to_fill_dentry (returning EAGAIN) if we don't.
+		 * And we need to ensure that the same dentry is used for
+		 * all following lookup calls until it is hashed so that
+		 * the dentry flags are persistent throughout the request.
 		 */
-		while (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
-			DPRINTK("wait for incomplete expire %p name=%.*s",
-				unhashed, unhashed->d_name.len,
-				unhashed->d_name.name);
-			autofs4_wait(sbi, unhashed, NFY_NONE);
-			DPRINTK("request completed");
-		}
-		dentry = unhashed;
+		ino = autofs4_init_ino(NULL, sbi, 0555);
+		if (!ino)
+			return ERR_PTR(-ENOMEM);
+
+		dentry->d_fsdata = ino;
+		ino->dentry = dentry;
+
+		spin_lock(&sbi->lookup_lock);
+		list_add(&ino->active, &sbi->active_list);
+		spin_unlock(&sbi->lookup_lock);
+
+		d_instantiate(dentry, NULL);
 	}
 
 	if (!oz_mode) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
-	}
-
-	if (dentry->d_op && dentry->d_op->d_revalidate) {
-		mutex_unlock(&dir->i_mutex);
-		(dentry->d_op->d_revalidate)(dentry, nd);
-		mutex_lock(&dir->i_mutex);
+		if (dentry->d_op && dentry->d_op->d_revalidate) {
+			mutex_unlock(&dir->i_mutex);
+			(dentry->d_op->d_revalidate)(dentry, nd);
+			mutex_lock(&dir->i_mutex);
+		}
 	}
 
 	/*
@@ -650,9 +564,11 @@ static struct dentry *autofs4_lookup(str
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-		spin_unlock(&dentry->d_lock);
+		if (!oz_mode) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+			spin_unlock(&dentry->d_lock);
+		}
 	}
 
 	/*
@@ -683,7 +599,7 @@ static struct dentry *autofs4_lookup(str
 	}
 
 	if (unhashed)
-		return dentry;
+		return unhashed;
 
 	return NULL;
 }
@@ -705,20 +621,30 @@ static int autofs4_dir_symlink(struct in
 		return -EACCES;
 
 	ino = autofs4_init_ino(ino, sbi, S_IFLNK | 0555);
-	if (ino == NULL)
-		return -ENOSPC;
+	if (!ino)
+		return -ENOMEM;
 
-	ino->size = strlen(symname);
-	ino->u.symlink = cp = kmalloc(ino->size + 1, GFP_KERNEL);
-
-	if (cp == NULL) {
-		kfree(ino);
-		return -ENOSPC;
+	spin_lock(&sbi->lookup_lock);
+	if (!list_empty(&ino->active))
+		list_del_init(&ino->active);
+	spin_unlock(&sbi->lookup_lock);
+
+	cp = kmalloc(ino->size + 1, GFP_KERNEL);
+	if (!cp) {
+		if (!dentry->d_fsdata)
+			kfree(ino);
+		return -ENOMEM;
 	}
 
 	strcpy(cp, symname);
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
+	if (!inode) {
+		kfree(cp);
+		if (!dentry->d_fsdata)
+			kfree(ino);
+		return -ENOMEM;
+	}
 	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
@@ -734,6 +660,8 @@ static int autofs4_dir_symlink(struct in
 		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 
+	ino->size = strlen(symname);
+	ino->u.symlink = cp;
 	dir->i_mtime = CURRENT_TIME;
 
 	return 0;
@@ -746,9 +674,8 @@ static int autofs4_dir_symlink(struct in
  * that the file no longer exists. However, doing that means that the
  * VFS layer can turn the dentry into a negative dentry.  We don't want
  * this, because the unlink is probably the result of an expire.
- * We simply d_drop it and add it to a rehash candidates list in the
- * super block, which allows the dentry lookup to reuse it retaining
- * the flags, such as expire in progress, in case we're racing with expire.
+ * We simply d_drop it and add it to a expiring list in the super block,
+ * which allows the dentry lookup to check for an incomplete expire.
  *
  * If a process is blocked on the dentry waiting for the expire to finish,
  * it will invalidate the dentry and try to mount with a new one.
@@ -778,9 +705,10 @@ static int autofs4_dir_unlink(struct ino
 	dir->i_mtime = CURRENT_TIME;
 
 	spin_lock(&dcache_lock);
-	spin_lock(&sbi->rehash_lock);
-	list_add(&ino->rehash, &sbi->rehash_list);
-	spin_unlock(&sbi->rehash_lock);
+	spin_lock(&sbi->lookup_lock);
+	if (list_empty(&ino->expiring))
+		list_add(&ino->expiring, &sbi->expiring_list);
+	spin_unlock(&sbi->lookup_lock);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -806,9 +734,10 @@ static int autofs4_dir_rmdir(struct inod
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
-	spin_lock(&sbi->rehash_lock);
-	list_add(&ino->rehash, &sbi->rehash_list);
-	spin_unlock(&sbi->rehash_lock);
+	spin_lock(&sbi->lookup_lock);
+	if (list_empty(&ino->expiring))
+		list_add(&ino->expiring, &sbi->expiring_list);
+	spin_unlock(&sbi->lookup_lock);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -843,10 +772,20 @@ static int autofs4_dir_mkdir(struct inod
 		dentry, dentry->d_name.len, dentry->d_name.name);
 
 	ino = autofs4_init_ino(ino, sbi, S_IFDIR | 0555);
-	if (ino == NULL)
-		return -ENOSPC;
+	if (!ino)
+		return -ENOMEM;
+
+	spin_lock(&sbi->lookup_lock);
+	if (!list_empty(&ino->active))
+		list_del_init(&ino->active);
+	spin_unlock(&sbi->lookup_lock);
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
+	if (!inode) {
+		if (!dentry->d_fsdata)
+			kfree(ino);
+		return -ENOMEM;
+	}
 	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
@@ -899,44 +838,6 @@ static inline int autofs4_get_protosubve
 }
 
 /*
- * Tells the daemon whether we need to reghost or not. Also, clears
- * the reghost_needed flag.
- */
-static inline int autofs4_ask_reghost(struct autofs_sb_info *sbi, int __user *p)
-{
-	int status;
-
-	DPRINTK("returning %d", sbi->needs_reghost);
-
-	status = put_user(sbi->needs_reghost, p);
-	if (status)
-		return status;
-
-	sbi->needs_reghost = 0;
-	return 0;
-}
-
-/*
- * Enable / Disable reghosting ioctl() operation
- */
-static inline int autofs4_toggle_reghost(struct autofs_sb_info *sbi, int __user *p)
-{
-	int status;
-	int val;
-
-	status = get_user(val, p);
-
-	DPRINTK("reghost = %d", val);
-
-	if (status)
-		return status;
-
-	/* turn on/off reghosting, with the val */
-	sbi->reghost_enabled = val;
-	return 0;
-}
-
-/*
 * Tells the daemon whether it can umount the autofs mount.
 */
 static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
@@ -1000,11 +901,6 @@ static int autofs4_root_ioctl(struct ino
 	case AUTOFS_IOC_SETTIMEOUT:
 		return autofs4_get_set_timeout(sbi, p);
 
-	case AUTOFS_IOC_TOGGLEREGHOST:
-		return autofs4_toggle_reghost(sbi, p);
-	case AUTOFS_IOC_ASKREGHOST:
-		return autofs4_ask_reghost(sbi, p);
-
 	case AUTOFS_IOC_ASKUMOUNT:
 		return autofs4_ask_umount(filp->f_path.mnt, p);
 
--- linux-2.6.24.orig/fs/autofs4/autofs_i.h
+++ linux-2.6.24/fs/autofs4/autofs_i.h
@@ -52,7 +52,8 @@ struct autofs_info {
 
 	int		flags;
 
-	struct list_head rehash;
+	struct list_head active;
+	struct list_head expiring;
 
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
@@ -74,9 +75,7 @@ struct autofs_wait_queue {
 	struct autofs_wait_queue *next;
 	autofs_wqt_t wait_queue_token;
 	/* We use the following to see what we are waiting for */
-	unsigned int hash;
-	unsigned int len;
-	char *name;
+	struct qstr name;
 	u32 dev;
 	u64 ino;
 	uid_t uid;
@@ -85,7 +84,7 @@ struct autofs_wait_queue {
 	pid_t tgid;
 	/* This is for status reporting upon return */
 	int status;
-	atomic_t wait_ctr;
+	unsigned int wait_ctr;
 };
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
@@ -112,8 +111,9 @@ struct autofs_sb_info {
 	struct mutex wq_mutex;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
-	spinlock_t rehash_lock;
-	struct list_head rehash_list;
+	spinlock_t lookup_lock;
+	struct list_head active_list;
+	struct list_head expiring_list;
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
--- linux-2.6.24.orig/fs/autofs4/inode.c
+++ linux-2.6.24/fs/autofs4/inode.c
@@ -24,8 +24,10 @@
 
 static void ino_lnkfree(struct autofs_info *ino)
 {
-	kfree(ino->u.symlink);
-	ino->u.symlink = NULL;
+	if (ino->u.symlink) {
+		kfree(ino->u.symlink);
+		ino->u.symlink = NULL;
+	}
 }
 
 struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
@@ -41,16 +43,18 @@ struct autofs_info *autofs4_init_ino(str
 	if (ino == NULL)
 		return NULL;
 
-	ino->flags = 0;
-	ino->mode = mode;
-	ino->inode = NULL;
-	ino->dentry = NULL;
-	ino->size = 0;
-
-	INIT_LIST_HEAD(&ino->rehash);
+	if (!reinit) {
+		ino->flags = 0;
+		ino->inode = NULL;
+		ino->dentry = NULL;
+		ino->size = 0;
+		INIT_LIST_HEAD(&ino->active);
+		INIT_LIST_HEAD(&ino->expiring);
+		atomic_set(&ino->count, 0);
+	}
 
+	ino->mode = mode;
 	ino->last_used = jiffies;
-	atomic_set(&ino->count, 0);
 
 	ino->sbi = sbi;
 
@@ -159,8 +163,8 @@ void autofs4_kill_sb(struct super_block 
 	if (!sbi)
 		goto out_kill_sb;
 
-	if (!sbi->catatonic)
-		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
+	/* Free wait queues, close pipe */
+	autofs4_catatonic_mode(sbi);
 
 	/* Clean up and release dangling references */
 	autofs4_force_release(sbi);
@@ -333,8 +337,9 @@ int autofs4_fill_super(struct super_bloc
 	mutex_init(&sbi->wq_mutex);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
-	spin_lock_init(&sbi->rehash_lock);
-	INIT_LIST_HEAD(&sbi->rehash_list);
+	spin_lock_init(&sbi->lookup_lock);
+	INIT_LIST_HEAD(&sbi->active_list);
+	INIT_LIST_HEAD(&sbi->expiring_list);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
--- linux-2.6.24.orig/fs/compat_ioctl.c
+++ linux-2.6.24/fs/compat_ioctl.c
@@ -2384,8 +2384,6 @@ COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOVER)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE)
 COMPATIBLE_IOCTL(AUTOFS_IOC_EXPIRE_MULTI)
 COMPATIBLE_IOCTL(AUTOFS_IOC_PROTOSUBVER)
-COMPATIBLE_IOCTL(AUTOFS_IOC_ASKREGHOST)
-COMPATIBLE_IOCTL(AUTOFS_IOC_TOGGLEREGHOST)
 COMPATIBLE_IOCTL(AUTOFS_IOC_ASKUMOUNT)
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
--- linux-2.6.24.orig/include/linux/auto_fs4.h
+++ linux-2.6.24/include/linux/auto_fs4.h
@@ -98,8 +98,6 @@ union autofs_v5_packet_union {
 #define AUTOFS_IOC_EXPIRE_INDIRECT	AUTOFS_IOC_EXPIRE_MULTI
 #define AUTOFS_IOC_EXPIRE_DIRECT	AUTOFS_IOC_EXPIRE_MULTI
 #define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93,0x67,int)
-#define AUTOFS_IOC_ASKREGHOST           _IOR(0x93,0x68,int)
-#define AUTOFS_IOC_TOGGLEREGHOST        _IOR(0x93,0x69,int)
 #define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93,0x70,int)
