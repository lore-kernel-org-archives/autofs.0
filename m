From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Tue, 24 Jun 2008 11:08:25 +0800
Message-ID: <1214276906.12623.88.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<1213414942.18072.26.camel@raven.themaw.net>
	<1213845274.2971.11.camel@raven.themaw.net>
	<20080619183446.532D82111B1@simba.math.ucla.edu>
	<1213934961.2971.69.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806201713350.13828@xena.cft.ca.us>
	<1214017944.4975.60.camel@raven.themaw.net>
	<Pine.LNX.4.64.0806222024150.18218@xena.cft.ca.us>
	<1214196368.3098.41.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1214196368.3098.41.camel@raven.themaw.net>
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


On Mon, 2008-06-23 at 12:46 +0800, Ian Kent wrote:
> On Sun, 2008-06-22 at 20:49 -0700, Jim Carter wrote:
> > On Sat, 21 Jun 2008, Ian Kent wrote:
> > 
> > > Ooops, I didn't pay enough attention when I read the pthread barrier man
> > > page. That isn't actually an error return but now I'm wondering why I
> > > haven't seen it in my test, very odd.
> > > 
> > > Let me fix it and we'll try again.
> > > 
> > > There are other problems but I need to know if this is a viable approach
> > > before going further with it.
> > > 
> > > Try this instead.
> > 
> > OK!!!  The test program has been running for 28 hours continuously, 32 
> > hours total, and is still going, having done 37300 mount-unmount cycles so 
> > far.  There are normally 244 filesystems mounted from 125 different 
> > machines.
> 
> Sound promising.
> Using a pthread barrier is clearly the way to go here.
> 
> > 
> > There have been no hung processes, i.e. automount either mounts the 
> > filesystem or returns ENOENT in response to readdir(), within 120 secs.  
> > There have been no omitted unmounts, i.e. every mounted filesystem (that 
> > was unused) was unmounted within 1800 secs (the default timeout of 300 secs 
> > is used).
> 
> Mmmm .. wonder what's going on with that.
> 
> My test showed a problem with expires.
> I'm fairly sure there was corruption of the control file handle and I'm
> trying to fix that.
> 
> The kernel patches are meant to fix occasional incorrect ENOENT and
> EBUSY returns but this could also be something in the daemon. Lets see
> how an updated version of revision 8 of this patch goes before we look
> more deeply into this.
> 
> > 
> > There was one error reported.  I ran the test program, and someone powered 
> > off a workstation whose filesystem I had mounted.  The resulting NFS 
> > timeout(s) caused the program to think the test thread was hung, so it 
> > tried to produce a backtrace, but there was a bug and the trace was spoiled 
> > (you've seen these spoiled traces before in files I've sent in).  I 
> > improved the trace procedure and attempted to restart.  I did a forced 
> > umount by "kill -USR1 $PID", but automount said on syslog:
> > 
> > Jun 21 15:58:47 bustamove automount[2880]: master.c:957: assertion failed: 
> > ap->state == ST_READY
> 
> Oh .. that's not good, I haven't looked closely at the prune event
> handling for quite some time. I expect I've broken it with other changes
> since I last checked.

Looks to me like I need to check if there is an expire or prune already
running and issue a message saying that and ignore the signal.

This could be the expire still waiting on the blocked umount(8). This is
a bit of a problem because RPC won't give up trying to send if it thinks
there is an outstanding write. We will need to investigate this further
later as I don't think it is specifically related to the submount issue.

> 
> > 
> > And it didn't unmount anything.  So I rebooted and started the test on a 
> > clean machine.  
> > 
> > There is a pattern of failure that may not be automount's fault.  On 
> > almost exactly 0.1% of the attempted mounts, the readdir eventually fails 
> > with ENOENT.  The test program leaves these filesystems alone for 1800 
> > secs, then tries again to mount and test them, which invariably succeeds. I 
> > don't see any pattern to the type of the machine: workstation, server, 
> > compute node, heavily loaded, totally idle, etc.  But if multiple 
> > filesystems from one machine (submount) are unmounted and remounted at the 
> > "same" time (0.2 secs apart), if any one fails, there is a tendency for 
> > several others to also fail.
> 
> But we have to assume it's autofs, for now at least.

