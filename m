From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - atomic var underflow - obvious programming error
Date: Sun, 26 Mar 2006 19:41:18 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0603261921380.6061@eagle.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

Here is the patch I have for the underflow of reported recently.

It looks like an obvious programming error on my part (as usual).

Signed-off-by: Ian Kent <raven@themaw.net>

--

--- linux-2.6.16-rc6-mm1/fs/autofs4/waitq.c.notify-bug	2006-03-13 13:23:52.000000000 +0800
+++ linux-2.6.16-rc6-mm1/fs/autofs4/waitq.c	2006-03-13 13:25:40.000000000 +0800
@@ -263,7 +263,7 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->tgid = current->tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
 		atomic_set(&wq->wait_ctr, 2);
-		atomic_set(&wq->notified, 1);
+		atomic_set(&wq->notify, 1);
 		mutex_unlock(&sbi->wq_mutex);
 	} else {
 		atomic_inc(&wq->wait_ctr);
@@ -273,9 +273,11 @@ int autofs4_wait(struct autofs_sb_info *
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
 	}
 
-	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
+	if (notify != NFY_NONE && atomic_read(&wq->notify)) {
 		int type;
 
+		atomic_dec(&wq->notify);
+
 		if (sbi->version < 5) {
 			if (notify == NFY_MOUNT)
 				type = autofs_ptype_missing;
--- linux-2.6.16-rc6-mm1/fs/autofs4/autofs_i.h.notify-bug	2006-03-13 13:23:39.000000000 +0800
+++ linux-2.6.16-rc6-mm1/fs/autofs4/autofs_i.h	2006-03-13 13:24:08.000000000 +0800
@@ -85,7 +85,7 @@ struct autofs_wait_queue {
 	pid_t tgid;
 	/* This is for status reporting upon return */
 	int status;
-	atomic_t notified;
+	atomic_t notify;
 	atomic_t wait_ctr;
 };
 
