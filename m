From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 deadlock during expire - kernel 2.6
Date: Wed, 24 Sep 2003 21:01:56 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0309242059120.4975-100000@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Maneesh Soni <maneesh@in.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, Jeremy Fitzhardinge <jeremy@goop.org>


This is a corrected patch for the autofs4 daedlock problem I posted about 
yesterday.

As before comments please.

diff -Nur autofs4-2.6.orig/fs/autofs4/autofs_i.h autofs4-2.6.deadlock/fs/autofs4/autofs_i.h
--- autofs4-2.6.orig/fs/autofs4/autofs_i.h	2003-09-09 03:50:14.000000000 +0800
+++ autofs4-2.6.deadlock/fs/autofs4/autofs_i.h	2003-09-22 22:48:11.000000000 +0800
@@ -82,6 +82,7 @@
 	char *name;
 	/* This is for status reporting upon return */
 	int status;
+	struct task_struct *owner;
 	int wait_ctr;
 };
 
diff -Nur autofs4-2.6.orig/fs/autofs4/waitq.c autofs4-2.6.deadlock/fs/autofs4/waitq.c
--- autofs4-2.6.orig/fs/autofs4/waitq.c	2003-09-09 03:50:31.000000000 +0800
+++ autofs4-2.6.deadlock/fs/autofs4/waitq.c	2003-09-24 00:10:38.000000000 +0800
@@ -165,6 +165,7 @@
 		wq->status = -EINTR; /* Status return if interrupted */
 		memcpy(wq->name, name->name, name->len);
 		wq->next = sbi->queues;
+		wq->owner = current;
 		sbi->queues = wq;
 
 		DPRINTK(("autofs_wait: new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
@@ -206,6 +207,11 @@
 
 		interruptible_sleep_on(&wq->queue);
 
+		if (waitqueue_active(&wq->queue) && current != wq->owner) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(wq->wait_ctr * (HZ/10));
+		}
+
 		spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