This could be related to the expire issue I saw in my tests so we need
to test my slightly updated patch and see before we go into this.
Hopefully I haven't regressed from the last test.

So here is my updated revision 8 of the patch against the SuSE package
as usual.

I left my test running all day yesterday (and last night) then let the
mounts expire and that worked OK. I still need to test immediate
shutdown after an extended run to test if I have a problem with expire
thread cancellation.

autofs-5.0.3 - fix submount shutdown handling.

From: Ian Kent <raven@themaw.net>

When using submount maps on a busy system autofs can hang.

This patch improves the submount shutdown logic and allows
submounts that become busy during shutdown to recover.
---

 daemon/automount.c     |   91 ++++++++++++++++++++++++++---------------------
 daemon/direct.c        |    4 +-
 daemon/indirect.c      |   93 +++++++++++++++++++++++++++++++++++++-----------
 daemon/lookup.c        |    3 --
 daemon/state.c         |    5 ++-
 include/automount.h    |    3 +-
 include/master.h       |    3 +-
 lib/master.c           |   57 +++++++++--------------------
 modules/mount_autofs.c |    6 ++-
 9 files changed, 149 insertions(+), 116 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index afbcb56..34cb53a 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1465,13 +1465,11 @@ static void handle_mounts_cleanup(void *arg)
 	/* If we have been canceled then we may hold the state mutex. */
 	mutex_operation_wait(&ap->state_mutex);
 
-	alarm_delete(ap);
-	st_remove_tasks(ap);
-
-	umount_autofs(ap, 1);
-
 	destroy_logpri_fifo(ap);
-	master_signal_submount(ap, MASTER_SUBMNT_JOIN);
+	if (submount) {
+		master_source_unlock(ap->parent->entry);
+		master_signal_submount(ap, MASTER_SUBMNT_SHUTDOWN);
+	}
 	master_remove_mapent(ap->entry);
 	master_free_mapent_sources(ap->entry, 1);
 	master_free_mapent(ap->entry);
@@ -1533,71 +1531,82 @@ void *handle_mounts(void *arg)
 	if (!ap->submount && ap->exp_timeout)
 		alarm_add(ap, ap->exp_runfreq + rand() % ap->exp_runfreq);
 
-	pthread_cleanup_push(handle_mounts_cleanup, ap);
-	pthread_setcancelstate(cancel_state, NULL);
-
 	state_mutex_unlock(ap);
