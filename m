From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/13] autofs4 - lookup white space cleanup
Date: Wed, 18 Jan 2006 15:22:31 +0800
Message-ID: <200601180722.k0I7MVpn006120@eagle.themaw.net>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Whitespace and formating changes to lookup code.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.16-rc1/fs/autofs4/root.c.lookup-cleanup	2006-01-18 09:20:22.000000000 +0800
+++ linux-2.6.16-rc1/fs/autofs4/root.c	2006-01-18 09:24:03.000000000 +0800
@@ -296,20 +296,20 @@ static int try_to_fill_dentry(struct vfs
 {
 	struct super_block *sb = mnt->mnt_sb;
 	struct autofs_sb_info *sbi = autofs4_sbi(sb);
-	struct autofs_info *de_info = autofs4_dentry_ino(dentry);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status = 0;
 
 	/* Block on any pending expiry here; invalidate the dentry
            when expiration is done to trigger mount request with a new
            dentry */
-	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
+	if (ino && (ino->flags & AUTOFS_INF_EXPIRING)) {
 		DPRINTK("waiting for expire %p name=%.*s",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 
 		status = autofs4_wait(sbi, dentry, NFY_NONE);
-		
+
 		DPRINTK("expire done status=%d", status);
-		
+
 		/*
 		 * If the directory still exists the mount request must
 		 * continue otherwise it can't be followed at the right
@@ -323,18 +323,21 @@ static int try_to_fill_dentry(struct vfs
 	DPRINTK("dentry=%p %.*s ino=%p",
 		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode);
 
-	/* Wait for a pending mount, triggering one if there isn't one already */
+	/*
+	 * Wait for a pending mount, triggering one if there
+	 * isn't one already
+	 */
 	if (dentry->d_inode == NULL) {
 		DPRINTK("waiting for mount name=%.*s",
 			 dentry->d_name.len, dentry->d_name.name);
 
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
-		 
+
 		DPRINTK("mount done status=%d", status);
 
 		if (status && dentry->d_inode)
 			return 0; /* Try to get the kernel to invalidate this dentry */
-		
+
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			dentry->d_time = jiffies + AUTOFS_NEGATIVE_TIMEOUT;
@@ -367,8 +370,10 @@ static int try_to_fill_dentry(struct vfs
 		}
 	}
 
-	/* We don't update the usages for the autofs daemon itself, this
-	   is necessary for recursive autofs mounts */
+	/*
+	 * We don't update the usages for the autofs daemon itself, this
+	 * is necessary for recursive autofs mounts
+	 */
 	if (!autofs4_oz_mode(sbi))
 		autofs4_update_usage(mnt, dentry);
 
@@ -384,9 +389,9 @@ static int try_to_fill_dentry(struct vfs
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs4_revalidate(struct dentry * dentry, struct nameidata *nd)
+static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
-	struct inode * dir = dentry->d_parent->d_inode;
+	struct inode *dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
 	int flags = nd ? nd->flags : 0;
@@ -462,12 +467,13 @@ static struct dentry *autofs4_lookup(str
 	DPRINTK("name = %.*s",
 		dentry->d_name.len, dentry->d_name.name);
 
+	/* File name too long to exist */
 	if (dentry->d_name.len > NAME_MAX)
-		return ERR_PTR(-ENAMETOOLONG);/* File name too long to exist */
+		return ERR_PTR(-ENAMETOOLONG);
 
 	sbi = autofs4_sbi(dir->i_sb);
-
 	oz_mode = autofs4_oz_mode(sbi);
+
 	DPRINTK("pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d",
 		 current->pid, process_group(current), sbi->catatonic, oz_mode);
 
@@ -519,7 +525,7 @@ static struct dentry *autofs4_lookup(str
 	 * doesn't do the right thing for all system calls, but it should
 	 * be OK for the operations we permit from an autofs.
 	 */
-	if ( dentry->d_inode && d_unhashed(dentry) )
+	if (dentry->d_inode && d_unhashed(dentry))
 		return ERR_PTR(-ENOENT);
 
 	return NULL;
