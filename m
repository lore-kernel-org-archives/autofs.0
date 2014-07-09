From: NeilBrown <neilb@suse.de>
Subject: [PATCH 1/6] autofs4: remove unused autofs4_ispending()
Date: Thu, 10 Jul 2014 09:41:14 +1000
Message-ID: <20140709234114.4525.94513.stgit@notabene.brown>
References: <20140709233541.4525.25151.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140709233541.4525.25151.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/autofs4/autofs_i.h |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index acf32054edd8..22a280151e45 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -143,20 +143,6 @@ static inline int autofs4_oz_mode(struct autofs_sb_info *sbi) {
 	return sbi->catatonic || task_pgrp(current) == sbi->oz_pgrp;
 }
 
-/* Does a dentry have some pending activity? */
-static inline int autofs4_ispending(struct dentry *dentry)
-{
-	struct autofs_info *inf = autofs4_dentry_ino(dentry);
-
-	if (inf->flags & AUTOFS_INF_PENDING)
-		return 1;
-
-	if (inf->flags & AUTOFS_INF_EXPIRING)
-		return 1;
-
-	return 0;
-}
-
 struct inode *autofs4_get_inode(struct super_block *, umode_t);
 void autofs4_free_ino(struct autofs_info *);
 

