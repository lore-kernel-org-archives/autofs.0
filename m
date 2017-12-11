From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/27] autofs-5.1.3 - serialize calls to open_xxxx()
 functions
Date: Mon, 11 Dec 2017 16:58:26 +0800
Message-ID: <151298270696.19722.15257630239177308910.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

This patch is the second part of the change described in "move
open_xxxx() functions to spawn.c" to serialize the open_xxxx()
functions wrt. to fork(2).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 daemon/spawn.c           |   61 ++++++++++++++++++++++++++++++++++++++++------
 include/automount.h      |    2 ++
 lib/mounts.c             |    2 ++
 modules/lookup_program.c |    3 ++
 5 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 44540da3..65dd850e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -41,6 +41,7 @@ xx/xx/2017 autofs-5.1.4
 - update configure to check for pipe2(2).
 - fix open calls not using open_xxxx() calls.
 - move open_xxxx() functions to spawn.c.
+- serialize calls to open_xxxx() functions.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index f03f9028..56133815 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -30,6 +30,7 @@
 #include "automount.h"
 
 static pthread_mutex_t spawn_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_mutex_t open_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 #define SPAWN_OPT_NONE		0x0000
 #define SPAWN_OPT_LOCK		0x0001
@@ -49,6 +50,20 @@ void dump_core(void)
 	raise(SIGSEGV);
 }
 
