From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch rfc] don't exit from parent until autofs can
	service requests
Date: Wed, 1 Jun 2005 10:29:29 -0400
Message-ID: <17053.50761.832966.775060@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi, Ian, list,

I have a user who starts a service just after autofs in the boot
sequence, and this service depends on the automounter.  However, because
the daemon calls become_daemon very early, the init script will most
certainly return before the daemon is ready to service mount requests.  As
a result, the service that depends on autofs fails to start.

The following patch addresses this by keeping the parent around until
either the daemon fails to start, or is about ready to service mount
requests.  Communication of status information is done via a pipe.  I also
modified the init script to print out any failures, so the user sees them
on the console and is aware that there is a problem.  (I only modified the
Red Hat portion of the init script, as I don't have a debian system to test
with.  Note to debian folks, I'm happy to provide a patch for that if
someone will test).

I tested this by putting together master maps that had no entries, all
valid entries, all invalid entries, and a mix of valid and invalid entries.
I verified the output in every case.

To test the exit paths after the become_daemon call in autofs, I provided a
map with type "invalid", by putting a line like so in /etc/auto.master:

  /foo	 invalid:/etc/auto.foo

The daemon will fail in open_lookup, when trying to dlopen
/usr/lib/autofs/lookup_invalid.so.  I verified that this did in fact fail,
and that the failure was reported by the init script.

Here is sample output for the following master map:
/dne    /etc/auto.dne  # auto.dne does not exist
/net    /etc/auto.net

# service autofs start
Starting automount: 
failed to load map auto.dne                                [WARNING]

Since auto.net started successfully, the init script printed out a
warning.  If no maps load, FAILED is printed.  If everything works fine,
then it prints OK as before.

Comments would be greatly appreciated.  The patch is generated from current
cvs, using cvs diff.

Thanks,

Jeff

? cscope.files
? cscope.in.out
? cscope.out
? cscope.po.out
Index: daemon/automount.c
===================================================================
RCS file: /root/autofs/daemon/automount.c,v
retrieving revision 1.41
diff -u -p -r1.41 automount.c
--- daemon/automount.c	1 May 2005 09:38:05 -0000	1.41
+++ daemon/automount.c	1 Jun 2005 14:23:43 -0000
@@ -29,6 +29,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <stdarg.h>
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -71,6 +72,13 @@ static pid_t my_pgrp;		/* The "magic" pr
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
 
@@ -1298,25 +1306,100 @@ static int handle_packet(void)
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
+		ret = vsnprintf(buf, DAEMON_STATUS_MSG_SZ, "%s", ap);
+		va_end(ap);
+		if (ret > DAEMON_STATUS_MSG_SZ)
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
@@ -1555,12 +1638,16 @@ int supervisor(char *path)
 	map = ap.lookup->lookup_ghost(ap.path, ap.ghost, 0, ap.lookup->context);
 	if (map & LKP_FAIL) {
 		error("failed to load map exiting");
+		daemon_status(-1, "failed to load map exiting");
 		cleanup_exit(ap.path, 1);
 	} else if (map & LKP_INDIRECT) {
 		error("bad map format: found indirect, expected direct exiting");
+		daemon_status(-1, "bad map format: found indirect, "
+			      "expected direct exiting");
 		cleanup_exit(ap.path, 1);
 	}
 
+	daemon_status(0, "Success");
 	ap.state = ST_READY;
 	setup_signals(sig_supervisor, sig_supervisor);
 
@@ -1614,6 +1701,7 @@ int handle_mounts(char *path)
 
 	if (mount_autofs(path) < 0) {
 		crit("%s: mount failed!", path);
+		daemon_status(-1, "%s: mount failed!", path);
 		cleanup_exit(path, 1);
 	}
 
@@ -1663,8 +1751,11 @@ int handle_mounts(char *path)
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
@@ -1684,6 +1775,8 @@ int handle_mounts(char *path)
 				      "expected indirect exiting");
 				rm_unwanted(ap.path, 1, 1);
 				umount_autofs(1);
+				daemon_status(-1, "bad map format: found direct,"
+					    " exptected indirect exiting");
 				cleanup_exit(path, 1);
 			}
 		}
@@ -1706,6 +1799,8 @@ int handle_mounts(char *path)
 	if (submount || map & LKP_DIRECT)
 		kill(my_pid, SIGSTOP);
 
+	daemon_status(0, "Success");
+
 	while (ap.state != ST_SHUTDOWN) {
 		if (handle_packet()) {
 			sigset_t olds;
@@ -1846,8 +1941,11 @@ int main(int argc, char *argv[])
 
 	ap.maptype = map;
 
-	if (!(ap.lookup = open_lookup(map, "", mapfmt, mapargc, mapargv)))
+	if (!(ap.lookup = open_lookup(map, "", mapfmt, mapargc, mapargv))) {
+		daemon_status(-1, "Failed to initialize lookup module for %s",
+			mapfmt);
 		cleanup_exit(path, 1);
+	}
 
 	if (!strncmp(path, "/-", 2)) {
 		supervisor(path);
Index: samples/rc.autofs.in
===================================================================
RCS file: /root/autofs/samples/rc.autofs.in,v
retrieving revision 1.58
diff -u -p -r1.58 rc.autofs.in
--- samples/rc.autofs.in	11 Apr 2005 11:30:54 -0000	1.58
+++ samples/rc.autofs.in	1 Jun 2005 14:23:44 -0000
@@ -504,15 +504,35 @@ case "$1" in
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
+		    map=`echo $rest | awk '{print \$NF}'`
+		    echo -n -e "\nfailed to load map $map"
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
