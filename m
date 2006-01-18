From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/13] autofs4 - white space cleanup for waitq.c
Date: Wed, 18 Jan 2006 15:24:09 +0800
Message-ID: <200601180724.k0I7O9Go006193@eagle.themaw.net>
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org, Kernel Mailing List <linux-kernel@vger.kernel.org>

Whitespace and formating changes to waitq code.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.15-rc5-mm3/fs/autofs4/waitq.c.waitq-cleanup	2006-01-02 13:28:54.000000000 +0800
+++ linux-2.6.15-rc5-mm3/fs/autofs4/waitq.c	2006-01-02 13:28:35.000000000 +0800
@@ -33,7 +33,7 @@ void autofs4_catatonic_mode(struct autof
 	sbi->catatonic = 1;
 	wq = sbi->queues;
 	sbi->queues = NULL;	/* Erase all wait queues */
-	while ( wq ) {
+	while (wq) {
 		nwq = wq->next;
 		wq->status = -ENOENT; /* Magic is gone - report failure */
 		kfree(wq->name);
@@ -45,7 +45,6 @@ void autofs4_catatonic_mode(struct autof
 		fput(sbi->pipe);	/* Close the pipe */
 		sbi->pipe = NULL;
 	}
-
 	shrink_dcache_sb(sbi->sb);
 }
 
@@ -165,7 +164,7 @@ int autofs4_wait(struct autofs_sb_info *
 	int len, status;
 
 	/* In catatonic mode, we don't wait for nobody */
-	if ( sbi->catatonic )
+	if (sbi->catatonic)
 		return -ENOENT;
 	
 	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
@@ -190,7 +189,7 @@ int autofs4_wait(struct autofs_sb_info *
 			break;
 	}
 
-	if ( !wq ) {
+	if (!wq) {
 		/* Can't wait for an expire if there's no mount */
 		if (notify == NFY_NONE && !d_mountpoint(dentry)) {
 			kfree(name);
@@ -200,7 +199,7 @@ int autofs4_wait(struct autofs_sb_info *
 
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
-		if ( !wq ) {
+		if (!wq) {
 			kfree(name);
 			up(&sbi->wq_sem);
 			return -ENOMEM;
@@ -240,14 +239,14 @@ int autofs4_wait(struct autofs_sb_info *
 
 	/* wq->name is NULL if and only if the lock is already released */
 
-	if ( sbi->catatonic ) {
+	if (sbi->catatonic) {
 		/* We might have slept, so check again for catatonic mode */
 		wq->status = -ENOENT;
 		kfree(wq->name);
 		wq->name = NULL;
 	}
 
-	if ( wq->name ) {
+	if (wq->name) {
 		/* Block all but "shutdown" signals while waiting */
 		sigset_t oldset;
 		unsigned long irqflags;
@@ -283,12 +282,12 @@ int autofs4_wait_release(struct autofs_s
 	struct autofs_wait_queue *wq, **wql;
 
 	down(&sbi->wq_sem);
-	for ( wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next ) {
-		if ( wq->wait_queue_token == wait_queue_token )
+	for (wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next) {
+		if (wq->wait_queue_token == wait_queue_token)
 			break;
 	}
 
-	if ( !wq ) {
+	if (!wq) {
 		up(&sbi->wq_sem);
 		return -EINVAL;
 	}
