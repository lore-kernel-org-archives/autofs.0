From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 patches for older kernels
Date: Mon, 26 Nov 2007 11:09:43 +0900
Message-ID: <1196042983.3143.9.camel@raven.themaw.net>
References: <472F2856.6090701@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <472F2856.6090701@kmaclub.com>
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
To: Michael <michael@kmaclub.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-11-05 at 07:27 -0700, Michael wrote:
> Hello,
> 
> I am running an older SuSE SLES9 release.  It ships with autofs-4.1.3 
> with a 2.6.5 kernel.
> 
> We are having a number of issues with the automount daemon dying on 
> certain mounts, failing to be responsive, etc in a rather large 
> environment. 
> 
> We would like to upgrade to autofs5 but the kernel shipped ( 2.6.5 ) 
> doesn't include support for autofs5 or a great number of patches that 
> have gone into 2.6.16+ kernels.
> 
> Is anyone maintaining a current autofs patch set against older 2.6.x 
> kernels?

Here is a first attempt at a version 5 update for 2.6.5.

I'm not sure this will even compile because the 2.6.5 compile fails
early on so I can't test it.

Not also that the patch is against the standard released 2.6.5 and
includes a couple of VFS changes. If there are any vendor changes they
could cause the patch to not apply to the kernel.

Ian

---
diff -Nurp linux-2.6.5.orig/fs/autofs/autofs_i.h linux-2.6.5/fs/autofs/autofs_i.h
--- linux-2.6.5.orig/fs/autofs/autofs_i.h	2004-04-04 11:37:37.000000000 +0800
+++ linux-2.6.5/fs/autofs/autofs_i.h	2007-11-25 17:01:09.000000000 +0900
@@ -150,6 +150,7 @@ extern struct file_operations autofs_roo
 /* Initializing function */
 
 int autofs_fill_super(struct super_block *, void *, int);
+void autofs_kill_sb(struct super_block *);
 
 /* Queue management functions */
 
