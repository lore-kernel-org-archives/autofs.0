From: Ian Kent <raven@themaw.net>
Subject: [PATCH 26/34] autofs-5.1.2 - factor out
 set_thread_mount_request_log_id()
Date: Mon, 24 Apr 2017 09:02:26 +0800
Message-ID: <149299574677.23475.6953867796888410049.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=Kr+PnDeS1iCKO34xVU
        YeJs1wMBtgEufTd3wmWxmjxNQ=; b=SJtwZ/JsWzgjMSG2A6DDuB0E11Y7vSMqIi
        tyT2nhPGSoYSYaEMWpQ0xYVEwQ6WGhAulgmq606QRkFMQnUJQJbdEJLBGY9IBGgm
        xcEtNOC//YntH/ymfYHt5BwbpVLEkkYICIuIHsOGEBLmqu4Lmv21r4K4DtwjnRbp
        jG8dOqLoY4dT7YPR4hOAXwn+YMNMC2lKr+tGIE6GntEo+BA+L0BOrjV9wJtAW6O/
        asOAiHi6r2nJNLhXjO/MRM6QEfYqNsDqbHj7jx+7mrq0qnIBrw7YsdFcnfsN5G8Y
        L+7Wp6I3fUmMR36C5qfzOt6c1lPU4rRSaNj4xaOdlAqPvWqFc4Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=Kr+PnDeS1iCKO34xVUYeJs1wMBtgEufTd3wmWxmjxNQ=; b=Tgsa3DZ6
        DXkNEkYx48vQhYk1hSWZ3gwMYuF/XTlhve32sps/ExSFgKA/Fi2NBlFLSsSPK8kn
        /8x2J7hyABXz/3GzNnZv7Xnpc+fAaq6XS+EPat/rsk3i+cB4M/SiYGgZ9NCyLIvl
        iiHApUUIICbOtxiJ8gJ8IsndIh6ozrdviRT4YPK0bwEgfd4gswYh6F8XlUjKQRuD
        P9s+HcWfeP/1DoiHlNfwQSTPTJvErftd+561P7psZiis2nYZOnFhgf9zDtJlRHi6
        TQrEsZZSeegVoh+UJr9jc9lnQHVX2nAmTWJvOTSBMuTmU3eU7QU3GBTcDI/3pJ1C
        dJVFAaJGXQjxuw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Factor out setting the thread mount request log id.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 daemon/automount.c  |   24 +++++++++++++++++++++++-
 daemon/direct.c     |   17 +----------------
 daemon/indirect.c   |   17 +----------------
 include/automount.h |    3 ++-
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index eed9697..7add032 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -52,6 +52,7 @@ xx/xx/2016 autofs-5.1.3
 - add the mount requestor's pid to pending_args.
 - create thread-local ID for mount attempts.
 - log functions to prefix messages with attempt_id if available.
+- factor out set_thread_mount_request_log_id().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 2b23dec..203d21f 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -100,7 +100,7 @@ static int umount_all(struct autofs_point *ap, int force);
 extern struct master *master_list;
 
 /* simple string hash based on public domain sdbm library */
-unsigned long sdbm_hash(const char *str, unsigned long seed)
+static unsigned long sdbm_hash(const char *str, unsigned long seed)
 {
 	unsigned long hash = seed;
 	char c;
@@ -110,6 +110,28 @@ unsigned long sdbm_hash(const char *str, unsigned long seed)
 	return hash;
 }
 
+void set_thread_mount_request_log_id(struct pending_args *mt)
+{
+	char attempt_id_comp[20];
+	unsigned long *attempt_id;
+	int status;
+
+	attempt_id = pthread_getspecific(key_thread_attempt_id);
+	if (attempt_id == NULL) {
+		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
+		if (attempt_id  == NULL)
+			fatal(ENOMEM);
+		snprintf(attempt_id_comp, 20, "%ld", mt->wait_queue_token);
+		*attempt_id = sdbm_hash(attempt_id_comp, 0);
+		snprintf(attempt_id_comp, 20, "%u", mt->pid);
+		*attempt_id = sdbm_hash(attempt_id_comp, *attempt_id);
+		*attempt_id = sdbm_hash(mt->name, *attempt_id);
+		status = pthread_setspecific(key_thread_attempt_id, attempt_id);
+		if (status != 0)
+			fatal(status);
+	}
+}
+
 static int is_remote_fstype(unsigned int fs_type)
 {
 	int ret = 0;
diff --git a/daemon/direct.c b/daemon/direct.c
index 6f1329b..b682346 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1210,8 +1210,6 @@ static void *do_mount_direct(void *arg)
 	struct autofs_point *ap;
 	struct stat st;
 	int status, state;
-	char attempt_id_comp[20];
-	unsigned long *attempt_id;
 
 	args = (struct pending_args *) arg;
 
@@ -1221,20 +1219,7 @@ static void *do_mount_direct(void *arg)
 
 	ap = mt.ap;
 
-	attempt_id = pthread_getspecific(key_thread_attempt_id);
-	if (attempt_id == NULL) {
-		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
-		if (attempt_id == NULL)
-			fatal(ENOMEM);
-		snprintf(attempt_id_comp, 20, "%ld", mt.wait_queue_token);
-		*attempt_id = sdbm_hash(attempt_id_comp, 0);
-		snprintf(attempt_id_comp, 20, "%u", mt.pid);
-		*attempt_id = sdbm_hash(attempt_id_comp, *attempt_id);
-		*attempt_id = sdbm_hash(mt.name, *attempt_id);
-		status = pthread_setspecific(key_thread_attempt_id, attempt_id);
-		if (status != 0)
-			fatal(status);
-	}
+	set_thread_mount_request_log_id(&mt);
 
 	args->signaled = 1;
 	status = pthread_cond_signal(&args->cond);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 3ed47e8..00b2622 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -726,8 +726,6 @@ static void *do_mount_indirect(void *arg)
 	char buf[PATH_MAX + 1];
 	struct stat st;
 	int len, status, state;
-	char attempt_id_comp[20];
-	unsigned long *attempt_id;
 
 	args = (struct pending_args *) arg;
 
@@ -737,20 +735,7 @@ static void *do_mount_indirect(void *arg)
 
 	ap = mt.ap;
 
-	attempt_id = pthread_getspecific(key_thread_attempt_id);
-	if (attempt_id == NULL) {
-		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
-		if (attempt_id  == NULL)
-			fatal(ENOMEM);
-		snprintf(attempt_id_comp, 20, "%ld", mt.wait_queue_token);
-		*attempt_id = sdbm_hash(attempt_id_comp, 0);
-		snprintf(attempt_id_comp, 20, "%u", mt.pid);
-		*attempt_id = sdbm_hash(attempt_id_comp, *attempt_id);
-		*attempt_id = sdbm_hash(mt.name, *attempt_id);
-		status = pthread_setspecific(key_thread_attempt_id, attempt_id);
-		if (status != 0)
-			fatal(status);
-	}
+	set_thread_mount_request_log_id(&mt);
 
 	args->signaled = 1;
 	status = pthread_cond_signal(&args->cond);
diff --git a/include/automount.h b/include/automount.h
index 1800c21..eb4fcc4 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -245,7 +245,8 @@ const char **copy_argv(int argc, const char **argv);
 int compare_argv(int argc1, const char **argv1, int argc2, const char **argv2);
 int free_argv(int argc, const char **argv);
 
-unsigned long sdbm_hash(const char *str, unsigned long seed);
+struct pending_args;
+void set_thread_mount_request_log_id(struct pending_args *mt);
 
 void dump_core(void);
 int aquire_lock(void);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