+	pthread_setcancelstate(cancel_state, NULL);
 
 	while (ap->state != ST_SHUTDOWN) {
 		if (handle_packet(ap)) {
-			int ret, result;
+			int ret, cur_state;
+
+			/*
+			 * If we're a submount we need to ensure our parent
+			 * doesn't try to mount us again until our shutdown
+			 * is complete and that any outstanding mounts are
+			 * completed before we try to shutdown.
+			 */
+			pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
+
+			if (ap->submount)
+				master_source_writelock(ap->parent->entry);
 
 			state_mutex_lock(ap);
+
+			if (ap->state != ST_SHUTDOWN) {
+				if (!ap->submount)
+					alarm_add(ap, ap->exp_runfreq);
+				state_mutex_unlock(ap);
+				/* Return to ST_READY is done immediately */
+				if (ap->submount)
+					master_source_unlock(ap->parent->entry);
+				st_add_task(ap, ST_READY);
+				pthread_setcancelstate(cur_state, NULL);
+				continue;
+			}
+
+			alarm_delete(ap);
+			st_remove_tasks(ap);
+
 			/*
 			 * For a direct mount map all mounts have already gone
-			 * by the time we get here.
+			 * by the time we get here and since we only ever
+			 * umount direct mounts at shutdown there is no need
+			 * to check for possible recovery.
 			 */
 			if (ap->type == LKP_DIRECT) {
-				status = 1;
+				umount_autofs(ap, 1);
 				state_mutex_unlock(ap);
 				break;
 			}
 
 			/*
-			 * If the ioctl fails assume the kernel doesn't have
-			 * AUTOFS_IOC_ASKUMOUNT and just continue.
+			 * If umount_autofs returns non-zero it wasn't able
+			 * to complete the umount and has left the mount intact
+			 * so we can continue. This can happen if a lookup
+			 * occurs while we're trying to umount.
 			 */
-			ret = ioctl(ap->ioctlfd, AUTOFS_IOC_ASKUMOUNT, &result);
-			if (ret == -1) {
+			ret = umount_autofs(ap, 1);
+			if (!ret) {
 				state_mutex_unlock(ap);
 				break;
 			}
 
-			/* OK to exit */
-			if (ap->state == ST_SHUTDOWN) {
-				if (result) {
-					state_mutex_unlock(ap);
-					break;
-				}
-#ifdef ENABLE_IGNORE_BUSY_MOUNTS
-				/*
-				 * There weren't any active mounts but if the
-				 * filesystem is busy there may be a mount
-				 * request in progress so return to the ready
-				 * state unless a shutdown has been explicitly
-				 * requested.
-				 */
-				if (ap->shutdown) {
-					state_mutex_unlock(ap);
-					break;
-				}
-#endif
-			}
-
 			/* Failed shutdown returns to ready */
 			warn(ap->logopt,
 			     "can't shutdown: filesystem %s still busy",
 			     ap->path);
 			if (!ap->submount)
 				alarm_add(ap, ap->exp_runfreq);
-			nextstate(ap->state_pipe[1], ST_READY);
-
 			state_mutex_unlock(ap);
+			if (ap->submount)
+				master_source_unlock(ap->parent->entry);
+			/* Return to ST_READY is done immediately */
+			st_add_task(ap, ST_READY);
+			pthread_setcancelstate(cur_state, NULL);
+
 		}
 	}
 
-	pthread_cleanup_pop(1);
-	sched_yield();
+	handle_mounts_cleanup(ap);
 
 	return NULL;
 }
diff --git a/daemon/direct.c b/daemon/direct.c
index cc03ccd..f7a78b9 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -867,12 +867,12 @@ void *expire_proc_direct(void *arg)
 	if (status)
 		fatal(status);
 
+	pthread_cleanup_push(expire_cleanup, &ec);
+
 	status = pthread_mutex_unlock(&ea->mutex);
 	if (status)
 		fatal(status);
 
-	pthread_cleanup_push(expire_cleanup, &ec);
-
 	left = 0;
 
 	mnts = tree_make_mnt_tree(_PROC_MOUNTS, "/");
diff --git a/daemon/indirect.c b/daemon/indirect.c
index c32b658..41afe30 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -233,11 +233,8 @@ int mount_autofs_indirect(struct autofs_point *ap)
 	return 0;
 }
 
