From: Alexey Dobriyan <adobriyan@mail.ru>
Subject: [PATCH] autofs: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 11:34:08 +0200
Message-ID: <200501091134.08899.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs@linux.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.10-bk11-warnings/fs/autofs/waitq.c
===================================================================
--- linux-2.6.10-bk11-warnings/fs/autofs/waitq.c	(revision 8)
+++ linux-2.6.10-bk11-warnings/fs/autofs/waitq.c	(revision 9)
@@ -183,7 +183,7 @@
 {
 	struct autofs_wait_queue *wq, **wql;
 
-	for ( wql = &sbi->queues ; (wq = *wql) != 0 ; wql = &wq->next ) {
+	for ( wql = &sbi->queues ; (wq = *wql) != NULL ; wql = &wq->next ) {
 		if ( wq->wait_queue_token == wait_queue_token )
 			break;
 	}
