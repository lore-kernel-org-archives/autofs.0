From: Ian Kent <raven@themaw.net>
Subject: Re: clients suddenly start hanging (was: (no subject))
Date: Thu, 08 May 2008 14:13:28 +0800
Message-ID: <1210227208.1392.51.camel@raven.themaw.net>
References: <20080423185018.122C53C3B1@xena.cft.ca.us>
	<20080508045235.13C9EF8ED9@serval.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080508045235.13C9EF8ED9@serval.math.ucla.edu>
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


On Wed, 2008-05-07 at 21:52 -0700, Jim Carter wrote:
> On Mon, 28 Apr 2008 14:26:34 +0800 Ian Kent wrote:
> 
> > Jeff Moyer has identified a race in due to an execution order dependency
> > in the autofs4 function root.c:try_to_fill_dentry().
> --snip--
> > After the daemon finishes the mount, it calls back into the kernel
> > to release the waiters. When this happens, P1 is woken up and goes
> > about clearing the DCACHE_AUTOFS_PENDING flag, but it does this in
> > D1!  So, given that P1 in our case is a program that will immediately
> > try to access a file under /mount/submount/foo, we end up finding the
> > dentry D2 which still has the pending flag set, and we set out to
> > wait for a mount *again*!
> 
> I applied the two patches (redo-lookup-in-ttfd and correct-return-in-ttfd)
> and restarted/reloaded the resulting module, but unfortunately it did 
> not improve the issue of hanging client processes in my submount case.

You've jumped the gun at bit. These patches are only part of the work to
resolve these issues. I posted them, since I felt they were sound and
addressed issues that needed to be addressed, in order to meet the merge
window for 2.6.26. There are going to be more kernel changes.

But the patch that may make a real difference for your case is for the
daemon and hasn't been merged yet because were still testing it. I would
have posted it for you to test but I though we were still undecided as
to whether you wanted me to attempt a back port to an older SuSE code
base or you were happy to use the latest source.

Anyway, here it is, against the latest source, for you to test.

---

 daemon/automount.c |   91 +++++++++++++++++++++++++++++-----------------------
 daemon/indirect.c  |   89 +++++++++++++++++++++++++++++++++++++++------------
 daemon/lookup.c    |    3 --
 daemon/state.c     |    5 ++-
 lib/master.c       |    1 +
 5 files changed, 123 insertions(+), 66 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index 7ce9828..c8b7d1e 100644
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
+		master_signal_submount(ap, MASTER_SUBMNT_JOIN);
+		master_source_unlock(ap->parent->entry);
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
+			if (ap->submount)
+				master_source_writelock(ap->parent->entry);
 
 			state_mutex_lock(ap);
+
+			if (ap->state != ST_SHUTDOWN) {
+				if (!ap->submount)
+					alarm_add(ap, ap->exp_runfreq);
+				state_mutex_unlock(ap);
+				/* Return to ST_READY is done immediately */
+				st_add_task(ap, ST_READY);
+				if (ap->submount)
+					master_source_unlock(ap->parent->entry);
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
+			/* Return to ST_READY is done immediately */
+			st_add_task(ap, ST_READY);
+
+			if (ap->submount)
+				master_source_unlock(ap->parent->entry);
+			pthread_setcancelstate(cur_state, NULL);
+
 		}
 	}
 
-	pthread_cleanup_pop(1);
-	sched_yield();
+	handle_mounts_cleanup(ap);
 
 	return NULL;
 }
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 11865b3..c1bd3f2 100644
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
 
diff --git a/lib/master.c b/lib/master.c
index 4a34dd4..ac9b381 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -970,6 +970,7 @@ void master_notify_state_change(struct master *master, int sig)
 			if (ap->state != ST_SHUTDOWN_FORCE &&
 			    ap->state != ST_SHUTDOWN_PENDING) {
 				next = ST_SHUTDOWN_FORCE;
+				ap->shutdown = 1;
 				nextstate(state_pipe, next);
 			}
 			break;