diff -Nurp linux-2.6.5.orig/fs/autofs/dirhash.c linux-2.6.5/fs/autofs/dirhash.c
--- linux-2.6.5.orig/fs/autofs/dirhash.c	2004-04-04 11:36:17.000000000 +0800
+++ linux-2.6.5/fs/autofs/dirhash.c	2007-11-25 17:01:09.000000000 +0900
@@ -92,7 +92,7 @@ struct autofs_dir_ent *autofs_expire(str
 			;
 		dput(dentry);
 
-		if ( may_umount(mnt) == 0 ) {
+		if ( may_umount(mnt) ) {
 			mntput(mnt);
 			DPRINTK(("autofs: signaling expire on %s\n", ent->name));
 			return ent; /* Expirable! */
diff -Nurp linux-2.6.5.orig/fs/autofs/init.c linux-2.6.5/fs/autofs/init.c
--- linux-2.6.5.orig/fs/autofs/init.c	2004-04-04 11:37:36.000000000 +0800
+++ linux-2.6.5/fs/autofs/init.c	2007-11-25 17:01:09.000000000 +0900
@@ -24,7 +24,7 @@ static struct file_system_type autofs_fs
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.get_sb		= autofs_get_sb,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= autofs_kill_sb,
 };
 
 static int __init init_autofs_fs(void)
diff -Nurp linux-2.6.5.orig/fs/autofs/inode.c linux-2.6.5/fs/autofs/inode.c
--- linux-2.6.5.orig/fs/autofs/inode.c	2004-04-04 11:37:38.000000000 +0800
+++ linux-2.6.5/fs/autofs/inode.c	2007-11-25 17:01:09.000000000 +0900
@@ -19,11 +19,20 @@
 #include "autofs_i.h"
 #include <linux/module.h>
 
-static void autofs_put_super(struct super_block *sb)
+void autofs4_kill_sb(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(sb);
 	unsigned int n;
 
+	/*
+	 * In the event of a failure in get_sb_nodev the superblock
+	 * info is not present so nothing else has been setup, so
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
+	 */
+	if (!sbi)
+		goto out_kill_sb;
+
 	if ( !sbi->catatonic )
 		autofs_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
@@ -35,14 +44,15 @@ static void autofs_put_super(struct supe
 
 	kfree(sb->s_fs_info);
 
+out_kill_sb:
 	DPRINTK(("autofs: shutting down\n"));
+	kill_anon_super(sb);
 }
 
 static void autofs_read_inode(struct inode *inode);
 
 static struct super_operations autofs_sops = {
 	.read_inode	= autofs_read_inode,
-	.put_super	= autofs_put_super,
 	.statfs		= simple_statfs,
 };
 
@@ -136,7 +146,8 @@ int autofs_fill_super(struct super_block
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->catatonic = 0;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	autofs_initialize_hash(&sbi->dirhash);
@@ -178,6 +189,7 @@ int autofs_fill_super(struct super_block
 	if ( !pipe->f_op || !pipe->f_op->write )
 		goto fail_fput;
 	sbi->pipe = pipe;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
@@ -196,6 +208,7 @@ fail_iput:
 	iput(root_inode);
 fail_free:
 	kfree(sbi);
+	s->s_fs_info = NULL;
 fail_unlock:
 	return -EINVAL;
 }
diff -Nurp linux-2.6.5.orig/fs/autofs/waitq.c linux-2.6.5/fs/autofs/waitq.c
--- linux-2.6.5.orig/fs/autofs/waitq.c	2004-04-04 11:36:26.000000000 +0800
+++ linux-2.6.5/fs/autofs/waitq.c	2007-11-25 17:01:09.000000000 +0900
@@ -41,6 +41,7 @@ void autofs_catatonic_mode(struct autofs
 		wq = nwq;
 	}
 	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 	autofs_hash_dputall(&sbi->dirhash); /* Remove all dentry pointers */
 }
 
diff -Nurp linux-2.6.5.orig/fs/autofs4/autofs_i.h linux-2.6.5/fs/autofs4/autofs_i.h
--- linux-2.6.5.orig/fs/autofs4/autofs_i.h	2004-04-04 11:37:36.000000000 +0800
+++ linux-2.6.5/fs/autofs4/autofs_i.h	2007-11-25 17:01:09.000000000 +0900
@@ -3,6 +3,7 @@
  * linux/fs/autofs/autofs_i.h
  *
  *   Copyright 1997-1998 Transmeta Corporation - All Rights Reserved
+ *   Copyright 2005-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -25,27 +26,21 @@
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
 #include <asm/current.h>
 #include <asm/uaccess.h>
 
 /* #define DEBUG */
 
 #ifdef DEBUG
-#define DPRINTK(D) do{ printk("pid %d: ", current->pid); printk D; } while(0)
+#define DPRINTK(fmt,args...) do { printk(KERN_DEBUG "pid %d: %s: " fmt "\n" , current->pid , __FUNCTION__ , ##args); } while(0)
 #else
-#define DPRINTK(D) do {} while(0)
+#define DPRINTK(fmt,args...) do {} while(0)
 #endif
 
 #define AUTOFS_SUPER_MAGIC 0x0187
 
-/*
- * If the daemon returns a negative response (AUTOFS_IOC_FAIL) then the
- * kernel will keep the negative response cached for up to the time given
- * here, although the time can be shorter if the kernel throws the dcache
- * entry away.  This probably should be settable from user space.
- */
-#define AUTOFS_NEGATIVE_TIMEOUT (60*HZ)	/* 1 minute */
-
 /* Unified info structure.  This is pointed to by both the dentry and
    inode structures.  Each file in the filesystem has an instance of this
    structure.  It holds a reference to the dentry, so dentries are never
@@ -58,8 +53,11 @@ struct autofs_info {
 
 	int		flags;
 
+	struct list_head rehash;
+
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
+	atomic_t count;
 
 	mode_t	mode;
 	size_t	size;
@@ -77,25 +75,46 @@ struct autofs_wait_queue {
 	struct autofs_wait_queue *next;
 	autofs_wqt_t wait_queue_token;
 	/* We use the following to see what we are waiting for */
-	int hash;
-	int len;
+	unsigned int hash;
+	unsigned int len;
 	char *name;
+	u32 dev;
+	u64 ino;
+	uid_t uid;
+	gid_t gid;
+	pid_t pid;
+	pid_t tgid;
 	/* This is for status reporting upon return */
 	int status;
-	int wait_ctr;
+	atomic_t wait_ctr;
 };
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
+#define AUTOFS_TYPE_INDIRECT     0x0001
+#define AUTOFS_TYPE_DIRECT       0x0002
+#define AUTOFS_TYPE_OFFSET       0x0004
+
 struct autofs_sb_info {
 	u32 magic;
+	int pipefd;
 	struct file *pipe;
 	pid_t oz_pgrp;
 	int catatonic;
 	int version;
+	int sub_version;
+	int min_proto;
+	int max_proto;
 	unsigned long exp_timeout;
+	unsigned int type;
+	int reghost_enabled;
+	int needs_reghost;
 	struct super_block *sb;
+	struct semaphore wq_sem;
+	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
+	spinlock_t rehash_lock;
+	struct list_head rehash_list;
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
@@ -120,27 +139,45 @@ static inline int autofs4_oz_mode(struct
 static inline int autofs4_ispending(struct dentry *dentry)
 {
 	struct autofs_info *inf = autofs4_dentry_ino(dentry);
+	int pending = 0;
+
+	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
+		return 1;
 
-	return (dentry->d_flags & DCACHE_AUTOFS_PENDING) ||
-		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
+	if (inf) {
+		spin_lock(&inf->sbi->fs_lock);
+		pending = inf->flags & AUTOFS_INF_EXPIRING;
+		spin_unlock(&inf->sbi->fs_lock);
+	}
+
+	return pending;
+}
+
+static inline void autofs4_copy_atime(struct file *src, struct file *dst)
+{
+	dst->f_dentry->d_inode->i_atime = src->f_dentry->d_inode->i_atime;
+	return;
 }
 
 struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
-struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
 void autofs4_free_ino(struct autofs_info *);
 
 /* Expiration */
 int is_autofs4_dentry(struct dentry *);
 int autofs4_expire_run(struct super_block *, struct vfsmount *,
-			struct autofs_sb_info *, struct autofs_packet_expire *);
+			struct autofs_sb_info *,
+			struct autofs_packet_expire __user *);
 int autofs4_expire_multi(struct super_block *, struct vfsmount *,
-			struct autofs_sb_info *, int *);
+			struct autofs_sb_info *, int __user *);
 
 /* Operations structures */
 
 extern struct inode_operations autofs4_symlink_inode_operations;
 extern struct inode_operations autofs4_dir_inode_operations;
 extern struct inode_operations autofs4_root_inode_operations;
+extern struct inode_operations autofs4_indirect_root_inode_operations;
+extern struct inode_operations autofs4_direct_root_inode_operations;
+extern struct file_operations autofs4_dir_operations;
 extern struct file_operations autofs4_root_operations;
 
 /* Initializing function */
@@ -150,13 +187,50 @@ struct autofs_info *autofs4_init_ino(str
 
 /* Queue management functions */
 
-enum autofs_notify
-{
-	NFY_NONE,
-	NFY_MOUNT,
-	NFY_EXPIRE
-};
-
-int autofs4_wait(struct autofs_sb_info *,struct qstr *, enum autofs_notify);
+int autofs4_wait(struct autofs_sb_info *,struct dentry *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
+
+static inline int autofs4_follow_mount(struct vfsmount **mnt, struct dentry **dentry)
+{
+	int res = 0;
+
+	while (d_mountpoint(*dentry)) {
+		int followed = follow_down(mnt, dentry);
+		if (!followed)
+			break;
+		res = 1;
+	}
+	return res;
+}
+
+static inline u32 autofs4_get_dev(struct autofs_sb_info *sbi)
+{
+	return new_encode_dev(sbi->sb->s_dev);
+}
+
+static inline u64 autofs4_get_ino(struct autofs_sb_info *sbi)
+{
+	return sbi->sb->s_root->d_inode->i_ino;
+}
+
+static inline int simple_positive(struct dentry *dentry)
+{
+	return dentry->d_inode && !d_unhashed(dentry);
+}
+
+static inline int __simple_empty(struct dentry *dentry)
+{
+	struct dentry *child;
+	int ret = 0;
+
+	list_for_each_entry(child, &dentry->d_subdirs, d_child)
+		if (simple_positive(child))
+			goto out;
+	ret = 1;
+out:
+	return ret;
+}
+
+void autofs4_dentry_release(struct dentry *);
+extern void autofs4_kill_sb(struct super_block *);
diff -Nurp linux-2.6.5.orig/fs/autofs4/expire.c linux-2.6.5/fs/autofs4/expire.c
--- linux-2.6.5.orig/fs/autofs4/expire.c	2004-04-04 11:37:36.000000000 +0800
+++ linux-2.6.5/fs/autofs4/expire.c	2007-11-25 17:01:09.000000000 +0900
@@ -4,6 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -12,139 +13,266 @@
  * ------------------------------------------------------------------------- */
 
 #include "autofs_i.h"
-#include <linux/mount.h>
 
-/*
- * Determine if a subtree of the namespace is busy.
- *
- * mnt is the mount tree under the autofs mountpoint
- */
-static inline int is_vfsmnt_tree_busy(struct vfsmount *mnt)
-{
-	struct vfsmount *this_parent = mnt;
-	struct list_head *next;
-	int count;
+static unsigned long now;
 
-	count = atomic_read(&mnt->mnt_count) - 1;
+/* Check if a dentry can be expired */
+static inline int autofs4_can_expire(struct dentry *dentry,
+					unsigned long timeout, int do_now)
+{
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
-repeat:
-	next = this_parent->mnt_mounts.next;
-	DPRINTK(("is_vfsmnt_tree_busy: mnt=%p, this_parent=%p, next=%p\n",
-		 mnt, this_parent, next));
-resume:
-	for( ; next != &this_parent->mnt_mounts; next = next->next) {
-		struct vfsmount *p = list_entry(next, struct vfsmount,
-						mnt_child);
-
-		/* -1 for struct vfs_mount's normal count, 
-		   -1 to compensate for child's reference to parent */
-		count += atomic_read(&p->mnt_count) - 1 - 1;
-
-		DPRINTK(("is_vfsmnt_tree_busy: p=%p, count now %d\n",
-			 p, count));
-
-		if (!list_empty(&p->mnt_mounts)) {
-			this_parent = p;
-			goto repeat;
-		}
-		/* root is busy if any leaf is busy */
-		if (atomic_read(&p->mnt_count) > 1)
-			return 1;
+	/* dentry in the process of being deleted */
+	if (ino == NULL)
+		return 0;
+
+	/* No point expiring a pending mount */
+	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
+		return 0;
+
+	if (!do_now) {
+		/* Too young to die */
+		if (time_after(ino->last_used + timeout, now))
+			return 0;
+
+		/* update last_used here :-
+		   - obviously makes sense if it is in use now
+		   - less obviously, prevents rapid-fire expire
+		     attempts if expire fails the first time */
+		ino->last_used = now;
 	}
+	return 1;
+}
 
-	/* All done at this level ... ascend and resume the search. */
-	if (this_parent != mnt) {
-		next = this_parent->mnt_child.next; 
-		this_parent = this_parent->mnt_parent;
-		goto resume;
+/* Check a mount point for busyness */
+static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
+{
+	struct dentry *top = dentry;
+	int status = 1;
+
+	DPRINTK("dentry %p %.*s",
+		dentry, (int)dentry->d_name.len, dentry->d_name.name);
+
+	mntget(mnt);
+	dget(dentry);
+
+	if (!autofs4_follow_mount(&mnt, &dentry))
+		goto done;
+
+	/* This is an autofs submount, we can't expire it */
+	if (is_autofs4_dentry(dentry))
+		goto done;
+
+	/* Update the expiry counter if fs is busy */
+	if (!may_umount_tree(mnt)) {
+		struct autofs_info *ino = autofs4_dentry_ino(top);
+		ino->last_used = jiffies;
+		goto done;
 	}
 
-	DPRINTK(("is_vfsmnt_tree_busy: count=%d\n", count));
-	return count != 0; /* remaining users? */
+	status = 0;
+done:
+	DPRINTK("returning = %d", status);
+	mntput(mnt);
+	dput(dentry);
+	return status;
 }
 
-/* Traverse a dentry's list of vfsmounts and return the number of
-   non-busy mounts */
-static int check_vfsmnt(struct vfsmount *mnt, struct dentry *dentry)
+/*
+ * Calculate next entry in top down tree traversal.
+ * From next_mnt in namespace.c - elegant.
+ */
+static struct dentry *next_dentry(struct dentry *p, struct dentry *root)
 {
-	int ret = dentry->d_mounted;
-	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
+	struct list_head *next = p->d_subdirs.next;
 
-	if (vfs) {
-		mntput(vfs);
-		if (is_vfsmnt_tree_busy(vfs))
-			ret--;
+	if (next == &p->d_subdirs) {
+		while (1) {
+			if (p == root)
+				return NULL;
+			next = p->d_child.next;
+			if (next != &p->d_parent->d_subdirs)
+				break;
+			p = p->d_parent;
+		}
 	}
-	DPRINTK(("check_vfsmnt: ret=%d\n", ret));
-	return ret;
+	return list_entry(next, struct dentry, d_child);
 }
 
-/* Check dentry tree for busyness.  If a dentry appears to be busy
-   because it is a mountpoint, check to see if the mounted
-   filesystem is busy. */
-static int is_tree_busy(struct vfsmount *topmnt, struct dentry *top)
+/*
+ * Check a direct mount point for busyness.
+ * Direct mounts have similar expiry semantics to tree mounts.
+ * The tree is not busy iff no mountpoints are busy and there are no
+ * autofs submounts.
+ */
+static int autofs4_direct_busy(struct vfsmount *mnt,
+				struct dentry *top,
+				unsigned long timeout,
+				int do_now)
 {
-	struct dentry *this_parent;
-	struct list_head *next;
-	int count;
+	DPRINTK("top %p %.*s",
+		top, (int) top->d_name.len, top->d_name.name);
 
-	count = atomic_read(&top->d_count);
-	
-	DPRINTK(("is_tree_busy: top=%p initial count=%d\n", 
-		 top, count));
-	this_parent = top;
-
-	if (is_autofs4_dentry(top)) {
-		count--;
-		DPRINTK(("is_tree_busy: autofs; count=%d\n", count));
+	/* If it's busy update the expiry counters */
+	if (!may_umount_tree(mnt)) {
+		struct autofs_info *ino = autofs4_dentry_ino(top);
+		if (ino)
+			ino->last_used = jiffies;
+		return 1;
 	}
 
-	if (d_mountpoint(top))
-		count -= check_vfsmnt(topmnt, top);
+	/* Timeout of a direct mount is determined by its top dentry */
+	if (!autofs4_can_expire(top, timeout, do_now))
+		return 1;
 
- repeat:
-	next = this_parent->d_subdirs.next;
- resume:
-	while (next != &this_parent->d_subdirs) {
-		int adj = 0;
-		struct dentry *dentry = list_entry(next, struct dentry,
-						   d_child);
-		next = next->next;
+	return 0;
+}
 
-		count += atomic_read(&dentry->d_count) - 1;
+/* Check a directory tree of mount points for busyness
+ * The tree is not busy iff no mountpoints are busy
+ */
+static int autofs4_tree_busy(struct vfsmount *mnt,
+	       		     struct dentry *top,
+			     unsigned long timeout,
+			     int do_now)
+{
+	struct autofs_info *top_ino = autofs4_dentry_ino(top);
+	struct dentry *p;
 
-		if (d_mountpoint(dentry))
-			adj += check_vfsmnt(topmnt, dentry);
+	DPRINTK("top %p %.*s",
+		top, (int)top->d_name.len, top->d_name.name);
 
-		if (is_autofs4_dentry(dentry)) {
-			adj++;
-			DPRINTK(("is_tree_busy: autofs; adj=%d\n",
-				 adj));
-		}
+	/* Negative dentry - give up */
+	if (!simple_positive(top))
+		return 1;
 
-		count -= adj;
+	spin_lock(&dcache_lock);
+	for (p = top; p; p = next_dentry(p, top)) {
+		/* Negative dentry - give up */
+		if (!simple_positive(p))
+			continue;
+
+		DPRINTK("dentry %p %.*s",
+			p, (int) p->d_name.len, p->d_name.name);
+
+		p = dget(p);
+		spin_unlock(&dcache_lock);
 
-		if (!list_empty(&dentry->d_subdirs)) {
-			this_parent = dentry;
-			goto repeat;
+		/*
+		 * Is someone visiting anywhere in the subtree ?
+		 * If there's no mount we need to check the usage
+		 * count for the autofs dentry.
+		 * If the fs is busy update the expiry counter.
+		 */
+		if (d_mountpoint(p)) {
+			if (autofs4_mount_busy(mnt, p)) {
+				top_ino->last_used = jiffies;
+				dput(p);
+				return 1;
+			}
+		} else {
+			struct autofs_info *ino = autofs4_dentry_ino(p);
+			unsigned int ino_count = atomic_read(&ino->count);
+
+			/*
+			 * Clean stale dentries below that have not been
+			 * invalidated after a mount fail during lookup
+			 */
+			d_invalidate(p);
+
+			/* allow for dget above and top is already dgot */
+			if (p == top)
+				ino_count += 2;
+			else
+				ino_count++;
+
+			if (atomic_read(&p->d_count) > ino_count) {
+				top_ino->last_used = jiffies;
+				dput(p);
+				return 1;
+			}
 		}
+		dput(p);
+		spin_lock(&dcache_lock);
+	}
+	spin_unlock(&dcache_lock);
 
-		if (atomic_read(&dentry->d_count) != adj) {
-			DPRINTK(("is_tree_busy: busy leaf (d_count=%d adj=%d)\n",
-				 atomic_read(&dentry->d_count), adj));
-			return 1;
+	/* Timeout of a tree mount is ultimately determined by its top dentry */
+	if (!autofs4_can_expire(top, timeout, do_now))
+		return 1;
+
+	return 0;
+}
+
+static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
+					   struct dentry *parent,
+					   unsigned long timeout,
+					   int do_now)
+{
+	struct dentry *p;
+
+	DPRINTK("parent %p %.*s",
+		parent, (int)parent->d_name.len, parent->d_name.name);
+
+	spin_lock(&dcache_lock);
+	for (p = parent; p; p = next_dentry(p, parent)) {
+		/* Negative dentry - give up */
+		if (!simple_positive(p))
+			continue;
+
+		DPRINTK("dentry %p %.*s",
+			p, (int) p->d_name.len, p->d_name.name);
+
+		p = dget(p);
+		spin_unlock(&dcache_lock);
+
+		if (d_mountpoint(p)) {
+			/* Can we umount this guy */
+			if (autofs4_mount_busy(mnt, p))
+				goto cont;
+
+			/* Can we expire this guy */
+			if (autofs4_can_expire(p, timeout, do_now))
+				return p;
 		}
+cont:
+		dput(p);
+		spin_lock(&dcache_lock);
 	}
+	spin_unlock(&dcache_lock);
+	return NULL;
+}
 
-	/* All done at this level ... ascend and resume the search. */
-	if (this_parent != top) {
-		next = this_parent->d_child.next; 
-		this_parent = this_parent->d_parent;
-		goto resume;
+/* Check if we can expire a direct mount (possibly a tree) */
+static struct dentry *autofs4_expire_direct(struct super_block *sb,
+					    struct vfsmount *mnt,
+					    struct autofs_sb_info *sbi,
+					    int how)
+{
+	unsigned long timeout;
+	struct dentry *root = dget(sb->s_root);
+	int do_now = how & AUTOFS_EXP_IMMEDIATE;
+
+	if (!sbi->exp_timeout || !root)
+		return NULL;
+
+	now = jiffies;
+	timeout = sbi->exp_timeout;
+
+	/* Lock the tree as we must expire as a whole */
+	spin_lock(&sbi->fs_lock);
+	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+		struct autofs_info *ino = autofs4_dentry_ino(root);
+
+		/* Set this flag early to catch sys_chdir and the like */
+		ino->flags |= AUTOFS_INF_EXPIRING;
+		spin_unlock(&sbi->fs_lock);
+		return root;
 	}
+	spin_unlock(&sbi->fs_lock);
+	dput(root);
 
-	DPRINTK(("is_tree_busy: count=%d\n", count));
-	return count != 0; /* remaining users? */
+	return NULL;
 }
 
 /*
@@ -153,64 +281,105 @@ static int is_tree_busy(struct vfsmount 
  *  - it is unused by any user process
  *  - it has been unused for exp_timeout time
  */
-static struct dentry *autofs4_expire(struct super_block *sb,
-				     struct vfsmount *mnt,
-				     struct autofs_sb_info *sbi,
-				     int do_now)
+static struct dentry *autofs4_expire_indirect(struct super_block *sb,
+					      struct vfsmount *mnt,
+					      struct autofs_sb_info *sbi,
+					      int how)
 {
-	unsigned long now = jiffies;
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
-	struct list_head *tmp;
+	struct dentry *expired = NULL;
+	struct list_head *next;
+	int do_now = how & AUTOFS_EXP_IMMEDIATE;
+	int exp_leaves = how & AUTOFS_EXP_LEAVES;
 
-	if (!sbi->exp_timeout || !root)
+	if ( !sbi->exp_timeout || !root )
 		return NULL;
 
+	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	spin_lock(&dcache_lock);
-	for(tmp = root->d_subdirs.next;
-	    tmp != &root->d_subdirs; 
-	    tmp = tmp->next) {
-		struct autofs_info *ino;
-		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
+	next = root->d_subdirs.next;
 
-		if (dentry->d_inode == NULL)
+	/* On exit from the loop expire is set to a dgot dentry
+	 * to expire or it's NULL */
+	while ( next != &root->d_subdirs ) {
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
+
+		/* Negative dentry - give up */
+		if (!simple_positive(dentry)) {
+			next = next->next;
 			continue;
+		}
 
-		ino = autofs4_dentry_ino(dentry);
+		dentry = dget(dentry);
+		spin_unlock(&dcache_lock);
 
-		if (ino == NULL) {
-			/* dentry in the process of being deleted */
-			continue;
+		/*
+		 * Case 1: (i) indirect mount or top level pseudo direct mount
+		 *	   (autofs-4.1).
+		 *	   (ii) indirect mount with offset mount, check the "/"
+		 *	   offset (autofs-5.0+).
+		 */
+		if (d_mountpoint(dentry)) {
+			DPRINTK("checking mountpoint %p %.*s",
+				dentry, (int)dentry->d_name.len, dentry->d_name.name);
+
+			/* Can we umount this guy */
+			if (autofs4_mount_busy(mnt, dentry))
+				goto next;
+
+			/* Can we expire this guy */
+			if (autofs4_can_expire(dentry, timeout, do_now)) {
+				expired = dentry;
+				break;
+			}
+			goto next;
 		}
 
-		/* No point expiring a pending mount */
-		if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
-			continue;
+		if (simple_empty(dentry))
+			goto next;
 
-		if (!do_now) {
-			/* Too young to die */
-			if (time_after(ino->last_used + timeout, now))
-				continue;
-		
-			/* update last_used here :- 
-			   - obviously makes sense if it is in use now
-			   - less obviously, prevents rapid-fire expire
-			     attempts if expire fails the first time */
-			ino->last_used = now;
+		/* Case 2: tree mount, expire iff entire tree is not busy */
+		if (!exp_leaves) {
+			/* Lock the tree as we must expire as a whole */
+			spin_lock(&sbi->fs_lock);
+			if (!autofs4_tree_busy(mnt, dentry, timeout, do_now)) {
+				struct autofs_info *inf = autofs4_dentry_ino(dentry);
+
+				/* Set this flag early to catch sys_chdir and the like */
+				inf->flags |= AUTOFS_INF_EXPIRING;
+				spin_unlock(&sbi->fs_lock);
+				expired = dentry;
+				break;
+			}
+			spin_unlock(&sbi->fs_lock);
+		/*
+		 * Case 3: pseudo direct mount, expire individual leaves
+		 *	   (autofs-4.1).
+		 */
+		} else {
+			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
+			if (expired) {
+				dput(dentry);
+				break;
+			}
 		}
-		if (!is_tree_busy(mnt, dentry)) {
-			DPRINTK(("autofs_expire: returning %p %.*s\n",
-				 dentry, (int)dentry->d_name.len, dentry->d_name.name));
-			/* Start from here next time */
-			list_del(&root->d_subdirs);
-			list_add(&root->d_subdirs, &dentry->d_child);
-			dget(dentry);
-			spin_unlock(&dcache_lock);
+next:
+		dput(dentry);
+		spin_lock(&dcache_lock);
+		next = next->next;
+	}
 
-			return dentry;
-		}
+	if (expired) {
+		DPRINTK("returning %p %.*s",
+			expired, (int)expired->d_name.len, expired->d_name.name);
+		spin_lock(&dcache_lock);
+		list_del(&expired->d_parent->d_subdirs);
+		list_add(&expired->d_parent->d_subdirs, &expired->d_child);
+		spin_unlock(&dcache_lock);
+		return expired;
 	}
 	spin_unlock(&dcache_lock);
 
@@ -221,7 +390,7 @@ static struct dentry *autofs4_expire(str
 int autofs4_expire_run(struct super_block *sb,
 		      struct vfsmount *mnt,
 		      struct autofs_sb_info *sbi,
-		      struct autofs_packet_expire *pkt_p)
+		      struct autofs_packet_expire __user *pkt_p)
 {
 	struct autofs_packet_expire pkt;
 	struct dentry *dentry;
@@ -231,7 +400,7 @@ int autofs4_expire_run(struct super_bloc
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = autofs_ptype_expire;
 
-	if ((dentry = autofs4_expire(sb, mnt, sbi, 0)) == NULL)
+	if ((dentry = autofs4_expire_indirect(sb, mnt, sbi, 0)) == NULL)
 		return -EAGAIN;
 
 	pkt.len = dentry->d_name.len;
@@ -248,7 +417,7 @@ int autofs4_expire_run(struct super_bloc
 /* Call repeatedly until it returns -EAGAIN, meaning there's nothing
    more to be done */
 int autofs4_expire_multi(struct super_block *sb, struct vfsmount *mnt,
-			struct autofs_sb_info *sbi, int *arg)
+			struct autofs_sb_info *sbi, int __user *arg)
 {
 	struct dentry *dentry;
 	int ret = -EAGAIN;
@@ -257,17 +426,22 @@ int autofs4_expire_multi(struct super_bl
 	if (arg && get_user(do_now, arg))
 		return -EFAULT;
 
-	if ((dentry = autofs4_expire(sb, mnt, sbi, do_now)) != NULL) {
-		struct autofs_info *de_info = autofs4_dentry_ino(dentry);
+	if (sbi->type & AUTOFS_TYPE_DIRECT)
+		dentry = autofs4_expire_direct(sb, mnt, sbi, do_now);
+	else
+		dentry = autofs4_expire_indirect(sb, mnt, sbi, do_now);
+
+	if (dentry) {
+		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		/* This is synchronous because it makes the daemon a
                    little easier */
-		de_info->flags |= AUTOFS_INF_EXPIRING;
-		ret = autofs4_wait(sbi, &dentry->d_name, NFY_EXPIRE);
-		de_info->flags &= ~AUTOFS_INF_EXPIRING;
+		ino->flags |= AUTOFS_INF_EXPIRING;
+		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
+		ino->flags &= ~AUTOFS_INF_EXPIRING;
 		dput(dentry);
 	}
-		
+
 	return ret;
 }
 
diff -Nurp linux-2.6.5.orig/fs/autofs4/init.c linux-2.6.5/fs/autofs4/init.c
--- linux-2.6.5.orig/fs/autofs4/init.c	2004-04-04 11:37:37.000000000 +0800
+++ linux-2.6.5/fs/autofs4/init.c	2007-11-25 17:01:09.000000000 +0900
@@ -24,7 +24,7 @@ static struct file_system_type autofs_fs
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.get_sb		= autofs_get_sb,
-	.kill_sb	= kill_anon_super,
+	.kill_sb	= autofs4_kill_sb,
 };
 
 static int __init init_autofs4_fs(void)
diff -Nurp linux-2.6.5.orig/fs/autofs4/inode.c linux-2.6.5/fs/autofs4/inode.c
--- linux-2.6.5.orig/fs/autofs4/inode.c	2004-04-04 11:37:38.000000000 +0800
+++ linux-2.6.5/fs/autofs4/inode.c	2007-11-25 17:01:09.000000000 +0900
@@ -3,6 +3,7 @@
  * linux/fs/autofs/inode.c
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
+ *  Copyright 2005-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -13,9 +14,11 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/file.h>
+#include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/parser.h>
 #include <asm/bitops.h>
+#include <linux/smp_lock.h>
 #include "autofs_i.h"
 #include <linux/module.h>
 
@@ -46,7 +49,10 @@ struct autofs_info *autofs4_init_ino(str
 	ino->dentry = NULL;
 	ino->size = 0;
 
+	INIT_LIST_HEAD(&ino->rehash);
+
 	ino->last_used = jiffies;
+	atomic_set(&ino->count, 0);
 
 	ino->sbi = sbi;
 
@@ -65,10 +71,19 @@ struct autofs_info *autofs4_init_ino(str
 
 void autofs4_free_ino(struct autofs_info *ino)
 {
+	struct autofs_info *p_ino;
+
 	if (ino->dentry) {
 		ino->dentry->d_fsdata = NULL;
-		if (ino->dentry->d_inode)
+		if (ino->dentry->d_inode) {
+			struct dentry *parent = ino->dentry->d_parent;
+			if (atomic_dec_and_test(&ino->count)) {
+				p_ino = autofs4_dentry_ino(parent);
+				if (p_ino && parent != ino->dentry)
+					atomic_dec(&p_ino->count);
+			}
 			dput(ino->dentry);
+		}
 		ino->dentry = NULL;
 	}
 	if (ino->free)
@@ -76,26 +91,121 @@ void autofs4_free_ino(struct autofs_info
 	kfree(ino);
 }
 
-static void autofs4_put_super(struct super_block *sb)
+/*
+ * Deal with the infamous "Busy inodes after umount ..." message.
+ *
+ * Clean up the dentry tree. This happens with autofs if the user
+ * space program goes away due to a SIGKILL, SIGSEGV etc.
+ */
+static void autofs4_force_release(struct autofs_sb_info *sbi)
+{
+	struct dentry *this_parent = sbi->sb->s_root;
+	struct list_head *next;
+
+	if (!sbi->sb->s_root)
+		return;
+
+	spin_lock(&dcache_lock);
+repeat:
+	next = this_parent->d_subdirs.next;
+resume:
+	while (next != &this_parent->d_subdirs) {
+		struct dentry *dentry = list_entry(next, struct dentry, d_child);
+
+		/* Negative dentry - don`t care */
+		if (!simple_positive(dentry)) {
+			next = next->next;
+			continue;
+		}
+
+		if (!list_empty(&dentry->d_subdirs)) {
+			this_parent = dentry;
+			goto repeat;
+		}
+
+		next = next->next;
+		spin_unlock(&dcache_lock);
+
+		DPRINTK("dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+
+		dput(dentry);
+		spin_lock(&dcache_lock);
+	}
+
+	if (this_parent != sbi->sb->s_root) {
+		struct dentry *dentry = this_parent;
+
+		next = this_parent->d_child.next;
+		this_parent = this_parent->d_parent;
+		spin_unlock(&dcache_lock);
+		DPRINTK("parent dentry %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+		dput(dentry);
+		spin_lock(&dcache_lock);
+		goto resume;
+	}
+	spin_unlock(&dcache_lock);
+	shrink_dcache_sb(sbi->sb);
+}
+
+void autofs4_kill_sb(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
 
-	sb->s_fs_info = NULL;
+	/*
+	 * In the event of a failure in get_sb_nodev the superblock
+	 * info is not present so nothing else has been setup, so
+	 * just call kill_anon_super when we are called from
+	 * deactivate_super.
+	 */
+	if (!sbi)
+		goto out_kill_sb;
 
-	if ( !sbi->catatonic )
+	if (!sbi->catatonic)
 		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
+	/* Clean up and release dangling references */
+	autofs4_force_release(sbi);
+
+	sb->s_fs_info = NULL;
 	kfree(sbi);
 
-	DPRINTK(("autofs: shutting down\n"));
+out_kill_sb:
+	DPRINTK("shutting down");
+	kill_anon_super(sb);
+}
+
+static int autofs4_show_options(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(mnt->mnt_sb);
+
+	if (!sbi)
+		return 0;
+
+	seq_printf(m, ",fd=%d", sbi->pipefd);
+	seq_printf(m, ",pgrp=%d", sbi->oz_pgrp);
+	seq_printf(m, ",timeout=%lu", sbi->exp_timeout/HZ);
+	seq_printf(m, ",minproto=%d", sbi->min_proto);
+	seq_printf(m, ",maxproto=%d", sbi->max_proto);
+
+	if (sbi->type & AUTOFS_TYPE_OFFSET)
+		seq_printf(m, ",offset");
+	else if (sbi->type & AUTOFS_TYPE_DIRECT)
+		seq_printf(m, ",direct");
+	else
+		seq_printf(m, ",indirect");
+
+	return 0;
 }
 
 static struct super_operations autofs4_sops = {
-	.put_super	= autofs4_put_super,
 	.statfs		= simple_statfs,
+	.show_options	= autofs4_show_options,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto};
+enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
+	Opt_indirect, Opt_direct, Opt_offset};
 
 static match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -104,11 +214,15 @@ static match_table_t tokens = {
 	{Opt_pgrp, "pgrp=%u"},
 	{Opt_minproto, "minproto=%u"},
 	{Opt_maxproto, "maxproto=%u"},
+	{Opt_indirect, "indirect"},
+	{Opt_direct, "direct"},
+	{Opt_offset, "offset"},
 	{Opt_err, NULL}
 };
 
 static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid,
-			 pid_t *pgrp, int *minproto, int *maxproto)
+			 pid_t *pgrp, unsigned int *type,
+			 int *minproto, int *maxproto)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -162,6 +276,15 @@ static int parse_options(char *options, 
 				return 1;
 			*maxproto = option;
 			break;
+		case Opt_indirect:
+			*type = AUTOFS_TYPE_INDIRECT;
+			break;
+		case Opt_direct:
+			*type = AUTOFS_TYPE_DIRECT;
+			break;
+		case Opt_offset:
+			*type = AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET;
+			break;
 		default:
 			return 1;
 		}
@@ -180,6 +303,10 @@ static struct autofs_info *autofs4_mkroo
 	return ino;
 }
 
+static struct dentry_operations autofs4_sb_dentry_operations = {
+	.d_release      = autofs4_dentry_release,
+};
+
 int autofs4_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
@@ -187,23 +314,33 @@ int autofs4_fill_super(struct super_bloc
 	struct file * pipe;
 	int pipefd;
 	struct autofs_sb_info *sbi;
-	int minproto, maxproto;
+	struct autofs_info *ino;
 
 	sbi = (struct autofs_sb_info *) kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if ( !sbi )
 		goto fail_unlock;
-	DPRINTK(("autofs: starting up, sbi = %p\n",sbi));
+	DPRINTK("starting up, sbi = %p",sbi);
 
 	memset(sbi, 0, sizeof(*sbi));
 
 	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->catatonic = 0;
+	sbi->pipefd = -1;
+	sbi->pipe = NULL;
+	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
 	sbi->oz_pgrp = process_group(current);
 	sbi->sb = s;
 	sbi->version = 0;
+	sbi->sub_version = 0;
+	sbi->type = 0;
+	sbi->min_proto = 0;
+	sbi->max_proto = 0;
+	init_MUTEX(&sbi->wq_sem);
+	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
+	spin_lock_init(&sbi->rehash_lock);
+	INIT_LIST_HEAD(&sbi->rehash_list);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
@@ -212,40 +349,53 @@ int autofs4_fill_super(struct super_bloc
 	/*
 	 * Get the root inode and dentry, but defer checking for errors.
 	 */
-	root_inode = autofs4_get_inode(s, autofs4_mkroot(sbi));
-	if (!root_inode)
+	ino = autofs4_mkroot(sbi);
+	if (!ino)
 		goto fail_free;
+	root_inode = autofs4_get_inode(s, ino);
+	if (!root_inode)
+		goto fail_ino;
 
-	root_inode->i_op = &autofs4_root_inode_operations;
-	root_inode->i_fop = &autofs4_root_operations;
 	root = d_alloc_root(root_inode);
-	pipe = NULL;
-
 	if (!root)
 		goto fail_iput;
+	pipe = NULL;
+
+	root->d_op = &autofs4_sb_dentry_operations;
+	root->d_fsdata = ino;
 
 	/* Can this call block? */
 	if (parse_options(data, &pipefd,
 			  &root_inode->i_uid, &root_inode->i_gid,
-			  &sbi->oz_pgrp,
-			  &minproto, &maxproto)) {
+			  &sbi->oz_pgrp, &sbi->type,
+			  &sbi->min_proto, &sbi->max_proto)) {
 		printk("autofs: called with bogus options\n");
 		goto fail_dput;
 	}
 
+	root_inode->i_fop = &autofs4_root_operations;
+	root_inode->i_op = sbi->type & AUTOFS_TYPE_DIRECT ?
+			&autofs4_direct_root_inode_operations :
+			&autofs4_indirect_root_inode_operations;
+
 	/* Couldn't this be tested earlier? */
-	if (maxproto < AUTOFS_MIN_PROTO_VERSION ||
-	    minproto > AUTOFS_MAX_PROTO_VERSION) {
+	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
+	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
 		printk("autofs: kernel does not match daemon version "
 		       "daemon (%d, %d) kernel (%d, %d)\n",
-			minproto, maxproto,
+			sbi->min_proto, sbi->max_proto,
 			AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
 		goto fail_dput;
 	}
 
-	sbi->version = maxproto > AUTOFS_MAX_PROTO_VERSION ? AUTOFS_MAX_PROTO_VERSION : maxproto;
+	/* Establish highest kernel protocol version */
+	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
+		sbi->version = AUTOFS_MAX_PROTO_VERSION;
+	else
+		sbi->version = sbi->max_proto;
+	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
-	DPRINTK(("autofs: pipe fd = %d, pgrp = %u\n", pipefd, sbi->oz_pgrp));
+	DPRINTK("pipe fd = %d, pgrp = %u", pipefd, sbi->oz_pgrp);
 	pipe = fget(pipefd);
 	
 	if ( !pipe ) {
@@ -255,6 +405,8 @@ int autofs4_fill_super(struct super_bloc
 	if ( !pipe->f_op || !pipe->f_op->write )
 		goto fail_fput;
 	sbi->pipe = pipe;
+	sbi->pipefd = pipefd;
+	sbi->catatonic = 0;
 
 	/*
 	 * Success! Install the root dentry now to indicate completion.
@@ -275,8 +427,11 @@ fail_dput:
 fail_iput:
 	printk("autofs: get root dentry failed\n");
 	iput(root_inode);
+fail_ino:
+	kfree(ino);
 fail_free:
 	kfree(sbi);
+	s->s_fs_info = NULL;
 fail_unlock:
 	return -EINVAL;
 }
@@ -305,7 +460,7 @@ struct inode *autofs4_get_inode(struct s
 	if (S_ISDIR(inf->mode)) {
 		inode->i_nlink = 2;
 		inode->i_op = &autofs4_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(inf->mode)) {
 		inode->i_size = inf->size;
 		inode->i_op = &autofs4_symlink_inode_operations;
diff -Nurp linux-2.6.5.orig/fs/autofs4/root.c linux-2.6.5/fs/autofs4/root.c
--- linux-2.6.5.orig/fs/autofs4/root.c	2004-04-04 11:36:14.000000000 +0800
+++ linux-2.6.5/fs/autofs4/root.c	2007-11-25 17:01:09.000000000 +0900
@@ -4,6 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -18,191 +19,460 @@
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
-static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
-static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
+static int autofs4_dir_open(struct inode *inode, struct file *file);
+static int autofs4_dir_close(struct inode *inode, struct file *file);
+static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
+static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
+static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
+static int autofs4_follow_link(struct dentry *, struct nameidata *);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
-	.llseek		= dcache_dir_lseek,
 	.read		= generic_read_dir,
-	.readdir	= dcache_readdir,
+	.readdir	= autofs4_root_readdir,
 	.ioctl		= autofs4_root_ioctl,
 };
 
-struct inode_operations autofs4_root_inode_operations = {
-	.lookup		= autofs4_root_lookup,
+struct file_operations autofs4_dir_operations = {
+	.open		= autofs4_dir_open,
+	.release	= autofs4_dir_close,
+	.read		= generic_read_dir,
+	.readdir	= autofs4_dir_readdir,
+};
+
+struct inode_operations autofs4_indirect_root_inode_operations = {
+	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
 	.rmdir		= autofs4_dir_rmdir,
 };
 
+struct inode_operations autofs4_direct_root_inode_operations = {
+	.lookup		= autofs4_lookup,
+	.unlink		= autofs4_dir_unlink,
+	.mkdir		= autofs4_dir_mkdir,
+	.rmdir		= autofs4_dir_rmdir,
+	.follow_link	= autofs4_follow_link,
+};
+
 struct inode_operations autofs4_dir_inode_operations = {
-	.lookup		= autofs4_dir_lookup,
+	.lookup		= autofs4_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
 	.rmdir		= autofs4_dir_rmdir,
 };
 
-/* Update usage from here to top of tree, so that scan of
-   top-level directories will give a useful result */
-static void autofs4_update_usage(struct dentry *dentry)
+static int autofs4_root_readdir(struct file *file, void *dirent,
+				filldir_t filldir)
 {
-	struct dentry *top = dentry->d_sb->s_root;
+	struct autofs_sb_info *sbi = autofs4_sbi(file->f_dentry->d_sb);
+	int oz_mode = autofs4_oz_mode(sbi);
+
+	DPRINTK("called, filp->f_pos = %lld", file->f_pos);
+
+	/*
+	 * Don't set reghost flag if:
+	 * 1) f_pos is larger than zero -- we've already been here.
+	 * 2) we haven't even enabled reghosting in the 1st place.
+	 * 3) this is the daemon doing a readdir
+	 */
+	if (oz_mode && file->f_pos == 0 && sbi->reghost_enabled)
+		sbi->needs_reghost = 1;
+
+	DPRINTK("needs_reghost = %d", sbi->needs_reghost);
+
+	return dcache_readdir(file, dirent, filldir);
+}
+
+static int autofs4_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct vfsmount *mnt = file->f_vfsmnt;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor;
+	int status;
+
+	status = dcache_dir_open(inode, file);
+	if (status)
+		goto out;
+
+	cursor = file->private_data;
+	cursor->d_fsdata = NULL;
+
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK("dentry busy");
+		dcache_dir_close(inode, file);
+		status = -EBUSY;
+		goto out;
+	}
+
+	status = -ENOENT;
+	if (!d_mountpoint(dentry) && dentry->d_op && dentry->d_op->d_revalidate) {
+		struct nameidata nd;
+		int empty, ret;
+
+		/* In case there are stale directory dentrys from a failed mount */
+		spin_lock(&dcache_lock);
+		empty = list_empty(&dentry->d_subdirs);
+		spin_unlock(&dcache_lock);
+
+		if (!empty)
+			d_invalidate(dentry);
 
-	for(; dentry != top; dentry = dentry->d_parent) {
-		struct autofs_info *ino = autofs4_dentry_ino(dentry);
+		nd.flags = LOOKUP_DIRECTORY;
+		ret = (dentry->d_op->d_revalidate)(dentry, &nd);
 
-		if (ino) {
-			update_atime(dentry->d_inode);
-			ino->last_used = jiffies;
+		if (ret <= 0) {
+			if (ret < 0)
+				status = ret;
+			dcache_dir_close(inode, file);
+			goto out;
 		}
 	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = NULL;
+		struct vfsmount *fp_mnt = mntget(mnt);
+		struct dentry *fp_dentry = dget(dentry);
+
+		if (!autofs4_follow_mount(&fp_mnt, &fp_dentry)) {
+			dput(fp_dentry);
+			mntput(fp_mnt);
+			dcache_dir_close(inode, file);
+			goto out;
+		}
+
+		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
+		status = PTR_ERR(fp);
+		if (IS_ERR(fp)) {
+			dcache_dir_close(inode, file);
+			goto out;
+		}
+		cursor->d_fsdata = fp;
+	}
+	return 0;
+out:
+	return status;
 }
 
-static int try_to_fill_dentry(struct dentry *dentry, 
-			      struct super_block *sb,
-			      struct autofs_sb_info *sbi)
+static int autofs4_dir_close(struct inode *inode, struct file *file)
 {
-	struct autofs_info *de_info = autofs4_dentry_ino(dentry);
+	struct dentry *dentry = file->f_dentry;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor = file->private_data;
+	int status = 0;
+
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK("dentry busy");
+		status = -EBUSY;
+		goto out;
+	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = cursor->d_fsdata;
+		if (!fp) {
+			status = -ENOENT;
+			goto out;
+		}
+		filp_close(fp, current->files);
+	}
+out:
+	dcache_dir_close(inode, file);
+	return status;
+}
+
+static int autofs4_dir_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct dentry *cursor = file->private_data;
+	int status;
+
+	DPRINTK("file=%p dentry=%p %.*s",
+		file, dentry, dentry->d_name.len, dentry->d_name.name);
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK("dentry busy");
+		return -EBUSY;
+	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = cursor->d_fsdata;
+
+		if (!fp)
+			return -ENOENT;
+
+		if (!fp->f_op || !fp->f_op->readdir)
+			goto out;
+
+		status = vfs_readdir(fp, filldir, dirent);
+		file->f_pos = fp->f_pos;
+		if (status)
+			autofs4_copy_atime(file, fp);
+		return status;
+	}
+out:
+	return dcache_readdir(file, dirent, filldir);
+}
+
+static int try_to_fill_dentry(struct dentry *dentry, int flags)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status = 0;
 
 	/* Block on any pending expiry here; invalidate the dentry
            when expiration is done to trigger mount request with a new
            dentry */
-	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
-		DPRINTK(("try_to_fill_entry: waiting for expire %p name=%.*s, flags&PENDING=%s de_info=%p de_info->flags=%x\n",
-			 dentry, dentry->d_name.len, dentry->d_name.name, 
-			 dentry->d_flags & DCACHE_AUTOFS_PENDING?"t":"f",
-			 de_info, de_info?de_info->flags:0));
-		status = autofs4_wait(sbi, &dentry->d_name, NFY_NONE);
-		
-		DPRINTK(("try_to_fill_entry: expire done status=%d\n", status));
-		
-		return 0;
+	if (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
+		DPRINTK("waiting for expire %p name=%.*s",
+			 dentry, dentry->d_name.len, dentry->d_name.name);
+
+		status = autofs4_wait(sbi, dentry, NFY_NONE);
+
+		DPRINTK("expire done status=%d", status);
+
+		/*
+		 * If the directory still exists the mount request must
+		 * continue otherwise it can't be followed at the right
+		 * time during the walk.
+		 */
+		status = d_invalidate(dentry);
+		if (status != -EBUSY)
+			return -EAGAIN;
 	}
 
-	DPRINTK(("try_to_fill_entry: dentry=%p %.*s ino=%p\n", 
-		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode));
+	DPRINTK("dentry=%p %.*s ino=%p",
+		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
 
 	/* Wait for a pending mount, triggering one if there isn't one already */
-	while(dentry->d_inode == NULL) {
-		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s, de_info=%p de_info->flags=%x\n",
-			 dentry->d_name.len, dentry->d_name.name, 
-			 de_info, de_info?de_info->flags:0));
-		status = autofs4_wait(sbi, &dentry->d_name, NFY_MOUNT);
+	if (dentry->d_inode == NULL) {
+		DPRINTK("waiting for mount name=%.*s",
+			 dentry->d_name.len, dentry->d_name.name);
+
+		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 		 
-		DPRINTK(("try_to_fill_entry: mount done status=%d\n", status));
+		DPRINTK("mount done status=%d", status);
 
-		if (status && dentry->d_inode)
-			return 0; /* Try to get the kernel to invalidate this dentry */
-		
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
-			dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
+			spin_lock(&dentry->d_lock);
 			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-			return 1;
+			spin_unlock(&dentry->d_lock);
+			return status;
 		} else if (status) {
 			/* Return a negative dentry, but leave it "pending" */
-			return 1;
+			return status;
+		}
+	/* Trigger mount for path component or follow link */
+	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
+			current->link_count) {
+		DPRINTK("waiting for mount name=%.*s",
+			dentry->d_name.len, dentry->d_name.name);
+
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
+		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+
+		DPRINTK("mount done status=%d", status);
+
+		if (status) {
+			spin_lock(&dentry->d_lock);
+			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+			spin_unlock(&dentry->d_lock);
+			return status;
 		}
 	}
 
-	/* If this is an unused directory that isn't a mount point,
-	   bitch at the daemon and fix it in user space */
+	/* Initialize expiry counter after successful mount */
+	if (ino)
+		ino->last_used = jiffies;
+
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+	spin_unlock(&dentry->d_lock);
+	return status;
+}
+
+/* For autofs direct mounts the follow link triggers the mount */
+static int autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	int oz_mode = autofs4_oz_mode(sbi);
+	unsigned int lookup_type;
+	int status;
+
+	DPRINTK("dentry=%p %.*s oz_mode=%d nd->flags=%d",
+		dentry, dentry->d_name.len, dentry->d_name.name, oz_mode,
+		nd->flags);
+
+	/* If it's our master or we shouldn't trigger a mount we're done */
+	lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+	if (oz_mode || !lookup_type)
+		goto done;
+
+	/* If an expire request is pending wait for it. */
+	if (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
+		DPRINTK("waiting for active request %p name=%.*s",
+			dentry, dentry->d_name.len, dentry->d_name.name);
+
+		status = autofs4_wait(sbi, dentry, NFY_NONE);
+
+		DPRINTK("request done status=%d", status);
+	}
+
+	/*
+	 * If the dentry contains directories then it is an
+	 * autofs multi-mount with no root mount offset. So
+	 * don't try to mount it again.
+	 */
 	spin_lock(&dcache_lock);
-	if (S_ISDIR(dentry->d_inode->i_mode) &&
-	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
-		DPRINTK(("try_to_fill_entry: mounting existing dir\n"));
+	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
 		spin_unlock(&dcache_lock);
-		return autofs4_wait(sbi, &dentry->d_name, NFY_MOUNT) == 0;
+
+		status = try_to_fill_dentry(dentry, 0);
+		if (status)
+			goto out_error;
+
+		/*
+		 * The mount succeeded but if there is no root mount
+		 * it must be an autofs multi-mount with no root offset
+		 * so we don't need to follow the mount.
+		 */
+		if (d_mountpoint(dentry)) {
+			if (!autofs4_follow_mount(&nd->mnt, &nd->dentry)) {
+				status = -ENOENT;
+				goto out_error;
+			}
+		}
+
+		goto done;
 	}
 	spin_unlock(&dcache_lock);
 
-	/* We don't update the usages for the autofs daemon itself, this
-	   is necessary for recursive autofs mounts */
-	if (!autofs4_oz_mode(sbi))
-		autofs4_update_usage(dentry);
+done:
+	return 0;
 
-	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
-	return 1;
+out_error:
+	path_release(nd);
+	return status;
 }
 
-
 /*
  * Revalidate is called on every cache lookup.  Some of those
  * cache lookups may actually happen while the dentry is not
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs4_root_revalidate(struct dentry * dentry, struct nameidata *nd)
+static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct inode * dir = dentry->d_parent->d_inode;
+	struct inode *dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
+	int flags = nd ? nd->flags : 0;
+	int status;
 
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
-		if (autofs4_oz_mode(sbi))
+		/* The daemon never causes a mount to trigger */
+		if (oz_mode)
 			return 1;
-		else
-			return try_to_fill_dentry(dentry, dir->i_sb, sbi);
+
+		/*
+		 * A zero status is success otherwise we have a
+		 * negative error code.
+		 */
+		status = try_to_fill_dentry(dentry, flags);
+		if (status == 0)
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
+
+		return status;
 	}
 
 	/* Negative dentry.. invalidate if "old" */
 	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= AUTOFS_NEGATIVE_TIMEOUT);
+		return 0;
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
-		DPRINTK(("autofs_root_revalidate: dentry=%p %.*s, emptydir\n",
-			 dentry, dentry->d_name.len, dentry->d_name.name));
+	    __simple_empty(dentry)) {
+		DPRINTK("dentry=%p %.*s, emptydir",
+			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
+		/* The daemon never causes a mount to trigger */
 		if (oz_mode)
 			return 1;
-		else
-			return try_to_fill_dentry(dentry, dir->i_sb, sbi);
-	}
-	spin_unlock(&dcache_lock);
-
-	/* Update the usage list */
-	if (!oz_mode)
-		autofs4_update_usage(dentry);
 
-	return 1;
-}
-
-static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
-{
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+		/*
+		 * A zero status is success otherwise we have a
+		 * negative error code.
+		 */
+		status = try_to_fill_dentry(dentry, flags);
+		if (status == 0)
+			return 1;
 
-	if (!autofs4_oz_mode(sbi))
-		autofs4_update_usage(dentry);
+		return status;
+	}
+	spin_unlock(&dcache_lock);
 
 	return 1;
 }
 
-static void autofs4_dentry_release(struct dentry *de)
+void autofs4_dentry_release(struct dentry *de)
 {
 	struct autofs_info *inf;
 
-	DPRINTK(("autofs4_dentry_release: releasing %p\n", de));
+	DPRINTK("releasing %p", de);
 
 	inf = autofs4_dentry_ino(de);
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
 
@@ -212,7 +482,7 @@ static void autofs4_dentry_release(struc
 
 /* For dentries of directories in the root dir */
 static struct dentry_operations autofs4_root_dentry_operations = {
-	.d_revalidate	= autofs4_root_revalidate,
+	.d_revalidate	= autofs4_revalidate,
 	.d_release	= autofs4_dentry_release,
 };
 
@@ -222,57 +492,138 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
-/* Lookups in non-root dirs never find anything - if it's there, it's
-   already in the dcache */
-/* SMP-safe */
-static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
-{
-#if 0
-	DPRINTK(("autofs_dir_lookup: ignoring lookup of %.*s/%.*s\n",
-		 dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
-		 dentry->d_name.len, dentry->d_name.name));
-#endif
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
 
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
 	return NULL;
 }
 
 /* Lookups in the root directory */
-static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
+	struct dentry *unhashed;
 	int oz_mode;
 
-	DPRINTK(("autofs_root_lookup: name = %.*s\n", 
-		 dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("name = %.*s",
+		dentry->d_name.len, dentry->d_name.name);
 
+	/* File name too long to exist */
 	if (dentry->d_name.len > NAME_MAX)
-		return ERR_PTR(-ENAMETOOLONG);/* File name too long to exist */
+		return ERR_PTR(-ENAMETOOLONG);
 
 	sbi = autofs4_sbi(dir->i_sb);
-
-	lock_kernel();
 	oz_mode = autofs4_oz_mode(sbi);
-	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, process_group(current), sbi->catatonic, oz_mode));
 
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
+	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
+		 current->pid, process_group(current), sbi->catatonic, oz_mode);
 
-	if (!oz_mode)
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
+
+	if (!oz_mode) {
+		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
+		spin_unlock(&dentry->d_lock);
+	}
 
 	if (dentry->d_op && dentry->d_op->d_revalidate) {
 		up(&dir->i_sem);
@@ -285,21 +636,51 @@ static struct dentry *autofs4_root_looku
 	 * a signal. If so we can force a restart..
 	 */
 	if (dentry->d_flags & DCACHE_AUTOFS_PENDING) {
+		/* See if we were interrupted */
 		if (signal_pending(current)) {
-			unlock_kernel();
-			return ERR_PTR(-ERESTARTNOINTR);
+			sigset_t *sigset = &current->pending.signal;
+			if (sigismember (sigset, SIGKILL) ||
+			    sigismember (sigset, SIGQUIT) ||
+			    sigismember (sigset, SIGINT)) {
+			    if (unhashed)
+				dput(unhashed);
+			    return ERR_PTR(-ERESTARTNOINTR);
+			}
 		}
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
 	}
-	unlock_kernel();
 
 	/*
 	 * If this dentry is unhashed, then we shouldn't honour this
-	 * lookup even if the dentry is positive.  Returning ENOENT here
-	 * doesn't do the right thing for all system calls, but it should
-	 * be OK for the operations we permit from an autofs.
+	 * lookup.  Returning ENOENT here doesn't do the right thing
+	 * for all system calls, but it should be OK for the operations
+	 * we permit from an autofs.
 	 */
-	if ( dentry->d_inode && d_unhashed(dentry) )
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
@@ -310,37 +691,32 @@ static int autofs4_dir_symlink(struct in
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	struct inode *inode;
 	char *cp;
 
-	DPRINTK(("autofs_dir_symlink: %s <- %.*s\n", symname, 
-		 dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("%s <- %.*s", symname,
+		dentry->d_name.len, dentry->d_name.name);
 
-	lock_kernel();
-	if (!autofs4_oz_mode(sbi)) {
-		unlock_kernel();
+	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
-	}
 
 	ino = autofs4_init_ino(ino, sbi, S_IFLNK | 0555);
-	if (ino == NULL) {
-		unlock_kernel();
+	if (ino == NULL)
 		return -ENOSPC;
-	}
 
 	ino->size = strlen(symname);
 	ino->u.symlink = cp = kmalloc(ino->size + 1, GFP_KERNEL);
 
 	if (cp == NULL) {
 		kfree(ino);
-		unlock_kernel();
 		return -ENOSPC;
 	}
 
 	strcpy(cp, symname);
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
 		dentry->d_op = &autofs4_root_dentry_operations;
@@ -349,11 +725,14 @@ static int autofs4_dir_symlink(struct in
 
 	dentry->d_fsdata = ino;
 	ino->dentry = dget(dentry);
+	atomic_inc(&ino->count);
+	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	if (p_ino && dentry->d_parent != dentry)
+		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 
 	dir->i_mtime = CURRENT_TIME;
 
-	unlock_kernel();
 	return 0;
 }
 
@@ -363,27 +742,31 @@ static int autofs4_dir_symlink(struct in
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
  *
- * Also see autofs_dir_rmdir().. 
+ * Also see autofs4_dir_rmdir()..
  */
 static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	
 	/* This allows root to remove symlinks */
-	lock_kernel();
-	if ( !autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN) ) {
-		unlock_kernel();
+	if ( !autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN) )
 		return -EACCES;
-	}
 
+	if (atomic_dec_and_test(&ino->count)) {
+		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		if (p_ino && dentry->d_parent != dentry)
+			atomic_dec(&p_ino->count);
+	}
 	dput(ino->dentry);
 
 	dentry->d_inode->i_size = 0;
@@ -391,10 +774,13 @@ static int autofs4_dir_unlink(struct ino
 
 	dir->i_mtime = CURRENT_TIME;
 
-	d_drop(dentry);
+	spin_lock(&dcache_lock);
+	spin_lock(&sbi->rehash_lock);
+	list_add(&ino->rehash, &sbi->rehash_list);
+	spin_unlock(&sbi->rehash_lock);
+	__d_drop(dentry);
+	spin_unlock(&dcache_lock);
 
-	unlock_kernel();
-	
 	return 0;
 }
 
@@ -402,59 +788,59 @@ static int autofs4_dir_rmdir(struct inod
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	
-	lock_kernel();
-	if (!autofs4_oz_mode(sbi)) {
-		unlock_kernel();
+	DPRINTK("dentry %p, removing %.*s",
+		dentry, dentry->d_name.len, dentry->d_name.name);
+
+	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
-	}
 
 	spin_lock(&dcache_lock);
 	if (!list_empty(&dentry->d_subdirs)) {
 		spin_unlock(&dcache_lock);
-		unlock_kernel();
 		return -ENOTEMPTY;
 	}
+	spin_lock(&sbi->rehash_lock);
+	list_add(&ino->rehash, &sbi->rehash_list);
+	spin_unlock(&sbi->rehash_lock);
 	__d_drop(dentry);
 	spin_unlock(&dcache_lock);
 
+	if (atomic_dec_and_test(&ino->count)) {
+		p_ino = autofs4_dentry_ino(dentry->d_parent);
+		if (p_ino && dentry->d_parent != dentry)
+			atomic_dec(&p_ino->count);
+	}
 	dput(ino->dentry);
-
 	dentry->d_inode->i_size = 0;
 	dentry->d_inode->i_nlink = 0;
 
 	if (dir->i_nlink)
 		dir->i_nlink--;
 
-	unlock_kernel();
 	return 0;
 }
 
-
-
 static int autofs4_dir_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_info *p_ino;
 	struct inode *inode;
 
-	lock_kernel();
-	if ( !autofs4_oz_mode(sbi) ) {
-		unlock_kernel();
+	if ( !autofs4_oz_mode(sbi) )
 		return -EACCES;
-	}
 
-	DPRINTK(("autofs_dir_mkdir: dentry %p, creating %.*s\n",
-		 dentry, dentry->d_name.len, dentry->d_name.name));
+	DPRINTK("dentry %p, creating %.*s",
+		dentry, dentry->d_name.len, dentry->d_name.name);
 
 	ino = autofs4_init_ino(ino, sbi, S_IFDIR | 0555);
-	if (ino == NULL) {
-		unlock_kernel();
+	if (ino == NULL)
 		return -ENOSPC;
-	}
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 
 	if (dir == dir->i_sb->s_root->d_inode)
 		dentry->d_op = &autofs4_root_dentry_operations;
@@ -463,17 +849,20 @@ static int autofs4_dir_mkdir(struct inod
 
 	dentry->d_fsdata = ino;
 	ino->dentry = dget(dentry);
+	atomic_inc(&ino->count);
+	p_ino = autofs4_dentry_ino(dentry->d_parent);
+	if (p_ino && dentry->d_parent != dentry)
+		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 	dir->i_nlink++;
 	dir->i_mtime = CURRENT_TIME;
 
-	unlock_kernel();
 	return 0;
 }
 
 /* Get/set timeout ioctl() operation */
 static inline int autofs4_get_set_timeout(struct autofs_sb_info *sbi,
-					 unsigned long *p)
+					 unsigned long __user *p)
 {
 	int rv;
 	unsigned long ntimeout;
@@ -491,12 +880,73 @@ static inline int autofs4_get_set_timeou
 }
 
 /* Return protocol version */
-static inline int autofs4_get_protover(struct autofs_sb_info *sbi, int *p)
+static inline int autofs4_get_protover(struct autofs_sb_info *sbi, int __user *p)
 {
 	return put_user(sbi->version, p);
 }
 
-/* Identify autofs_dentries - this is so we can tell if there's
+/* Return protocol sub version */
+static inline int autofs4_get_protosubver(struct autofs_sb_info *sbi, int __user *p)
+{
+	return put_user(sbi->sub_version, p);
+}
+
+/*
+ * Tells the daemon whether we need to reghost or not. Also, clears
+ * the reghost_needed flag.
+ */
+static inline int autofs4_ask_reghost(struct autofs_sb_info *sbi, int __user *p)
+{
+	int status;
+
+	DPRINTK("returning %d", sbi->needs_reghost);
+
+	status = put_user(sbi->needs_reghost, p);
+	if ( status )
+		return status;
+
+	sbi->needs_reghost = 0;
+	return 0;
+}
+
+/*
+ * Enable / Disable reghosting ioctl() operation
+ */
+static inline int autofs4_toggle_reghost(struct autofs_sb_info *sbi, int __user *p)
+{
+	int status;
+	int val;
+
+	status = get_user(val, p);
+
+	DPRINTK("reghost = %d", val);
+
+	if (status)
+		return status;
+
+	/* turn on/off reghosting, with the val */
+	sbi->reghost_enabled = val;
+	return 0;
+}
+
+/*
+* Tells the daemon whether it can umount the autofs mount.
+*/
+static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
+{
+	int status = 0;
+
+	if (may_umount(mnt))
+		status = 1;
+
+	DPRINTK("returning %d", status);
+
+	status = put_user(status, p);
+
+	return status;
+}
+
+/* Identify autofs4_dentries - this is so we can tell if there's
    an extra dentry refcount or not.  We only hold a refcount on the
    dentry if its non-negative (ie, d_inode != NULL)
 */
@@ -516,9 +966,10 @@ static int autofs4_root_ioctl(struct ino
 			     unsigned int cmd, unsigned long arg)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
+	void __user *p = (void __user *)arg;
 
-	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
-		 cmd,arg,sbi,process_group(current)));
+	DPRINTK("cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u",
+		cmd,arg,sbi,process_group(current));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
@@ -536,18 +987,26 @@ static int autofs4_root_ioctl(struct ino
 		autofs4_catatonic_mode(sbi);
 		return 0;
 	case AUTOFS_IOC_PROTOVER: /* Get protocol version */
-		return autofs4_get_protover(sbi, (int *)arg);
+		return autofs4_get_protover(sbi, p);
+	case AUTOFS_IOC_PROTOSUBVER: /* Get protocol sub version */
+		return autofs4_get_protosubver(sbi, p);
 	case AUTOFS_IOC_SETTIMEOUT:
-		return autofs4_get_set_timeout(sbi,(unsigned long *)arg);
+		return autofs4_get_set_timeout(sbi, p);
+
+	case AUTOFS_IOC_TOGGLEREGHOST:
+		return autofs4_toggle_reghost(sbi, p);
+	case AUTOFS_IOC_ASKREGHOST:
+		return autofs4_ask_reghost(sbi, p);
+
+	case AUTOFS_IOC_ASKUMOUNT:
+		return autofs4_ask_umount(filp->f_vfsmnt, p);
 
 	/* return a single thing to expire */
 	case AUTOFS_IOC_EXPIRE:
-		return autofs4_expire_run(inode->i_sb,filp->f_vfsmnt,sbi,
-					  (struct autofs_packet_expire *)arg);
+		return autofs4_expire_run(inode->i_sb,filp->f_vfsmnt,sbi, p);
 	/* same as above, but can send multiple expires through pipe */
 	case AUTOFS_IOC_EXPIRE_MULTI:
-		return autofs4_expire_multi(inode->i_sb,filp->f_vfsmnt,sbi,
-					    (int *)arg);
+		return autofs4_expire_multi(inode->i_sb,filp->f_vfsmnt,sbi, p);
 
 	default:
 		return -ENOSYS;
diff -Nurp linux-2.6.5.orig/fs/autofs4/symlink.c linux-2.6.5/fs/autofs4/symlink.c
--- linux-2.6.5.orig/fs/autofs4/symlink.c	2004-04-04 11:37:36.000000000 +0800
+++ linux-2.6.5/fs/autofs4/symlink.c	2007-11-25 17:01:09.000000000 +0900
@@ -12,21 +12,14 @@
 
 #include "autofs_i.h"
 
-static int autofs4_readlink(struct dentry *dentry, char *buffer, int buflen)
-{
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
-	return vfs_readlink(dentry, buffer, buflen, ino->u.symlink);
-}
-
 static int autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-
-	return vfs_follow_link(nd, ino->u.symlink);
+	nd_set_link(nd, (char *)ino->u.symlink);
+	return 0;
 }
 
 struct inode_operations autofs4_symlink_inode_operations = {
-	.readlink	= autofs4_readlink,
+	.readlink	= generic_readlink,
 	.follow_link	= autofs4_follow_link
 };
diff -Nurp linux-2.6.5.orig/fs/autofs4/waitq.c linux-2.6.5/fs/autofs4/waitq.c
--- linux-2.6.5.orig/fs/autofs4/waitq.c	2004-04-04 11:38:18.000000000 +0800
+++ linux-2.6.5/fs/autofs4/waitq.c	2007-11-25 17:01:09.000000000 +0900
@@ -3,6 +3,7 @@
  * linux/fs/autofs/waitq.c
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -27,24 +28,21 @@ void autofs4_catatonic_mode(struct autof
 {
 	struct autofs_wait_queue *wq, *nwq;
 
-	DPRINTK(("autofs: entering catatonic mode\n"));
+	DPRINTK("entering catatonic mode");
 
 	sbi->catatonic = 1;
 	wq = sbi->queues;
 	sbi->queues = NULL;	/* Erase all wait queues */
-	while ( wq ) {
+	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name);
 		wq->name = NULL;
-		wake_up(&wq->queue);
+		wake_up_interruptible(&wq->queue);
 		wq = nwq;
 	}
-	if (sbi->pipe) {
-		fput(sbi->pipe);	/* Close the pipe */
-		sbi->pipe = NULL;
-	}
-
+	fput(sbi->pipe);	/* Close the pipe */
+	sbi->pipe = NULL;
 	shrink_dcache_sb(sbi->sb);
 }
 
@@ -87,18 +85,25 @@ static void autofs4_notify_daemon(struct
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
 
-	DPRINTK(("autofs_notify: wait id = 0x%08lx, name = %.*s, type=%d\n",
-		 wq->wait_queue_token, wq->len, wq->name, type));
+	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
+		wq->wait_queue_token, wq->len, wq->name, type);
 
 	memset(&pkt,0,sizeof pkt); /* For security reasons */
 
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = type;
-	if (type == autofs_ptype_missing) {
-		struct autofs_packet_missing *mp = &pkt.missing;
+	switch (type) {
+	/* Kernel protocol v4 missing and expire packets */
+	case autofs_ptype_missing:
+	{
+		struct autofs_packet_missing *mp = &pkt.v4_pkt.missing;
 
 		pktsz = sizeof(*mp);
 
@@ -106,8 +111,11 @@ static void autofs4_notify_daemon(struct
 		mp->len = wq->len;
 		memcpy(mp->name, wq->name, wq->len);
 		mp->name[wq->len] = '\0';
-	} else if (type == autofs_ptype_expire_multi) {
-		struct autofs_packet_expire_multi *ep = &pkt.expire_multi;
+		break;
+	}
+	case autofs_ptype_expire_multi:
+	{
+		struct autofs_packet_expire_multi *ep = &pkt.v4_pkt.expire_multi;
 
 		pktsz = sizeof(*ep);
 
@@ -115,8 +123,35 @@ static void autofs4_notify_daemon(struct
 		ep->len = wq->len;
 		memcpy(ep->name, wq->name, wq->len);
 		ep->name[wq->len] = '\0';
-	} else {
-		printk("autofs_notify_daemon: bad type %d!\n", type);
+		break;
+	}
+	/*
+	 * Kernel protocol v5 packet for handling indirect and direct
+	 * mount missing and expire requests
+	 */
+	case autofs_ptype_missing_indirect:
+	case autofs_ptype_expire_indirect:
+	case autofs_ptype_missing_direct:
+	case autofs_ptype_expire_direct:
+	{
+		struct autofs_v5_packet *packet = &pkt.v5_pkt.v5_packet;
+
+		pktsz = sizeof(*packet);
+
+		packet->wait_queue_token = wq->wait_queue_token;
+		packet->len = wq->len;
+		memcpy(packet->name, wq->name, wq->len);
+		packet->name[wq->len] = '\0';
+		packet->dev = wq->dev;
+		packet->ino = wq->ino;
+		packet->uid = wq->uid;
+		packet->gid = wq->gid;
+		packet->pid = wq->pid;
+		packet->tgid = wq->tgid;
+		break;
+	}
+	default:
+		printk("autofs4_notify_daemon: bad type %d!\n", type);
 		return;
 	}
 
@@ -124,62 +159,178 @@ static void autofs4_notify_daemon(struct
 		autofs4_catatonic_mode(sbi);
 }
 
-int autofs4_wait(struct autofs_sb_info *sbi, struct qstr *name,
+static int autofs4_getpath(struct autofs_sb_info *sbi,
+			   struct dentry *dentry, char **name)
+{
+	struct dentry *root = sbi->sb->s_root;
+	struct dentry *tmp;
+	char *buf = *name;
+	char *p;
+	int len = 0;
+
+	spin_lock(&dcache_lock);
+	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
+		len += tmp->d_name.len + 1;
+
+	if (--len > NAME_MAX) {
+		spin_unlock(&dcache_lock);
+		return 0;
+	}
+
+	*(buf + len) = '\0';
+	p = buf + len - dentry->d_name.len;
+	strncpy(p, dentry->d_name.name, dentry->d_name.len);
+
+	for (tmp = dentry->d_parent; tmp != root ; tmp = tmp->d_parent) {
+		*(--p) = '/';
+		p -= tmp->d_name.len;
+		strncpy(p, tmp->d_name.name, tmp->d_name.len);
+	}
+	spin_unlock(&dcache_lock);
+
+	return len;
+}
+
+static struct autofs_wait_queue *
+autofs4_find_wait(struct autofs_sb_info *sbi,
+		  char *name, unsigned int hash, unsigned int len)
+{
+	struct autofs_wait_queue *wq = NULL;
+
+	for (wq = sbi->queues ; wq ; wq = wq->next) {
+		if (wq->hash == hash &&
+		    wq->len == len &&
+		    wq->name && !memcmp(wq->name, name, len))
+			break;
+	}
+	return wq;
+}
+
+int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		enum autofs_notify notify)
 {
+	struct autofs_info *ino;
 	struct autofs_wait_queue *wq;
-	int status;
+	char *name;
+	unsigned int len = 0;
+	unsigned int hash = 0;
+	int status, type;
 
 	/* In catatonic mode, we don't wait for nobody */
-	if ( sbi->catatonic )
+	if (sbi->catatonic)
 		return -ENOENT;
 	
-	/* We shouldn't be able to get here, but just in case */
-	if ( name->len > NAME_MAX )
-		return -ENOENT;
+	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	/* If this is a direct mount request create a dummy name */
+	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYPE_DIRECT))
+		len = sprintf(name, "%p", dentry);
+	else {
+		len = autofs4_getpath(sbi, dentry, &name);
+		if (!len) {
+			kfree(name);
+			return -ENOENT;
+		}
+	}
+	hash = full_name_hash(name, len);
 
-	for ( wq = sbi->queues ; wq ; wq = wq->next ) {
-		if ( wq->hash == name->hash &&
-		     wq->len == name->len &&
-		     wq->name && !memcmp(wq->name,name->name,name->len) )
-			break;
+	if (down_interruptible(&sbi->wq_sem)) {
+		kfree(name);
+		return -EINTR;
 	}
-	
-	if ( !wq ) {
+
+	wq = autofs4_find_wait(sbi, name, hash, len);
+	ino = autofs4_dentry_ino(dentry);
+	if (!wq && ino && notify == NFY_NONE) {
+		/*
+		 * Either we've betean the pending expire to post it's
+		 * wait or it finished while we waited on the mutex.
+		 * So we need to wait till either, the wait appears
+		 * or the expire finishes.
+		 */
+
+		while (ino->flags & AUTOFS_INF_EXPIRING) {
+			up(&sbi->wq_sem);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(HZ/10);
+			if (down_interruptible(&sbi->wq_sem)) {
+				kfree(name);
+				return -EINTR;
+			}
+			wq = autofs4_find_wait(sbi, name, hash, len);
+			if (wq)
+				break;
+		}
+
+		/*
+		 * Not ideal but the status has already gone. Of the two
+		 * cases where we wait on NFY_NONE neither depend on the
+		 * return status of the wait.
+		 */
+		if (!wq) {
+			kfree(name);
+			up(&sbi->wq_sem);
+			return 0;
+		}
+	}
+
+	if (!wq) {
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
-		if ( !wq )
-			return -ENOMEM;
-
-		wq->name = kmalloc(name->len,GFP_KERNEL);
-		if ( !wq->name ) {
-			kfree(wq);
+		if (!wq) {
+			kfree(name);
+			up(&sbi->wq_sem);
 			return -ENOMEM;
 		}
+
 		wq->wait_queue_token = autofs4_next_wait_queue;
 		if (++autofs4_next_wait_queue == 0)
 			autofs4_next_wait_queue = 1;
-		init_waitqueue_head(&wq->queue);
-		wq->hash = name->hash;
-		wq->len = name->len;
-		wq->status = -EINTR; /* Status return if interrupted */
-		memcpy(wq->name, name->name, name->len);
 		wq->next = sbi->queues;
 		sbi->queues = wq;
+		init_waitqueue_head(&wq->queue);
+		wq->hash = hash;
+		wq->name = name;
+		wq->len = len;
+		wq->dev = autofs4_get_dev(sbi);
+		wq->ino = autofs4_get_ino(sbi);
+		wq->uid = current->uid;
+		wq->gid = current->gid;
+		wq->pid = current->pid;
+		wq->tgid = current->tgid;
+		wq->status = -EINTR; /* Status return if interrupted */
+		atomic_set(&wq->wait_ctr, 2);
+		up(&sbi->wq_sem);
 
-		DPRINTK(("autofs_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 wq->wait_queue_token, wq->len, wq->name, notify));
-		/* autofs4_notify_daemon() may block */
-		wq->wait_ctr = 2;
-		if (notify != NFY_NONE) {
-			autofs4_notify_daemon(sbi,wq, 
-					      notify == NFY_MOUNT ? autofs_ptype_missing :
-								    autofs_ptype_expire_multi);
+		if (sbi->version < 5) {
+			if (notify == NFY_MOUNT)
+				type = autofs_ptype_missing;
+			else
+				type = autofs_ptype_expire_multi;
+		} else {
+			if (notify == NFY_MOUNT)
+				type = (sbi->type & AUTOFS_TYPE_DIRECT) ?
+					autofs_ptype_missing_direct :
+					 autofs_ptype_missing_indirect;
+			else
+				type = (sbi->type & AUTOFS_TYPE_DIRECT) ?
+					autofs_ptype_expire_direct :
+					autofs_ptype_expire_indirect;
 		}
+
+		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
+
+		/* autofs4_notify_daemon() may block */
+		autofs4_notify_daemon(sbi, wq, type);
 	} else {
-		wq->wait_ctr++;
-		DPRINTK(("autofs_wait: existing wait id = 0x%08lx, name = %.*s, nfy=%d\n",
-			 wq->wait_queue_token, wq->len, wq->name, notify));
+		atomic_inc(&wq->wait_ctr);
+		up(&sbi->wq_sem);
+		kfree(name);
+		DPRINTK("existing wait id = 0x%08lx, name = %.*s, nfy=%d",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}
 
 	/* wq->name is NULL if and only if the lock is already released */
@@ -204,19 +355,20 @@ int autofs4_wait(struct autofs_sb_info *
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 
-		interruptible_sleep_on(&wq->queue);
+		wait_event_interruptible(wq->queue, wq->name == NULL);
 
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();
 		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 	} else {
-		DPRINTK(("autofs_wait: skipped sleeping\n"));
+		DPRINTK("skipped sleeping");
 	}
 
 	status = wq->status;
 
-	if (--wq->wait_ctr == 0)	/* Are we the last process to need status? */
+	/* Are we the last process to need status? */
+	if (atomic_dec_and_test(&wq->wait_ctr))
 		kfree(wq);
 
 	return status;
@@ -227,23 +379,28 @@ int autofs4_wait_release(struct autofs_s
 {
 	struct autofs_wait_queue *wq, **wql;
 
-	for ( wql = &sbi->queues ; (wq = *wql) ; wql = &wq->next ) {
-		if ( wq->wait_queue_token == wait_queue_token )
+	down(&sbi->wq_sem);
+	for (wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next) {
+		if (wq->wait_queue_token == wait_queue_token)
 			break;
 	}
-	if ( !wq )
+
+	if (!wq) {
+		up(&sbi->wq_sem);
 		return -EINVAL;
+	}
 
 	*wql = wq->next;	/* Unlink from chain */
+	up(&sbi->wq_sem);
 	kfree(wq->name);
 	wq->name = NULL;	/* Do not wait on this queue */
 
 	wq->status = status;
 
-	if (--wq->wait_ctr == 0)	/* Is anyone still waiting for this guy? */
+	if (atomic_dec_and_test(&wq->wait_ctr))	/* Is anyone still waiting for this guy? */
 		kfree(wq);
 	else
-		wake_up(&wq->queue);
+		wake_up_interruptible(&wq->queue);
 
 	return 0;
 }
diff -Nurp linux-2.6.5.orig/fs/namei.c linux-2.6.5/fs/namei.c
--- linux-2.6.5.orig/fs/namei.c	2004-04-04 11:36:55.000000000 +0800
+++ linux-2.6.5/fs/namei.c	2007-11-25 17:01:09.000000000 +0900
@@ -275,6 +275,29 @@ void path_release(struct nameidata *nd)
 	mntput(nd->mnt);
 }
 
+static inline struct dentry *do_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int status = dentry->d_op->d_revalidate(dentry, nd);
+	if (unlikely(status <= 0)) {
+		/*
+		 * The dentry failed validation.
+		 * If d_revalidate returned 0 attempt to invalidate
+		 * the dentry otherwise d_revalidate is asking us
+		 * to return a fail status.
+		 */
+		if (!status) {
+			if (!d_invalidate(dentry)) {
+				dput(dentry);
+				dentry = NULL;
+			}
+		} else {
+			dput(dentry);
+			dentry = ERR_PTR(status);
+		}
+	}
+	return dentry;
+}
+
 /*
  * Internal lookup() using the new generic dcache.
  * SMP-safe
@@ -289,12 +312,9 @@ static struct dentry * cached_lookup(str
 	if (!dentry)
 		dentry = d_lookup(parent, name);
 
-	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
-			dput(dentry);
-			dentry = NULL;
-		}
-	}
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate)
+		dentry = do_revalidate(dentry, nd);
+
 	return dentry;
 }
 
@@ -384,10 +404,9 @@ static struct dentry * real_lookup(struc
 	 */
 	up(&dir->i_sem);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
-			dput(result);
+		result = do_revalidate(result, nd);
+		if (!result)
 			result = ERR_PTR(-ENOENT);
-		}
 	}
 	return result;
 }
@@ -552,12 +571,12 @@ need_lookup:
 	goto done;
 
 need_revalidate:
-	if (dentry->d_op->d_revalidate(dentry, nd))
-		goto done;
-	if (d_invalidate(dentry))
-		goto done;
-	dput(dentry);
-	goto need_lookup;
+	dentry = do_revalidate(dentry, nd);
+	if (!dentry)
+		goto need_lookup;
+	if (IS_ERR(dentry))
+		goto fail;
+	goto done;
 
 fail:
 	return PTR_ERR(dentry);
@@ -663,6 +682,11 @@ int fastcall link_path_walk(const char *
 
 		if (inode->i_op->follow_link) {
 			mntget(next.mnt);
+			if (next.mnt != nd->mnt) {
+				dput(nd->dentry);
+				nd->mnt = next.mnt;
+				nd->dentry = dget(next.dentry);
+			}
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
@@ -717,6 +741,11 @@ last_component:
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			mntget(next.mnt);
+			if (next.mnt != nd->mnt) {
+				dput(nd->dentry);
+				nd->mnt = next.mnt;
+				nd->dentry = dget(next.dentry);
+			}
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
diff -Nurp linux-2.6.5.orig/fs/namespace.c linux-2.6.5/fs/namespace.c
--- linux-2.6.5.orig/fs/namespace.c	2004-04-04 11:37:36.000000000 +0800
+++ linux-2.6.5/fs/namespace.c	2007-11-25 17:01:09.000000000 +0900
@@ -251,16 +251,75 @@ struct seq_operations mounts_op = {
 	.show	= show_vfsmnt
 };
 
-/*
+/**
+ * may_umount_tree - check if a mount tree is busy
+ * @mnt: root of mount tree
+ *
+ * This is called to check if a tree of mounts has any
+ * open files, pwds, chroots or sub mounts that are
+ * busy.
+ */
+int may_umount_tree(struct vfsmount *mnt)
+{
+	struct list_head *next;
+	struct vfsmount *this_parent = mnt;
+	int actual_refs;
+	int minimum_refs;
+
+	spin_lock(&vfsmount_lock);
+	actual_refs = atomic_read(&mnt->mnt_count);
+	minimum_refs = 2;
+repeat:
+	next = this_parent->mnt_mounts.next;
+resume:
+	while (next != &this_parent->mnt_mounts) {
+		struct vfsmount *p = list_entry(next, struct vfsmount, mnt_child);
+
+		next = next->next;
+
+		actual_refs += atomic_read(&p->mnt_count);
+		minimum_refs += 2;
+
+		if (!list_empty(&p->mnt_mounts)) {
+			this_parent = p;
+			goto repeat;
+		}
+	}
+
+	if (this_parent != mnt) {
+		next = this_parent->mnt_child.next;
+		this_parent = this_parent->mnt_parent;
+		goto resume;
+	}
+	spin_unlock(&vfsmount_lock);
+
+	if (actual_refs > minimum_refs)
+		return 0;
+
+	return 1;
+}
+
+EXPORT_SYMBOL(may_umount_tree);
+
+/**
+ * may_umount - check if a mount point is busy
+ * @mnt: root of mount
+ *
+ * This is called to check if a mount point has any
+ * open files, pwds, chroots or sub mounts. If the
+ * mount has sub mounts this will return busy
+ * regardless of whether the sub mounts are busy.
+ *
  * Doesn't take quota and stuff into account. IOW, in some cases it will
  * give false negatives. The main reason why it's here is that we need
  * a non-destructive way to look for easily umountable filesystems.
  */
 int may_umount(struct vfsmount *mnt)
 {
+	int ret = 1;
 	if (atomic_read(&mnt->mnt_count) > 2)
-		return -EBUSY;
-	return 0;
+		ret = 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(may_umount);
diff -Nurp linux-2.6.5.orig/include/linux/auto_fs4.h linux-2.6.5/include/linux/auto_fs4.h
--- linux-2.6.5.orig/include/linux/auto_fs4.h	2004-04-04 11:36:16.000000000 +0800
+++ linux-2.6.5/include/linux/auto_fs4.h	2007-11-25 17:01:09.000000000 +0900
@@ -19,12 +19,37 @@
 #undef AUTOFS_MIN_PROTO_VERSION
 #undef AUTOFS_MAX_PROTO_VERSION
 
-#define AUTOFS_PROTO_VERSION		4
+#define AUTOFS_PROTO_VERSION		5
 #define AUTOFS_MIN_PROTO_VERSION	3
-#define AUTOFS_MAX_PROTO_VERSION	4
+#define AUTOFS_MAX_PROTO_VERSION	5
 
-/* New message type */
-#define autofs_ptype_expire_multi	2	/* Expire entry (umount request) */
+#define AUTOFS_PROTO_SUBVERSION		0
+
+/* Mask for expire behaviour */
+#define AUTOFS_EXP_IMMEDIATE		1
+#define AUTOFS_EXP_LEAVES		2
+
+/* Daemon notification packet types */
+enum autofs_notify {
+	NFY_NONE,
+	NFY_MOUNT,
+	NFY_EXPIRE
+};
+
+/* Kernel protocol version 4 packet types */
+
+/* Expire entry (umount request) */
+#define autofs_ptype_expire_multi	2
+
+/* Kernel protocol version 5 packet types */
+
+/* Indirect mount missing and expire requests. */
+#define autofs_ptype_missing_indirect	3
+#define autofs_ptype_expire_indirect	4
+
+/* Direct mount missing and expire requests */
+#define autofs_ptype_missing_direct	5
+#define autofs_ptype_expire_direct	6
 
 /* v4 multi expire (via pipe) */
 struct autofs_packet_expire_multi {
@@ -41,7 +66,41 @@ union autofs_packet_union {
 	struct autofs_packet_expire_multi expire_multi;
 };
 
-#define AUTOFS_IOC_EXPIRE_MULTI _IOW(0x93,0x66,int)
+/* autofs v5 common packet struct */
+struct autofs_v5_packet {
+	struct autofs_packet_hdr hdr;
+	autofs_wqt_t wait_queue_token;
+	__u32 dev;
+	__u64 ino;
+	__u32 uid;
+	__u32 gid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 len;
+	char name[NAME_MAX+1];
+};
+
+typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_expire_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_missing_direct_t;
+typedef struct autofs_v5_packet autofs_packet_expire_direct_t;
+
+union autofs_v5_packet_union {
+	struct autofs_packet_hdr hdr;
+	struct autofs_v5_packet v5_packet;
+	autofs_packet_missing_indirect_t missing_indirect;
+	autofs_packet_expire_indirect_t expire_indirect;
+	autofs_packet_missing_direct_t missing_direct;
+	autofs_packet_expire_direct_t expire_direct;
+};
+
+#define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93,0x66,int)
+#define AUTOFS_IOC_EXPIRE_INDIRECT	AUTOFS_IOC_EXPIRE_MULTI
+#define AUTOFS_IOC_EXPIRE_DIRECT	AUTOFS_IOC_EXPIRE_MULTI
+#define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93,0x67,int)
+#define AUTOFS_IOC_ASKREGHOST           _IOR(0x93,0x68,int)
+#define AUTOFS_IOC_TOGGLEREGHOST        _IOR(0x93,0x69,int)
+#define AUTOFS_IOC_ASKUMOUNT		_IOR(0x93,0x70,int)
 
 
 #endif /* _LINUX_AUTO_FS4_H */
