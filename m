From: Andrei Vagin <avagin@openvz.org>
Subject: [PATCH] autofs4: use wake_up() instead of wake_up_interruptible
Date: Fri, 30 Mar 2018 19:28:39 -0700
Message-ID: <20180331022839.21277-1-avagin@openvz.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=q0/Tgktlo0TN6a5tI0UEjZvwGI3Z3CaIMzwWUajoMNM=;
        b=PvkumO9Ey97EMxZKN10m1zVj8/BVp2vcJ9EFpBTERTRtFZ9WFQL2DW146EHHros59r
         O8cp28/BYz6CdvYMMCGHg/m5H4Ij+Dzchu6kLDjSepDMlTb+Oi48Ez9KMH1s1P+avVha
         g1QaKL/+1cAjaiitQ6DpiSLKEvN20znwuj3USJ3mVHR5r3CPimpbCtV/78gn9g0kuvyP
         eKsV4ZG3OdtxM2GM/le9pb9MyB6EN8kUAcCf9VXQpPiSDUMQjMqqse3y/3rYCCPb8DR5
         xO0NVx2brahDHcfnmYpBFp9MmQYGH4t4em20BsPGDuaFElKQPvi6R0bCpQP0UvYwphbx
         oBBA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>, Matthew Wilcox <mawilcox@microsoft.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

In "autofs4: use wait_event_killable",  wait_event_interruptible() was
replaced by wait_event_killable(), but in this case we have to use
wake_up() instead of wake_up_interruptible().

Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
---
 fs/autofs4/waitq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index c160e9b3aa0f..be9c3dc048ab 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -549,7 +549,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
 	kfree(wq->name.name);
 	wq->name.name = NULL;	/* Do not wait on this queue */
 	wq->status = status;
-	wake_up_interruptible(&wq->queue);
+	wake_up(&wq->queue);
 	if (!--wq->wait_ctr)
 		kfree(wq);
 	mutex_unlock(&sbi->wq_mutex);
-- 
2.13.6

