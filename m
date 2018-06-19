From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/6] autofs - fix clearing AUTOFS_EXP_LEAVES in
 autofs_expire_indirect()
Date: Tue, 19 Jun 2018 11:02:04 +0800
Message-ID: <152937732410.21213.7447294898147765076.stgit@pluto.themaw.net>
References: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The expire flag AUTOFS_EXP_LEAVES is cleared before the second
call to should_expire() in autofs_expire_indirect() but the
parameter passed in the second call is incorrect.

Fortunately AUTOFS_EXP_LEAVES expire flag has not been used for
a long time but might be needed in the future so fix it rather
than remove the expire leaves functionality.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 295feec10ea6..41855cdc5630 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -467,7 +467,7 @@ struct dentry *autofs_expire_indirect(struct super_block *sb,
 		 * things have changed.
 		 */
 		flags &= ~AUTOFS_EXP_LEAVES;
-		found = should_expire(expired, mnt, timeout, how);
+		found = should_expire(expired, mnt, timeout, flags);
 		if (!found || found != expired)
 			/* Something has changed, continue */
 			goto next;

