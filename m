From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] return a proper exit status at startup
Date: Wed, 01 Nov 2006 18:39:29 -0500
Message-ID: <x49fyd268jy.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

I posted this once before, I think.  Basically, it would be nice if the
autofs init script reported a failure if the daemon was unable to start.
As it stands, it may return success (since become_daemon is run pretty
early) before the daemon is ready to service mount requests.  If there are
other services that require the automounter for operations, then we should
not return a status to the init script until we can successfully service
requests.  This patch addresses both of these problems by opening a status
pipe that is used to communicate success or failure conditions at startup.

This code has been working in RHEL for some time now.  Any review is, of
course, encouraged.

Thanks!

-Jeff

diff --git a/daemon/automount.c b/daemon/automount.c
index 8d73d31..348b499 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -30,6 +30,7 @@ #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <stdarg.h>
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -72,6 +73,13 @@ static pid_t my_pgrp;		/* The "magic" pr
 static pid_t my_pid;		/* The pid of this process */
 static char *pid_file = NULL;	/* File in which to keep pid */
 
+#define DAEMON_STATUS_MSG_SZ 80
+static int daemon_status_fd = -1; /* FD for sending daemon status to parent */
+struct daemon_status_msg {
+	int code; /* status code, either 0 (Success) or -1 (Failure) */
+	int len;  /* Length of the textual error message */
+};
+
 int kproto_version;		/* Kernel protocol version used */
 int kproto_sub_version = 0;	/* Kernel protocol version used */
 
@@ -1325,25 +1333,100 @@ static int handle_packet(void)
 	return -1;
 }
 
+/*
+ *  Read the daemon status message from the child.  This function returns
+ *  0 if the child is successfully started, or the exit code of the
+ *  child, otherwise.
+ */
+static int read_daemon_status(int rfd)
+{
+	ssize_t nread;
+	struct daemon_status_msg msg;
+	char buf[DAEMON_STATUS_MSG_SZ];
+
+	while ((nread = read(rfd, &msg, sizeof(msg))) < 0)
+		if (errno == EINTR)
+			continue;
+
+	if (nread <= 0)
+		return 1;
+	if (msg.code == 0)
+		return 0;
+
+	while ((nread = read(rfd, buf, msg.len)) < 0)
+		if (errno == EINTR)
+			continue;
+
+	if (nread <= 0)
+		return msg.code;
+
+	buf[msg.len] = '\0';
+	fprintf(stderr, "%s\n", buf);
+	return msg.code;
+}
+
+/*
+ *  Function called to tell the parent process the exit status of the
+ *  child condition.  This is done primarily so that the parent does not
+ *  return to the caller before the automount daemon is ready to process
+ *  requests.  We get the added advantage of seeing an error message on
+ *  the console for the cases where the daemon fails to initialize.
+ */
+static void daemon_status(int code, const char *fmt, ...)
+{
+	va_list ap;
+	struct daemon_status_msg msg;
+	char buf[DAEMON_STATUS_MSG_SZ];
+	int ret = 0;
+
+	if (submount || daemon_status_fd < 0)
+		return;
+
+	msg.code = code;
+	if (code) {
+		va_start(ap, fmt);
+		ret = vsnprintf(buf, DAEMON_STATUS_MSG_SZ, fmt, ap);
+		va_end(ap);
+		if (ret >= DAEMON_STATUS_MSG_SZ)
+			ret = DAEMON_STATUS_MSG_SZ - 1;
+	}
+	msg.len = ret;
+
+	write(daemon_status_fd, &msg, sizeof(msg));
+	if (msg.len)
+		write(daemon_status_fd, buf, msg.len);
+
+	daemon_status_fd = -1;
+}
+
 static void become_daemon(void)
 {
 	FILE *pidfp;
 	pid_t pid;
 	int nullfd;
+	int pfds[2];
 
 	/* Don't BUSY any directories unnecessarily */
 	chdir("/");
 
 	/* Detach from foreground process */
 	if (!submount) {
+		if (pipe(pfds) < 0) {
+			fprintf(stderr, "%s: pipe failed: %s\n", program,
+				strerror(errno));
+			exit(1);
+		}
 		pid = fork();
-		if (pid > 0)
-			exit(0);
-		else if (pid < 0) {
+		if (pid > 0) {
+			close(pfds[1]);
+			exit(read_daemon_status(pfds[0]));
+		} else if (pid < 0) {
 			fprintf(stderr, "%s: Could not detach process\n",
 				program);
 			exit(1);
 		}
+		close(pfds[0]);
+		daemon_status_fd = pfds[1];
 	}
 
 	/* Open syslog */
@@ -1586,12 +1669,16 @@ int supervisor(char *path)
 	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, 0, ap.lookup->context);
 	if (map & LKP_FAIL) {
 		error("failed to load map exiting");
+		daemon_status(-1, "failed to load map exiting");
 		cleanup_exit(ap.path, 1);
 	} else if (map & LKP_INDIRECT) {
 		error("bad map format: found indirect, expected direct exiting");
+		daemon_status(-1, "bad map format: found indirect, "
+			    "expected direct exiting");
 		cleanup_exit(ap.path, 1);
 	}
 
+	daemon_status(0, "Success");
 	setup_signals(sig_supervisor, sig_supervisor);
 
 	while (waitpid(0, NULL, 0) > 0);
@@ -1607,6 +1694,7 @@ int handle_mounts(char *path)
 
 	if (mount_autofs(path) < 0) {
 		crit("%s: mount failed!", path);
+		daemon_status(-1, "%s: mount failed!", path);
 		cleanup_exit(path, 1);
 	}
 
@@ -1656,8 +1744,11 @@ int handle_mounts(char *path)
 		if (map & LKP_INDIRECT) {
 			error("bad map format: found indirect, "
 			      "expected direct exiting");
+			daemon_status(-1, "bad map format: found indirect, "
+				    "expected direct exiting");
 		} else {
 			error("failed to load map, exiting");
+			daemon_status(-1, "failed to load map, exiting");
 		}
 		rm_unwanted(ap.path, 1, 1);
 		umount_autofs(1);
@@ -1677,6 +1768,8 @@ int handle_mounts(char *path)
 				      "expected indirect exiting");
 				rm_unwanted(ap.path, 1, 1);
 				umount_autofs(1);