+void open_mutex_lock(void)
+{
+	int _o_lock = pthread_mutex_lock(&open_mutex);
+	if (_o_lock)
+		fatal(_o_lock);
+}
+
+void open_mutex_unlock(void)
+{
+	int _o_unlock = pthread_mutex_unlock(&open_mutex);
+	if (_o_unlock)
+		fatal(_o_unlock);
+}
+
 /*
  * Use CLOEXEC flag for open(), pipe(), fopen() (read-only case) and
  * socket() if possible.
@@ -72,14 +87,18 @@ int open_fd(const char *path, int flags)
 {
 	int fd;
 
+	open_mutex_lock();
 #if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
 	if (cloexec_works != -1)
 		flags |= O_CLOEXEC;
 #endif
 	fd = open(path, flags);
-	if (fd == -1)
+	if (fd == -1) {
+		open_mutex_unlock();
 		return -1;
+	}
 	check_cloexec(fd);
+	open_mutex_unlock();
 	return fd;
 }
 
@@ -87,14 +106,18 @@ int open_fd_mode(const char *path, int flags, int mode)
 {
 	int fd;
 
+	open_mutex_lock();
 #if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
 	if (cloexec_works != -1)
 		flags |= O_CLOEXEC;
 #endif
 	fd = open(path, flags, mode);
-	if (fd == -1)
+	if (fd == -1) {
+		open_mutex_unlock();
 		return -1;
+	}
 	check_cloexec(fd);
+	open_mutex_unlock();
 	return fd;
 }
 
@@ -102,35 +125,45 @@ int open_pipe(int pipefd[2])
 {
 	int ret;
 
+	open_mutex_lock();
 #if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC) && defined(HAVE_PIPE2)
 	if (cloexec_works != -1) {
 		ret = pipe2(pipefd, O_CLOEXEC);
 		if (ret != -1)
-			return 0;
+			goto done;
 		if (errno != EINVAL)
-			return -1;
+			goto err;
 	}
 #endif
 	ret = pipe(pipefd);
 	if (ret == -1)
-		return -1;
+		goto err;
 	check_cloexec(pipefd[0]);
 	check_cloexec(pipefd[1]);
+done:
+	open_mutex_unlock();
 	return 0;
+err:
+	open_mutex_unlock();
+	return -1;
 }
 
 int open_sock(int domain, int type, int protocol)
 {
 	int fd;
 
+	open_mutex_lock();
 #ifdef SOCK_CLOEXEC
 	if (cloexec_works != -1)
 		type |= SOCK_CLOEXEC;
 #endif
 	fd = socket(domain, type, protocol);
-	if (fd == -1)
+	if (fd == -1) {
+		open_mutex_unlock();
 		return -1;
+	}
 	check_cloexec(fd);
+	open_mutex_unlock();
 	return fd;
 }
 
@@ -138,19 +171,24 @@ FILE *open_fopen_r(const char *path)
 {
 	FILE *f;
 
+	open_mutex_lock();
 #if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
 	if (cloexec_works != -1) {
 		f = fopen(path, "re");
 		if (f != NULL) {
 			check_cloexec(fileno(f));
+			open_mutex_unlock();
 			return f;
 		}
 	}
 #endif
 	f = fopen(path, "r");
-	if (f == NULL)
+	if (f == NULL) {
+		open_mutex_unlock();
 		return NULL;
+	}
 	check_cloexec(fileno(f));
+	open_mutex_unlock();
 	return f;
 }
 
@@ -158,19 +196,24 @@ FILE *open_setmntent_r(const char *table)
 {
 	FILE *tab;
 
+	open_mutex_lock();
 #if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
 	if (cloexec_works != -1) {
 		tab = setmntent(table, "re");
 		if (tab != NULL) {
 			check_cloexec(fileno(tab));
+			open_mutex_unlock();
 			return tab;
 		}
 	}
 #endif
 	tab = fopen(table, "r");
-	if (tab == NULL)
+	if (tab == NULL) {
+		open_mutex_unlock();
 		return NULL;
+	}
 	check_cloexec(fileno(tab));
+	open_mutex_unlock();
 	return tab;
 }
 
@@ -284,6 +327,7 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 		egid = tsv->gid;
 	}
 
+	open_mutex_lock();
 	f = fork();
 	if (f == 0) {
 		char **pargv = (char **) argv;
@@ -398,6 +442,7 @@ done:
 
 		sigaddset(&tmpsig, SIGCHLD);
 		pthread_sigmask(SIG_SETMASK, &tmpsig, NULL);
+		open_mutex_unlock();
 
 		close(pipefd[1]);
 
diff --git a/include/automount.h b/include/automount.h
index c461a309..2e2c2b02 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -257,6 +257,8 @@ int spawnv(unsigned logopt, const char *prog, const char *const *argv);
 int spawn_mount(unsigned logopt, ...);
 int spawn_bind_mount(unsigned logopt, ...);
 int spawn_umount(unsigned logopt, ...);
+void open_mutex_lock(void);
+void open_mutex_unlock(void);
 int open_fd(const char *, int);
 int open_fd_mode(const char *, int, int);
 int open_pipe(int[2]);
diff --git a/lib/mounts.c b/lib/mounts.c
index 7fd88471..93c53026 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -230,6 +230,7 @@ int check_nfs_mount_version(struct nfs_mount_vers *vers,
 	sigfillset(&allsigs);
 	pthread_sigmask(SIG_BLOCK, &allsigs, &oldsig);
 
+	open_mutex_lock();
 	f = fork();
 	if (f == 0) {
 		reset_signals();
@@ -248,6 +249,7 @@ int check_nfs_mount_version(struct nfs_mount_vers *vers,
 
 	sigaddset(&tmpsig, SIGCHLD);
 	pthread_sigmask(SIG_SETMASK, &tmpsig, NULL);
+	open_mutex_unlock();
 
 	close(pipefd[1]);
 
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index b3f1c1f0..56e19394 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -225,6 +225,7 @@ static char *lookup_one(struct autofs_point *ap,
 		goto out_error;
 	}
 
+	open_mutex_lock();
 	f = fork();
 	if (f < 0) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
@@ -233,6 +234,7 @@ static char *lookup_one(struct autofs_point *ap,
 		close(pipefd[1]);
 		close(epipefd[0]);
 		close(epipefd[1]);
+		open_mutex_unlock();
 		goto out_error;
 	} else if (f == 0) {
 		reset_signals();
@@ -262,6 +264,7 @@ static char *lookup_one(struct autofs_point *ap,
 	}
 	close(pipefd[1]);
 	close(epipefd[1]);
+	open_mutex_unlock();
 
 	mapp = mapent;
 	errp = errbuf;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
