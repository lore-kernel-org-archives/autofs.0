From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/5] autofs-5.0.3 - fix submount shutdown handling.
Date: Thu, 12 Jun 2008 13:04:50 +0800
Message-ID: <20080612050450.27161.67734.stgit@raven.themaw.net>
References: <20080612045519.27161.92549.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612045519.27161.92549.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

autofs-5.0.3-submount-shutdown-recovery-7.patch

When using submount maps on a busy system autofs can hang.

This patch improves the submount shutdown logic and allows
submounts that become busy during shutdown to recover.

---

 daemon/automount.c     |   82 +++++++++++++++++++++---------------------
 daemon/direct.c        |    4 +-
 daemon/indirect.c      |   93 +++++++++++++++++++++++++++++++++++++-----------
 daemon/lookup.c        |    3 --
 daemon/state.c         |    5 ++-
 include/automount.h    |   19 +++++++++-
 lib/master.c           |   51 +++++++++++++++++++-------
 modules/mount_autofs.c |    4 +-
 8 files changed, 172 insertions(+), 89 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index afbcb56..f7c5472 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1465,13 +1465,9 @@ static void handle_mounts_cleanup(void *arg)
 	/* If we have been canceled then we may hold the state mutex. */
 	mutex_operation_wait(&ap->state_mutex);
 
-	alarm_delete(ap);
-	st_remove_tasks(ap);
-
-	umount_autofs(ap, 1);
-
 	destroy_logpri_fifo(ap);
-	master_signal_submount(ap, MASTER_SUBMNT_JOIN);
+	if (submount)
+		master_signal_submount(ap, MASTER_SUBMNT_JOIN);
 	master_remove_mapent(ap->entry);
 	master_free_mapent_sources(ap->entry, 1);
 	master_free_mapent(ap->entry);
@@ -1533,71 +1529,75 @@ void *handle_mounts(void *arg)
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
 
 			state_mutex_lock(ap);
