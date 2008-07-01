From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/5] autofs4 - fix waitq locking
Date: Tue, 01 Jul 2008 17:26:06 +0800
Message-ID: <20080701092605.12041.64298.stgit@raven.themaw.net>
References: <20080701092548.12041.69868.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080701092548.12041.69868.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The autofs4_catatonic_mode() function accesses the wait queue without
any locking but can be called at any time. This could lead to a
possible double free of the name field of the wait and a double fput
of the daemon communication pipe or an fput of a NULL file pointer.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/inode.c |    4 ++--
 fs/autofs4/waitq.c |   23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)


diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index e3e7099..7bb3e5b 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -163,8 +163,8 @@ void autofs4_kill_sb(struct super_block *sb)
 	if (!sbi)
 		goto out_kill_sb;
 
-	if (!sbi->catatonic)
-		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
+	/* Free wait queues, close pipe */
+	autofs4_catatonic_mode(sbi);
 
 	/* Clean up and release dangling references */
 	autofs4_force_release(sbi);
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index d291b07..f8dee31 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -28,6 +28,12 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
 
+	mutex_lock(&sbi->wq_mutex);
+	if (sbi->catatonic) {
+		mutex_unlock(&sbi->wq_mutex);
+		return;
+	}
+
 	DPRINTK("entering catatonic mode");
 
 	sbi->catatonic = 1;
@@ -45,6 +51,8 @@ void autofs4_catatonic_mode(struct autofs_sb_info *sbi)
 	}
 	fput(sbi->pipe);	/* Close the pipe */
 	sbi->pipe = NULL;
+	sbi->pipefd = -1;
+	mutex_unlock(&sbi->wq_mutex);
 }
 
 static int autofs4_write(struct file *file, const void *addr, int bytes)
@@ -398,17 +406,10 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 			wq->name.name, notify);
 	}
 
-	/* wq->name is NULL if and only if the lock is already released */
-
-	if (sbi->catatonic) {
-		/* We might have slept, so check again for catatonic mode */
-		wq->status = -ENOENT;
-		if (wq->name.name) {
-			kfree(wq->name.name);
-			wq->name.name = NULL;
-		}
-	}
-
+	/*
+	 * wq->name.name is NULL iff the lock is already released
+	 * or the mount has been made catatonic.
+	 */
 	if (wq->name.name) {
 		/* Block all but "shutdown" signals while waiting */
 		sigset_t oldset;
