From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/2] autofs4: store struct pids in autofs_waitqs
Date: Wed, 19 Sep 2012 17:29:36 +0200
Message-ID: <1348068576-21363-3-git-send-email-miklos@szeredi.hu>
References: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1ABq1Q3JbhU9c+mUHnej1bGfpUZW2yG705EStXlDpVg=;
        b=SzkKFhTBDkTvVAHPtMnakflHXMc7lfrXgMOKtSr499rUcU4OPJFgGSppUFYlkeQ6Hh
         q+jwZRXlTXFFUOjWzUaVbe2dWTB61sV4aCepAAlmD2G9MUaeJlnic0BA6nMg2ownv/S6
         yHPLptjrgWvfltiX/9VISVHhjgXCc92i/MLmY=
In-Reply-To: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com, mszeredi@suse.cz

From: Serge Hallyn <serue@us.ibm.com>

Store struct pids in autofs_waitqs in place of pidnrs to prevent
pid overflow problems.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
---
 fs/autofs4/autofs_i.h |    4 ++--
 fs/autofs4/waitq.c    |   19 +++++++++++++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 8457a1f..c3b3302 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -91,8 +91,8 @@ struct autofs_wait_queue {
 	u64 ino;
 	uid_t uid;
 	gid_t gid;
-	pid_t pid;
-	pid_t tgid;
+	struct pid *pid;
+	struct pid *tgid;
 	/* This is for status reporting upon return */
 	int status;
 	unsigned int wait_ctr;
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index da8876d..27b18ae 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -165,8 +165,8 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		packet->ino = wq->ino;
 		packet->uid = wq->uid;
 		packet->gid = wq->gid;
-		packet->pid = wq->pid;
-		packet->tgid = wq->tgid;
+		packet->pid = pid_nr(wq->pid);
+		packet->tgid = pid_nr(wq->tgid);
 		break;
 	}
 	default:
@@ -348,6 +348,13 @@ static int validate_request(struct autofs_wait_queue **wait,
 	return 1;
 }
 
+static void autofs_free_wait_queue(struct autofs_wait_queue *wq)
+{
+	put_pid(wq->pid);
+	put_pid(wq->tgid);
+	kfree(wq);
+}
+
 int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		enum autofs_notify notify)
 {
@@ -425,8 +432,8 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		wq->ino = autofs4_get_ino(sbi);
 		wq->uid = current_uid();
 		wq->gid = current_gid();
-		wq->pid = current->pid;
-		wq->tgid = current->tgid;
+		wq->pid = get_pid(task_pid(current));
+		wq->tgid = get_pid(task_tgid(current));
 		wq->status = -EINTR; /* Status return if interrupted */
 		wq->wait_ctr = 2;
 		mutex_unlock(&sbi->wq_mutex);
@@ -526,7 +533,7 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 	/* Are we the last process to need status? */
 	mutex_lock(&sbi->wq_mutex);
 	if (!--wq->wait_ctr)
-		kfree(wq);
+		autofs_free_wait_queue(wq);
 	mutex_unlock(&sbi->wq_mutex);
 
 	return status;
@@ -554,7 +561,7 @@ int autofs4_wait_release(struct autofs_sb_info *sbi, autofs_wqt_t wait_queue_tok
 	wq->status = status;
 	wake_up_interruptible(&wq->queue);
 	if (!--wq->wait_ctr)
-		kfree(wq);
+		autofs_free_wait_queue(wq);
 	mutex_unlock(&sbi->wq_mutex);
 
 	return 0;
-- 
1.7.7
