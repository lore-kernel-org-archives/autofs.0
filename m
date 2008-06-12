From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/10] autofs4 - don't make expiring dentry negative
Date: Thu, 12 Jun 2008 12:51:09 +0800
Message-ID: <20080612045109.25151.5839.stgit@raven.themaw.net>
References: <20080612044425.25151.58126.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612044425.25151.58126.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

Correct the error of making a positive dentry negative after it has been
instantiated.

This involves removing the code in autofs4_lookup_unhashed() that makes
the dentry negative and updating autofs4_lookup() to check for an
unfinished expire and wait if needed. The dentry used for the lookup
must be negative for mounts to trigger in the required cases so the
dentry can't be re-used (which is probably for the better anyway).

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/autofs_i.h |    6 +--
 fs/autofs4/inode.c    |    6 +--
 fs/autofs4/root.c     |  115 ++++++++++++++++++-------------------------------
 3 files changed, 49 insertions(+), 78 deletions(-)


diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 2d4ae40..f36d0c5 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -52,7 +52,7 @@ struct autofs_info {
 
 	int		flags;
 
-	struct list_head rehash;
+	struct list_head expiring;
 
 	struct autofs_sb_info *sbi;
 	unsigned long last_used;
@@ -112,8 +112,8 @@ struct autofs_sb_info {
 	struct mutex wq_mutex;
 	spinlock_t fs_lock;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
-	spinlock_t rehash_lock;
-	struct list_head rehash_list;
+	spinlock_t lookup_lock;
+	struct list_head expiring_list;
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 7f05d6c..fc04334 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -47,7 +47,7 @@ struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
 	ino->dentry = NULL;
 	ino->size = 0;
 
-	INIT_LIST_HEAD(&ino->rehash);
+	INIT_LIST_HEAD(&ino->expiring);
 
 	ino->last_used = jiffies;
 	atomic_set(&ino->count, 0);
@@ -333,8 +333,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	mutex_init(&sbi->wq_mutex);
 	spin_lock_init(&sbi->fs_lock);
 	sbi->queues = NULL;
-	spin_lock_init(&sbi->rehash_lock);
-	INIT_LIST_HEAD(&sbi->rehash_list);
+	spin_lock_init(&sbi->lookup_lock);
+	INIT_LIST_HEAD(&sbi->expiring_list);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2c5dfe8..d5b36e4 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -470,10 +470,10 @@ void autofs4_dentry_release(struct dentry *de)
 		struct autofs_sb_info *sbi = autofs4_sbi(de->d_sb);
 
 		if (sbi) {
-			spin_lock(&sbi->rehash_lock);
-			if (!list_empty(&inf->rehash))
-				list_del(&inf->rehash);
-			spin_unlock(&sbi->rehash_lock);
+			spin_lock(&sbi->lookup_lock);
+			if (!list_empty(&inf->expiring))
+				list_del(&inf->expiring);
+			spin_unlock(&sbi->lookup_lock);
 		}
 
 		inf->dentry = NULL;
@@ -495,7 +495,7 @@ static struct dentry_operations autofs4_dentry_operations = {
 	.d_release	= autofs4_dentry_release,
 };
 
-static struct dentry *autofs4_lookup_unhashed(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
+static struct dentry *autofs4_lookup_expiring(struct autofs_sb_info *sbi, struct dentry *parent, struct qstr *name)
 {
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
@@ -503,14 +503,14 @@ static struct dentry *autofs4_lookup_unhashed(struct autofs_sb_info *sbi, struct
 	struct list_head *p, *head;
 
 	spin_lock(&dcache_lock);
-	spin_lock(&sbi->rehash_lock);
-	head = &sbi->rehash_list;
+	spin_lock(&sbi->lookup_lock);
+	head = &sbi->expiring_list;
 	list_for_each(p, head) {
 		struct autofs_info *ino;
 		struct dentry *dentry;
 		struct qstr *qstr;
 
-		ino = list_entry(p, struct autofs_info, rehash);
+		ino = list_entry(p, struct autofs_info, expiring);
 		dentry = ino->dentry;
 
 		spin_lock(&dentry->d_lock);
@@ -532,33 +532,17 @@ static struct dentry *autofs4_lookup_unhashed(struct autofs_sb_info *sbi, struct
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
@@ -568,7 +552,7 @@ next:
 static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
-	struct dentry *unhashed;
+	struct dentry *expiring;
 	int oz_mode;
 
 	DPRINTK("name = %.*s",
@@ -584,44 +568,40 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
 		 current->pid, task_pgrp_nr(current), sbi->catatonic, oz_mode);
 
-	unhashed = autofs4_lookup_unhashed(sbi, dentry->d_parent, &dentry->d_name);
-	if (!unhashed) {
-		/*
-		 * Mark the dentry incomplete but don't hash it. We do this
-		 * to serialize our inode creation operations (symlink and
-		 * mkdir) which prevents deadlock during the callback to
-		 * the daemon. Subsequent user space lookups for the same
-		 * dentry are placed on the wait queue while the daemon
-		 * itself is allowed passage unresticted so the create
-		 * operation itself can then hash the dentry. Finally,
-		 * we check for the hashed dentry and return the newly
-		 * hashed dentry.
-		 */
-		dentry->d_op = &autofs4_root_dentry_operations;
-
-		dentry->d_fsdata = NULL;
-		d_instantiate(dentry, NULL);
-	} else {
-		struct autofs_info *ino = autofs4_dentry_ino(unhashed);
-		DPRINTK("rehash %p with %p", dentry, unhashed);
+	expiring = autofs4_lookup_expiring(sbi, dentry->d_parent, &dentry->d_name);
+	if (expiring) {
+		struct autofs_info *ino = autofs4_dentry_ino(expiring);
 		/*
 		 * If we are racing with expire the request might not
 		 * be quite complete but the directory has been removed
 		 * so it must have been successful, so just wait for it.
-		 * We need to ensure the AUTOFS_INF_EXPIRING flag is clear
-		 * before continuing as revalidate may fail when calling
-		 * try_to_fill_dentry (returning EAGAIN) if we don't.
 		 */
 		while (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
 			DPRINTK("wait for incomplete expire %p name=%.*s",
-				unhashed, unhashed->d_name.len,
-				unhashed->d_name.name);
-			autofs4_wait(sbi, unhashed, NFY_NONE);
+				expiring, expiring->d_name.len,
+				expiring->d_name.name);
+			autofs4_wait(sbi, expiring, NFY_NONE);
 			DPRINTK("request completed");
 		}
-		dentry = unhashed;
+		dput(expiring);
 	}
 
+	/*
+	 * Mark the dentry incomplete but don't hash it. We do this
+	 * to serialize our inode creation operations (symlink and
+	 * mkdir) which prevents deadlock during the callback to
+	 * the daemon. Subsequent user space lookups for the same
+	 * dentry are placed on the wait queue while the daemon
+	 * itself is allowed passage unresticted so the create
+	 * operation itself can then hash the dentry. Finally,
+	 * we check for the hashed dentry and return the newly
+	 * hashed dentry.
+	 */
+	dentry->d_op = &autofs4_root_dentry_operations;
+
+	dentry->d_fsdata = NULL;
+	d_instantiate(dentry, NULL);
+
 	if (!oz_mode) {
 		spin_lock(&dentry->d_lock);
 		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
@@ -645,8 +625,6 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 			if (sigismember (sigset, SIGKILL) ||
 			    sigismember (sigset, SIGQUIT) ||
 			    sigismember (sigset, SIGINT)) {
-			    if (unhashed)
-				dput(unhashed);
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
@@ -676,15 +654,9 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, s
 		else
 			dentry = ERR_PTR(-ENOENT);
 
-		if (unhashed)
-			dput(unhashed);
-
 		return dentry;
 	}
 
-	if (unhashed)
-		return dentry;
-
 	return NULL;
 }
 
@@ -746,9 +718,8 @@ static int autofs4_dir_symlink(struct inode *dir,
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
@@ -778,9 +749,9 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 	dir->i_mtime = CURRENT_TIME;
 
 	spin_lock(&dcache_lock);
-	spin_lock(&sbi->rehash_lock);
-	list_add(&ino->rehash, &sbi->rehash_list);
-	spin_unlock(&sbi->rehash_lock);
+	spin_lock(&sbi->lookup_lock);
+	list_add(&ino->expiring, &sbi->expiring_list);
+	spin_unlock(&sbi->lookup_lock);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -806,9 +777,9 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
-	spin_lock(&sbi->rehash_lock);
-	list_add(&ino->rehash, &sbi->rehash_list);
-	spin_unlock(&sbi->rehash_lock);
+	spin_lock(&sbi->lookup_lock);
+	list_add(&ino->expiring, &sbi->expiring_list);
+	spin_unlock(&sbi->lookup_lock);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
 	spin_unlock(&dentry->d_lock);
