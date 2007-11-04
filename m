From: Ian Kent <raven@themaw.net>
Subject: Re: Attempt on mounting a non-existing directory
Date: Sun, 04 Nov 2007 13:47:07 +0900
Message-ID: <1194151627.3112.13.camel@raven.themaw.net>
References: <20071101101633.GJ30850@math.leidenuniv.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20071101101633.GJ30850@math.leidenuniv.nl>
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
To: Xiwen Cheng <xcheng@math.leidenuniv.nl>
Cc: autofs@linux.kernel.org

On Thu, 2007-11-01 at 11:16 +0100, Xiwen Cheng wrote:
> Recently we migrated from static nfs mounts to autofs on our webserver.
> This concerns all /home/*/public_html/ directories which are mounted
> read-only by default. /etc/autofs/auto.home includes some exceptions
> whereas certain users requested their ~/public_html or even ~/ to be
> writable. 
> 
> This setup works _almost_ all the time although syslog reveals some
> extremely strange behaviors, a snippet:
> 
> Oct 31 17:38:02 host1 automount[14335]: mount(nfs): nfs: mount failure
> nfs.somewhere.com:/home/user/.bash_profile/public_html on
> /home/user/.bash_profile/public_html
> 
> There are numerous similair failures including normal webserver
> requests. The above sample was the result of a "su - user" if anyone
> wonders.
> 
> The big question mark is: Why does autofs try to mount ~/public_html one
> threshold/level lower? It shouldn't look any further than
> /home/anyuser/public_html.  
> ~/public_html  
> 
> Server info
> ===========
> OS:			2.6.19-gentoo-r5

I don't know what additional autofs4 patches may be included in this
kernel but here is the patch for the 2.6.19 upstream kernel.

Can you give this a try and see if it applies cleanly and check if it
resolves the problem please.

The other difficulty you face is that 4.1.3 is an old release and many
things have been fixed in following releases. Lets see how this goes.

---
diff -Nurp linux-2.6.19.orig/fs/autofs/inode.c linux-2.6.19/fs/autofs/inode.c
--- linux-2.6.19.orig/fs/autofs/inode.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/fs/autofs/inode.c	2007-11-04 12:47:47.000000000 +0900
@@ -28,10 +28,11 @@ void autofs_kill_sb(struct super_block *
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
 	 * info is not present so nothing else has been setup, so
-	 * just exit when we are called from deactivate_super.
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
 	 */
 	if (!sbi)
-		return;
+		goto out_kill_sb;
 
 	if ( !sbi->catatonic )
 		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
@@ -44,6 +45,7 @@ void autofs_kill_sb(struct super_block *
 
 	kfree(sb->s_fs_info);
 
+out_kill_sb:
 	DPRINTK(("autofs: shutting down\n"));
 	kill_anon_super(sb);
 }
