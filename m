From: Ian Kent <raven@themaw.net>
Subject: [PATCH 24/34] autofs-5.1.2 - create thread-local ID for mount
 attempts
Date: Mon, 24 Apr 2017 09:02:16 +0800
Message-ID: <149299573646.23475.14202580644194196479.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=SNyXxC8h02B4mD8ZPi
        LO0fARurccDvnUQLKNiMpp9z0=; b=fxEFSdo2texTCYFB18kMAro3SUpAmmc7Pu
        q3GKfY9Iz4/U3eYI1Gi/IaXgOVnfDEor0YdGn9eVmk2QeUx773FnmDqwP3F/GvPe
        tejakzFji6Lld712qbKeF6dBaH8N6jFG1pisQ8lN6iJHWQ+MY9XtmfJvzsNbY5pn
        jfT1lR4OnzjQG8SQXk4WvvxZ9cRCrg9hBpMQpiw+t5oRYiJ17upDuUBNmy6FEgGd
        73JcMYyc+DxvfaIrAEIZEesaspn4Lw5Vt9SJ37ogiMEqnOt/lb9UHx8dEv3l3hBX
        op9V9nbtDwn/x+x/svjWve53XYszmJK0Lm+nWwnVsCOrdFQXmEiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=SNyXxC8h02B4mD8ZPiLO0fARurccDvnUQLKNiMpp9z0=; b=VsgJFSqc
        6EMY9YpY+lbP7rJpiQE+YaeiCQcUskuT+gD5e+dkkbhMQ4qZPqAz1/mnT8mi6D6Q
        d9SWSMCQyhq6CjLvj5AbJW3kj+KQR/mx5JQSLd4Zu5YmLl+ro6Y1qK0E7eqN4CQX
        cml3eTF8j6MgSdJIUGl2tpYWXfpEaCE0j5HdQ4mJX8XPCtvDpdZzCTX7fRLyBg0U
        UDGoK3D1KchxegkzkR+rhW2P+dTha/uQA4L77CZfOLhmWBB/S+QZsWDB/+sZoX7j
        JequJEOLuOSpNF/u6pyRzPM7+LyaQnxCX4HOQMrLNt5+wjjJUeImTHcysw5/r4av
        ZxLyiYKIYmQVlA==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Lars R. Damerow <lars@pixar.com>

This patch creates key_thread_attempt_id as a pthread key and populates it
in each new thread serving a mount attempt. This ID can be used in output logs
as an easy string to grep for, allowing admins to quickly see a mount attempt's
log entries without the messages from other attempts interleaved.

The contents of the ID are intended to be opaque, but to get a chance at
a unique value for each mount attempt, this patch does a very simple hash
computation of the thread's wait_queue_token, the pid of the requesting
process, and the key for the mount. The hash is based on the public domain
sdbm library.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 daemon/automount.c  |   24 ++++++++++++++++++++++++
 daemon/direct.c     |   17 +++++++++++++++++
 daemon/indirect.c   |   17 +++++++++++++++++
 include/automount.h |    6 ++++++
 5 files changed, 65 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index cf9b62c..0cd0d45 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -50,6 +50,7 @@ xx/xx/2016 autofs-5.1.3
 - fix bogus check in expire_cleanup().
 - delay submount exit for amd submounts.
 - add the mount requestor's pid to pending_args.
+- create thread-local ID for mount attempts.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 6ebe885..2b23dec 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -89,6 +89,7 @@ struct startup_cond suc = {
 	PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0, 0};
 
 pthread_key_t key_thread_stdenv_vars;
+pthread_key_t key_thread_attempt_id = (pthread_key_t) 0L;
 
 #define MAX_OPEN_FILES		10240
 
@@ -98,6 +99,17 @@ static int umount_all(struct autofs_point *ap, int force);
 
 extern struct master *master_list;
 
