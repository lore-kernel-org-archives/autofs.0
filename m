From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs-5.0.3 - fix submount shutdown handling.
Date: Mon, 30 Jun 2008 14:51:09 +0800
Message-ID: <20080630065107.20857.36575.stgit@raven.themaw.net>
References: <20080630064340.20857.84258.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080630064340.20857.84258.stgit@raven.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

autofs-5.0.3-submount-shutdown-recovery-9.patch

When using submount maps on a busy system autofs can hang.

This patch improves the submount shutdown logic and allows
submounts that become busy during shutdown to recover.

---

 daemon/automount.c  |   91 +++++++++++++++++++++++++++-----------------------
 daemon/direct.c     |    4 +-
 daemon/indirect.c   |   93 +++++++++++++++++++++++++++++++++++++++------------
 daemon/lookup.c     |    3 --
 daemon/state.c      |    5 ++-
 include/automount.h |    4 +-
 include/master.h    |    3 +-
 lib/master.c        |   50 ++++++++++++---------------
 8 files changed, 150 insertions(+), 103 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index 4b94028..96bcf2f 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1514,13 +1514,11 @@ static void handle_mounts_cleanup(void *arg)
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
@@ -1585,71 +1583,82 @@ void *handle_mounts(void *arg)
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
index 76e5478..b26fa73 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -461,8 +461,8 @@ struct autofs_point {
 					 * host from which to mount */
 	struct autofs_point *parent;	/* Owner of mounts list for submount */
 	pthread_mutex_t mounts_mutex;	/* Protect mount lists */
-	pthread_cond_t mounts_cond;	/* Submounts condition variable */
-	unsigned int mounts_signaled;	/* Submount signals task complete */
+	unsigned int submount_wait;	/* We need to wait on barrier */
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
index edd3bdc..ae52954 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -113,7 +113,8 @@ int master_add_autofs_point(struct master_mapent *entry,
 		return 0;
 	}
 
-	status = pthread_cond_init(&ap->mounts_cond, NULL);
+	ap->submount_wait = 0;
+	status = pthread_barrier_init(&ap->submount_barrier, NULL, 2);
 	if (status) {
 		status = pthread_mutex_destroy(&ap->mounts_mutex);
 		if (status)
@@ -125,6 +126,7 @@ int master_add_autofs_point(struct master_mapent *entry,
 		free(ap);
 		return 0;
 	}
+
 	entry->ap = ap;
 
 	return 1;
@@ -145,7 +147,7 @@ void master_free_autofs_point(struct autofs_point *ap)
 	if (status)
 		fatal(status);
 
-	status = pthread_cond_destroy(&ap->mounts_cond);
+	status = pthread_barrier_destroy(&ap->submount_barrier);
 	if (status)
 		fatal(status);
 
@@ -828,7 +830,6 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 {
 	struct list_head *head, *p;
 	struct autofs_point *this;
-	pthread_t thid;
 	size_t plen = strlen(path);
 	int status, ret = 1;
 
@@ -880,22 +881,14 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
 
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
+		this->submount_wait = 1;
+		status = pthread_barrier_wait(&this->submount_barrier);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD)
+			fatal(status);
 
-		break;
+		return ret;
 	}
 
 	mounts_mutex_unlock(ap);
@@ -903,28 +896,26 @@ int master_notify_submount(struct autofs_point *ap, const char *path, enum state
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
-		list_del(&ap->mounts);
+		list_del_init(&ap->mounts);
 	}
 
-	status = pthread_cond_signal(&ap->parent->mounts_cond);
-	if (status)
-		fatal(status);
-
-	mounts_mutex_unlock(ap->parent);
+	if (ap->submount_wait) {
+		ap->submount_wait = 0;
+		status = pthread_barrier_wait(&ap->submount_barrier);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD)
+			fatal(status);
+	}
 
 	return;
 }
@@ -970,6 +961,7 @@ void master_notify_state_change(struct master *master, int sig)
 			if (ap->state != ST_SHUTDOWN_FORCE &&
 			    ap->state != ST_SHUTDOWN_PENDING) {
 				next = ST_SHUTDOWN_FORCE;
+				ap->shutdown = 1;
 				nextstate(state_pipe, next);
 			}
 			break;