@@ -209,7 +211,6 @@ fail_iput:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }
diff -Nurp linux-2.6.19.orig/fs/autofs4/autofs_i.h linux-2.6.19/fs/autofs4/autofs_i.h
--- linux-2.6.19.orig/fs/autofs4/autofs_i.h	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/fs/autofs4/autofs_i.h	2007-11-04 12:47:47.000000000 +0900
@@ -52,6 +52,8 @@ struct autofs_info {
 
 	int		flags;
 
+	struct list_head rehash;
+
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
 	atomic_t count;
@@ -110,6 +112,8 @@ struct autofs_sb_info {
 	struct mutex wq_mutex;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
+	spinlock_t rehash_lock;
+	struct list_head rehash_list;
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
diff -Nurp linux-2.6.19.orig/fs/autofs4/inode.c linux-2.6.19/fs/autofs4/inode.c
--- linux-2.6.19.orig/fs/autofs4/inode.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/fs/autofs4/inode.c	2007-11-04 12:47:47.000000000 +0900
@@ -48,6 +48,8 @@ struct autofs_info *autofs4_init_ino(str
 	ino->dentry = NULL;
 	ino->size = 0;
 
+	INIT_LIST_HEAD(&ino->rehash);
+
 	ino->last_used = jiffies;
 	atomic_set(&ino->count, 0);
 
@@ -152,21 +154,22 @@ void autofs4_kill_sb(struct super_block 
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
 	 * info is not present so nothing else has been setup, so
-	 * just exit when we are called from deactivate_super.
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
 	 */
 	if (!sbi)
-		return;
+		goto out_kill_sb;
 
-	sb->s_fs_info = NULL;
-
-	if ( !sbi->catatonic )
+	if (!sbi->catatonic)
 		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
 	/* Clean up and release dangling references */
 	autofs4_force_release(sbi);
 
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
+out_kill_sb:
 	DPRINTK("shutting down");
 	kill_anon_super(sb);
 }
@@ -334,6 +337,8 @@ int autofs4_fill_super(struct super_bloc
 	mutex_init(&sbi->wq_mutex);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
+	spin_lock_init(&sbi->rehash_lock);
+	INIT_LIST_HEAD(&sbi->rehash_list);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
@@ -426,7 +431,6 @@ fail_ino:
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
-	kill_anon_super(s);
 fail_unlock:
 	return -EINVAL;
 }
diff -Nurp linux-2.6.19.orig/fs/autofs4/root.c linux-2.6.19/fs/autofs4/root.c
--- linux-2.6.19.orig/fs/autofs4/root.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/fs/autofs4/root.c	2007-11-04 12:47:47.000000000 +0900
@@ -263,7 +263,7 @@ static int try_to_fill_dentry(struct den
 		 */
 		status = d_invalidate(dentry);
 		if (status != -EBUSY)
-			return -ENOENT;
+			return -EAGAIN;
 	}
 
 	DPRINTK("dentry=%p %.*s ino=%p",
@@ -413,7 +413,16 @@ static int autofs4_revalidate(struct den
 		 */
 		status = try_to_fill_dentry(dentry, flags);
 		if (status == 0)
-				return 1;
+			return 1;
+
+		/*
+		 * A status of EAGAIN here means that the dentry has gone
+		 * away while waiting for an expire to complete. If we are
+		 * racing with expire lookup will wait for it so this must
+		 * be a revalidate and we need to send it to lookup.
+		 */
+		if (status == -EAGAIN)
+			return 0;
 
 		return status;
 	}
@@ -459,6 +468,15 @@ void autofs4_dentry_release(struct dentr
 	de->d_fsdata = NULL;
 
 	if (inf) {
+		struct autofs_sb_info *sbi = autofs4_sbi(de->d_sb);
+
+		if (sbi) {
+			spin_lock(&sbi->rehash_lock);
+			if (!list_empty(&inf->rehash))
+				list_del(&inf->rehash);
+			spin_unlock(&sbi->rehash_lock);
+		}
+
 		inf->dentry = NULL;
 		inf->inode = NULL;
 
@@ -478,10 +496,80 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
+static struct dentry *autofs4_lookup_unhashed(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
+{
+	unsigned int len = name->len;
+	unsigned int hash = name->hash;
+	const unsigned char *str = name->name;
+	struct list_head *p, *head;
+
+	spin_lock(&dcache_lock);
+	spin_lock(&sbi->rehash_lock);
+	head = &sbi->rehash_list;
+	list_for_each(p, head) {
+		struct autofs_info *ino;
+		struct dentry *dentry;
+		struct qstr *qstr;
+
+		ino = list_entry(p, struct autofs_info, rehash);
+		dentry = ino->dentry;
+
+		spin_lock(&dentry->d_lock);
+
+		/* Bad luck, we've already been dentry_iput */
+		if (!dentry->d_inode)
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
+			struct autofs_info *ino = autofs4_dentry_ino(dentry);
+			struct inode *inode = dentry->d_inode;
+
+			list_del_init(&ino->rehash);
+			dget(dentry);
+			/*
+			 * Make the rehashed dentry negative so the VFS
+			 * behaves as it should.
+			 */
+			if (inode) {
+				dentry->d_inode = NULL;
+				list_del_init(&dentry->d_alias);
+				spin_unlock(&dentry->d_lock);
+				spin_unlock(&sbi->rehash_lock);
+				spin_unlock(&dcache_lock);
+				iput(inode);
+				return dentry;
+			}
+			spin_unlock(&dentry->d_lock);
+			spin_unlock(&sbi->rehash_lock);
+			spin_unlock(&dcache_lock);
+			return dentry;
+		}
+next:
+		spin_unlock(&dentry->d_lock);
+	}
+	spin_unlock(&sbi->rehash_lock);
+	spin_unlock(&dcache_lock);
+
+	return NULL;
+}
+
 /* Lookups in the root directory */
 static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
+	struct dentry *unhashed;
 	int oz_mode;
 
 	DPRINTK("name = %.*s",
@@ -497,25 +585,49 @@ static struct dentry *autofs4_lookup(str
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
+	unhashed = autofs4_lookup_unhashed(sbi, dentry->d_parent, &dentry->d_name);
+	if (!unhashed) {
+		/*
+		 * Mark the dentry incomplete but don't hash it. We do this 
+		 * to serialize our inode creation operations (symlink and
+		 * mkdir) which prevents deadlock during the callback to
+		 * the daemon. Subsequent user space lookups for the same
+		 * dentry are placed on the wait queue while the daemon
+		 * itself is allowed passage unresticted so the create
+		 * operation itself can then hash the dentry. Finally,
+		 * we check for the hashed dentry and return the newly
+		 * hashed dentry.
+		 */
+		dentry->d_op = &autofs4_root_dentry_operations;
+
+		dentry->d_fsdata = NULL;
+		d_instantiate(dentry, NULL);
+	} else {
+		struct autofs_info *ino = autofs4_dentry_ino(unhashed);
+		DPRINTK("rehash %p with %p", dentry, unhashed);
+		/*
+		 * If we are racing with expire the request might not
+		 * be quite complete but the directory has been removed
+		 * so it must have been successful, so just wait for it.
+		 * We need to ensure the AUTOFS_INF_EXPIRING flag is clear
+		 * before continuing as revalidate may fail when calling
+		 * try_to_fill_dentry (returning EAGAIN) if we don't.
+		 */
+		while (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
+			DPRINTK("wait for incomplete expire %p name=%.*s",
+				unhashed, unhashed->d_name.len,
+				unhashed->d_name.name);
+			autofs4_wait(sbi, unhashed, NFY_NONE);
+			DPRINTK("request completed");
+		}
+		dentry = unhashed;
+	}
 
 	if (!oz_mode) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
 		spin_unlock(&dentry->d_lock);
 	}
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
 
 	if (dentry->d_op && dentry->d_op->d_revalidate) {
 		mutex_unlock(&dir->i_mutex);
@@ -534,6 +646,8 @@ static struct dentry *autofs4_lookup(str
 			if (sigismember (sigset, SIGKILL) ||
 			    sigismember (sigset, SIGQUIT) ||
 			    sigismember (sigset, SIGINT)) {
+			    if (unhashed)
+				dput(unhashed);
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
@@ -544,12 +658,33 @@ static struct dentry *autofs4_lookup(str
 
 	/*
 	 * If this dentry is unhashed, then we shouldn't honour this
-	 * lookup even if the dentry is positive.  Returning ENOENT here
-	 * doesn't do the right thing for all system calls, but it should
-	 * be OK for the operations we permit from an autofs.
+	 * lookup.  Returning ENOENT here doesn't do the right thing
+	 * for all system calls, but it should be OK for the operations
+	 * we permit from an autofs.
 	 */
-	if (dentry->d_inode && d_unhashed(dentry))
-		return ERR_PTR(-ENOENT);
+	if (!oz_mode && d_unhashed(dentry)) {
+		/*
+		 * A user space application can (and has done in the past)
+		 * remove and re-create this directory during the callback.
+		 * This can leave us with an unhashed dentry, but a
+		 * successful mount!  So we need to perform another
+		 * cached lookup in case the dentry now exists.
+		 */
+		struct dentry *parent = dentry->d_parent;
+		struct dentry *new = d_lookup(parent, &dentry->d_name);
+		if (new != NULL)
+			dentry = new;
+		else
+			dentry = ERR_PTR(-ENOENT);
+
+		if (unhashed)
+			dput(unhashed);
+
+		return dentry;
+	}
+
+	if (unhashed)
+		return dentry;
 
 	return NULL;
 }
@@ -585,7 +720,7 @@ static int autofs4_dir_symlink(struct in
 	strcpy(cp, symname);
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
 		dentry->d_op = &autofs4_root_dentry_operations;
@@ -611,9 +746,10 @@ static int autofs4_dir_symlink(struct in
  * Normal filesystems would do a "d_delete()" to tell the VFS dcache
  * that the file no longer exists. However, doing that means that the
  * VFS layer can turn the dentry into a negative dentry.  We don't want
- * this, because since the unlink is probably the result of an expire.
- * We simply d_drop it, which allows the dentry lookup to remount it
- * if necessary.
+ * this, because the unlink is probably the result of an expire.
+ * We simply d_drop it and add it to a rehash candidates list in the
+ * super block, which allows the dentry lookup to reuse it retaining
+ * the flags, such as expire in progress, in case we're racing with expire.
  *
  * If a process is blocked on the dentry waiting for the expire to finish,
  * it will invalidate the dentry and try to mount with a new one.
@@ -642,7 +778,14 @@ static int autofs4_dir_unlink(struct ino
 
 	dir->i_mtime = CURRENT_TIME;
 
-	d_drop(dentry);
+	spin_lock(&dcache_lock);
+	spin_lock(&sbi->rehash_lock);
+	list_add(&ino->rehash, &sbi->rehash_list);
+	spin_unlock(&sbi->rehash_lock);
+	spin_lock(&dentry->d_lock);
+	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
+	spin_unlock(&dcache_lock);
 
 	return 0;
 }
@@ -653,6 +796,9 @@ static int autofs4_dir_rmdir(struct inod
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	
+	DPRINTK("dentry %p, removing %.*s",
+		dentry, dentry->d_name.len, dentry->d_name.name);
+
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
 
@@ -661,6 +807,9 @@ static int autofs4_dir_rmdir(struct inod
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
+	spin_lock(&sbi->rehash_lock);
+	list_add(&ino->rehash, &sbi->rehash_list);
+	spin_unlock(&sbi->rehash_lock);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -699,7 +848,7 @@ static int autofs4_dir_mkdir(struct inod
 		return -ENOSPC;
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
 		dentry->d_op = &autofs4_root_dentry_operations;
diff -Nurp linux-2.6.19.orig/fs/autofs4/waitq.c linux-2.6.19/fs/autofs4/waitq.c
--- linux-2.6.19.orig/fs/autofs4/waitq.c	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/fs/autofs4/waitq.c	2007-11-04 12:47:47.000000000 +0900
@@ -84,7 +84,11 @@ static void autofs4_notify_daemon(struct
 				 struct autofs_wait_queue *wq,
 				 int type)
 {
-	union autofs_packet_union pkt;
+	union {
+		struct autofs_packet_hdr hdr;
+		union autofs_packet_union v4_pkt;
+		union autofs_v5_packet_union v5_pkt;
+	} pkt;
 	size_t pktsz;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
@@ -98,7 +102,7 @@ static void autofs4_notify_daemon(struct
 	/* Kernel protocol v4 missing and expire packets */
 	case autofs_ptype_missing:
 	{
-		struct autofs_packet_missing *mp = &pkt.missing;
+		struct autofs_packet_missing *mp = &pkt.v4_pkt.missing;
 
 		pktsz = sizeof(*mp);
 
@@ -110,7 +114,7 @@ static void autofs4_notify_daemon(struct
 	}
 	case autofs_ptype_expire_multi:
 	{
-		struct autofs_packet_expire_multi *ep = &pkt.expire_multi;
+		struct autofs_packet_expire_multi *ep = &pkt.v4_pkt.expire_multi;
 
 		pktsz = sizeof(*ep);
 
@@ -129,7 +133,7 @@ static void autofs4_notify_daemon(struct
 	case autofs_ptype_missing_direct:
 	case autofs_ptype_expire_direct:
 	{
-		struct autofs_v5_packet *packet = &pkt.v5_packet;
+		struct autofs_v5_packet *packet = &pkt.v5_pkt.v5_packet;
 
 		pktsz = sizeof(*packet);
 
diff -Nurp linux-2.6.19.orig/include/linux/auto_fs4.h linux-2.6.19/include/linux/auto_fs4.h
--- linux-2.6.19.orig/include/linux/auto_fs4.h	2006-11-30 05:57:37.000000000 +0800
+++ linux-2.6.19/include/linux/auto_fs4.h	2007-11-04 12:47:47.000000000 +0900
@@ -59,6 +59,13 @@ struct autofs_packet_expire_multi {
 	char name[NAME_MAX+1];
 };
 
+union autofs_packet_union {
+	struct autofs_packet_hdr hdr;
+	struct autofs_packet_missing missing;
+	struct autofs_packet_expire expire;
+	struct autofs_packet_expire_multi expire_multi;
+};
+
 /* autofs v5 common packet struct */
 struct autofs_v5_packet {
 	struct autofs_packet_hdr hdr;
@@ -78,12 +85,13 @@ typedef struct autofs_v5_packet autofs_p
 typedef struct autofs_v5_packet autofs_packet_missing_direct_t;
 typedef struct autofs_v5_packet autofs_packet_expire_direct_t;
 
-union autofs_packet_union {
+union autofs_v5_packet_union {
 	struct autofs_packet_hdr hdr;
-	struct autofs_packet_missing missing;
-	struct autofs_packet_expire expire;
-	struct autofs_packet_expire_multi expire_multi;
 	struct autofs_v5_packet v5_packet;
+	autofs_packet_missing_indirect_t missing_indirect;
+	autofs_packet_expire_indirect_t expire_indirect;
+	autofs_packet_missing_direct_t missing_direct;
+	autofs_packet_expire_direct_t expire_direct;
 };
 
 #define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93,0x66,int)