+
+			if (ap->state != ST_SHUTDOWN) {
+				if (!ap->submount)
+					alarm_add(ap, ap->exp_runfreq);
+				state_mutex_unlock(ap);
+				/* Return to ST_READY is done immediately */
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
index cd8ce7b..8828cc0 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -457,8 +457,9 @@ struct autofs_point {
 					 * host from which to mount */
 	struct autofs_point *parent;	/* Owner of mounts list for submount */
 	pthread_mutex_t mounts_mutex;	/* Protect mount lists */
-	pthread_cond_t mounts_cond;	/* Submounts condition variable */
-	unsigned int mounts_signaled;	/* Submount signals task complete */
+	pthread_cond_t submount_cond;	/* Submount condition variable */
+	pthread_mutex_t submount_mutex;	/* Submount condition mutex variabe */
+	unsigned int submount_signaled;	/* Submount signals task complete */
 	struct list_head mounts;	/* List of autofs mounts at current level */
 	unsigned int submount;		/* Is this a submount */
 	unsigned int shutdown;		/* Shutdown notification */
@@ -520,6 +521,20 @@ do { \
 		fatal(_m_unlock); \
 } while(0)
 
+#define submount_mutex_lock(ap) \
+do { \
+	int _s_lock = pthread_mutex_lock(&ap->submount_mutex); \
+	if (_s_lock) \
+		fatal(_s_lock); \
+} while (0)
+
+#define submount_mutex_unlock(ap) \
+do { \
+	int _s_unlock = pthread_mutex_unlock(&ap->submount_mutex); \
+	if (_s_unlock) \
+		fatal(_s_unlock); \
+} while(0)
+
 /* Expire alarm handling routines */
 int alarm_start_handler(void);
 int alarm_add(struct autofs_point *ap, time_t seconds);
diff --git a/lib/master.c b/lib/master.c
index 4a34dd4..e506661 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -113,7 +113,7 @@ int master_add_autofs_point(struct master_mapent *entry,
 		return 0;
 	}
 
-	status = pthread_cond_init(&ap->mounts_cond, NULL);
+	status = pthread_mutex_init(&ap->submount_mutex, NULL);
 	if (status) {
 		status = pthread_mutex_destroy(&ap->mounts_mutex);
 		if (status)
@@ -125,6 +125,23 @@ int master_add_autofs_point(struct master_mapent *entry,
 		free(ap);
 		return 0;
 	}
+
+	status = pthread_cond_init(&ap->submount_cond, NULL);
+	if (status) {
+		status = pthread_mutex_destroy(&ap->submount_mutex);
+		if (status)
+			fatal(status);
+		status = pthread_mutex_destroy(&ap->mounts_mutex);
+		if (status)
+			fatal(status);
+		status = pthread_mutex_destroy(&ap->state_mutex);
+		if (status)
+			fatal(status);
+		free(ap->path);
+		free(ap);
+		return 0;
+	}
+
 	entry->ap = ap;
 
 	return 1;
@@ -145,7 +162,11 @@ void master_free_autofs_point(struct autofs_point *ap)
 	if (status)
 		fatal(status);
 
-	status = pthread_cond_destroy(&ap->mounts_cond);
+	status = pthread_mutex_destroy(&ap->submount_mutex);
+	if (status)
+		fatal(status);
+
+	status = pthread_cond_destroy(&ap->submount_cond);
 	if (status)
 		fatal(status);
 
@@ -880,20 +901,22 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 
 		state_mutex_unlock(this);
 
+		submount_mutex_lock(ap);
 		thid = this->thid;
-		ap->mounts_signaled = MASTER_SUBMNT_WAIT;
-		while (ap->mounts_signaled == MASTER_SUBMNT_WAIT) {
-			status = pthread_cond_wait(&ap->mounts_cond, &ap->mounts_mutex);
+		ap->submount_signaled = MASTER_SUBMNT_WAIT;
+		while (ap->submount_signaled == MASTER_SUBMNT_WAIT) {
+			status = pthread_cond_wait(&ap->submount_cond,
+						   &ap->submount_mutex);
 			if (status)
 				fatal(status);
 		}
-
-		if (ap->mounts_signaled == MASTER_SUBMNT_JOIN) {
+		if (ap->submount_signaled == MASTER_SUBMNT_JOIN) {
 			status = pthread_join(thid, NULL);
 			if (status)
 				fatal(status);
 		} else
 			ret = 0;
+		submount_mutex_unlock(ap);
 
 		break;
 	}
@@ -903,6 +926,7 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 	return ret;
 }
 
+/* Parent ap->mounts_mutex must already be held if joining on shutdown */
 void master_signal_submount(struct autofs_point *ap, unsigned int join)
 {
 	int status;
@@ -910,21 +934,17 @@ void master_signal_submount(struct autofs_point *ap, unsigned int join)
 	if (!ap->parent || !ap->submount)
 		return;
 
-	mounts_mutex_lock(ap->parent);
-
-	ap->parent->mounts_signaled = join;
-
+	submount_mutex_lock(ap->parent);
+	ap->parent->submount_signaled = join;
 	if (join == MASTER_SUBMNT_JOIN) {
 		/* We are finishing up */
 		ap->parent->submnt_count--;
 		list_del(&ap->mounts);
 	}
-
-	status = pthread_cond_signal(&ap->parent->mounts_cond);
+	status = pthread_cond_signal(&ap->parent->submount_cond);
 	if (status)
 		fatal(status);
-
-	mounts_mutex_unlock(ap->parent);
+	submount_mutex_unlock(ap->parent);
 
 	return;
 }
@@ -970,6 +990,7 @@ void master_notify_state_change(struct master *master, int sig)
 			if (ap->state != ST_SHUTDOWN_FORCE &&
 			    ap->state != ST_SHUTDOWN_PENDING) {
 				next = ST_SHUTDOWN_FORCE;
+				ap->shutdown = 1;
 				nextstate(state_pipe, next);
 			}
 			break;
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 356fb14..c679386 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
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
