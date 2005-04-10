From: raven@themaw.net
Subject: [PATCH 2/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 20:50:47 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102048370.5212@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>


autofs4-2.6.12-rc1-mm4-tree-race.patch

For tree mount maps, a call to chdir or chroot, to a directory above the
moint point directories at a certain time during the expire results in
the expire incorrectly thinking the tree is not busy. This patch adds a
check to see if the filesystem above the tree mount points is busy and
also locks the filesystem during the tree mount expire to prevent the
race.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h.tree-race	2005-04-03 12:34:00.000000000 +0800
+++ linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h	2005-04-03 12:38:09.000000000 +0800
@@ -102,6 +102,7 @@ struct autofs_sb_info {
  	int needs_reghost;
  	struct super_block *sb;
  	struct semaphore wq_sem;
+	spinlock_t fs_lock;
  	struct autofs_wait_queue *queues; /* Wait queue pointer */
  };

@@ -127,9 +128,18 @@ static inline int autofs4_oz_mode(struct
  static inline int autofs4_ispending(struct dentry *dentry)
  {
  	struct autofs_info *inf = autofs4_dentry_ino(dentry);
+	int pending;

-	return (dentry->d_flags & DCACHE_AUTOFS_PENDING) ||
-		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
+	if (dentry->d_flags & DCACHE_AUTOFS_PENDING)
+		return 1;
+
+	if (inf) {
+		spin_lock(&inf->sbi->fs_lock);
+		pending = inf->flags & AUTOFS_INF_EXPIRING;
+		spin_unlock(&inf->sbi->fs_lock);
+	}
+
+	return pending;
  }

  static inline void autofs4_copy_atime(struct file *src, struct file *dst)
--- linux-2.6.12-rc1-mm4/fs/autofs4/inode.c.tree-race	2005-04-03 12:34:10.000000000 +0800
+++ linux-2.6.12-rc1-mm4/fs/autofs4/inode.c	2005-04-03 12:34:54.000000000 +0800
@@ -206,6 +206,7 @@ int autofs4_fill_super(struct super_bloc
  	sbi->version = 0;
  	sbi->sub_version = 0;
  	init_MUTEX(&sbi->wq_sem);
+	spin_lock_init(&sbi->fs_lock);
  	sbi->queues = NULL;
  	s->s_blocksize = 1024;
  	s->s_blocksize_bits = 10;
--- linux-2.6.12-rc1-mm4/fs/autofs4/expire.c.tree-race	2005-04-03 12:34:22.000000000 +0800
+++ linux-2.6.12-rc1-mm4/fs/autofs4/expire.c	2005-04-03 12:42:41.000000000 +0800
@@ -99,6 +99,10 @@ static int autofs4_check_tree(struct vfs
  	if (!autofs4_can_expire(top, timeout, do_now))
  		return 0;

+	/* Is someone visiting anywhere in the tree ? */
+	if (autofs4_may_umount(mnt))
+		return 0;
+
  	spin_lock(&dcache_lock);
  repeat:
  	next = this_parent->d_subdirs.next;
@@ -270,10 +274,18 @@ static struct dentry *autofs4_expire(str

  		/* Case 2: tree mount, expire iff entire tree is not busy */
  		if (!exp_leaves) {
+			/* Lock the tree as we must expire as a whole */
+			spin_lock(&sbi->fs_lock);
  			if (autofs4_check_tree(mnt, dentry, timeout, do_now)) {
-			expired = dentry;
-			break;
+				struct autofs_info *inf = autofs4_dentry_ino(dentry);
+
+				/* Set this flag early to catch sys_chdir and the like */
+				inf->flags |= AUTOFS_INF_EXPIRING;
+				spin_unlock(&sbi->fs_lock);
+				expired = dentry;
+				break;
  			}
+			spin_unlock(&sbi->fs_lock);
  		/* Case 3: direct mount, expire individual leaves */
  		} else {
  			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
