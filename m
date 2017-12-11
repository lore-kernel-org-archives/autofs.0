From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/27] autofs-5.1.3 - move open_xxxx() functions to spawn.c
Date: Mon, 11 Dec 2017 16:58:19 +0800
Message-ID: <151298269931.19722.6557254983845023493.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In a bug report by John Salmon has described a race between the
autofs open_xxxx() functions and fork(2) that can cause file handles
that don't have close on exec set to leak into subprocesses.

Basically, in some cases there can be a finite time between performing
the open and setting the descriptor close on exec and it's this window
that leads to the problem.

The description went on to talk about a case where autofs can hang when
this happens. That is when the leaked decriptor causes poll(2) to not
return in another process because it is waiting for the decriptor to
close (on mount completion) but another execed process has the cloned
descriptor open.

Serializing access to the open_xxxx() functions wrt. to fork(2) calls
should be suficient to resolve this leakage.

This patch starts this by moving the open_xxxx() out of the automount.h
include file and into spawn.c.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 
 daemon/spawn.c      |  125 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/automount.h |  132 +++------------------------------------------------
 3 files changed, 133 insertions(+), 125 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 09d2f39e..44540da3 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -40,6 +40,7 @@ xx/xx/2017 autofs-5.1.4
 - fix ordering of seteuid/setegid in do_spawn().
 - update configure to check for pipe2(2).
 - fix open calls not using open_xxxx() calls.
+- move open_xxxx() functions to spawn.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 6557c066..f03f9028 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -50,6 +50,131 @@ void dump_core(void)
 }
 
 /*
+ * Use CLOEXEC flag for open(), pipe(), fopen() (read-only case) and
+ * socket() if possible.
+ */
+static int cloexec_works = 0;
+
+static void check_cloexec(int fd)
+{
+	if (cloexec_works == 0) {
+		int fl = fcntl(fd, F_GETFD);
+		if (fl != -1)
+			cloexec_works = (fl & FD_CLOEXEC) ? 1 : -1;
+	}
+	if (cloexec_works > 0)
+		return;
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
+	return;
+}
+
+int open_fd(const char *path, int flags)
+{
+	int fd;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
+	if (cloexec_works != -1)
+		flags |= O_CLOEXEC;
+#endif
+	fd = open(path, flags);
+	if (fd == -1)
+		return -1;
+	check_cloexec(fd);
+	return fd;
+}
+
+int open_fd_mode(const char *path, int flags, int mode)
+{
+	int fd;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
+	if (cloexec_works != -1)
+		flags |= O_CLOEXEC;
+#endif
+	fd = open(path, flags, mode);
+	if (fd == -1)
+		return -1;
+	check_cloexec(fd);
+	return fd;
+}
+
+int open_pipe(int pipefd[2])
+{
+	int ret;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC) && defined(HAVE_PIPE2)
+	if (cloexec_works != -1) {
+		ret = pipe2(pipefd, O_CLOEXEC);
+		if (ret != -1)
+			return 0;
+		if (errno != EINVAL)
+			return -1;
+	}
+#endif
+	ret = pipe(pipefd);
+	if (ret == -1)
+		return -1;
+	check_cloexec(pipefd[0]);
+	check_cloexec(pipefd[1]);
+	return 0;
+}
+
+int open_sock(int domain, int type, int protocol)
+{
+	int fd;
+
+#ifdef SOCK_CLOEXEC
+	if (cloexec_works != -1)
+		type |= SOCK_CLOEXEC;
+#endif
+	fd = socket(domain, type, protocol);
+	if (fd == -1)
+		return -1;
+	check_cloexec(fd);
+	return fd;
+}
+
+FILE *open_fopen_r(const char *path)
+{
+	FILE *f;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
+	if (cloexec_works != -1) {
+		f = fopen(path, "re");
+		if (f != NULL) {
+			check_cloexec(fileno(f));
+			return f;
+		}
+	}
+#endif
+	f = fopen(path, "r");
+	if (f == NULL)
+		return NULL;
+	check_cloexec(fileno(f));
+	return f;
+}
+
+FILE *open_setmntent_r(const char *table)
+{
+	FILE *tab;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
+	if (cloexec_works != -1) {
+		tab = setmntent(table, "re");
+		if (tab != NULL) {
+			check_cloexec(fileno(tab));
+			return tab;
+		}
+	}
+#endif
+	tab = fopen(table, "r");
+	if (tab == NULL)
+		return NULL;
+	check_cloexec(fileno(tab));
+	return tab;
+}
+
+/*
  * Used by subprocesses which exec to avoid carrying over the main
  * daemon's signalling environment
  */
