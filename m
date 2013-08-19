From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/25] autofs-5.0.7 - dont start readmap unless ready
Date: Mon, 19 Aug 2013 09:12:20 +0800
Message-ID: <20130819011219.6472.86472.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=/nyIWc83oaTDAiN+O+Za0G4cl/I=; b=BXAWt+r6ZagGPgxlVkftP8oKYh1M
	DeUTtRWJtCjABd9jSQUOVKcEHSAAMkhMICUdg/XuVXBOUxFrLRY2gM2EbotlsNxx
	qmyQ6HJrMui3RCTWSGNZtCGwAODCGfhh26f7ThnBXP8BLfL9BprH78cUAoNST9TT
	Q1mxw0gW7gzb6JY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=/nyIWc83oaTDAiN+O+Za0G
	4cl/I=; b=DC2DqYWAOl3MdPq0oQyLNQKnq9QbcUOshpemZ14OiPVwFVYe5Cs1wE
	s0lCw+vGkGA0REE0SJAbDr/w7fOfaMk3pFKbDSU4KcChIefGXbrhuD2PVPME8iUa
	H4p/MEGU92g9jQClTHZWkjr+YlRHMAiHBslNfI2oPA0Xb4Ftmjs7U=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Ian Kent <ikent@redhat.com>

State transitions should only be made when an autofs point goes
to state ST_READY or when a new task is added to an empty task
queue.
---
 CHANGELOG      |    1 +
 daemon/state.c |   15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2734fe3..3228d6b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -56,6 +56,7 @@
 - don't override LDFLAGS in make rules.
 - fix a couple of compiler warnings.
 - add after sssd dependency to unit file.
+- dont start readmap unless ready.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/daemon/state.c b/daemon/state.c
index ddc5556..8d81788 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -818,14 +818,13 @@ done:
 		new = st_alloc_task(ap, state);
 		if (new)
 			list_add(&new->list, head);
+		/* Added to empty state queue, kick state machine */
+		signaled = 1;
+		status = pthread_cond_signal(&cond);
+		if (status)
+			fatal(status);
 	}
 
-	/* Added task, encourage state machine */
-	signaled = 1;
-	status = pthread_cond_signal(&cond);
-	if (status)
-		fatal(status);
-
 	return 1;
 }
 
@@ -1131,6 +1130,10 @@ static void *st_queue_handler(void *arg)
 				task = list_entry(p, struct state_queue, list);
 				p = p->next;
 
+				/* Task may have been canceled before it started */
+				if (!task->thid && task->cancel)
+					goto remove;
+
 				if (!task->busy) {
 					/* Start a new task */
 					task->busy = 1;

