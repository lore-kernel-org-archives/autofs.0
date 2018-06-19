From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/6] autofs - fix inconsistent use of now variable
Date: Tue, 19 Jun 2018 11:01:57 +0800
Message-ID: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The global variable "now" in fs/autofs/expire.c is used in
an inconsistent way, sometimes using jiffies directly, and
sometimes using the "now" variable, and setting it isn't done
consistently either.

But the autofs dentry info last_used field is only updated
during path walks or during expire so jiffies can be used
directly and the global variable "now" removed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index b332d3f6e730..295feec10ea6 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -10,8 +10,6 @@
 
 #include "autofs_i.h"
 
-static unsigned long now;
-
 /* Check if a dentry can be expired */
 static inline int autofs_can_expire(struct dentry *dentry,
 				    unsigned long timeout, int do_now)
@@ -24,7 +22,7 @@ static inline int autofs_can_expire(struct dentry *dentry,
 
 	if (!do_now) {
 		/* Too young to die */
-		if (!timeout || time_after(ino->last_used + timeout, now))
+		if (!timeout || time_after(ino->last_used + timeout, jiffies))
 			return 0;
 	}
 	return 1;
@@ -307,7 +305,6 @@ struct dentry *autofs_expire_direct(struct super_block *sb,
 	if (!root)
 		return NULL;
 
-	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
@@ -442,7 +439,6 @@ struct dentry *autofs_expire_indirect(struct super_block *sb,
 	if (!root)
 		return NULL;
 
-	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	dentry = NULL;
@@ -575,7 +571,7 @@ int autofs_expire_run(struct super_block *sb,
 	spin_lock(&sbi->fs_lock);
 	ino = autofs_dentry_ino(dentry);
 	/* avoid rapid-fire expire attempts if expiry fails */
-	ino->last_used = now;
+	ino->last_used = jiffies;
 	ino->flags &= ~(AUTOFS_INF_EXPIRING|AUTOFS_INF_WANT_EXPIRE);
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
@@ -605,7 +601,7 @@ int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 
 		spin_lock(&sbi->fs_lock);
 		/* avoid rapid-fire expire attempts if expiry fails */
-		ino->last_used = now;
+		ino->last_used = jiffies;
 		ino->flags &= ~(AUTOFS_INF_EXPIRING|AUTOFS_INF_WANT_EXPIRE);
 		complete_all(&ino->expire_complete);
 		spin_unlock(&sbi->fs_lock);