diff --git a/include/automount.h b/include/automount.h
index 8d3a3d72..c461a309 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -8,6 +8,7 @@
 #ifndef AUTOMOUNT_H
 #define AUTOMOUNT_H
 
+#include <stdio.h>
 #include <paths.h>
 #include <limits.h>
 #include <time.h>
@@ -256,6 +257,12 @@ int spawnv(unsigned logopt, const char *prog, const char *const *argv);
 int spawn_mount(unsigned logopt, ...);
 int spawn_bind_mount(unsigned logopt, ...);
 int spawn_umount(unsigned logopt, ...);
+int open_fd(const char *, int);
+int open_fd_mode(const char *, int, int);
+int open_pipe(int[2]);
+int open_sock(int, int, int);
+FILE *open_fopen_r(const char *);
+FILE *open_setmntent_r(const char *);
 void reset_signals(void);
 int do_mount(struct autofs_point *ap, const char *root, const char *name,
 	     int name_len, const char *what, const char *fstype,
@@ -632,130 +639,5 @@ int alarm_start_handler(void);
 int alarm_add(struct autofs_point *ap, time_t seconds);
 void alarm_delete(struct autofs_point *ap);
 
-/*
- * Use CLOEXEC flag for open(), pipe(), fopen() (read-only case) and
- * socket() if possible.
- */
-static int cloexec_works;
-
-static inline void check_cloexec(int fd)
-{
-	if (cloexec_works == 0) {
-		int fl = fcntl(fd, F_GETFD);
-		if (fl != -1)
-			cloexec_works = (fl & FD_CLOEXEC) ? 1 : -1;
-	}
-	if (cloexec_works > 0)
-		return;
-	fcntl(fd, F_SETFD, FD_CLOEXEC);
-	return;
-}
-
-static inline int open_fd(const char *path, int flags)
-{
-	int fd;
-
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
-	if (cloexec_works != -1)
-		flags |= O_CLOEXEC;
-#endif
-	fd = open(path, flags);
-	if (fd == -1)
-		return -1;
-	check_cloexec(fd);
-	return fd;
-}
-
-static inline int open_fd_mode(const char *path, int flags, int mode)
-{
-	int fd;
-
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
-	if (cloexec_works != -1)
-		flags |= O_CLOEXEC;
-#endif
-	fd = open(path, flags, mode);
-	if (fd == -1)
-		return -1;
-	check_cloexec(fd);
-	return fd;
-}
-
-static inline int open_pipe(int pipefd[2])
-{
-	int ret;
-
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC) && defined(HAVE_PIPE2)
-	if (cloexec_works != -1) {
-		ret = pipe2(pipefd, O_CLOEXEC);
-		if (ret != -1)
-			return 0;
-		if (errno != EINVAL)
-			return -1;
-	}
-#endif
-	ret = pipe(pipefd);
-	if (ret == -1)
-		return -1;
-	check_cloexec(pipefd[0]);
-	check_cloexec(pipefd[1]);
-	return 0;
-}
-
-static inline int open_sock(int domain, int type, int protocol)
-{
-	int fd;
-
-#ifdef SOCK_CLOEXEC
-	if (cloexec_works != -1)
-		type |= SOCK_CLOEXEC;
-#endif
-	fd = socket(domain, type, protocol);
-	if (fd == -1)
-		return -1;
-	check_cloexec(fd);
-	return fd;
-}
-
-static inline FILE *open_fopen_r(const char *path)
-{
-	FILE *f;
-
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
-	if (cloexec_works != -1) {
-		f = fopen(path, "re");
-		if (f != NULL) {
-			check_cloexec(fileno(f));
-			return f;
-		}
-	}
-#endif
-	f = fopen(path, "r");
-	if (f == NULL)
-		return NULL;
-	check_cloexec(fileno(f));
-	return f;
-}
-
-static inline FILE *open_setmntent_r(const char *table)
-{
-	FILE *tab;
-
-#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
-	if (cloexec_works != -1) {
-		tab = setmntent(table, "re");
-		if (tab != NULL) {
-			check_cloexec(fileno(tab));
-			return tab;
-		}
-	}
-#endif
-	tab = fopen(table, "r");
-	if (tab == NULL)
-		return NULL;
-	check_cloexec(fileno(tab));
-	return tab;
-}
-
 #endif
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
