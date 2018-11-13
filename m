From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/6] autofs - change catatonic setting to a bit flag
Date: Tue, 13 Nov 2018 09:36:53 +0800
Message-ID: <154207298652.11064.8570858641027372025.stgit@pluto-themaw-net>
References: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Change the super block info. catatonic setting to be part of a
flags bit field.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h  |    7 +++++--
 fs/autofs/dev-ioctl.c |    4 ++--
 fs/autofs/inode.c     |    4 ++--
 fs/autofs/root.c      |   11 ++++++-----
 fs/autofs/waitq.c     |   10 +++++-----
 5 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index c4301e33c027..032cbb12531a 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -101,16 +101,18 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
+#define AUTOFS_SBI_CATATONIC	0x0001
+
 struct autofs_sb_info {
 	u32 magic;
 	int pipefd;
 	struct file *pipe;
 	struct pid *oz_pgrp;
-	int catatonic;
 	int version;
 	int sub_version;
 	int min_proto;
 	int max_proto;
+	unsigned int flags;
 	unsigned long exp_timeout;
 	unsigned int type;
 	struct super_block *sb;
@@ -140,7 +142,8 @@ static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
  */
 static inline int autofs_oz_mode(struct autofs_sb_info *sbi)
 {
-	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
+	return ((sbi->flags & AUTOFS_SBI_CATATONIC) ||
+		 task_pgrp(current) == sbi->oz_pgrp);
 }
 
 struct inode *autofs_get_inode(struct super_block *, umode_t);
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 3de4f5e61caf..fc1caf449fa3 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -352,7 +352,7 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 	pipefd = param->setpipefd.pipefd;
 
 	mutex_lock(&sbi->wq_mutex);
-	if (!sbi->catatonic) {
+	if (!(sbi->flags & AUTOFS_SBI_CATATONIC)) {
 		mutex_unlock(&sbi->wq_mutex);
 		return -EBUSY;
 	} else {
@@ -379,7 +379,7 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		swap(sbi->oz_pgrp, new_pid);
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
-		sbi->catatonic = 0;
+		sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 	}
 out:
 	put_pid(new_pid);
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 53ed6c637cbf..5e774852ae84 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -275,7 +275,7 @@ static int autofs_apply_sbi_options(struct autofs_sb_info *sbi,
 	if (err < 0)
 		goto out_fput;
 
-	sbi->catatonic = 0;
+	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
 	return 0;
 
@@ -299,7 +299,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(struct super_block *s)
 	sbi->sb = s;
 	sbi->pipefd = -1;
 	sbi->pipe = NULL;
-	sbi->catatonic = 1;
+	sbi->flags = AUTOFS_SBI_CATATONIC;
 	set_autofs_type_indirect(&sbi->type);
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 782e57b911ab..164ccd3402cf 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -510,7 +510,8 @@ static struct dentry *autofs_lookup(struct inode *dir,
 	sbi = autofs_sbi(dir->i_sb);
 
 	pr_debug("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, task_pgrp_nr(current), sbi->catatonic,
+		 current->pid, task_pgrp_nr(current),
+		 sbi->flags & AUTOFS_SBI_CATATONIC,
 		 autofs_oz_mode(sbi));
 
 	active = autofs_lookup_active(dentry);
@@ -563,7 +564,7 @@ static int autofs_dir_symlink(struct inode *dir,
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	BUG_ON(!ino);
@@ -626,7 +627,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	if (atomic_dec_and_test(&ino->count)) {
@@ -714,7 +715,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	spin_lock(&sbi->lookup_lock);
@@ -759,7 +760,7 @@ static int autofs_dir_mkdir(struct inode *dir,
 	 * autofs mount is catatonic but the state of an autofs
 	 * file system needs to be preserved over restarts.
 	 */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -EACCES;
 
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index f6385c6ef0a5..15a3e31d0904 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -20,14 +20,14 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 	struct autofs_wait_queue *wq, *nwq;
 
 	mutex_lock(&sbi->wq_mutex);
-	if (sbi->catatonic) {
+	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
 		mutex_unlock(&sbi->wq_mutex);
 		return;
 	}
 
 	pr_debug("entering catatonic mode\n");
 
-	sbi->catatonic = 1;
+	sbi->flags |= AUTOFS_SBI_CATATONIC;
 	wq = sbi->queues;
 	sbi->queues = NULL;	/* Erase all wait queues */
 	while (wq) {
@@ -255,7 +255,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 	struct autofs_wait_queue *wq;
 	struct autofs_info *ino;
 
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -ENOENT;
 
 	/* Wait in progress, continue; */
@@ -290,7 +290,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 			if (mutex_lock_interruptible(&sbi->wq_mutex))
 				return -EINTR;
 
-			if (sbi->catatonic)
+			if (sbi->flags & AUTOFS_SBI_CATATONIC)
 				return -ENOENT;
 
 			wq = autofs_find_wait(sbi, qstr);
@@ -359,7 +359,7 @@ int autofs_wait(struct autofs_sb_info *sbi,
 	pid_t tgid;
 
 	/* In catatonic mode, we don't wait for nobody */
-	if (sbi->catatonic)
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return -ENOENT;
 
 	/*

