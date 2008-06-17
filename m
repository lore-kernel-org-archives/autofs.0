From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/7] autofs4 - revert - redo lookup in ttfd
Date: Tue, 17 Jun 2008 20:23:44 +0800
Message-ID: <20080617122344.14725.11503.stgit@raven.themaw.net>
References: <20080617122336.14725.64829.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080617122336.14725.64829.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

This patch series enables the use of a single dentry for lookups
prior to the dentry being hashed and so we no longer need to
redo the lookup. This patch reverts the patch of commit
033790449ba9c4dcf8478a87693d33df625c23b5.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/root.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2e8959c..8511cb2 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -242,7 +242,6 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-	struct dentry *new;
 	int status;
 
 	/* Block on any pending expiry here; invalidate the dentry
@@ -320,26 +319,6 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	spin_unlock(&dentry->d_lock);
 
-	/*
-	 * The dentry that is passed in from lookup may not be the one
-	 * we end up using, as mkdir can create a new one.  If this
-	 * happens, and another process tries the lookup at the same time,
-	 * it will set the PENDING flag on this new dentry, but add itself
-	 * to our waitq.  Then, if after the lookup succeeds, the first
-	 * process that requested the mount performs another lookup of the
-	 * same directory, it will show up as still pending!  So, we need
-	 * to redo the lookup here and clear pending on that dentry.
-	 */
-	if (d_unhashed(dentry)) {
-		new = d_lookup(dentry->d_parent, &dentry->d_name);
-		if (new) {
-			spin_lock(&new->d_lock);
-			new->d_flags &= ~DCACHE_AUTOFS_PENDING;
-			spin_unlock(&new->d_lock);
-			dput(new);
-		}
-	}
-
 	return 0;
 }
 
