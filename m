From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] autofs4: Use wait_event_killable
Date: Mon, 19 Mar 2018 12:16:09 -0700
Message-ID: <20180319191609.23880-1-willy@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HAwRmn3MWkWKy1TIkSdZy0xl+rZjU3129LoPVJV5+jQ=; b=mE24WuYJwqC/tC/UUWFtvcSwI
        y2CnM+nRxHciohcRwcLv9ks2ual1jaD2G69ir44CXZ3yU0iKYdRnqa6MS8IgTHJDY8Onux3wVWiYY
        XG+m6lYyCBhGOPABH9E/xJvkpvC8QEH7qwFnznWJFHKqSy8nDgu7EUKjRKkUFlca1zg6X74ZKICUF
        vhud7yhveXWzUxQHM4wglLvR/y5fdT+ZMjIt0Q1c1uhLbbdQplCyVRdJJyNpfoZ2yC8gEWBS/ce39
        6Sb2iWkYOUNigtTZBOcL73Ute9r82v6rj3psB3aZYES2cZNde+DB2faH9Cs0CqLINb98PpyBuojBu
    
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>

From: Matthew Wilcox <mawilcox@microsoft.com>

This playing with signals to allow only fatal signals appears to predate
the introduction of wait_event_killable(), and I'm fairly sure that
wait_event_killable is what was meant to happen here.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/autofs4/waitq.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index a0c57c37fa21..c160e9b3aa0f 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -19,9 +19,6 @@
  */
 static autofs_wqt_t autofs4_next_wait_queue = 1;
 
-/* These are the signals we allow interrupting a pending mount */
-#define SHUTDOWN_SIGS	(sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))
-
 void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
@@ -486,29 +483,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 	 * wq->name.name is NULL iff the lock is already released
 	 * or the mount has been made catatonic.
 	 */
-	if (wq->name.name) {
-		/* Block all but "shutdown" signals while waiting */
-		unsigned long shutdown_sigs_mask;
-		unsigned long irqflags;
-		sigset_t oldset;
-
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
-		oldset = current->blocked;
-		shutdown_sigs_mask = SHUTDOWN_SIGS & ~oldset.sig[0];
-		siginitsetinv(&current->blocked, shutdown_sigs_mask);
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
-
-		wait_event_interruptible(wq->queue, wq->name.name == NULL);
-
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
-		current->blocked = oldset;
-		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
-	} else {
-		pr_debug("skipped sleeping\n");
-	}
-
+	wait_event_killable(wq->queue, wq->name.name == NULL);
 	status = wq->status;
 
 	/*
-- 
2.16.2

