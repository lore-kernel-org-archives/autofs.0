From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 3/5] logging to stderr
Date: Fri, 11 Feb 2005 12:03:58 +0200
Message-ID: <200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_OMIDCvKXGPCRfRt"
In-Reply-To: <200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
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
To: autofs@linux.kernel.org


--Boundary-00=_OMIDCvKXGPCRfRt
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add code, but do not switch rest of program to use it, yet.
--
vda

--Boundary-00=_OMIDCvKXGPCRfRt
Content-Type: text/x-diff;
  charset="koi8-r";
  name="414b1.23.stderr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="414b1.23.stderr.patch"

diff -urpN autofs-4.1.4_beta1_2/daemon/automount.c autofs-4.1.4_beta1_3/daemon/automount.c
--- autofs-4.1.4_beta1_2/daemon/automount.c	Fri Feb 11 10:49:55 2005
+++ autofs-4.1.4_beta1_3/daemon/automount.c	Fri Feb 11 10:49:57 2005
@@ -62,6 +62,8 @@ int do_verbose = 0;		/* Verbose feedback
 int do_debug = 0;		/* Enable full debug output */
 int daemonize = 1;		/* Shall we daemonize? */
 
+int log_stderr;			/* Use stderr instead of syslog? */
+
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
 sigset_t sigchld_mask;
@@ -1277,7 +1279,6 @@ static void become_daemon(void)
 {
 	FILE *pidfp;
 	pid_t pid;
-	int nullfd;
 
 	/* Don't BUSY any directories unnecessarily */
 	chdir("/");
@@ -1294,8 +1295,12 @@ static void become_daemon(void)
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
@@ -1311,19 +1316,6 @@ static void become_daemon(void)
 	}
 	my_pgrp = getpgrp();
 
-	/* Redirect all our file descriptors to /dev/null */
-	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
-		crit("cannot open /dev/null: %m");
-		exit(1);
-	}
-
-	if (dup2(nullfd, STDIN_FILENO) < 0 ||
-	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
-		crit("redirecting file descriptors failed: %m");
-		exit(1);
-	}
-	if (nullfd > 2) close(nullfd);
-
 	/* Write pid file if requested */
 	if (pid_file) {
 		if ((pidfp = fopen(pid_file, "wt"))) {
@@ -1380,6 +1372,7 @@ static void usage(void)
 		"	-p --pid-file f	write process id to file f\n"
 		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
 		"	-f --foreground	do not daemonize\n"
+		"	-s --stderr	log to stderr instead of syslog\n"
 		"	-v --verbose	be verbose\n"
 		"	-d --debug	be even more verbose\n"
 		"	-V --version	print version and exit\n"
@@ -1674,6 +1667,7 @@ int main(int argc, char *argv[])
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
 		{"foreground", 0, 0, 'f'},
+		{"stderr", 0, 0, 's'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1691,7 +1685,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fsvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1707,6 +1701,10 @@ int main(int argc, char *argv[])
 
 		case 'f':
 			daemonize = 0;
+			break;
+
+		case 's':
+			log_stderr = 1;
 			break;
 
 		case 'v':
diff -urpN autofs-4.1.4_beta1_2/include/automount.h autofs-4.1.4_beta1_3/include/automount.h
--- autofs-4.1.4_beta1_2/include/automount.h	Wed Jan 26 15:03:02 2005
+++ autofs-4.1.4_beta1_3/include/automount.h	Fri Feb 11 11:42:54 2005
@@ -286,21 +286,16 @@ int allow_owner_mount(const char *);
 extern int do_verbose;
 extern int do_debug;
 
-#define info(msg, args...) 		\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_INFO, msg, ##args);
+extern void (*info)(const char* msg, ...);
+extern void (*notice)(const char* msg, ...);
+extern void (*warn)(const char* msg, ...);
+extern void (*error)(const char* msg, ...);
+extern void (*crit)(const char* msg, ...);
+extern void (*debug)(const char* msg, ...);
 
-#define warn(msg, args...) 			\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_WARNING, msg, ##args);
+void log_to_syslog();
+void log_to_stderr();
 
-#define error(msg, args...)	syslog(LOG_ERR, msg, ##args);
-
-#define crit(msg, args...)	syslog(LOG_CRIT, msg, ##args);
-
-#define debug(msg, args...) 		\
-if (do_debug) 				\
-	syslog(LOG_DEBUG, msg, ##args);
 
 #endif
 
diff -urpN autofs-4.1.4_beta1_2/lib/Makefile autofs-4.1.4_beta1_3/lib/Makefile
--- autofs-4.1.4_beta1_2/lib/Makefile	Sun Jan  9 11:16:43 2005
+++ autofs-4.1.4_beta1_3/lib/Makefile	Fri Feb 11 10:49:57 2005
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
 
diff -urpN autofs-4.1.4_beta1_2/lib/log.c autofs-4.1.4_beta1_3/lib/log.c
--- autofs-4.1.4_beta1_2/lib/log.c	Thu Jan  1 03:00:00 1970
+++ autofs-4.1.4_beta1_3/lib/log.c	Fri Feb 11 10:49:57 2005
@@ -0,0 +1,103 @@
+#include <stdarg.h>
+#include <stdio.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <fcntl.h>	/* open() */
+#include <stdlib.h>	/* exit() */
+
+#include "automount.h"
+
+static void null(const char *msg, ...)
+{
+}
+
+static void syslog_debug(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_DEBUG, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_info(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_INFO, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_warn(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_WARNING, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_err(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_ERR, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_crit(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_CRIT, msg, ap);
+	va_end(ap);
+}
+
+static void to_stderr(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
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
+		warn = syslog_warn;
+	}
+	error = syslog_err;
+	crit = syslog_crit;
+
+	/* Redirect all our file descriptors to /dev/null */
+	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
+		crit("cannot open /dev/null: %m");
+		exit(1);
+	}
+	if (dup2(nullfd, STDIN_FILENO) < 0 ||
+	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
+		crit("redirecting file descriptors failed: %m");
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
+		warn = to_stderr;
+	}
+	error = to_stderr;
+	crit = to_stderr;
+}
+
+void (*info)(const char* msg, ...) = null;
+void (*warn)(const char* msg, ...) = null;
+void (*error)(const char* msg, ...) = null;
+void (*crit)(const char* msg, ...) = null;
+void (*debug)(const char* msg, ...) = null;

--Boundary-00=_OMIDCvKXGPCRfRt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_OMIDCvKXGPCRfRt--

