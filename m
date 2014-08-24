From: NeilBrown <neilb@suse.de>
Subject: [PATCH 3/6] autofs4: make "autofs4_can_expire" idempotent.
Date: Mon, 25 Aug 2014 08:42:36 +1000
Message-ID: <20140824224236.16196.77033.stgit@notabene.brown>
References: <20140824223628.16196.5795.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140824223628.16196.5795.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Have a "test" function change the value it is testing can
be confusing, particularly as a future patch will be calling
this function twice.

So move the update for 'last_used' to avoid repeat expiry
to the place where the final determination on what to expire is known.

Reviewed-by: Ian Kent <raven@themaw.net>
Tested-by: Ian Kent <raven@themaw.net>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/autofs4/expire.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index bee939efca2b..af09dada91bc 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -30,12 +30,6 @@ static inline int autofs4_can_expire(struct dentry *dentry,
 		/* Too young to die */
 		if (!timeout || time_after(ino->last_used + timeout, now))
 			return 0;
-
-		/* update last_used here :-
-		   - obviously makes sense if it is in use now
-		   - less obviously, prevents rapid-fire expire
-		     attempts if expire fails the first time */
-		ino->last_used = now;
 	}
 	return 1;
 }
@@ -541,6 +535,8 @@ int autofs4_expire_run(struct super_block *sb,
 
 	spin_lock(&sbi->fs_lock);
 	ino = autofs4_dentry_ino(dentry);
+	/* avoid rapid-fire expire attempts if expiry fails */
+	ino->last_used = now;
 	ino->flags &= ~AUTOFS_INF_EXPIRING;
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
@@ -567,6 +563,8 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
 
 		spin_lock(&sbi->fs_lock);
+		/* avoid rapid-fire expire attempts if expiry fails */
+		ino->last_used = now;
 		ino->flags &= ~AUTOFS_INF_EXPIRING;
 		complete_all(&ino->expire_complete);
 		spin_unlock(&sbi->fs_lock);

