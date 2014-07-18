From: NeilBrown <neilb@suse.de>
Subject: [PATCH 2/5] autofs4: remove a redundant assignment
Date: Fri, 18 Jul 2014 10:48:28 +1000
Message-ID: <20140718004828.19389.22656.stgit@notabene.brown>
References: <20140718004353.19389.48104.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718004353.19389.48104.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

The variable 'ino' already exists and already
has the correct value.  The d_fsdata of a dentry
is never changed after the d_fsdata is instantiated,
so this new assignment cannot be necessary.

It was introduced in
commit b5b801779d59165c4ecf1009009109545bd1f642
    autofs4: Add d_manage() dentry operation

Signed-off-by: NeilBrown <neilb@suse.de>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/expire.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 394e90b02c5e..a7be57e39be7 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -333,7 +333,6 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
 	if (ino->flags & AUTOFS_INF_PENDING)
 		goto out;
 	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
-		struct autofs_info *ino = autofs4_dentry_ino(root);
 		ino->flags |= AUTOFS_INF_EXPIRING;
 		init_completion(&ino->expire_complete);
 		spin_unlock(&sbi->fs_lock);

