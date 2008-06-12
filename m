From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/5] autofs-5.0.3 - Fix incorrect pthreads
	condition handling	for mount requests.
Date: Thu, 12 Jun 2008 13:04:34 +0800
Message-ID: <20080612050434.27161.46468.stgit@raven.themaw.net>
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

autofs-5.0.3-mount-thread-create-cond-handling.patch

---

 daemon/direct.c   |   66 +++++++++++++++++++++++++++--------------------------
 daemon/indirect.c |   41 +++++++++++++++++----------------
 2 files changed, 55 insertions(+), 52 deletions(-)


diff --git a/daemon/direct.c b/daemon/direct.c
index 529f143..f13ff62 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1212,7 +1212,7 @@ static void mount_mutex_unlock(void *arg)
 
 static void *do_mount_direct(void *arg)
 {
-	struct pending_args *mt;
+	struct pending_args *args, mt;
 	struct autofs_point *ap;
 	struct passwd pw;
 	struct passwd *ppw = &pw;
@@ -1226,47 +1226,47 @@ static void *do_mount_direct(void *arg)
 	struct stat st;
 	int status, state;
 
-	mt = (struct pending_args *) arg;
+	args = (struct pending_args *) arg;
 
 	status = pthread_mutex_lock(&ma_mutex);
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
 
 	mount_mutex_unlock(NULL);
 
-	pthread_cleanup_push(free_pending_args, mt);
-	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(mount_send_fail, mt);
+	pthread_cleanup_push(mount_send_fail, &mt);
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
 
-	status = fstat(mt->ioctlfd, &st);
+	status = fstat(mt.ioctlfd, &st);
 	if (status == -1) {
 		error(ap->logopt,
-		      "can't stat direct mount trigger %s", mt->name);
+		      "can't stat direct mount trigger %s", mt.name);
 		pthread_setcancelstate(state, NULL);
 		pthread_exit(NULL);
 	}
 
-	status = stat(mt->name, &st);
-	if (!S_ISDIR(st.st_mode) || st.st_dev != mt->dev) {
+	status = stat(mt.name, &st);
+	if (!S_ISDIR(st.st_mode) || st.st_dev != mt.dev) {
 		error(ap->logopt,
 		     "direct trigger not valid or already mounted %s",
-		     mt->name);
+		     mt.name);
 		pthread_setcancelstate(state, NULL);
 		pthread_exit(NULL);
 	}
 
 	pthread_setcancelstate(state, NULL);
 
-	info(ap->logopt, "attempting to mount entry %s", mt->name);
+	info(ap->logopt, "attempting to mount entry %s", mt.name);
 
 	/*
 	 * Setup thread specific data values for macro
@@ -1278,8 +1278,8 @@ static void *do_mount_direct(void *arg)
 	if (!tsv) 
 		goto cont;
 
-	tsv->uid = mt->uid;
-	tsv->gid = mt->gid;
+	tsv->uid = mt.uid;
+	tsv->gid = mt.gid;
 
 	/* Try to get passwd info */
 
@@ -1297,7 +1297,7 @@ static void *do_mount_direct(void *arg)
 		goto cont;
 	}
 
-	status = getpwuid_r(mt->uid, ppw, pw_tmp, tmplen, pppw);
+	status = getpwuid_r(tsv->uid, ppw, pw_tmp, tmplen, pppw);
 	if (status || !ppw) {
 		error(ap->logopt, "failed to get passwd info from getpwuid_r");
 		free(tsv);
@@ -1351,7 +1351,7 @@ static void *do_mount_direct(void *arg)
 		gr_tmp = tmp;
 		pgr = &gr;
 		ppgr = &pgr;
-		status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
+		status = getgrgid_r(tsv->gid, pgr, gr_tmp, tmplen, ppgr);
 		if (status != ERANGE)
 			break;
 		tmplen += grplen;
@@ -1388,7 +1388,7 @@ static void *do_mount_direct(void *arg)
 	}
 
 cont:
