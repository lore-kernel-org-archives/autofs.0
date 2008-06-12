From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/5] autofs-5.0.3 - mount thread create condition
	handling fix
Date: Thu, 12 Jun 2008 13:04:39 +0800
Message-ID: <20080612050439.27161.52276.stgit@raven.themaw.net>
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

autofs-5.0.3-mount-thread-create-cond-handling-fix.patch

Make the mount thread creation condition mutex spacific to the
thread being created.

---

 daemon/direct.c   |   30 +++++++++++++++++++++++-------
 daemon/indirect.c |   30 +++++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 14 deletions(-)


diff --git a/daemon/direct.c b/daemon/direct.c
index f13ff62..cc03ccd 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1203,9 +1203,18 @@ static void mount_send_fail(void *arg)
 	close(mt->ioctlfd);
 }
 
+static void pending_mutex_destroy(void *arg)
+{
+	struct pending_args *mt = (struct pending_args *) arg;
+	int status = pthread_mutex_destroy(&mt->mutex);
+	if (status)
+		fatal(status);
+}
+
 static void mount_mutex_unlock(void *arg)
 {
-	int status = pthread_mutex_unlock(&ma_mutex);
+	struct pending_args *mt = (struct pending_args *) arg;
+	int status = pthread_mutex_unlock(&mt->mutex);
 	if (status)
 		fatal(status);
 }
@@ -1228,7 +1237,7 @@ static void *do_mount_direct(void *arg)
 
 	args = (struct pending_args *) arg;
 
-	status = pthread_mutex_lock(&ma_mutex);
+	status = pthread_mutex_lock(&args->mutex);
 	if (status)
 		fatal(status);
 
@@ -1241,7 +1250,7 @@ static void *do_mount_direct(void *arg)
 	if (status)
 		fatal(status);
 
-	mount_mutex_unlock(NULL);
+	mount_mutex_unlock(args);
 
 	pthread_cleanup_push(mount_send_fail, &mt);
 
@@ -1518,7 +1527,11 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	if (status)
 		fatal(status);
 
-	status = pthread_mutex_lock(&ma_mutex);
+	status = pthread_mutex_init(&mt->mutex, NULL);
+	if (status)
+		fatal(status);
+
+	status = pthread_mutex_lock(&mt->mutex);
 	if (status)
 		fatal(status);
 
@@ -1538,8 +1551,9 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 		send_fail(ap->logopt, ioctlfd, pkt->wait_queue_token);
 		close(ioctlfd);
 		cache_unlock(mc);
-		mount_mutex_unlock(NULL);
+		mount_mutex_unlock(mt);
 		pending_cond_destroy(mt);
+		pending_mutex_destroy(mt);
 		free_pending_args(mt);
 		pthread_setcancelstate(state, NULL);
 		return 1;
@@ -1547,13 +1561,14 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 
 	cache_unlock(mc);
 	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_mutex_destroy, mt);
 	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(mount_mutex_unlock, NULL);
+	pthread_cleanup_push(mount_mutex_unlock, mt);
 	pthread_setcancelstate(state, NULL);
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		status = pthread_cond_wait(&mt->cond, &ma_mutex);
+		status = pthread_cond_wait(&mt->cond, &mt->mutex);
 		if (status)
 			fatal(status);
 	}
@@ -1561,6 +1576,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	pthread_cleanup_pop(1);
 	pthread_cleanup_pop(1);
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 1d79032..c32b658 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -649,9 +649,18 @@ static void mount_send_fail(void *arg)
 	send_fail(mt->ap->logopt, mt->ap->ioctlfd, mt->wait_queue_token);
 }
 
+static void pending_mutex_destroy(void *arg)
+{
+	struct pending_args *mt = (struct pending_args *) arg;
+	int status = pthread_mutex_destroy(&mt->mutex);
+	if (status)
+		fatal(status);
+}
+
 static void mount_mutex_unlock(void *arg)
 {
-	int status = pthread_mutex_unlock(&ma_mutex);
+	struct pending_args *mt = (struct pending_args *) arg;
+	int status = pthread_mutex_unlock(&mt->mutex);
 	if (status)
 		fatal(status);
 }
@@ -674,7 +683,7 @@ static void *do_mount_indirect(void *arg)
 
 	args = (struct pending_args *) arg;
 
-	status = pthread_mutex_lock(&ma_mutex);
+	status = pthread_mutex_lock(&args->mutex);
 	if (status)
 		fatal(status);
 
@@ -687,7 +696,7 @@ static void *do_mount_indirect(void *arg)
 	if (status)
 		fatal(status);
 
-	mount_mutex_unlock(NULL);
+	mount_mutex_unlock(args);
 
 	pthread_cleanup_push(mount_send_fail, &mt);
 
@@ -882,7 +891,11 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	if (status)
 		fatal(status);
 
-	status = pthread_mutex_lock(&ma_mutex);
+	status = pthread_mutex_init(&mt->mutex, NULL);
+	if (status)
+		fatal(status);
+
+	status = pthread_mutex_lock(&mt->mutex);
 	if (status)
 		fatal(status);
 
@@ -899,21 +912,23 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	if (status) {
 		error(ap->logopt, "expire thread create failed");
 		send_fail(ap->logopt, ap->ioctlfd, pkt->wait_queue_token);
-		mount_mutex_unlock(NULL);
+		mount_mutex_unlock(mt);
 		pending_cond_destroy(mt);
+		pending_mutex_destroy(mt);
 		free_pending_args(mt);
 		pthread_setcancelstate(state, NULL);
 		return 1;
 	}
 
 	pthread_cleanup_push(free_pending_args, mt);
+	pthread_cleanup_push(pending_mutex_destroy, mt);
 	pthread_cleanup_push(pending_cond_destroy, mt);
-	pthread_cleanup_push(mount_mutex_unlock, NULL);
+	pthread_cleanup_push(mount_mutex_unlock, mt);
 	pthread_setcancelstate(state, NULL);
 
 	mt->signaled = 0;
 	while (!mt->signaled) {
-		status = pthread_cond_wait(&mt->cond, &ma_mutex);
+		status = pthread_cond_wait(&mt->cond, &mt->mutex);
 		if (status)
 			fatal(status);
 	}
@@ -921,6 +936,7 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	pthread_cleanup_pop(1);
 	pthread_cleanup_pop(1);
 	pthread_cleanup_pop(1);
+	pthread_cleanup_pop(1);
 
 	return 0;
 }
