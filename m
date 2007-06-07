From: Anders Blomdell <anders.blomdell@control.lth.se>
Subject: Minor change to alarm_handler to avoid code duplication
Date: Thu, 07 Jun 2007 15:49:35 +0200
Message-ID: <46680CEF.2080803@control.lth.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050606080104070605020809"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050606080104070605020809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

As per request from discussions in
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=241780
a patch against git.

Best regards

Anders Blomdell

--------------050606080104070605020809
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
	name="alarm_handler.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alarm_handler.patch"

--- autofs/lib/alarm.c	2007-06-07 15:05:03.000000000 +0200
+++ /usr/src/autofs/autofs.patched/lib/alarm.c	2007-06-07 15:08:29.000000000 +0200
@@ -28,16 +28,16 @@
 
 #define alarm_lock() \
 do { \
-	int _alm_lock = pthread_mutex_lock(&mutex); \
-	if (_alm_lock) \
-		fatal(_alm_lock); \
+	int status = pthread_mutex_lock(&mutex); \
+	if (status) \
+		fatal(status); \
 } while (0)
 
 #define alarm_unlock() \
 do { \
-	int _alm_unlock = pthread_mutex_unlock(&mutex); \
-	if (_alm_unlock) \
-		fatal(_alm_unlock); \
+	int status = pthread_mutex_unlock(&mutex); \
+	if (status) \
+		fatal(status); \
 } while (0)
 
 void dump_alarms(void)
@@ -168,87 +168,65 @@
 static void *alarm_handler(void *arg)
 {
 	struct list_head *head;
-	struct timespec expire;
-	time_t now;
 	int status;
-
+	
 	alarm_lock();
 
 	head = &alarms;
 
 	while (1) {
-		struct alarm *current;
-
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
-		}
-
-		current = list_entry(head->next, struct alarm, list);
-
-		now = time(NULL);
-
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
-
-			status = pthread_cond_timedwait(&cond, &mutex, &expire);
-			if (status && status != ETIMEDOUT)
-				fatal(status);
-
-			next = list_entry(head->next, struct alarm, list);
-			if (next->cancel) {
-				list_del(&next->list);
-				free(next);
-				break;
+		} else {
+			struct alarm *first;
+			time_t now;
+
+			first = list_entry(head->next, struct alarm, list);
+
+			now = time(NULL);
+
+			if (first->time > now) {
+				/* Wait for alarm to trigger or a new alarm 
+				   to be added */
+				struct timespec expire;
+
+				expire.tv_sec = first->time;
+				expire.tv_nsec = 0;
+
+				status = pthread_cond_timedwait(&cond, &mutex,
+								&expire);
+				if (status && status != ETIMEDOUT)
+					fatal(status);
+			} else {
+				/* First alarm has triggered, run it */
+				struct autofs_point *ap;
+
+				list_del(&first->list);
+				ap = first->ap;
+				if (!first->cancel) {
+					/* We need to unlock the alarm list 
+					   in case some other thread holds 
+					   the state_mutex_lock(ap), and is 
+					   currently trying to do some 
+					   alarm_* function (i.e if we don't 
+					   unlock, we might deadlock) */
+					alarm_unlock(); 
+
+					state_mutex_lock(ap);
+					nextstate(ap->state_pipe[1], 
+						  ST_EXPIRE);
+					state_mutex_unlock(ap);
+
+					alarm_lock();
+				}
+				free(first);
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
 		}
 	}
+	/* Will never come here, so alarm_unlock is not necessary */
 }
 
 int alarm_start_handler(void)

--------------050606080104070605020809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050606080104070605020809--

