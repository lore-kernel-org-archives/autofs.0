From: raven@themaw.net
Subject: [PATCH 1/3] autofs4 - expiring filesystem from under process
Date: Sun, 10 Apr 2005 20:48:34 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <michael@kmaclub.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>


autofs4-2.6.12-rc1-mm4-wait-order.patch

It's possible for an event wait request to arive before the event
requestor. If this happens the daemon never gets notified and autofs
hangs.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.12-rc1-mm4/fs/autofs4/waitq.c.wait-order	2005-04-03 12:30:14.000000000 +0800
+++ linux-2.6.12-rc1-mm4/fs/autofs4/waitq.c	2005-04-03 12:31:57.000000000 +0800
@@ -210,17 +210,8 @@ int autofs4_wait(struct autofs_sb_info *
  		wq->len = len;
  		wq->status = -EINTR; /* Status return if interrupted */
  		atomic_set(&wq->wait_ctr, 2);
+		atomic_set(&wq->notified, 1);
  		up(&sbi->wq_sem);
-
-		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d",
-			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
-		/* autofs4_notify_daemon() may block */
-		if (notify != NFY_NONE) {
-			autofs4_notify_daemon(sbi,wq, 
-					notify == NFY_MOUNT ?
-						  autofs_ptype_missing :
-						  autofs_ptype_expire_multi);
-		}
  	} else {
  		atomic_inc(&wq->wait_ctr);
  		up(&sbi->wq_sem);
@@ -229,6 +220,17 @@ int autofs4_wait(struct autofs_sb_info *
  			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
  	}

+	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
+		int type = (notify == NFY_MOUNT ? 
+			autofs_ptype_missing : autofs_ptype_expire_multi);
+
+		DPRINTK(("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
+			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify));
+
+		/* autofs4_notify_daemon() may block */
+		autofs4_notify_daemon(sbi, wq, type);
+	}
+
  	/* wq->name is NULL if and only if the lock is already released */

  	if ( sbi->catatonic ) {
--- linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h.wait-order	2005-04-03 12:30:24.000000000 +0800
+++ linux-2.6.12-rc1-mm4/fs/autofs4/autofs_i.h	2005-04-03 12:30:46.000000000 +0800
@@ -84,6 +84,7 @@ struct autofs_wait_queue {
  	char *name;
  	/* This is for status reporting upon return */
  	int status;
+	atomic_t notified;
  	atomic_t wait_ctr;
  };