-int umount_autofs_indirect(struct autofs_point *ap)
+static void close_mount_fds(struct autofs_point *ap)
 {
-	char buf[MAX_ERR_BUF];
-	int ret, rv, retries;
-
 	/*
 	 * Since submounts look after themselves the parent never knows
 	 * it needs to close the ioctlfd for offset mounts so we have
@@ -247,6 +244,25 @@ int umount_autofs_indirect(struct autofs_point *ap)
 	if (ap->submount)
 		lookup_source_close_ioctlfd(ap->parent, ap->path);
 
+	close(ap->state_pipe[0]);
+	close(ap->state_pipe[1]);
+	ap->state_pipe[0] = -1;
+	ap->state_pipe[1] = -1;
+
+	if (ap->pipefd >= 0)
+		close(ap->pipefd);
+
+	if (ap->kpipefd >= 0)
+		close(ap->kpipefd);
+
+	return;
+}
+
+int umount_autofs_indirect(struct autofs_point *ap)
+{
+	char buf[MAX_ERR_BUF];
+	int ret, rv, retries;
+
 	/* If we are trying to shutdown make sure we can umount */
 	rv = ioctl(ap->ioctlfd, AUTOFS_IOC_ASKUMOUNT, &ret);
 	if (rv == -1) {
@@ -255,23 +271,19 @@ int umount_autofs_indirect(struct autofs_point *ap)
 		return 1;
 	} else if (!ret) {
 		error(ap->logopt, "ask umount returned busy %s", ap->path);
+#if defined(ENABLE_IGNORE_BUSY_MOUNTS) || defined(ENABLE_FORCED_SHUTDOWN)
+		if (!ap->shutdown)
+			return 1;
+#else
 		return 1;
+#endif
 	}
 
-	ioctl(ap->ioctlfd, AUTOFS_IOC_CATATONIC, 0);
+	if (ap->shutdown)
+		ioctl(ap->ioctlfd, AUTOFS_IOC_CATATONIC, 0);
+
 	close(ap->ioctlfd);
 	ap->ioctlfd = -1;
-	close(ap->state_pipe[0]);
-	close(ap->state_pipe[1]);
-	ap->state_pipe[0] = -1;
-	ap->state_pipe[1] = -1;
-
-	if (ap->pipefd >= 0)
-		close(ap->pipefd);
-
-	if (ap->kpipefd >= 0)
-		close(ap->kpipefd);
-
 	sched_yield();
 
 	retries = UMOUNT_RETRIES;
@@ -288,24 +300,61 @@ int umount_autofs_indirect(struct autofs_point *ap)
 		case EINVAL:
 			error(ap->logopt,
 			      "mount point %s does not exist", ap->path);
+			close_mount_fds(ap);
 			return 0;
 			break;
 		case EBUSY:
-			error(ap->logopt,
+			debug(ap->logopt,
 			      "mount point %s is in use", ap->path);
-			if (ap->state == ST_SHUTDOWN_FORCE)
+			if (ap->state == ST_SHUTDOWN_FORCE) {
+				close_mount_fds(ap);
 				goto force_umount;
-			else
-				return 0;
+			} else {
+				int cl_flags;
+				/*
+				 * If the umount returns EBUSY there may be
+				 * a mount request in progress so we need to
+				 * recover unless we have been explicitly
+				 * asked to shutdown and configure option
+				 * ENABLE_IGNORE_BUSY_MOUNTS is enabled.
+				 */
+#ifdef ENABLE_IGNORE_BUSY_MOUNTS
+				if (ap->shutdown) {
+					close_mount_fds(ap);
+					return 0;
+				}
+#endif
+				ap->ioctlfd = open(ap->path, O_RDONLY);
+				if (ap->ioctlfd < 0) {
+					warn(ap->logopt,
+					     "could not recover autofs path %s",
+					     ap->path);
+					close_mount_fds(ap);
+					return 0;
+				}
+
+				if ((cl_flags = fcntl(ap->ioctlfd, F_GETFD, 0)) != -1) {
+					cl_flags |= FD_CLOEXEC;
+					fcntl(ap->ioctlfd, F_SETFD, cl_flags);
+				}
+			}
 			break;
 		case ENOTDIR:
 			error(ap->logopt, "mount point is not a directory");
+			close_mount_fds(ap);
 			return 0;
 			break;
 		}
 		return 1;
 	}
 
