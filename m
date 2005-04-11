From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] semi-trivial patches
Date: Mon, 11 Apr 2005 15:26:23 +0300
Message-ID: <200504111526.23279.vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net> <200504111101.13933.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0504111704160.18235@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vzmWCcKAV1UrfCv"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504111704160.18235@wombat.indigo.net.au>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


--Boundary-00=_vzmWCcKAV1UrfCv
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 11 April 2005 12:14, Ian Kent wrote:
> I remember applying several of your patches to do with this some time ago.
> On my development machine (an Ultra 2), the autofs daemon failed 
> completely when trying to log. I mailed you asking about it but received 
> no answer.

I decided to return to it on next non-beta. This is what I've found:

Crash was caused by me erroneously using syslog() instead of vsyslog().
(I didn't test logging to syslog back then, and bug slipped through).

> Are you able to help merging them when I get to it?

Sure.

Also please find attached patches which implement
running in foreground and stderr logging.

Both logging to syslog and to stderr work for me now.
--
vda

--Boundary-00=_vzmWCcKAV1UrfCv
Content-Type: text/x-diff;
  charset="koi8-r";
  name="e.fg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="e.fg.patch"

diff -urpN autofs-4.1.4.d.close/daemon/automount.c autofs-4.1.4.e.foreground/daemon/automount.c
--- autofs-4.1.4.d.close/daemon/automount.c	Mon Apr 11 10:42:20 2005
+++ autofs-4.1.4.e.foreground/daemon/automount.c	Mon Apr 11 11:07:56 2005
@@ -60,6 +60,7 @@ static int submount = 0;
 
 int do_verbose = 0;		/* Verbose feedback option */
 int do_debug = 0;		/* Enable full debug output */
+int daemonize = 1;		/* Shall we daemonize? */
 
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
@@ -1282,7 +1283,7 @@ static void become_daemon(void)
 	chdir("/");
 
 	/* Detach from foreground process */
-	if (!submount) {
+	if (!submount && daemonize) {
 		pid = fork();
 		if (pid > 0)
 			exit(0);
@@ -1382,7 +1383,19 @@ static unsigned long getnumopt(char *str
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
+	fprintf(stderr,
+		"Usage: %s [options] path map_type [args...]\n"
+		"	-h --help	this text\n"
+		"	-p --pid-file f	write process id to file f\n"
+		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
+		"	-f --foreground	do not daemonize\n"
+		"	-v --verbose	be verbose\n"
+		"	-d --debug	be even more verbose\n"
+		"	-V --version	print version and exit\n"
+		/* "	-g --ghost	\n" */
+		/* "	--submount	\n" */
+		, program
+	);
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1669,6 +1682,7 @@ int main(int argc, char *argv[])
 		{"help", 0, 0, 'h'},
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
+		{"foreground", 0, 0, 'f'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1686,7 +1700,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1698,6 +1712,10 @@ int main(int argc, char *argv[])
 
 		case 't':
 			ap.exp_timeout = getnumopt(optarg, opt);
+			break;
+
+		case 'f':
+			daemonize = 0;
 			break;
 
 		case 'v':

--Boundary-00=_vzmWCcKAV1UrfCv
Content-Type: text/x-diff;
  charset="koi8-r";
  name="f.stderr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="f.stderr.patch"

diff -urpN autofs-4.1.4.e.foreground/daemon/automount.c autofs-4.1.4.f.stderr/daemon/automount.c
--- autofs-4.1.4.e.foreground/daemon/automount.c	Mon Apr 11 11:07:56 2005
+++ autofs-4.1.4.f.stderr/daemon/automount.c	Mon Apr 11 14:39:45 2005
@@ -39,7 +39,7 @@
 #include <linux/auto_fs4.h>
 
 #ifndef NDEBUG
-#define assert(x)	do { if (!(x)) { syslog(LOG_CRIT, __FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
+#define assert(x)	do { if (!(x)) { crit(__FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
 #else
 #define assert(x)	do { } while(0)
 #endif
@@ -61,6 +61,7 @@ static int submount = 0;
 int do_verbose = 0;		/* Verbose feedback option */
 int do_debug = 0;		/* Enable full debug output */
 int daemonize = 1;		/* Shall we daemonize? */
+int log_stderr = 0;		/* Use stderr instead of syslog? */
 
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
@@ -160,7 +161,7 @@ static int umount_ent(const char *root, 
 			umount_ok = 1;
 
 		if (umount_ok || is_smbfs) {
-			rv = spawnll(LOG_DEBUG, 
+			rv = spawnll(debug,
 				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
 		}
 	}
@@ -314,13 +315,13 @@ static int do_umount_autofs(void)
 		struct stat st;
 		int ret;
 
-		rv = spawnll(LOG_DEBUG,
+		rv = spawnll(debug,
 			    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		if (rv & MTAB_NOTUPDATED) {
 			info("umount %s succeeded: "
 			     "mtab not updated, retrying to clean",
 			      ap.path);
-			rv = spawnll(LOG_DEBUG,
+			rv = spawnll(debug,
 				    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		}
 		ret = stat(ap.path, &st);
@@ -450,7 +451,7 @@ static int mount_autofs(char *path)
         }
 	our_name[len] = '\0';
 
-	if (spawnll(LOG_DEBUG, PATH_MOUNT, PATH_MOUNT,
+	if (spawnll(debug, PATH_MOUNT, PATH_MOUNT,
 		   "-t", "autofs", "-o", options, our_name, path, NULL) != 0) {
 		crit("failed to mount autofs path %s", ap.path);
 		rmdir_path(ap.path);
@@ -1020,7 +1021,7 @@ static int handle_packet_missing(const s
 	pid_t f;
 	struct pending_mount *mt = NULL;
 
-	debug("handle_packet_missing: token %ld, name %s\n",
+	debug("handle_packet_missing: token %ld, name %s",
 		(unsigned long) pkt->wait_queue_token, pkt->name);
 
 	/* Ignore packet if we're trying to shut down */
@@ -1240,7 +1241,7 @@ static int handle_packet_expire_multi(co
 {
 	int ret;
 
-	debug("handle_packet_expire_multi: token %ld, name %s\n",
+	debug("handle_packet_expire_multi: token %ld, name %s",
 		  (unsigned long) pkt->wait_queue_token, pkt->name);
 
 	ret = handle_expire(pkt->name, pkt->len, pkt->wait_queue_token);
@@ -1277,7 +1278,6 @@ static void become_daemon(void)
 {
 	FILE *pidfp;
 	pid_t pid;
-	int nullfd;
 
 	/* Don't BUSY any directories unnecessarily */
 	chdir("/");
@@ -1294,8 +1294,12 @@ static void become_daemon(void)
 		}
 	}
 
-	/* Open syslog */
-	openlog("automount", LOG_PID, LOG_DAEMON);
+	/* Initialize logging subsystem */
+	if(!log_stderr) {
+		log_to_syslog();
+	} else {
+		log_to_stderr();
+	}
 
 	/* Initialize global data */
 	my_pid = getpid();
@@ -1317,20 +1321,6 @@ static void become_daemon(void)
 	}
 	my_pgrp = getpgrp();
 
-	/* Redirect all our file descriptors to /dev/null */
-	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
-		crit("cannot open /dev/null: %s", strerror(errno));
-		exit(1);
-	}
-
-	if (dup2(nullfd, STDIN_FILENO) < 0
-	 || dup2(nullfd, STDOUT_FILENO) < 0
-	 || dup2(nullfd, STDERR_FILENO) < 0) {
-		crit("redirecting file descriptors failed: %s", strerror(errno));
-		exit(1);
-	}
-	if (nullfd > 2) close(nullfd);
-
 	/* Write pid file if requested */
 	if (pid_file) {
 		if ((pidfp = fopen(pid_file, "wt"))) {
@@ -1389,6 +1379,7 @@ static void usage(void)
 		"	-p --pid-file f	write process id to file f\n"
 		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
 		"	-f --foreground	do not daemonize\n"
+		"	-s --stderr	log to stderr instead of syslog\n"
 		"	-v --verbose	be verbose\n"
 		"	-d --debug	be even more verbose\n"
 		"	-V --version	print version and exit\n"
@@ -1683,6 +1674,7 @@ int main(int argc, char *argv[])
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
 		{"foreground", 0, 0, 'f'},
+		{"stderr", 0, 0, 's'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1700,7 +1692,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fsvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1718,6 +1710,10 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 
+		case 's':
+			log_stderr = 1;
+			break;
+
 		case 'v':
 			do_verbose = 1;
 			break;
@@ -1769,9 +1765,9 @@ int main(int argc, char *argv[])
 #ifdef DEBUG
 	if (mapargc) {
 		int i;
-		syslog(LOG_DEBUG, "Map argc = %d", mapargc);
+		debug("Map argc = %d", mapargc);
 		for (i = 0; i < mapargc; i++)
-			syslog(LOG_DEBUG, "Map argv[%d] = %s", i, mapargv[i]);
+			debug("Map argv[%d] = %s", i, mapargv[i]);
 	}
 #endif
 
diff -urpN autofs-4.1.4.e.foreground/daemon/spawn.c autofs-4.1.4.f.stderr/daemon/spawn.c
--- autofs-4.1.4.e.foreground/daemon/spawn.c	Mon Apr 11 10:20:27 2005
+++ autofs-4.1.4.f.stderr/daemon/spawn.c	Mon Apr 11 11:18:51 2005
@@ -199,7 +199,7 @@ out:
 
 #define ERRBUFSIZ 2047		/* Max length of error string excl \0 */
 
-static int do_spawn(int logpri, int use_lock, const char *prog, const char *const *argv)
+static int do_spawn(logger* log, int use_lock, const char *prog, const char *const *argv)
 {
 	pid_t f;
 	int status, pipefd[2];
@@ -260,7 +260,7 @@ static int do_spawn(int logpri, int use_
 				while (errp && (p = memchr(sp, '\n', errp))) {
 					*p++ = '\0';
 					if (sp[0])	/* Don't output empty lines */
-						syslog(logpri, ">> %s", sp);
+						log(">> %s", sp);
 					errp -= (p - sp);
 					sp = p;
 				}
@@ -271,7 +271,7 @@ static int do_spawn(int logpri, int use_
 				if (errp >= ERRBUFSIZ) {
 					/* Line too long, split */
 					errbuf[errp] = '\0';
-					syslog(logpri, ">> %s", errbuf);
+					log(">> %s", errbuf);
 					errp = 0;
 				}
 			}
@@ -281,7 +281,7 @@ static int do_spawn(int logpri, int use_
 		if (errp > 0) {
 			/* End of file without \n */
 			errbuf[errp] = '\0';
-			syslog(logpri, ">> %s", errbuf);
+			log(">> %s", errbuf);
 		}
 
 		if (waitpid(f, &status, 0) != f)
@@ -296,12 +296,12 @@ static int do_spawn(int logpri, int use_
 	}
 }
 
-int spawnv(int logpri, const char *prog, const char *const *argv)
+int spawnv(logger* log, const char *prog, const char *const *argv)
 {
-	return do_spawn(logpri, 0, prog, argv);
+	return do_spawn(log, 0, prog, argv);
 }
 
-int spawnl(int logpri, const char *prog, ...)
+int spawnl(logger* log, const char *prog, ...)
 {
 	va_list arg;
 	int argc;
@@ -319,10 +319,10 @@ int spawnl(int logpri, const char *prog,
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(logpri, 0, prog, (const char **) argv);
+	return do_spawn(log, 0, prog, (const char **) argv);
 }
 
-int spawnll(int logpri, const char *prog, ...)
+int spawnll(logger* log, const char *prog, ...)
 {
 	va_list arg;
 	int argc;
@@ -340,5 +340,5 @@ int spawnll(int logpri, const char *prog
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(logpri, 1, prog, (const char **) argv);
+	return do_spawn(log, 1, prog, (const char **) argv);
 }
diff -urpN autofs-4.1.4.e.foreground/include/automount.h autofs-4.1.4.f.stderr/include/automount.h
--- autofs-4.1.4.e.foreground/include/automount.h	Wed Jan 26 15:03:02 2005
+++ autofs-4.1.4.f.stderr/include/automount.h	Mon Apr 11 11:18:51 2005
@@ -117,13 +117,29 @@ struct autofs_point {
 
 extern struct autofs_point ap; 
 
+/* log notification */
+extern int do_verbose;
+extern int do_debug;
+
+extern void (*info)(const char* msg, ...);
+extern void (*notice)(const char* msg, ...);
+extern void (*warn)(const char* msg, ...);
+extern void (*error)(const char* msg, ...);
+extern void (*crit)(const char* msg, ...);
+extern void (*debug)(const char* msg, ...);
+
+typedef void logger(const char* msg, ...);
+
+void log_to_syslog();
+void log_to_stderr();
+
 /* Standard function used by daemon or modules */
 
 int aquire_lock(void);
 void release_lock(void);
-int spawnll(int logpri, const char *prog, ...);
-int spawnl(int logpri, const char *prog, ...);
-int spawnv(int logpri, const char *prog, const char *const *argv);
+int spawnll(logger* log, const char *prog, ...);
+int spawnl(logger* log, const char *prog, ...);
+int spawnv(logger* log, const char *prog, const char *const *argv);
 void reset_signals(void);
 void ignore_signals(void);
 void discard_pending(int sig);
@@ -282,25 +298,4 @@ int is_mounted(const char *table, const 
 int has_fstab_option(const char *path, const char *opt);
 int allow_owner_mount(const char *);
 
-/* log notification */
-extern int do_verbose;
-extern int do_debug;
-
-#define info(msg, args...) 		\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_INFO, msg, ##args);
-
-#define warn(msg, args...) 			\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_WARNING, msg, ##args);
-
-#define error(msg, args...)	syslog(LOG_ERR, msg, ##args);
-
-#define crit(msg, args...)	syslog(LOG_CRIT, msg, ##args);
-
-#define debug(msg, args...) 		\
-if (do_debug) 				\
-	syslog(LOG_DEBUG, msg, ##args);
-
 #endif
-
diff -urpN autofs-4.1.4.e.foreground/lib/Makefile autofs-4.1.4.f.stderr/lib/Makefile
--- autofs-4.1.4.e.foreground/lib/Makefile	Sun Jan  9 11:16:43 2005
+++ autofs-4.1.4.f.stderr/lib/Makefile	Mon Apr 11 11:18:40 2005
@@ -12,7 +12,7 @@ RANLIB = /usr/bin/ranlib
 SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c
 RPCS = mount.h mount_clnt.c mount_xdr.c
 OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o \
-	cat_path.o rpc_subs.o mounts.o lock.o
+	cat_path.o rpc_subs.o mounts.o lock.o log.o
 
 LIB = autofs.a
 
@@ -47,6 +47,10 @@ mount_xdr.o: mount_xdr.c
 listmount.o: listmount.c
 	$(CC) $(CFLAGS) -o listmount.o -c listmount.c
 	$(STRIP) listmount.o
+
+log.o: log.c
+	$(CC) $(CFLAGS) -o log.o -c log.c
+	$(STRIP) log.o
 
 install: all
 
diff -urpN autofs-4.1.4.e.foreground/lib/log.c autofs-4.1.4.f.stderr/lib/log.c
--- autofs-4.1.4.e.foreground/lib/log.c	Thu Jan  1 03:00:00 1970
+++ autofs-4.1.4.f.stderr/lib/log.c	Mon Apr 11 14:45:00 2005
@@ -0,0 +1,119 @@
+#include <stdarg.h>
+#include <stdio.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <fcntl.h>	/* open() */
+#include <stdlib.h>	/* exit() */
+#include <string.h>	/* strerror() */
+#include <errno.h>
+
+#include "automount.h"
+
+static void null(const char *msg, ...)
+{
+}
+
+void (*info)(const char* msg, ...) = null;
+void (*notice)(const char* msg, ...) = null;
+void (*warn)(const char* msg, ...) = null;
+void (*error)(const char* msg, ...) = null;
+void (*crit)(const char* msg, ...) = null;
+void (*debug)(const char* msg, ...) = null;
+
+static void syslog_debug(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_DEBUG, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_info(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_INFO, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_notice(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_NOTICE, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_warn(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_WARNING, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_err(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_ERR, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_crit(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vsyslog(LOG_CRIT, msg, ap);
+	va_end(ap);
+}
+
+static void to_stderr(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
+	fputc('\n',stderr);
+	va_end(ap);
+}
+
+void log_to_syslog()
+{
+	int nullfd;
+
+	openlog("automount", LOG_PID, LOG_DAEMON);
+	if (do_debug) debug = syslog_debug;
+	if (do_verbose || do_debug) {
+		info = syslog_info;
+		notice = syslog_notice;
+		warn = syslog_warn;
+	}
+	error = syslog_err;
+	crit = syslog_crit;
+
+	/* Redirect all our file descriptors to /dev/null */
+	nullfd = open("/dev/null", O_RDWR);
+	if (nullfd < 0) {
+		crit("cannot open /dev/null: %s", strerror(errno));
+		exit(1);
+	}
+	if (dup2(nullfd, STDIN_FILENO) < 0
+	 || dup2(nullfd, STDOUT_FILENO) < 0
+	 || dup2(nullfd, STDERR_FILENO) < 0) {
+		crit("redirecting file descriptors failed: %s", strerror(errno));
+		exit(1);
+	}
+	if (nullfd > 2) close(nullfd);
+}
+
+void log_to_stderr()
+{
+	if (do_debug) debug = to_stderr;
+	if (do_verbose || do_debug) {
+		info = to_stderr;
+		notice = to_stderr;
+		warn = to_stderr;
+	}
+	error = to_stderr;
+	crit = to_stderr;
+}
diff -urpN autofs-4.1.4.e.foreground/modules/mount_bind.c autofs-4.1.4.f.stderr/modules/mount_bind.c
--- autofs-4.1.4.e.foreground/modules/mount_bind.c	Mon Apr 11 10:46:24 2005
+++ autofs-4.1.4.f.stderr/modules/mount_bind.c	Mon Apr 11 11:18:51 2005
@@ -59,7 +59,7 @@ int mount_init(void **context)
 	if (lstat(tmp1, &st1) == -1)
 		goto out;
 
-	err = spawnl(LOG_DEBUG,
+	err = spawnl(debug,
 	    	     PATH_MOUNT, PATH_MOUNT, "-n", "--bind", tmp1, tmp2, NULL);
 
 	if (err == 0 &&
@@ -69,7 +69,7 @@ int mount_init(void **context)
 	}
 
 	debug(MODPREFIX "bind_works = %d", bind_works);
-	spawnl(LOG_DEBUG,
+	spawnl(debug,
 	       PATH_UMOUNT, PATH_UMOUNT, "-n", tmp2, NULL);
 
       out:
@@ -132,7 +132,7 @@ int mount_mount(const char *root, const 
 		      "calling mount --bind " SLOPPY " -o %s %s %s",
 		      options, what, fullpath);
 
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "--bind",
 			     SLOPPYOPT "-o", options,
 			     what, fullpath, NULL);
diff -urpN autofs-4.1.4.e.foreground/modules/mount_changer.c autofs-4.1.4.f.stderr/modules/mount_changer.c
--- autofs-4.1.4.e.foreground/modules/mount_changer.c	Mon Apr 11 10:29:18 2005
+++ autofs-4.1.4.f.stderr/modules/mount_changer.c	Mon Apr 11 11:18:51 2005
@@ -68,7 +68,7 @@ int mount_mount(const char *root, const 
 
 	debug(MODPREFIX "calling umount %s", what);
 
-	err = spawnll(LOG_DEBUG,
+	err = spawnll(debug,
 		     PATH_UMOUNT, PATH_UMOUNT, what, NULL);
 	if (err) {
 		error(MODPREFIX "umount of %s failed (all may be unmounted)",
@@ -99,14 +99,14 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		    fstype, options, what, fullpath);
 
-		err = spawnll(LOG_DEBUG,
+		err = spawnll(debug,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 			  fstype, what, fullpath);
 
-		err = spawnll(LOG_DEBUG, PATH_MOUNT, PATH_MOUNT,
+		err = spawnll(debug, PATH_MOUNT, PATH_MOUNT,
 			     "-t", fstype, what, fullpath, NULL);
 	}
 
diff -urpN autofs-4.1.4.e.foreground/modules/mount_ext2.c autofs-4.1.4.f.stderr/modules/mount_ext2.c
--- autofs-4.1.4.e.foreground/modules/mount_ext2.c	Mon Apr 11 10:29:18 2005
+++ autofs-4.1.4.f.stderr/modules/mount_ext2.c	Mon Apr 11 11:18:51 2005
@@ -94,10 +94,10 @@ int mount_mount(const char *root, const 
 #endif
 	if (ro) {
 		debug(MODPREFIX "calling %s -n %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-n", what, NULL);
+		err = spawnl(debug, fsck_prog, fsck_prog, "-n", what, NULL);
 	} else {
 		debug(MODPREFIX "calling %s -p %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-p", what, NULL);
+		err = spawnl(debug, fsck_prog, fsck_prog, "-p", what, NULL);
 	}
 
 	if (err & ~6) {
@@ -109,13 +109,13 @@ int mount_mount(const char *root, const 
 	if (options) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 		             PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.4.e.foreground/modules/mount_generic.c autofs-4.1.4.f.stderr/modules/mount_generic.c
--- autofs-4.1.4.e.foreground/modules/mount_generic.c	Mon Apr 11 10:29:18 2005
+++ autofs-4.1.4.f.stderr/modules/mount_generic.c	Mon Apr 11 11:18:51 2005
@@ -78,13 +78,13 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
 
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.4.e.foreground/modules/mount_nfs.c autofs-4.1.4.f.stderr/modules/mount_nfs.c
--- autofs-4.1.4.e.foreground/modules/mount_nfs.c	Mon Apr 11 10:29:18 2005
+++ autofs-4.1.4.f.stderr/modules/mount_nfs.c	Mon Apr 11 11:18:51 2005
@@ -451,14 +451,14 @@ int mount_mount(const char *root, const 
 			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
 			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
 
-			err = spawnll(LOG_NOTICE,
+			err = spawnll(notice,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", SLOPPYOPT "-o", nfsoptions,
 				     whatstr, fullpath, NULL);
 		} else {
 			debug(MODPREFIX "calling mount -t nfs %s %s",
 			      whatstr, fullpath);
-			err = spawnll(LOG_NOTICE,
+			err = spawnll(notice,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", whatstr, fullpath, NULL);
 		}

--Boundary-00=_vzmWCcKAV1UrfCv--

