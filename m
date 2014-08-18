From: NeilBrown <neilb@suse.de>
Subject: [PATCH 4/5] autofs4: d_manage() should return -EISDIR when
 appropriate in rcu-walk mode.
Date: Mon, 18 Aug 2014 16:33:01 +1000
Message-ID: <20140818063301.9860.65391.stgit@notabene.brown>
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

If rcu-walk mode we don't *have* to return -EISDIR for non-mount-traps
as we will simply drop into REF-walk and handling DCACHE_NEED_AUTOMOUNT
dentrys the slow way.  But it is better if we do when possible.

In 'oz_mode', use the same condition as ref-walk: if not a mountpoint,
then it must be -EISDIR.

In regular mode there are most tests needed.  Most of them can be
performed without taking any spinlocks.
If we find a directory that isn't obviously empty, and isn't mounted
on, we need to call 'simple_empty()' which does take a spinlock.
If this turned out to hurt performance, some other approach could
be found to signal when a directory is known to be empty.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/autofs4/root.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2296c8301b66..71e4413d65c8 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -433,8 +433,6 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 
 	/* The daemon never waits. */
 	if (autofs4_oz_mode(sbi)) {
-		if (rcu_walk)
-			return 0;
 		if (!d_mountpoint(dentry))
 			return -EISDIR;
 		return 0;
@@ -452,12 +450,28 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 	if (status)
 		return status;
 
-	if (rcu_walk)
-		/* it is always safe to return 0 as the worst that
-		 * will happen is we retry in REF-walk mode.
-		 * Better than always taking a lock.
+	if (rcu_walk) {
+		/* We don't need fs_lock in rcu_walk mode,
+		 * just testing 'AUTOFS_INFO_NO_RCU' is enough.
+		 * simple_empty() takes a spinlock, so leave it
+		 * to last.
+		 * We only return -EISDIR when certain this isn't
+		 * a mount-trap.
 		 */
+		struct inode *inode;
+		if (ino->flags & (AUTOFS_INF_EXPIRING | AUTOFS_INF_NO_RCU))
+			return 0;
+		if (d_mountpoint(dentry))
+			return 0;
+		inode = rcu_dereference(dentry->d_inode);
+		if (inode && S_ISLNK(inode->i_mode))
+			return -EISDIR;
+		if (list_empty(&dentry->d_subdirs))
+			return 0;
+		if (!simple_empty(dentry))
+			return -EISDIR;
 		return 0;
+	}
 
 	spin_lock(&sbi->fs_lock);
 	/*

