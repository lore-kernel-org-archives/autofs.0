From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Sun, 18 May 2008 12:07:54 +0800
Message-ID: <1211083674.3118.5.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1210492627.3006.57.camel@raven.themaw.net>
	<20080515215941.6221B21124E@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080515215941.6221B21124E@simba.math.ucla.edu>
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


On Thu, 2008-05-15 at 14:59 -0700, Jim Carter wrote:
> Thread 4 (Thread 0x79aeeb90 (LWP 8592)):
> #0  0xffffe410 in __kernel_vsyscall ()
> #1  0xb7ecb817 in poll () from /lib/libc.so.6
> #2  0x8000a343 in handle_mounts (arg=0x800bd540) at automount.c:909
> #3  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> #4  0xb7ed502e in clone () from /lib/libc.so.6
> 
> Thread 3 (Thread 0x78ee9b90 (LWP 11528)):
> #0  0xffffe410 in __kernel_vsyscall ()
> #1  0xb7f52566 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib/libpthread.so.0
> #2  0x800215b7 in master_notify_submount (ap=0x8004e8a8, 
>     path=0x800a9630 "/net/bamboo45", state=ST_EXPIRE) at master.c:908
> #3  0x8000c90d in expire_proc_indirect (arg=0x800825e8) at indirect.c:468
> #4  0xb7f4e192 in start_thread () from /lib/libpthread.so.0
> #5  0xb7ed502e in clone () from /lib/libc.so.6

This does look like an execution order dependency.
Please try this patch in addition to the ones you're using.

autofs-5.0.3 - take submount submount lock before waiting

From: Ian Kent <raven@themaw.net>

Take the submount lock before issuing the nextstate() call to ensure
the child can't signal completion before the parent waits. Also add
cancellation cleanup for both mutexes.
---

 lib/master.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)


diff --git a/lib/master.c b/lib/master.c
index e506661..40441ca 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -845,6 +845,20 @@ int master_submount_list_empty(struct autofs_point *ap)
 	return res;
 }
 
+static void mounts_mutex_cleanup(void *arg)
+{
+	struct autofs_point *ap = (struct autofs_point *) arg;
+	mounts_mutex_unlock(ap);
+	return;
+}
+
+static void submount_mutex_cleanup(void *arg)
+{
+	struct autofs_point *ap = (struct autofs_point *) arg;
+	submount_mutex_unlock(ap);
+	return;
+}
+
 int master_notify_submount(struct autofs_point *ap, const char *path, enum states state)
 {
 	struct list_head *head, *p;
@@ -853,6 +867,7 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 	size_t plen = strlen(path);
 	int status, ret = 1;
 
+	pthread_cleanup_push(mounts_mutex_cleanup, ap);
 	mounts_mutex_lock(ap);
 
 	head = &ap->submounts;
@@ -889,19 +904,16 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 		}
 
 		/* Now we have a submount to expire */
-
+		pthread_cleanup_push(submount_mutex_cleanup, ap);
+		submount_mutex_lock(ap);
 		state_mutex_lock(this);
-
 		if (this->state == ST_SHUTDOWN) {
 			state_mutex_unlock(this);
 			break;
 		}
-
 		nextstate(this->state_pipe[1], state);
-
 		state_mutex_unlock(this);
 
-		submount_mutex_lock(ap);
 		thid = this->thid;
 		ap->submount_signaled = MASTER_SUBMNT_WAIT;
 		while (ap->submount_signaled == MASTER_SUBMNT_WAIT) {
@@ -916,12 +928,12 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 				fatal(status);
 		} else
 			ret = 0;
-		submount_mutex_unlock(ap);
+		pthread_cleanup_pop(1);
 
 		break;
 	}
 
-	mounts_mutex_unlock(ap);
+	pthread_cleanup_pop(1);
 
 	return ret;
 }
