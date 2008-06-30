From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs-5.0.3 - make handle_mounts startup
	condition	distinct
Date: Mon, 30 Jun 2008 14:51:00 +0800
Message-ID: <20080630065059.20857.38997.stgit@raven.themaw.net>
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

autofs-5.0.3-make-handle_mounts-startup-cond-distinct.patch

When starting a number of mounts we can get contention for the startup
condition used to synchronize the handle_mounts thread completion. This
patch makes the condition used distinct for each thread creation.

---

 daemon/automount.c     |   62 ++++++++++++++++++++++++++++++++++++++++++++----
 include/automount.h    |    4 +++
 lib/master.c           |   29 +++++++++++-----------
 modules/mount_autofs.c |   35 +++++++++++++--------------
 4 files changed, 92 insertions(+), 38 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index afbcb56..4b94028 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1446,6 +1446,55 @@ static void mutex_operation_wait(pthread_mutex_t *mutex)
 	return;
 }
 
+int handle_mounts_startup_cond_init(struct startup_cond *suc)
+{
+	int status;
+
+	status = pthread_mutex_init(&suc->mutex, NULL);
+	if (status)
+		return status;
+
+	status = pthread_cond_init(&suc->cond, NULL);
+	if (status) {
+		status = pthread_mutex_destroy(&suc->mutex);
+		if (status)
+			fatal(status);
+		return status;
+	}
+
+	status = pthread_mutex_lock(&suc->mutex);
+	if (status) {
+		status = pthread_mutex_destroy(&suc->mutex);
+		if (status)
+			fatal(status);
+		status = pthread_cond_destroy(&suc->cond);
+		if (status)
+			fatal(status);
+	}
+
+	return 0;
+}
+
+void handle_mounts_startup_cond_destroy(void *arg)
+{
+	struct startup_cond *suc = (struct startup_cond *) arg;
+	int status;
+
+	status = pthread_mutex_unlock(&suc->mutex);
+	if (status)
+		fatal(status);
+
+	status = pthread_mutex_destroy(&suc->mutex);
+	if (status)
+		fatal(status);
+
+	status = pthread_cond_destroy(&suc->cond);
+	if (status)
+		fatal(status);
+
+	return;
+}
+
 static void handle_mounts_cleanup(void *arg)
 {
 	struct autofs_point *ap;
@@ -1497,17 +1546,20 @@ static void handle_mounts_cleanup(void *arg)
 
 void *handle_mounts(void *arg)
 {
+	struct startup_cond *suc;
 	struct autofs_point *ap;
 	int cancel_state, status = 0;
 
-	ap = (struct autofs_point *) arg;
+	suc = (struct startup_cond *) arg;
+
+	ap = suc->ap;
 
-	pthread_cleanup_push(return_start_status, &suc);
+	pthread_cleanup_push(return_start_status, suc);
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cancel_state);
 
 	state_mutex_lock(ap);
 
-	status = pthread_mutex_lock(&suc.mutex);
+	status = pthread_mutex_lock(&suc->mutex);
 	if (status) {
 		logerr("failed to lock startup condition mutex!");
 		fatal(status);
@@ -1515,7 +1567,7 @@ void *handle_mounts(void *arg)
 
 	if (mount_autofs(ap) < 0) {
 		crit(ap->logopt, "mount of %s failed!", ap->path);
-		suc.status = 1;
+		suc->status = 1;
 		state_mutex_unlock(ap);
 		umount_autofs(ap, 1);
 		pthread_setcancelstate(cancel_state, NULL);
@@ -1525,7 +1577,7 @@ void *handle_mounts(void *arg)
 	if (ap->ghost && ap->type != LKP_DIRECT)
 		info(ap->logopt, "ghosting enabled");
 
-	suc.status = 0;
+	suc->status = 0;
 	pthread_cleanup_pop(1);
 
 	/* We often start several automounters at the same time.  Add some
diff --git a/include/automount.h b/include/automount.h
index cd8ce7b..76e5478 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -385,10 +385,14 @@ int tree_is_mounted(struct mnt_list *mnts, const char *path, unsigned int type);
 struct startup_cond {
 	pthread_mutex_t mutex;
 	pthread_cond_t  cond;
+	struct autofs_point *ap;
 	unsigned int done;
 	unsigned int status;
 };
 
+int handle_mounts_startup_cond_init(struct startup_cond *suc);
+void handle_mounts_startup_cond_destroy(void *arg);
+
 struct master_readmap_cond {
 	pthread_mutex_t mutex;
 	pthread_cond_t  cond;
diff --git a/lib/master.c b/lib/master.c
index 4a34dd4..edd3bdc 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -997,28 +997,31 @@ next:
 
 static int master_do_mount(struct master_mapent *entry)
 {
+	struct startup_cond suc;
 	struct autofs_point *ap;
 	pthread_t thid;
 	int status;
 
-	status = pthread_mutex_lock(&suc.mutex);
-	if (status)
-		fatal(status);
+	ap = entry->ap;
+
+	if (handle_mounts_startup_cond_init(&suc)) {
+		crit(ap->logopt,
+		     "failed to init startup cond for mount %s", entry->path);
+		return 0;
+	}
 
+	suc.ap = ap;
 	suc.done = 0;
 	suc.status = 0;
 
-	ap = entry->ap;
-
 	debug(ap->logopt, "mounting %s", entry->path);
 
-	if (pthread_create(&thid, &thread_attr, handle_mounts, ap)) {
+	status = pthread_create(&thid, &thread_attr, handle_mounts, &suc);
+	if (status) {
 		crit(ap->logopt,
 		     "failed to create mount handler thread for %s",
 		     entry->path);
-		status = pthread_mutex_unlock(&suc.mutex);
-		if (status)
-			fatal(status);
+		handle_mounts_startup_cond_destroy(&suc);
 		return 0;
 	}
 	entry->thid = thid;
@@ -1031,15 +1034,11 @@ static int master_do_mount(struct master_mapent *entry)
 
 	if (suc.status) {
 		error(ap->logopt, "failed to startup mount");
-		status = pthread_mutex_unlock(&suc.mutex);
-		if (status)
-			fatal(status);
+		handle_mounts_startup_cond_destroy(&suc);
 		return 0;
 	}
 
-	status = pthread_mutex_unlock(&suc.mutex);
-	if (status)
-		fatal(status);
+	handle_mounts_startup_cond_destroy(&suc);
 
 	return 1;
 }
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 356fb14..6f66564 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -46,6 +46,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 		int name_len, const char *what, const char *fstype,
 		const char *c_options, void *context)
 {
+	struct startup_cond suc;
 	pthread_t thid;
 	char *fullpath;
 	const char **argv;
@@ -210,34 +211,34 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	source->mc = cache_init(entry->ap, source);
 	if (!source->mc) {
 		error(ap->logopt, MODPREFIX "failed to init source cache");
+		master_free_map_source(source, 0);
 		master_free_mapent(entry);
 		return 1;
 	}
 
 	mounts_mutex_lock(ap);
 
-	status = pthread_mutex_lock(&suc.mutex);
-	if (status) {
-		crit(ap->logopt,
-		     MODPREFIX "failed to lock startup condition mutex!");
-		cache_release(source);
+	if (handle_mounts_startup_cond_init(&suc)) {
+		crit(ap->logopt, MODPREFIX
+		     "failed to init startup cond for mount %s", entry->path);
+		mounts_mutex_unlock(ap);
+		master_free_map_source(source, 1);
 		master_free_mapent(entry);
 		return 1;
 	}
 
+	suc.ap = nap;
 	suc.done = 0;
 	suc.status = 0;
 
-	if (pthread_create(&thid, NULL, handle_mounts, nap)) {
+	if (pthread_create(&thid, &thread_attr, handle_mounts, &suc)) {
 		crit(ap->logopt,
 		     MODPREFIX
 		     "failed to create mount handler thread for %s",
 		     fullpath);
+		handle_mounts_startup_cond_destroy(&suc);
 		mounts_mutex_unlock(ap);
-		status = pthread_mutex_unlock(&suc.mutex);
-		if (status)
-			fatal(status);
-		cache_release(source);
+		master_free_map_source(source, 1);
 		master_free_mapent(entry);
 		return 1;
 	}
@@ -246,8 +247,10 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	while (!suc.done) {
 		status = pthread_cond_wait(&suc.cond, &suc.mutex);
 		if (status) {
+			handle_mounts_startup_cond_destroy(&suc);
 			mounts_mutex_unlock(ap);
-			pthread_mutex_unlock(&suc.mutex);
+			master_free_map_source(source, 1);
+			master_free_mapent(entry);
 			fatal(status);
 		}
 	}
@@ -255,10 +258,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	if (suc.status) {
 		crit(ap->logopt,
 		     MODPREFIX "failed to create submount for %s", fullpath);
+		handle_mounts_startup_cond_destroy(&suc);
 		mounts_mutex_unlock(ap);
-		status = pthread_mutex_unlock(&suc.mutex);
-		if (status)
-			fatal(status);
+		master_free_map_source(source, 1);
 		master_free_mapent(entry);
 		return 1;
 	}
@@ -266,12 +268,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	ap->submnt_count++;
 	list_add(&nap->mounts, &ap->submounts);
 
+	handle_mounts_startup_cond_destroy(&suc);
 	mounts_mutex_unlock(ap);
 
-	status = pthread_mutex_unlock(&suc.mutex);
-	if (status)
-		fatal(status);
-
 	return 0;
 }