-	status = lookup_nss_mount(ap, NULL, mt->name, strlen(mt->name));
+	status = lookup_nss_mount(ap, NULL, mt.name, strlen(mt.name));
 	/*
 	 * Direct mounts are always a single mount. If it fails there's
 	 * nothing to undo so just complain
@@ -1397,29 +1397,27 @@ cont:
 	if (status) {
 		struct mapent *me;
 		int real_mount, set_fd;
-		cache_readlock(mt->mc);
-		me = cache_lookup_distinct(mt->mc, mt->name);
+		cache_readlock(mt.mc);
+		me = cache_lookup_distinct(mt.mc, mt.name);
 		real_mount = is_mounted(_PATH_MOUNTED, me->key, MNTS_REAL);
 		set_fd = (real_mount || me->multi == me);
-		cache_unlock(mt->mc);
+		cache_unlock(mt.mc);
 		if (set_fd) {
-			me->ioctlfd = mt->ioctlfd;
-			send_ready(ap->logopt, mt->ioctlfd, mt->wait_queue_token);
+			me->ioctlfd = mt.ioctlfd;
+			send_ready(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
 		} else {
-			send_ready(ap->logopt, mt->ioctlfd, mt->wait_queue_token);
-			close(mt->ioctlfd);
+			send_ready(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
+			close(mt.ioctlfd);
 		}
-		info(ap->logopt, "mounted %s", mt->name);
+		info(ap->logopt, "mounted %s", mt.name);
 	} else {
-		send_fail(mt->ap->logopt, mt->ioctlfd, mt->wait_queue_token);
-		close(mt->ioctlfd);
-		info(ap->logopt, "failed to mount %s", mt->name);
+		send_fail(ap->logopt, mt.ioctlfd, mt.wait_queue_token);
+		close(mt.ioctlfd);
+		info(ap->logopt, "failed to mount %s", mt.name);
 	}
 	pthread_setcancelstate(state, NULL);
 
 	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(1);
-	pthread_cleanup_pop(1);
 
 	return NULL;
 }
@@ -1548,6 +1546,8 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	}
 
 	cache_unlock(mc);
+	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_cond_destroy, mt);
 	pthread_cleanup_push(mount_mutex_unlock, NULL);
 	pthread_setcancelstate(state, NULL);
 
@@ -1559,6 +1559,8 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	}
 
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
diff --git a/daemon/indirect.c b/daemon/indirect.c
index fd94e59..1d79032 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -658,7 +658,7 @@ static void mount_mutex_unlock(void *arg)
 
 static void *do_mount_indirect(void *arg)
 {
-	struct pending_args *mt;
+	struct pending_args *args, mt;
 	struct autofs_point *ap;
 	char buf[PATH_MAX + 1];
 	struct stat st;
@@ -672,29 +672,28 @@ static void *do_mount_indirect(void *arg)
 	struct thread_stdenv_vars *tsv;
 	int len, tmplen, grplen, status, state;
 
-	mt = (struct pending_args *) arg;
+	args = (struct pending_args *) arg;
 
 	status = pthread_mutex_lock(&ma_mutex);
 	if (status)
 		fatal(status);
 
-	ap = mt->ap;
-	mt->status = 0;
+	memcpy(&mt, args, sizeof(struct pending_args));
 
-	mt->signaled = 1;
-	status = pthread_cond_signal(&mt->cond);
+	ap = mt.ap;
+
+	args->signaled = 1;
+	status = pthread_cond_signal(&args->cond);
 	if (status)
 		fatal(status);
 
 	mount_mutex_unlock(NULL);
 
-	pthread_cleanup_push(free_pending_args, mt);
-	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(mount_send_fail, mt);
+	pthread_cleanup_push(mount_send_fail, &mt);
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
 
-	len = ncat_path(buf, sizeof(buf), ap->path, mt->name, mt->len);
+	len = ncat_path(buf, sizeof(buf), ap->path, mt.name, mt.len);
 	if (!len) {
 		crit(ap->logopt, "path to be mounted is to long");
 		pthread_setcancelstate(state, NULL);
@@ -702,7 +701,7 @@ static void *do_mount_indirect(void *arg)
 	}
 
 	status = lstat(buf, &st);
-	if (status != -1 && !(S_ISDIR(st.st_mode) && st.st_dev == mt->dev)) {
+	if (status != -1 && !(S_ISDIR(st.st_mode) && st.st_dev == mt.dev)) {
 		error(ap->logopt,
 		      "indirect trigger not valid or already mounted %s", buf);
 		pthread_setcancelstate(state, NULL);
@@ -723,8 +722,8 @@ static void *do_mount_indirect(void *arg)
 	if (!tsv) 
 		goto cont;
 
-	tsv->uid = mt->uid;
-	tsv->gid = mt->gid;
+	tsv->uid = mt.uid;
+	tsv->gid = mt.gid;
 
 	/* Try to get passwd info */
 
@@ -742,7 +741,7 @@ static void *do_mount_indirect(void *arg)
 		goto cont;
 	}
 
-	status = getpwuid_r(mt->uid, ppw, pw_tmp, tmplen, pppw);
+	status = getpwuid_r(tsv->uid, ppw, pw_tmp, tmplen, pppw);
 	if (status || !ppw) {
 		error(ap->logopt, "failed to get passwd info from getpwuid_r");
 		free(tsv);
@@ -796,7 +795,7 @@ static void *do_mount_indirect(void *arg)
 		gr_tmp = tmp;
 		pgr = &gr;
 		ppgr = &pgr;
-		status = getgrgid_r(mt->gid, pgr, gr_tmp, tmplen, ppgr);
+		status = getgrgid_r(tsv->gid, pgr, gr_tmp, tmplen, ppgr);
 		if (status != ERANGE)
 			break;
 		tmplen += grplen;
@@ -832,20 +831,18 @@ static void *do_mount_indirect(void *arg)
 		free(tsv);
 	}
 cont:
-	status = lookup_nss_mount(ap, NULL, mt->name, mt->len);
+	status = lookup_nss_mount(ap, NULL, mt.name, mt.len);
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &state);
 	if (status) {
-		send_ready(ap->logopt, ap->ioctlfd, mt->wait_queue_token);
+		send_ready(ap->logopt, ap->ioctlfd, mt.wait_queue_token);
 		info(ap->logopt, "mounted %s", buf);
 	} else {
-		send_fail(ap->logopt, ap->ioctlfd, mt->wait_queue_token);
+		send_fail(ap->logopt, ap->ioctlfd, mt.wait_queue_token);
 		info(ap->logopt, "failed to mount %s", buf);
 	}
 	pthread_setcancelstate(state, NULL);
 
 	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(1);
-	pthread_cleanup_pop(1);
 
 	return NULL;
 }
@@ -909,6 +906,8 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 		return 1;
 	}
 
+	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_cond_destroy, mt);
 	pthread_cleanup_push(mount_mutex_unlock, NULL);
 	pthread_setcancelstate(state, NULL);
 
@@ -920,6 +919,8 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	}
 
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
