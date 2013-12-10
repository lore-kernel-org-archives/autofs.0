From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/9] Use %pd in AutoFS
Date: Tue, 10 Dec 2013 15:26:26 +0000
Message-ID: <20131210152626.4916.67655.stgit@warthog.procyon.org.uk>
References: <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20131210152612.4916.80435.stgit@warthog.procyon.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org, Ian Kent <raven@themaw.net>

Use the new %pd printk() specifier in AutoFS to replace passing of dentry name
or dentry name and name length * 2 with just passing the dentry.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ian Kent <raven@themaw.net>
cc: autofs@vger.kernel.org
---

 fs/autofs4/expire.c |   27 +++++++++------------------
 fs/autofs4/root.c   |   23 ++++++++---------------
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 3d9d3f5d5dda..fc5826c08fcd 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -47,8 +47,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	struct path path = {.mnt = mnt, .dentry = dentry};
 	int status = 1;
 
-	DPRINTK("dentry %p %.*s",
-		dentry, (int)dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("dentry %p %pd", dentry, dentry);
 
 	path_get(&path);
 
@@ -198,8 +197,7 @@ static int autofs4_direct_busy(struct vfsmount *mnt,
 				unsigned long timeout,
 				int do_now)
 {
-	DPRINTK("top %p %.*s",
-		top, (int) top->d_name.len, top->d_name.name);
+	DPRINTK("top %p %pd", top, top);
 
 	/* If it's busy update the expiry counters */
 	if (!may_umount_tree(mnt)) {
@@ -227,8 +225,7 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 	struct autofs_info *top_ino = autofs4_dentry_ino(top);
 	struct dentry *p;
 
-	DPRINTK("top %p %.*s",
-		top, (int)top->d_name.len, top->d_name.name);
+	DPRINTK("top %p %pd", top, top);
 
 	/* Negative dentry - give up */
 	if (!simple_positive(top))
@@ -236,8 +233,7 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 
 	p = NULL;
 	while ((p = get_next_positive_dentry(p, top))) {
-		DPRINTK("dentry %p %.*s",
-			p, (int) p->d_name.len, p->d_name.name);
+		DPRINTK("dentry %p %pd", p, top);
 
 		/*
 		 * Is someone visiting anywhere in the subtree ?
@@ -289,13 +285,11 @@ static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
 {
 	struct dentry *p;
 
-	DPRINTK("parent %p %.*s",
-		parent, (int)parent->d_name.len, parent->d_name.name);
+	DPRINTK("parent %p %pd", parent, parent);
 
 	p = NULL;
 	while ((p = get_next_positive_dentry(p, parent))) {
-		DPRINTK("dentry %p %.*s",
-			p, (int) p->d_name.len, p->d_name.name);
+		DPRINTK("dentry %p %pd", p, p);
 
 		if (d_mountpoint(p)) {
 			/* Can we umount this guy */
@@ -387,8 +381,7 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 		 *	   offset (autofs-5.0+).
 		 */
 		if (d_mountpoint(dentry)) {
-			DPRINTK("checking mountpoint %p %.*s",
-				dentry, (int)dentry->d_name.len, dentry->d_name.name);
+			DPRINTK("checking mountpoint %p %pd", dentry, dentry);
 
 			/* Can we umount this guy */
 			if (autofs4_mount_busy(mnt, dentry))
@@ -438,8 +431,7 @@ next:
 	return NULL;
 
 found:
-	DPRINTK("returning %p %.*s",
-		expired, (int)expired->d_name.len, expired->d_name.name);
+	DPRINTK("returning %p %pd", expired, expired);
 	ino = autofs4_dentry_ino(expired);
 	ino->flags |= AUTOFS_INF_EXPIRING;
 	init_completion(&ino->expire_complete);
@@ -465,8 +457,7 @@ int autofs4_expire_wait(struct dentry *dentry)
 	if (ino->flags & AUTOFS_INF_EXPIRING) {
 		spin_unlock(&sbi->fs_lock);
 
-		DPRINTK("waiting for expire %p name=%.*s",
-			 dentry, dentry->d_name.len, dentry->d_name.name);
+		DPRINTK("waiting for expire %p name=%pd", dentry, dentry);
 
 		status = autofs4_wait(sbi, dentry, NFY_NONE);
 		wait_for_completion(&ino->expire_complete);
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 92ef341ba0cf..99b9ab4b6859 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -108,8 +108,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
-	DPRINTK("file=%p dentry=%p %.*s",
-		file, dentry, dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("file=%p dentry=%p %pd", file, dentry, dentry);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
@@ -267,8 +266,7 @@ static int autofs4_mount_wait(struct dentry *dentry)
 	int status = 0;
 
 	if (ino->flags & AUTOFS_INF_PENDING) {
-		DPRINTK("waiting for mount name=%.*s",
-			dentry->d_name.len, dentry->d_name.name);
+		DPRINTK("waiting for mount name=%pd", dentry);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 		DPRINTK("mount wait done status=%d", status);
 	}
@@ -326,8 +324,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status;
 
-	DPRINTK("dentry=%p %.*s",
-		dentry, dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("dentry=%p %pd", dentry, dentry);
 
 	/* The daemon never triggers a mount. */
 	if (autofs4_oz_mode(sbi))
@@ -414,8 +411,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status;
 
-	DPRINTK("dentry=%p %.*s",
-		dentry, dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("dentry=%p %pd", dentry, dentry);
 
 	/* The daemon never waits. */
 	if (autofs4_oz_mode(sbi)) {
@@ -472,7 +468,7 @@ static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, u
 	struct autofs_info *ino;
 	struct dentry *active;
 
-	DPRINTK("name = %.*s", dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("name = %pd", dentry);
 
 	/* File name too long to exist */
 	if (dentry->d_name.len > NAME_MAX)
@@ -526,8 +522,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 	size_t size = strlen(symname);
 	char *cp;
 
-	DPRINTK("%s <- %.*s", symname,
-		dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("%s <- %pd", symname, dentry);
 
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
@@ -669,8 +664,7 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	
-	DPRINTK("dentry %p, removing %.*s",
-		dentry, dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("dentry %p, removing %pd", dentry, dentry);
 
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
@@ -712,8 +706,7 @@ static int autofs4_dir_mkdir(struct inode *dir, struct dentry *dentry, umode_t m
 	if (!autofs4_oz_mode(sbi))
 		return -EACCES;
 
-	DPRINTK("dentry %p, creating %.*s",
-		dentry, dentry->d_name.len, dentry->d_name.name);
+	DPRINTK("dentry %p, creating %pd", dentry, dentry);
 
 	BUG_ON(!ino);
 