+/* simple string hash based on public domain sdbm library */
+unsigned long sdbm_hash(const char *str, unsigned long seed)
+{
+	unsigned long hash = seed;
+	char c;
+
+	while ((c = *str++))
+		hash = c + (hash << 6) + (hash << 16) - hash;
+	return hash;
+}
+
 static int is_remote_fstype(unsigned int fs_type)
 {
 	int ret = 0;
@@ -2468,6 +2480,18 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
+	status = pthread_key_create(&key_thread_attempt_id, free);
+	if (status) {
+		logerr("%s: failed to create thread data key for attempt ID!",
+		       program);
+		master_kill(master_list);
+		res = write(start_pipefd[1], pst_stat, sizeof(*pst_stat));
+		close(start_pipefd[1]);
+		release_flag_file();
+		macro_free_global_table();
+		exit(1);
+	}
+
 	init_ioctl_ctl();
 
 	if (!alarm_start_handler()) {
diff --git a/daemon/direct.c b/daemon/direct.c
index 33faaea..6f1329b 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1210,6 +1210,8 @@ static void *do_mount_direct(void *arg)
 	struct autofs_point *ap;
 	struct stat st;
 	int status, state;
+	char attempt_id_comp[20];
+	unsigned long *attempt_id;
 
 	args = (struct pending_args *) arg;
 
@@ -1219,6 +1221,21 @@ static void *do_mount_direct(void *arg)
 
 	ap = mt.ap;
 
+	attempt_id = pthread_getspecific(key_thread_attempt_id);
+	if (attempt_id == NULL) {
+		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
+		if (attempt_id == NULL)
+			fatal(ENOMEM);
+		snprintf(attempt_id_comp, 20, "%ld", mt.wait_queue_token);
+		*attempt_id = sdbm_hash(attempt_id_comp, 0);
+		snprintf(attempt_id_comp, 20, "%u", mt.pid);
+		*attempt_id = sdbm_hash(attempt_id_comp, *attempt_id);
+		*attempt_id = sdbm_hash(mt.name, *attempt_id);
+		status = pthread_setspecific(key_thread_attempt_id, attempt_id);
+		if (status != 0)
+			fatal(status);
+	}
+
 	args->signaled = 1;
 	status = pthread_cond_signal(&args->cond);
 	if (status)
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 0db2749..3ed47e8 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -726,6 +726,8 @@ static void *do_mount_indirect(void *arg)
 	char buf[PATH_MAX + 1];
 	struct stat st;
 	int len, status, state;
+	char attempt_id_comp[20];
+	unsigned long *attempt_id;
 
 	args = (struct pending_args *) arg;
 
@@ -735,6 +737,21 @@ static void *do_mount_indirect(void *arg)
 
 	ap = mt.ap;
 
+	attempt_id = pthread_getspecific(key_thread_attempt_id);
+	if (attempt_id == NULL) {
+		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
+		if (attempt_id  == NULL)
+			fatal(ENOMEM);
+		snprintf(attempt_id_comp, 20, "%ld", mt.wait_queue_token);
+		*attempt_id = sdbm_hash(attempt_id_comp, 0);
+		snprintf(attempt_id_comp, 20, "%u", mt.pid);
+		*attempt_id = sdbm_hash(attempt_id_comp, *attempt_id);
+		*attempt_id = sdbm_hash(mt.name, *attempt_id);
+		status = pthread_setspecific(key_thread_attempt_id, attempt_id);
+		if (status != 0)
+			fatal(status);
+	}
+
 	args->signaled = 1;
 	status = pthread_cond_signal(&args->cond);
 	if (status)
diff --git a/include/automount.h b/include/automount.h
index 58c45a9..1800c21 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -78,6 +78,8 @@ int load_autofs4_module(void);
 #define NCP_SUPER_MAGIC    0x0000564CL
 #define NFS_SUPER_MAGIC    0x00006969L
 
+#define ATTEMPT_ID_SIZE 24
+
 /* This sould be enough for at least 20 host aliases */
 #define HOST_ENT_BUF_SIZE	2048
 
@@ -243,6 +245,8 @@ const char **copy_argv(int argc, const char **argv);
 int compare_argv(int argc1, const char **argv1, int argc2, const char **argv2);
 int free_argv(int argc, const char **argv);
 
+unsigned long sdbm_hash(const char *str, unsigned long seed);
+
 void dump_core(void);
 int aquire_lock(void);
 void release_lock(void);
@@ -503,6 +507,8 @@ struct thread_stdenv_vars {
 
 extern pthread_key_t key_thread_stdenv_vars;
 
+extern pthread_key_t key_thread_attempt_id;
+
 struct kernel_mod_version {
 	unsigned int major;
 	unsigned int minor;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