+	/*
+	 * We have successfully umounted the mount so we now close
+	 * the descriptors. The kernel end of the kernel pipe will
+	 * have been put during the umount super block cleanup.
+	 */
+	close_mount_fds(ap);
+
 force_umount:
 	if (rv != 0) {
 		warn(ap->logopt,
@@ -394,12 +443,12 @@ void *expire_proc_indirect(void *arg)
 	if (status)
 		fatal(status);
 
+	pthread_cleanup_push(expire_cleanup, &ec);
+
 	status = pthread_mutex_unlock(&ea->mutex);
 	if (status)
 		fatal(status);
 
-	pthread_cleanup_push(expire_cleanup, &ec);
-
 	left = 0;
 
 	/* Get a list of real mounts and expire them if possible */
diff --git a/daemon/lookup.c b/daemon/lookup.c
index eac6053..af70fde 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1139,8 +1139,6 @@ int lookup_source_close_ioctlfd(struct autofs_point *ap, const char *key)
 	struct mapent *me;
 	int ret = 0;
 
-	pthread_cleanup_push(master_source_lock_cleanup, entry);
-	master_source_readlock(entry);
 	map = entry->maps;
 	while (map) {
 		mc = map->mc;
@@ -1158,7 +1156,6 @@ int lookup_source_close_ioctlfd(struct autofs_point *ap, const char *key)
 		cache_unlock(mc);
 		map = map->next;
 	}
-	pthread_cleanup_pop(1);
 
 	return ret;
 }
diff --git a/daemon/state.c b/daemon/state.c
index 5804707..8a1c29e 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -213,8 +213,10 @@ static unsigned int st_ready(struct autofs_point *ap)
 	debug(ap->logopt,
 	      "st_ready(): state = %d path %s", ap->state, ap->path);
 
+	state_mutex_lock(ap);
 	ap->shutdown = 0;
 	ap->state = ST_READY;
+	state_mutex_unlock(ap);
 
 	if (ap->submount)
 		master_signal_submount(ap, MASTER_SUBMNT_CONTINUE);
@@ -677,9 +679,8 @@ int st_add_task(struct autofs_point *ap, enum states state)
 
 	/* Task termination marker, poke state machine */
 	if (state == ST_READY) {
-		state_mutex_lock(ap);
+		/* NOTE: no state mutex lock here */
 		st_ready(ap);
-		state_mutex_unlock(ap);
 
 		st_mutex_lock();
 
diff --git a/include/automount.h b/include/automount.h
index cd8ce7b..43c594d 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -457,8 +457,7 @@ struct autofs_point {
 					 * host from which to mount */
 	struct autofs_point *parent;	/* Owner of mounts list for submount */
 	pthread_mutex_t mounts_mutex;	/* Protect mount lists */
-	pthread_cond_t mounts_cond;	/* Submounts condition variable */
-	unsigned int mounts_signaled;	/* Submount signals task complete */
+	pthread_barrier_t submount_barrier; /* Submount completion barrier */
 	struct list_head mounts;	/* List of autofs mounts at current level */
 	unsigned int submount;		/* Is this a submount */
 	unsigned int shutdown;		/* Shutdown notification */
diff --git a/include/master.h b/include/master.h
index 5f10d1f..24dddec 100644
--- a/include/master.h
+++ b/include/master.h
@@ -20,9 +20,8 @@
 #ifndef MASTER_H
 #define MASTER_H
 
-#define MASTER_SUBMNT_WAIT	0
 #define MASTER_SUBMNT_CONTINUE	1
-#define MASTER_SUBMNT_JOIN	2
+#define MASTER_SUBMNT_SHUTDOWN	2
 
 struct map_source {
 	char *type;
diff --git a/lib/master.c b/lib/master.c
index 4a34dd4..11f89c3 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -113,18 +113,6 @@ int master_add_autofs_point(struct master_mapent *entry,
 		return 0;
 	}
 
-	status = pthread_cond_init(&ap->mounts_cond, NULL);
-	if (status) {
-		status = pthread_mutex_destroy(&ap->mounts_mutex);
-		if (status)
-			fatal(status);
-		status = pthread_mutex_destroy(&ap->state_mutex);
-		if (status)
-			fatal(status);
-		free(ap->path);
-		free(ap);
-		return 0;
-	}
 	entry->ap = ap;
 
 	return 1;
@@ -145,10 +133,6 @@ void master_free_autofs_point(struct autofs_point *ap)
 	if (status)
 		fatal(status);
 
-	status = pthread_cond_destroy(&ap->mounts_cond);
-	if (status)
-		fatal(status);
-
 	free(ap->path);
 	free(ap);
 }
@@ -878,24 +862,19 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 
 		nextstate(this->state_pipe[1], state);
 
+		status = pthread_barrier_init(&this->submount_barrier, NULL, 2);
+		if (status)
+			fatal(status);
+
 		state_mutex_unlock(this);
 
-		thid = this->thid;
-		ap->mounts_signaled = MASTER_SUBMNT_WAIT;
-		while (ap->mounts_signaled == MASTER_SUBMNT_WAIT) {
-			status = pthread_cond_wait(&ap->mounts_cond, &ap->mounts_mutex);
-			if (status)
-				fatal(status);
-		}
+		mounts_mutex_unlock(ap);
 
-		if (ap->mounts_signaled == MASTER_SUBMNT_JOIN) {
-			status = pthread_join(thid, NULL);
-			if (status)
-				fatal(status);
-		} else
-			ret = 0;
+		status = pthread_barrier_wait(&this->submount_barrier);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD)
+			fatal(status);
 
-		break;
+		return ret;
 	}
 
 	mounts_mutex_unlock(ap);
@@ -903,28 +882,27 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 	return ret;
 }
 
