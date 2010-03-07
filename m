From: Pavel Emelyanov <xemul@openvz.org>
Subject: [PATCH] autofs4: Use struct pid reference as autofs4
	oz_pgrp
Date: Sun, 07 Mar 2010 23:44:22 +0300
Message-ID: <4B941026.7080707@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>

Make autofs4 also container-friendly by caching the struct pid reference instead
of the pid_t with other respective changes.

This patch is identical to the Suka's commit fa0334f1. Fits Linus tree.

Signed-off-by: Pavel Emelyanov <xemul@openvz.org>

---

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 3d283ab..2d4ef53 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -122,7 +122,7 @@ struct autofs_sb_info {
 	u32 magic;
 	int pipefd;
 	struct file *pipe;
-	pid_t oz_pgrp;
+	struct pid *oz_pgrp;
 	int catatonic;
 	int version;
 	int sub_version;
@@ -156,7 +156,7 @@ static inline struct autofs_info *autofs4_dentry_ino(struct dentry *dentry)
    filesystem without "magic".) */
 
 static inline int autofs4_oz_mode(struct autofs_sb_info *sbi) {
-	return sbi->catatonic || task_pgrp_nr(current) == sbi->oz_pgrp;
+	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
 }
 
 /* Does a dentry have some pending activity? */
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index c8a80df..b7a6b98 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -385,7 +385,8 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 			fput(pipe);
 			goto out;
 		}
-		sbi->oz_pgrp = task_pgrp_nr(current);
+		put_pid(sbi->oz_pgrp);
+		sbi->oz_pgrp = get_pid(task_pgrp(current));
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
 		sbi->catatonic = 0;
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 821b2b9..fc77421 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -112,6 +112,8 @@ void autofs4_kill_sb(struct super_block *sb)
 	/* Free wait queues, close pipe */
 	autofs4_catatonic_mode(sbi);
 
+	put_pid(sbi->oz_pgrp);
+
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 
@@ -133,7 +135,7 @@ static int autofs4_show_options(struct seq_file *m, struct vfsmount *mnt)
 		seq_printf(m, ",uid=%u", root_inode->i_uid);
 	if (root_inode->i_gid != 0)
 		seq_printf(m, ",gid=%u", root_inode->i_gid);
-	seq_printf(m, ",pgrp=%d", sbi->oz_pgrp);
+	seq_printf(m, ",pgrp=%d", pid_vnr(sbi->oz_pgrp));
 	seq_printf(m, ",timeout=%lu", sbi->exp_timeout/HZ);
 	seq_printf(m, ",minproto=%d", sbi->min_proto);
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
@@ -263,6 +265,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
+	pid_t pgrp;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -275,7 +278,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	sbi->pipe = NULL;
 	sbi->catatonic = 1;
 	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = task_pgrp_nr(current);
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->sub_version = 0;
@@ -314,7 +316,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 
 	/* Can this call block? */
 	if (parse_options(data, &pipefd, &root_inode->i_uid, &root_inode->i_gid,
-				&sbi->oz_pgrp, &sbi->type, &sbi->min_proto,
+				&pgrp, &sbi->type, &sbi->min_proto,
 				&sbi->max_proto)) {
 		printk("autofs: called with bogus options\n");
 		goto fail_dput;
@@ -342,12 +344,18 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		sbi->version = sbi->max_proto;
 	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
 
-	DPRINTK("pipe fd = %d, pgrp = %u", pipefd, sbi->oz_pgrp);
+	DPRINTK("pipe fd = %d, pgrp = %u", pipefd, pgrp);
+	sbi->oz_pgrp = find_get_pid(pgrp);
+	if (sbi->oz_pgrp == NULL) {
+		printk("autofs: could not find process group %d\n", pgrp);
+		goto fail_dput;
+	}
+
 	pipe = fget(pipefd);
 	
 	if (!pipe) {
 		printk("autofs: could not open pipe file descriptor\n");
-		goto fail_dput;
+		goto fail_put_pid;
 	}
 	if (!pipe->f_op || !pipe->f_op->write)
 		goto fail_fput;
@@ -368,6 +376,8 @@ fail_fput:
 	printk("autofs: pipe file descriptor does not contain proper ops\n");
 	fput(pipe);
 	/* fall through */
+fail_put_pid:
+	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
 	goto fail_free;
