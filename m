From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/5] autofs4: factor should_expire() out of
 autofs4_expire_indirect.
Date: Mon, 18 Aug 2014 16:33:01 +1000
Message-ID: <20140818063300.9860.20538.stgit@notabene.brown>
References: <20140818062844.9860.43007.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140818062844.9860.43007.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

Future patch will potentially call this twice, so make it
separate.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/autofs4/expire.c |  162 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 74 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 7e2f22ce6954..bee939efca2b 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -345,6 +345,89 @@ out:
 	return NULL;
 }
 
+/* Check if 'dentry' should expire, or return a nearby
+ * dentry that is suitable.
+ * If returned dentry is different from arg dentry,
+ * then a dget() reference was taken, else not.
+ */
+static struct dentry *should_expire(struct dentry *dentry,
+				    struct vfsmount *mnt,
+				    unsigned long timeout,
+				    int how)
+{
+	int do_now = how & AUTOFS_EXP_IMMEDIATE;
+	int exp_leaves = how & AUTOFS_EXP_LEAVES;
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	unsigned int ino_count;
+
+	/* No point expiring a pending mount */
+	if (ino->flags & AUTOFS_INF_PENDING)
+		return NULL;
+
+	/*
+	 * Case 1: (i) indirect mount or top level pseudo direct mount
+	 *	   (autofs-4.1).
+	 *	   (ii) indirect mount with offset mount, check the "/"
+	 *	   offset (autofs-5.0+).
+	 */
+	if (d_mountpoint(dentry)) {
+		DPRINTK("checking mountpoint %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+
+		/* Can we umount this guy */
+		if (autofs4_mount_busy(mnt, dentry))
+			return NULL;
+
+		/* Can we expire this guy */
+		if (autofs4_can_expire(dentry, timeout, do_now))
+			return dentry;
+		return NULL;
+	}
+
+	if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
+		DPRINTK("checking symlink %p %.*s",
+			dentry, (int)dentry->d_name.len, dentry->d_name.name);
+		/*
+		 * A symlink can't be "busy" in the usual sense so
+		 * just check last used for expire timeout.
+		 */
+		if (autofs4_can_expire(dentry, timeout, do_now))
+			return dentry;
+		return NULL;
+	}
+
+	if (simple_empty(dentry))
+		return NULL;
+
+	/* Case 2: tree mount, expire iff entire tree is not busy */
+	if (!exp_leaves) {
+		/* Path walk currently on this dentry? */
+		ino_count = atomic_read(&ino->count) + 1;
+		if (d_count(dentry) > ino_count)
+			return NULL;
+
+		if (!autofs4_tree_busy(mnt, dentry, timeout, do_now))
+			return dentry;
+	/*
+	 * Case 3: pseudo direct mount, expire individual leaves
+	 *	   (autofs-4.1).
+	 */
+	} else {
+		/* Path walk currently on this dentry? */
+		struct dentry *expired;
+		ino_count = atomic_read(&ino->count) + 1;
+		if (d_count(dentry) > ino_count)
+			return NULL;
+
+		expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
+		if (expired) {
+			if (expired == dentry)
+				dput(dentry);
+			return expired;
+		}
+	}
+	return NULL;
+}
 /*
  * Find an eligible tree to time-out
  * A tree is eligible if :-
@@ -359,11 +442,8 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;
 	struct dentry *dentry;
-	struct dentry *expired = NULL;
-	int do_now = how & AUTOFS_EXP_IMMEDIATE;
-	int exp_leaves = how & AUTOFS_EXP_LEAVES;
+	struct dentry *expired;
 	struct autofs_info *ino;
-	unsigned int ino_count;
 
 	if (!root)
 		return NULL;
@@ -374,78 +454,12 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 	dentry = NULL;
 	while ((dentry = get_next_positive_subdir(dentry, root))) {
 		spin_lock(&sbi->fs_lock);
-		ino = autofs4_dentry_ino(dentry);
-		/* No point expiring a pending mount */
-		if (ino->flags & AUTOFS_INF_PENDING)
-			goto next;
-
-		/*
-		 * Case 1: (i) indirect mount or top level pseudo direct mount
-		 *	   (autofs-4.1).
-		 *	   (ii) indirect mount with offset mount, check the "/"
-		 *	   offset (autofs-5.0+).
-		 */
-		if (d_mountpoint(dentry)) {
-			DPRINTK("checking mountpoint %p %.*s",
-				dentry, (int)dentry->d_name.len, dentry->d_name.name);
-
-			/* Can we umount this guy */
-			if (autofs4_mount_busy(mnt, dentry))
-				goto next;
-
-			/* Can we expire this guy */
-			if (autofs4_can_expire(dentry, timeout, do_now)) {
-				expired = dentry;
-				goto found;
-			}
-			goto next;
-		}
-
-		if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
-			DPRINTK("checking symlink %p %.*s",
-				dentry, (int)dentry->d_name.len, dentry->d_name.name);
-			/*
-			 * A symlink can't be "busy" in the usual sense so
-			 * just check last used for expire timeout.
-			 */
-			if (autofs4_can_expire(dentry, timeout, do_now)) {
-				expired = dentry;
-				goto found;
-			}
-			goto next;
-		}
-
-		if (simple_empty(dentry))
-			goto next;
-
-		/* Case 2: tree mount, expire iff entire tree is not busy */
-		if (!exp_leaves) {
-			/* Path walk currently on this dentry? */
-			ino_count = atomic_read(&ino->count) + 1;
-			if (d_count(dentry) > ino_count)
-				goto next;
-
-			if (!autofs4_tree_busy(mnt, dentry, timeout, do_now)) {
-				expired = dentry;
-				goto found;
-			}
-		/*
-		 * Case 3: pseudo direct mount, expire individual leaves
-		 *	   (autofs-4.1).
-		 */
-		} else {
-			/* Path walk currently on this dentry? */
-			ino_count = atomic_read(&ino->count) + 1;
-			if (d_count(dentry) > ino_count)
-				goto next;
-
-			expired = autofs4_check_leaves(mnt, dentry, timeout, do_now);
-			if (expired) {
+		expired = should_expire(dentry, mnt, timeout, how);
+		if (expired) {
+			if (expired != dentry)
 				dput(dentry);
-				goto found;
-			}
+			goto found;
 		}
-next:
 		spin_unlock(&sbi->fs_lock);
 	}
 	return NULL;

