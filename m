From: Ian Kent <raven@themaw.net>
Subject: Re: Minor change to alarm_handler to avoid	code	duplication
Date: Wed, 13 Jun 2007 12:13:29 +0800
Message-ID: <1181708009.3336.12.camel@shark.themaw.net>
References: <46680CEF.2080803@control.lth.se>
	<1181538390.3423.27.camel@shark.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1181538390.3423.27.camel@shark.themaw.net>
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
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: autofs@linux.kernel.org

On Mon, 2007-06-11 at 13:06 +0800, Ian Kent wrote:
> On Thu, 2007-06-07 at 15:49 +0200, Anders Blomdell wrote:
> > As per request from discussions in
> > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=241780
> > a patch against git.
> 
> Yes, on closer inspection this version does look ok.
> Let me think about it for a little while in case I missed something.
> 

Hi Anders,

This does indeed give some simplification to the alarm_handler function
and, as far as I can tell, retains the semantics of the original
function.

I've changed the patch around a little.
I removed the change to the mutex macros, in line with my comments
before, and I've re-structured the code a little.

Could you have a look and check that I haven't made any stupid mistakes
and that the patch still works the way you intended please.

Ian

---
diff --git a/lib/alarm.c b/lib/alarm.c
index 4a72605..c6c4ba3 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -169,6 +169,7 @@ static void *alarm_handler(void *arg)
 {
 	struct list_head *head;
 	struct timespec expire;
+	struct alarm *first;
 	time_t now;
 	int status;
 
@@ -177,78 +178,56 @@ static void *alarm_handler(void *arg)
 	head = &alarms;
 
 	while (1) {
-		struct alarm *current;
 
-		/*
-		 * If the alarm list is empty, wait until an alarm is
-		 * added.
-		 */
-		while (list_empty(head)) {
+		if (list_empty(head)) {
+			/* No alarms, wait for one to be added */
 			status = pthread_cond_wait(&cond, &mutex);
 			if (status)
 				fatal(status);
+			continue;
 		}
 
-		current = list_entry(head->next, struct alarm, list);
+		first = list_entry(head->next, struct alarm, list);
 
 		now = time(NULL);
 
-		if (current->time <= now) {
-			struct autofs_point *ap;
-
-			list_del(&current->list);
-
-			if (current->cancel) {
-				free(current);
-				continue;
-			}
-
-			ap = current->ap;
-			free(current);
-			alarm_unlock();
-
-			state_mutex_lock(ap);
-			nextstate(ap->state_pipe[1], ST_EXPIRE);
-			state_mutex_unlock(ap);
-
-			alarm_lock();
-			continue;
-		}
-
-		expire.tv_sec = current->time;
-		expire.tv_nsec = 0;
-
-		while (1) {
-			struct autofs_point *ap;
-			struct alarm *next;
+		if (first->time > now) {
+			/* 
+			 * Wait for alarm to trigger or a new alarm 
+			 * to be added.
+			 */
+			expire.tv_sec = first->time;
+			expire.tv_nsec = 0;
 
 			status = pthread_cond_timedwait(&cond, &mutex, &expire);
 			if (status && status != ETIMEDOUT)
 				fatal(status);
-
-			next = list_entry(head->next, struct alarm, list);
-			if (next->cancel) {
-				list_del(&next->list);
-				free(next);
-				break;
+		} else {
+			/* First alarm has triggered, run it */
+
+			list_del(&first->list);
+
+			if (!first->cancel) {
+				struct autofs_point *ap = first->ap;
+				/* 
+				 * We need to unlock the alarm list in case
+				 * some other thread holds the state_mutex
+				 *_lock(ap), and is currently trying to do
+				 * some alarm_* function (i.e if we don't 
+				 * unlock, we might deadlock).
+				 */
+				alarm_unlock(); 
+
+				state_mutex_lock(ap);
+				nextstate(ap->state_pipe[1], ST_EXPIRE);
+				state_mutex_unlock(ap);
+
+				alarm_lock();
 			}
-
-			if (next != current)
-				break;
-
-			list_del(&current->list);
-			ap = current->ap;
-			free(current);
-			alarm_unlock();
-
-			state_mutex_lock(ap);
-			nextstate(ap->state_pipe[1], ST_EXPIRE);
-			state_mutex_unlock(ap);
-
-			alarm_lock();
-			break;
+			free(first);
 		}
 	}
+	/* Will never come here, so alarm_unlock is not necessary */
 }
 
 int alarm_start_handler(void)