-void master_signal_submount(struct autofs_point *ap, unsigned int join)
+/* Parent ap->mounts_mutex must already be held if joining on shutdown */
+void master_signal_submount(struct autofs_point *ap, unsigned int action)
 {
 	int status;
 
 	if (!ap->parent || !ap->submount)
 		return;
 
-	mounts_mutex_lock(ap->parent);
-
-	ap->parent->mounts_signaled = join;
-
-	if (join == MASTER_SUBMNT_JOIN) {
+	if (action == MASTER_SUBMNT_SHUTDOWN) {
 		/* We are finishing up */
 		ap->parent->submnt_count--;
 		list_del(&ap->mounts);
 	}
 
-	status = pthread_cond_signal(&ap->parent->mounts_cond);
-	if (status)
+	status = pthread_barrier_wait(&ap->submount_barrier);
+	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD)
 		fatal(status);
 
-	mounts_mutex_unlock(ap->parent);
+	status = pthread_barrier_destroy(&ap->submount_barrier);
+	if (status)
+		fatal(status);
 
 	return;
 }
@@ -970,6 +948,7 @@ void master_notify_state_change(struct master *master, int sig)
 			if (ap->state != ST_SHUTDOWN_FORCE &&
 			    ap->state != ST_SHUTDOWN_PENDING) {
 				next = ST_SHUTDOWN_FORCE;
+				ap->shutdown = 1;
 				nextstate(state_pipe, next);
 			}
 			break;
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 356fb14..d1856e3 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -228,7 +228,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	suc.done = 0;
 	suc.status = 0;
 
-	if (pthread_create(&thid, NULL, handle_mounts, nap)) {
+	if (pthread_create(&thid, &thread_attr, handle_mounts, nap)) {
 		crit(ap->logopt,
 		     MODPREFIX
 		     "failed to create mount handler thread for %s",
@@ -266,12 +266,12 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	ap->submnt_count++;
 	list_add(&nap->mounts, &ap->submounts);
 
-	mounts_mutex_unlock(ap);
-
 	status = pthread_mutex_unlock(&suc.mutex);
 	if (status)
 		fatal(status);
 
+	mounts_mutex_unlock(ap);
+
 	return 0;
 }