+				daemon_status(-1, "bad map format: found direct,"
+					    " exptected indirect exiting");
 				cleanup_exit(path, 1);
 			}
 		}
@@ -1699,6 +1792,8 @@ int handle_mounts(char *path)
 	if (submount || map & LKP_DIRECT)
 		kill(my_pid, SIGSTOP);
 
+	daemon_status(0, "Success");
+
 	while (ap.state != ST_SHUTDOWN) {
 		if (handle_packet() && errno != EINTR)
 			break;
@@ -1815,8 +1910,11 @@ #endif
 
 	ap.maptype = map;
 
-	if (!(ap.lookup = open_lookup(map, "", mapfmt, mapargc, mapargv)))
+	if (!(ap.lookup = open_lookup(map, "", mapfmt, mapargc, mapargv))) {
+		daemon_status(-1, "Failed to initialize lookup module for %s",
+			mapfmt);
 		cleanup_exit(path, 1);
+	}
 
 	if (!strncmp(path, "/-", 2)) {
 		supervisor(path);
diff --git a/samples/rc.autofs.in b/samples/rc.autofs.in
index 3a7f4cd..8cd3eb1 100644
--- a/samples/rc.autofs.in
+++ b/samples/rc.autofs.in
@@ -531,15 +531,34 @@ case "$1" in
         (grep -q autofs /proc/filesystems || /sbin/modprobe -k autofs4 || /sbin/modprobe -k autofs) 2> /dev/null
         echo -n $"Starting $prog: "
         TMP=`mktemp /tmp/autofs.XXXXXX` || { echo $"could not make temp file" >& 2; exit 1; }
-        getmounts | tee $TMP | sh
-        RETVAL=$?
-	if [ -s $TMP ] ; then
-	    if [ $RETVAL -eq 0 ] ; then
-		success "$prog startup"
-	    else
+
+	getmounts | tee $TMP | (
+	    WARN=0
+	    SUCCESS=0
+	    while read cmd rest
+	    do
+		$cmd $rest >&/dev/null
+		if [ $? -ne 0 ]; then
+		    echo -n -e "\nfailed to load map: \"$cmd $rest\""
+		    WARN=1
+		else
+		    SUCCESS=1
+		fi
+	    done;
+	    [ $SUCCESS = 0 ] && exit 2
+	    [ $WARN = 1 ] && exit 1
+	    exit 0
+	)
+	RETVAL=$?
+	if [ -s $TMP ]; then
+	    if [ $RETVAL = 1 ]; then
+		warning "$prog startup"
+	    elif [ $RETVAL = 2 ]; then
 		failure "$prog startup"
+	    else
+		success "$prog startup"
 	    fi
-	    [ $RETVAL = 0 ] && touch /var/lock/subsys/autofs
+	    [ $RETVAL != 2 ] && touch /var/lock/subsys/autofs
 	else
 	    echo -n $"No Mountpoints Defined"
 	    success "$prog startup"
@@ -602,8 +621,8 @@ case "$1" in
 	)
 	cat $TMP1 | ( while read x; do
 		if ! grep -q "^$x" $TMP2; then
-			$x
 			echo $"Start $x"
+			$x
 		fi
         done )
 	rm -f $TMP1 $TMP2
