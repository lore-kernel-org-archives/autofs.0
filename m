From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Fri, 23 May 2008 10:35:00 +0800
Message-ID: <1211510100.15090.27.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1211083674.3118.5.camel@raven.themaw.net>
	<20080522214233.7F5D4211250@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080522214233.7F5D4211250@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org


On Thu, 2008-05-22 at 14:42 -0700, Jim Carter wrote:
> Sorry for the delay -- we have a crisis with KDE menus disappearing :-(
> Anyway: the new patch did not stop the hanging, unfortunately.  Again 
> upon the first hang gdb was not able to print out the individual thread
> tracebacks, but the second time around, it succeeded.  But strangely,
> the hung daemon thread from the first hang is easily identified, but
> strings pertaining to the second hang are not evident.
> 
> I'm calling the patch "take-submount-lock". 

OK. I've named the patch
autofs-5.0.3-lock-submount-before-state-change.patch but it doesn't
really matter because it will be folded into the patch tittled
"autofs-5.0.3 - fix submount shutdown handling" which currently has the
name autofs-5.0.3-submount-shutdown-recovery-5.patch and will likely end
up with a 6 when I do this. I'm going to retain this submount locking
even though it may not be the source of the problem as I think it's an
improvement.

However, I'll keep the patch below separate as it (possibly) addresses a
different issue. I've named it
autofs-5.0.3-expire-thread-create-cond-handling.patch.

I'm sorry for all this hassle and I appreciate your patience and efforts
to help out very much.

But onto the issue.

I've looked at this again, on a broader front.
I think there are two possible causes.

One is that umount(8) is faulting and the expire thread is disappearing
because of it. I've seen that happen before so it is certainly possible.
But I don't want to add code to work around that yet because it would
mask a possible bug in the daemon.

The other possibility is my poor pthreads condition handling at expire
thread (the thread that does the actual umount) creation. In the early
development I changed the code, for both mount and umount thread
creation, time and again and ended up with something that appeared to
work for around 18 months. But then, recently, I suddenly started seeing
a hang with heavy mount activity. So I changed the code again, and
although I can understand why it started working with this change, I'm
still a little puzzled because I think it really should have continued
to function. Anyway, I've made this same alteration to the expire thread
creation in case the same thing is happening. The code is very similar
in both cases so it's a good candidate.

autofs-5.0.3 - fix incorrect pthreads condition handling for expire requests.

From: Ian Kent <raven@themaw.net>


---

 daemon/direct.c   |   40 +++++++++++++++++++++-------------------
 daemon/indirect.c |   28 +++++++++++++++-------------
 2 files changed, 36 insertions(+), 32 deletions(-)


diff --git a/daemon/direct.c b/daemon/direct.c
index 86c817c..4b35aba 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1052,55 +1052,53 @@ static void expire_mutex_unlock(void *arg)
 
 static void *do_expire_direct(void *arg)
 {
-	struct pending_args *mt;
+	struct pending_args *args, mt;
 	struct autofs_point *ap;
 	size_t len;
 	int status, state;
 
-	mt = (struct pending_args *) arg;
+	args = (struct pending_args *) arg;
 
 	status = pthread_mutex_lock(&ea_mutex);
 	if (status)
 		fatal(status);
 
-	ap = mt->ap;
+	memcpy(&mt, args, sizeof(struct pending_args));
 
-	mt->signaled = 1;
-	status = pthread_cond_signal(&mt->cond);
+	ap = mt.ap;
+
+	args->signaled = 1;
+	status = pthread_cond_signal(&args->cond);
 	if (status)
 		fatal(status);
 
 	expire_mutex_unlock(NULL);
 
-	pthread_cleanup_push(free_pending_args, mt);
-	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(expire_send_fail, mt);
+	pthread_cleanup_push(expire_send_fail, &mt);
 
-	len = _strlen(mt->name, KEY_MAX_LEN);
+	len = _strlen(mt.name, KEY_MAX_LEN);
 	if (!len) {
-		warn(ap->logopt, "direct key path too long %s", mt->name);
+		warn(ap->logopt, "direct key path too long %s", mt.name);
 		/* TODO: force umount ?? */
 		pthread_exit(NULL);
 	}
 
-	status = do_expire(ap, mt->name, len);
+	status = do_expire(ap, mt.name, len);
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
 	if (status)
-		send_fail(ap->logopt, mt->ioctlfd, mt->wait_queue_token);
+		send_fail(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
 	else {
 		struct mapent *me;
-		cache_readlock(mt->mc);
-		me = cache_lookup_distinct(mt->mc, mt->name);
+		cache_readlock(mt.mc);
+		me = cache_lookup_distinct(mt.mc, mt.name);
 		me->ioctlfd = -1;
-		cache_unlock(mt->mc);
-		send_ready(ap->logopt, mt->ioctlfd, mt->wait_queue_token);
-		close(mt->ioctlfd);
+		cache_unlock(mt.mc);
+		send_ready(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
+		close(mt.ioctlfd);
 	}
 	pthread_setcancelstate(state, NULL);
 
 	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(1);
-	pthread_cleanup_pop(1);
 
 	return NULL;
 }
@@ -1196,6 +1194,8 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 
 	cache_unlock(mc);
 
+	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_cond_destroy, mt);
 	pthread_cleanup_push(expire_mutex_unlock, NULL);
 	pthread_setcancelstate(state, NULL);
 
@@ -1207,6 +1207,8 @@ int handle_packet_expire_direct(struct autofs_point *ap, autofs_packet_expire_di
 	}
 
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
diff --git a/daemon/indirect.c b/daemon/indirect.c
index c1bd3f2..81c7c84 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -595,40 +595,38 @@ static void expire_mutex_unlock(void *arg)
 
 static void *do_expire_indirect(void *arg)
 {
-	struct pending_args *mt;
+	struct pending_args *args, mt;
 	struct autofs_point *ap;
 	int status, state;
 
-	mt = (struct pending_args *) arg;
+	args = (struct pending_args *) arg;
 
 	status = pthread_mutex_lock(&ea_mutex);
 	if (status)
 		fatal(status);
 
-	ap = mt->ap;
+	memcpy(&mt, args, sizeof(struct pending_args));
+
+	ap = mt.ap;
 
-	mt->signaled = 1;
-	status = pthread_cond_signal(&mt->cond);
+	args->signaled = 1;
+	status = pthread_cond_signal(&args->cond);
 	if (status)
 		fatal(status);
 
 	expire_mutex_unlock(NULL);
 
-	pthread_cleanup_push(free_pending_args, mt);
-	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(expire_send_fail, mt);
+	pthread_cleanup_push(expire_send_fail, &mt);
 
-	status = do_expire(mt->ap, mt->name, mt->len);
+	status = do_expire(mt.ap, mt.name, mt.len);
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
 	if (status)
-		send_fail(ap->logopt, ap->ioctlfd, mt->wait_queue_token);
+		send_fail(ap->logopt, ap->ioctlfd, mt.wait_queue_token);
 	else
-		send_ready(ap->logopt, ap->ioctlfd, mt->wait_queue_token);
+		send_ready(ap->logopt, ap->ioctlfd, mt.wait_queue_token);
 	pthread_setcancelstate(state, NULL);
 
 	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(1);
-	pthread_cleanup_pop(1);
 
 	return NULL;
 }
@@ -679,6 +677,8 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 		return 1;
 	}
 
+	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_cond_destroy, mt);
 	pthread_cleanup_push(expire_mutex_unlock, NULL);
 	pthread_setcancelstate(state, NULL);
 
@@ -690,6 +690,8 @@ int handle_packet_expire_indirect(struct autofs_point *ap, autofs_packet_expire_
 	}
 
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
