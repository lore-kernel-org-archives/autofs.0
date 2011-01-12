From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 7/8] Ian Kent's reentrant
	syslog patch
Date: Thu, 13 Jan 2011 11:15:53 +1300
Message-ID: <01d41bc670be83edc1a1ab9ec31db1c8f9d6f27b.1295972820.git.bill.ryder.nz@gmail.com>
References: <cover.1295972820.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1295972820.git.bill.ryder.nz@gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

---
 CHANGELOG           |    8 +
 COPYRIGHT           |   36 +++-
 daemon/automount.c  |   72 +++++--
 include/automount.h |   27 +++
 include/syslog.h    |  201 +++++++++++++++++
 lib/Makefile        |    5 +-
 lib/syslog.c        |  383 +++++++++++++++++++++++++++++++
 lib/vsprintf.c      |  619 +++++++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 1332 insertions(+), 19 deletions(-)
 create mode 100644 include/syslog.h
 create mode 100644 lib/syslog.c
 create mode 100644 lib/vsprintf.c

diff --git a/CHANGELOG b/CHANGELOG
index bbf4d3d..b4959ec 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,11 @@
+15/07/2010 autofs-4.1.4 - syslog patch
+--------------------------------------
+
+This patch is necessary - especially when using debug syslog messages
+and testing high mount rates. Without it I've see the daemon wedge in
+syslog. I'm pretty sure Ian Kent did the patch.
+
+
 14/07/2010 autofs-4.1.4 - bryder p42
 ------------------------------------
  Adds retrying to nfs mounts. 
diff --git a/COPYRIGHT b/COPYRIGHT
index cf647f8..ee56c0c 100644
--- a/COPYRIGHT
+++ b/COPYRIGHT
@@ -14,4 +14,38 @@ For all software in this distribution unless otherwise indicated:
    GNU General Public License for more details.
 
 Portions Copyright (C) 1999-2000 Jeremy Fitzhardinge
-Portions Copyright (C) 2001-2003 Ian Kent
+Portions Copyright (C) 2001-2005 Ian Kent
+
+The files lib/syslog.c and include/syslog.h are licenced under the
+BSD License and require that a copy of the notice ibelow be included in
+accompanying documentation and be distributed with binary distributions
+of the code, so be sure to include this file along with any binary
+distributions derived from this source package.
+
+Copyright (c) 1983, 1988, 1993
+     The Regents of the University of California.  All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. Neither the name of the University nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+SUCH DAMAGE.
+
diff --git a/daemon/automount.c b/daemon/automount.c
index 3567abf..92476b4 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -38,13 +38,32 @@
 #include <sys/poll.h>
 #include <linux/auto_fs4.h>
 
+#include "automount.h"
+
 #ifndef NDEBUG
-#define assert(x)	do { if (!(x)) { syslog(LOG_CRIT, __FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
+#define assert(x) 						    \
+	do { 							    \
+		if (!(x)) {					    \
+			crit(__FILE__ ":%d: assertion failed: " #x, \
+				__LINE__);			    \
+		}						    \
+	} while(0)
 #else
 #define assert(x)	do { } while(0)
 #endif
 
-#include "automount.h"
+#ifndef NDEBUG
+#define assert_r(context, x) 					   \
+	do { 							   \
+		if (!(x)) {					   \
+			crit_r(context,				   \
+				__FILE__ ":%d: assertion failed: ",\
+				__LINE__);			   \
+		}						   \
+	} while(0)
+#else
+#define assert_r(context, x)	do { } while(0)
+#endif
 
 const char *program;		/* Initialized with argv[0] */
 const char *version = VERSION_STRING;	/* Program version */
@@ -68,6 +87,9 @@ sigset_t sigchld_mask;
 
 struct autofs_point ap;
 
+/* re-entrant syslog default context data */
+#define AUTOFS_SYSLOG_CONTEXT {-1, 0, 0, LOG_PID, (const char *)0, LOG_DAEMON, 0xff}
+
 volatile struct pending_mount *junk_mounts = NULL;
 
 #define CHECK_RATIO     4	/* exp_runfreq = exp_timeout/CHECK_RATIO */
@@ -481,19 +503,25 @@ static int mount_autofs(char *path)
 
 static void nextstate(enum states next)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
+
 	if (write(ap.state_pipe[1], &next, sizeof(next)) != sizeof(next))
-		error("nextstate: write failed %m");
+		error_r(slc, "nextstate: write failed %m");
 }
 
 /* Deal with all the signal-driven events in the state machine */
 static void sig_statemachine(int sig)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
 	int save_errno = errno;
 	enum states next = ap.state;
 
 	switch (sig) {
 	default:		/* all the "can't happen" signals */
-		error("process %d got unexpected signal %d!", getpid(), sig);
+		error_r(slc, "process %d got unexpected signal %d!",
+			getpid(), sig);
 		break;
 		/* don't FALLTHROUGH */
 
@@ -519,18 +547,21 @@ static void sig_statemachine(int sig)
 		break;
 	}
 
-	debug("sig %d switching from %d to %d", sig, ap.state, next);
+	debug_r(slc, "sig %d switching from %d to %d", sig, ap.state, next);
 
 	errno = save_errno;
 }
 
 static int send_ready(unsigned int wait_queue_token)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
+
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_ready: token=%d\n", wait_queue_token);
+	debug_r(slc, "send_ready: token=%d\n", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_READY, wait_queue_token) < 0) {
-		error("AUTOFS_IOC_READY: %m");
+		error_r(slc, "AUTOFS_IOC_READY: %m");
 		return 1;
 	}
 	return 0;
@@ -538,11 +569,14 @@ static int send_ready(unsigned int wait_queue_token)
 
 static int send_fail(unsigned int wait_queue_token)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
+
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_fail: token=%d\n", wait_queue_token);
+	debug_r(slc, "send_fail: token=%d\n", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_FAIL, wait_queue_token) < 0) {
-		syslog(LOG_ERR, "AUTOFS_IOC_FAIL: %m");
+		error_r(slc, "AUTOFS_IOC_FAIL: %m");
 		return 1;
 	}
 	return 0;
@@ -553,6 +587,8 @@ static int send_fail(unsigned int wait_queue_token)
    result.  */
 static enum states handle_child(int hang)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
 	pid_t pid;
 	int status;
 	enum states next = ST_INVAL;
@@ -560,7 +596,7 @@ static enum states handle_child(int hang)
 	while ((pid = waitpid(-1, &status, hang ? 0 : WNOHANG)) > 0) {
 		struct pending_mount volatile *mt, *volatile *mtp;
 
-		debug("handle_child: got pid %d, sig %d (%d), stat %d\n",
+		debug_r(slc, "handle_child: got pid %d, sig %d (%d), stat %d",
 			pid, WIFSIGNALED(status),
 			WTERMSIG(status), WEXITSTATUS(status));
 
@@ -606,18 +642,19 @@ static enum states handle_child(int hang)
 				}
 
 				/* Failed shutdown returns to ready */
-				warn("can't shutdown: filesystem %s still busy",
-				     ap.path);
+				warn_r(slc,
+				   "can't shutdown: filesystem %s still busy",
+				   ap.path);
 				alarm(ap.exp_runfreq);
 				next = ST_READY;
 				break;
 
 			default:
-				error("bad state %d", ap.state);
+				error_r(slc, "bad state %d", ap.state);
 			}
 
 			if (next != ST_INVAL)
-				debug("sigchld: exp "
+				debug_r(slc, "sigchld: exp "
 				     "%d finished, switching from %d to %d",
 				     pid, ap.state, next);
 
@@ -633,7 +670,7 @@ static enum states handle_child(int hang)
 			if (!WIFEXITED(status) && !WIFSIGNALED(status))
 				break;
 
-			debug("sig_child: found pending iop pid %d: "
+			debug_r(slc, "sig_child: found pending iop pid %d: "
 			     "signalled %d (sig %d), exit status %d",
 				pid, WIFSIGNALED(status),
 				WTERMSIG(status), WEXITSTATUS(status));
@@ -1530,11 +1567,14 @@ static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handl
 /* Deal with the signals recieved by direct mount supervisor */
 static void sig_supervisor(int sig)
 {
+	static struct syslog_data syslog_context = AUTOFS_SYSLOG_CONTEXT;
+	static struct syslog_data *slc = &syslog_context;
 	int save_errno = errno;
 
 	switch (sig) {
 	default:		/* all the signals not handled */
-		error("process %d got unexpected signal %d!", getpid(), sig);
+		error_r(slc, "process %d got unexpected signal %d!",
+			getpid(), sig);
 		return;
 		/* don't FALLTHROUGH */
 
diff --git a/include/automount.h b/include/automount.h
index b09dd78..72f6c91 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -15,6 +15,9 @@
 #include <time.h>
 #include "config.h"
 
+/* OpenBSD re-entrant syslog */
+#include "syslog.h"
+
 /* We MUST have the paths to mount(8) and umount(8) */
 #ifndef HAVE_MOUNT
 #error Failed to locate mount(8)!
@@ -318,5 +321,29 @@ if (do_verbose || do_debug) 		\
 if (do_debug) 				\
 	syslog(LOG_DEBUG, msg, ##args);
 
+/* Define reentrant logging macros for signal handlers */
+
+#define debug_r(context, msg, args...)				\
+do {								\
+	if (do_debug)						\
+		syslog_r(LOG_DEBUG, context, msg, ##args);	\
+} while (0)
+
+#define warn_r(context, msg, args...)				\
+do {								\
+	if (do_verbose || do_debug)				\
+		syslog_r(LOG_WARNING, context, msg, ##args);	\
+} while (0)
+
+#define error_r(context, msg, args...)			\
+do {							\
+	syslog_r(LOG_ERR, context, msg, ##args);	\
+} while (0)
+
+#define crit_r(context, msg, args...)			\
+do {							\
+	syslog_r(LOG_CRIT, context, msg, ##args);	\
+} while (0)
+
 #endif
 
diff --git a/include/syslog.h b/include/syslog.h
new file mode 100644
index 0000000..9f1cae4
--- /dev/null
+++ b/include/syslog.h
@@ -0,0 +1,201 @@
+/*	$OpenBSD: syslog.h,v 1.11 2003/08/24 01:27:07 avsm Exp $	*/
+/*	$NetBSD: syslog.h,v 1.14 1996/04/03 20:46:44 christos Exp $	*/
+
+/*
+ * Copyright (c) 1982, 1986, 1988, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ *
+ *	@(#)syslog.h	8.1 (Berkeley) 6/2/93
+ */
+
+#ifndef _SYS_SYSLOG_H_
+#define _SYS_SYSLOG_H_
+
+#include <features.h>
+#define __need___va_list
+#include <stdarg.h>
+
+#define	_PATH_LOG	"/dev/log"
+
+/*
+ * priorities/facilities are encoded into a single 32-bit quantity, where the
+ * bottom 3 bits are the priority (0-7) and the top 28 bits are the facility
+ * (0-big number).  Both the priorities and the facilities map roughly
+ * one-to-one to strings in the syslogd(8) source code.  This mapping is
+ * included in this file.
+ *
+ * priorities (these are ordered)
+ */
+#define	LOG_EMERG	0	/* system is unusable */
+#define	LOG_ALERT	1	/* action must be taken immediately */
+#define	LOG_CRIT	2	/* critical conditions */
+#define	LOG_ERR		3	/* error conditions */
+#define	LOG_WARNING	4	/* warning conditions */
+#define	LOG_NOTICE	5	/* normal but significant condition */
+#define	LOG_INFO	6	/* informational */
+#define	LOG_DEBUG	7	/* debug-level messages */
+
+#define	LOG_PRIMASK	0x07	/* mask to extract priority part (internal) */
+				/* extract priority */
+#define	LOG_PRI(p)	((p) & LOG_PRIMASK)
+#define	LOG_MAKEPRI(fac, pri)	(((fac) << 3) | (pri))
+
+#ifdef SYSLOG_NAMES
+#define	INTERNAL_NOPRI	0x10	/* the "no priority" priority */
+				/* mark "facility" */
+#define	INTERNAL_MARK	LOG_MAKEPRI(LOG_NFACILITIES, 0)
+typedef struct _code {
+	char	*c_name;
+	int	c_val;
+} CODE;
+
+CODE prioritynames[] = {
+	{ "alert",	LOG_ALERT },
+	{ "crit",	LOG_CRIT },
+	{ "debug",	LOG_DEBUG },
+	{ "emerg",	LOG_EMERG },
+	{ "err",	LOG_ERR },
+	{ "error",	LOG_ERR },		/* DEPRECATED */
+	{ "info",	LOG_INFO },
+	{ "none",	INTERNAL_NOPRI },	/* INTERNAL */
+	{ "notice",	LOG_NOTICE },
+	{ "panic", 	LOG_EMERG },		/* DEPRECATED */
+	{ "warn",	LOG_WARNING },		/* DEPRECATED */
+	{ "warning",	LOG_WARNING },
+	{ NULL,		-1 },
+};
+#endif
+
+/* facility codes */
+#define	LOG_KERN	(0<<3)	/* kernel messages */
+#define	LOG_USER	(1<<3)	/* random user-level messages */
+#define	LOG_MAIL	(2<<3)	/* mail system */
+#define	LOG_DAEMON	(3<<3)	/* system daemons */
+#define	LOG_AUTH	(4<<3)	/* security/authorization messages */
+#define	LOG_SYSLOG	(5<<3)	/* messages generated internally by syslogd */
+#define	LOG_LPR		(6<<3)	/* line printer subsystem */
+#define	LOG_NEWS	(7<<3)	/* network news subsystem */
+#define	LOG_UUCP	(8<<3)	/* UUCP subsystem */
+#define	LOG_CRON	(9<<3)	/* clock daemon */
+#define	LOG_AUTHPRIV	(10<<3)	/* security/authorization messages (private) */
+#define	LOG_FTP		(11<<3)	/* ftp daemon */
+
+	/* other codes through 15 reserved for system use */
+#define	LOG_LOCAL0	(16<<3)	/* reserved for local use */
+#define	LOG_LOCAL1	(17<<3)	/* reserved for local use */
+#define	LOG_LOCAL2	(18<<3)	/* reserved for local use */
+#define	LOG_LOCAL3	(19<<3)	/* reserved for local use */
+#define	LOG_LOCAL4	(20<<3)	/* reserved for local use */
+#define	LOG_LOCAL5	(21<<3)	/* reserved for local use */
+#define	LOG_LOCAL6	(22<<3)	/* reserved for local use */
+#define	LOG_LOCAL7	(23<<3)	/* reserved for local use */
+
+#define	LOG_NFACILITIES	24	/* current number of facilities */
+#define	LOG_FACMASK	0x03f8	/* mask to extract facility part */
+				/* facility of pri */
+#define	LOG_FAC(p)	(((p) & LOG_FACMASK) >> 3)
+
+#ifdef SYSLOG_NAMES
+CODE facilitynames[] = {
+	{ "auth",	LOG_AUTH },
+	{ "authpriv",	LOG_AUTHPRIV },
+	{ "cron", 	LOG_CRON },
+	{ "daemon",	LOG_DAEMON },
+	{ "ftp",	LOG_FTP },
+	{ "kern",	LOG_KERN },
+	{ "lpr",	LOG_LPR },
+	{ "mail",	LOG_MAIL },
+	{ "mark", 	INTERNAL_MARK },	/* INTERNAL */
+	{ "news",	LOG_NEWS },
+	{ "security",	LOG_AUTH },		/* DEPRECATED */
+	{ "syslog",	LOG_SYSLOG },
+	{ "user",	LOG_USER },
+	{ "uucp",	LOG_UUCP },
+	{ "local0",	LOG_LOCAL0 },
+	{ "local1",	LOG_LOCAL1 },
+	{ "local2",	LOG_LOCAL2 },
+	{ "local3",	LOG_LOCAL3 },
+	{ "local4",	LOG_LOCAL4 },
+	{ "local5",	LOG_LOCAL5 },
+	{ "local6",	LOG_LOCAL6 },
+	{ "local7",	LOG_LOCAL7 },
+	{ NULL,		-1 },
+};
+#endif
+
+/* Used by reentrant functions */
+
+struct syslog_data {
+	int	log_file;
+	int	connected;
+	int	opened;
+	int	log_stat;
+	const char 	*log_tag;
+	int 	log_fac;
+	int 	log_mask;
+};
+
+#define SYSLOG_DATA_INIT {-1, 0, 0, 0, (const char *)0, LOG_USER, 0xff}
+
+/*
+ * arguments to setlogmask.
+ */
+#define	LOG_MASK(pri)	(1 << (pri))		/* mask for one priority */
+#define	LOG_UPTO(pri)	((1 << ((pri)+1)) - 1)	/* all priorities through pri */
+
+/*
+ * Option flags for openlog.
+ *
+ * LOG_ODELAY no longer does anything.
+ * LOG_NDELAY is the inverse of what it used to be.
+ */
+#define	LOG_PID		0x01	/* log the pid with each message */
+#define	LOG_CONS	0x02	/* log on the console if errors in sending */
+#define	LOG_ODELAY	0x04	/* delay open until first syslog() (default) */
+#define	LOG_NDELAY	0x08	/* don't delay open */
+#define	LOG_NOWAIT	0x10	/* don't wait for console forks: DEPRECATED */
+#define	LOG_PERROR	0x20	/* log to stderr as well */
+
+__BEGIN_DECLS
+void	closelog(void);
+void	openlog(const char *__ident, int __option, int __facility);
+int	setlogmask(int __mask);
+void	syslog(int __pri, const char *__fmt, ...)
+		__attribute__((__format__(__printf__, 2, 3)));
+void	vsyslog(int __pri, const char *, __gnuc_va_list __ap)
+		__attribute__((__format__(__printf__, 2, 0)));
+void	closelog_r(struct syslog_data *__data);
+void	openlog_r(const char *__ident, int __option, int __facility, struct syslog_data *__data);
+int	setlogmask_r(int __mask, struct syslog_data *__data);
+void	syslog_r(int __pri, struct syslog_data *__data, const char *__fmt, ...)
+		__attribute__((__format__(__printf__, 3, 4)));
+void	vsyslog_r(int __pri, struct syslog_data *__data, const char *__fmt, __gnuc_va_list __ap)
+		__attribute__((__format__(__printf__, 3, 0)));
+__END_DECLS
+
+#endif /* !_SYS_SYSLOG_H_ */
+
diff --git a/lib/Makefile b/lib/Makefile
index 5cc809c..1771b1f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -9,10 +9,11 @@ include ../Makefile.rules
 RPCGEN = /usr/bin/rpcgen
 RANLIB = /usr/bin/ranlib
 
-SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c
+SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c syslog.c \
+	vsprintf.c
 RPCS = mount.h mount_clnt.c mount_xdr.c
 OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o \
-	cat_path.o rpc_subs.o mounts.o lock.o
+	cat_path.o rpc_subs.o mounts.o lock.o syslog.o vsprintf.o
 
 LIB = autofs.a
 
diff --git a/lib/syslog.c b/lib/syslog.c
new file mode 100644
index 0000000..9e5623e
--- /dev/null
+++ b/lib/syslog.c
@@ -0,0 +1,383 @@
+#ident "$Id: syslog.c,v 1.1 2005/05/01 09:48:34 raven Exp $"
+/*
+ * Copyright (c) 1983, 1988, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. Neither the name of the University nor the names of its contributors
+ *    may be used to endorse or promote products derived from this software
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+ * SUCH DAMAGE.
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/uio.h>
+#include <sys/un.h>
+#include <netdb.h>
+
+#include <errno.h>
+#include <fcntl.h>
+#include <paths.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdarg.h>
+
+#include "syslog.h"
+
+#define	TBUF_LEN	2048
+#define	FMT_LEN		1024
+#define	INTERNALLOG	LOG_ERR|LOG_CONS|LOG_PERROR|LOG_PID
+
+#define	DEC()					\
+	do {					\
+		if (prlen < 0)			\
+			prlen = 0;		\
+		if (prlen >= tbuf_left)		\
+			prlen = tbuf_left - 1;	\
+		p += prlen;			\
+		tbuf_left -= prlen;		\
+	} while (0)
+
+/* Use our internal printf routines */
+extern int snprintf_int(char * buf, size_t size, const char * fmt, ...)
+	__attribute__ ((format (printf, 3, 4)));
+extern int vsnprintf_int(char *buf, size_t size, const char *fmt, va_list args)
+	__attribute__ ((format (printf, 3, 0)));
+
+static struct syslog_data sdata = SYSLOG_DATA_INIT;
+static int LogType = SOCK_DGRAM;	/* type of socket connection */
+
+extern char	*__progname;		/* Program name, from crt0. */
+
+static void	disconnectlog_r(struct syslog_data *);	/* disconnect from syslogd */
+static void	connectlog_r(struct syslog_data *);	/* (re)connect to syslogd */
+
+/*
+ * syslog, vsyslog --
+ *	print message on log file; output is intended for syslogd(8).
+ */
+void
+syslog(int pri, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsyslog(pri, fmt, ap);
+	va_end(ap);
+}
+
+void
+vsyslog(int pri, const char *fmt, va_list ap)
+{
+	vsyslog_r(pri, &sdata, fmt, ap);
+}
+
+void
+openlog(const char *ident, int logstat, int logfac)
+{
+	openlog_r(ident, logstat, logfac, &sdata);
+}
+
+void
+closelog(void)
+{
+	closelog_r(&sdata);
+}
+
+/* setlogmask -- set the log mask level */
+int
+setlogmask(int pmask)
+{
+	return setlogmask_r(pmask, &sdata);
+}
+
+/* Reentrant version of syslog, i.e. syslog_r() */
+
+void
+syslog_r(int pri, struct syslog_data *data, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsyslog_r(pri, data, fmt, ap);
+	va_end(ap);
+}
+
+void
+vsyslog_r(int pri, struct syslog_data *data, const char *fmt, va_list ap)
+{
+	int cnt;
+	char ch, *p, *t;
+	time_t now;
+	int fd, saved_errno, error;
+	char *stdp = NULL, tbuf[TBUF_LEN], fmt_cpy[FMT_LEN];
+	int tbuf_left, fmt_left, prlen;
+
+	/* Check for invalid bits. */
+	if (pri & ~(LOG_PRIMASK|LOG_FACMASK)) {
+		if (data == &sdata) {
+			syslog(INTERNALLOG,
+			    "syslog: unknown facility/priority: %x", pri);
+		} else {
+			syslog_r(INTERNALLOG, data,
+			    "syslog_r: unknown facility/priority: %x", pri);
+		}
+		pri &= LOG_PRIMASK|LOG_FACMASK;
+	}
+
+	/* Check priority against setlogmask values. */
+	if (!(LOG_MASK(LOG_PRI(pri)) & data->log_mask))
+		return;
+
+	saved_errno = errno;
+
+	/* Set default facility if none specified. */
+	if ((pri & LOG_FACMASK) == 0)
+		pri |= data->log_fac;
+
+	/* If we have been called through syslog(), no need for reentrancy. */
+	if (data == &sdata)
+		(void)time(&now);
+
+	p = tbuf;
+	tbuf_left = TBUF_LEN;
+
+	prlen = snprintf_int(p, tbuf_left, "<%d>", pri);
+	DEC();
+
+	/* 
+	 * syslogd will expand time automagically for reentrant case, and
+	 * for normal case, just do like before
+	 */
+	if (data == &sdata) {
+		prlen = strftime(p, tbuf_left, "%h %e %T ", localtime(&now));
+		DEC();
+	}
+
+	if (data->log_stat & LOG_PERROR)
+		stdp = p;
+	if (data->log_tag == NULL)
+		data->log_tag = __progname;
+	if (data->log_tag != NULL) {
+		prlen = snprintf_int(p, tbuf_left, "%s", data->log_tag);
+		DEC();
+	}
+	if (data->log_stat & LOG_PID) {
+		prlen = snprintf_int(p, tbuf_left, "[%ld]", (long)getpid());
+		DEC();
+	}
+	if (data->log_tag != NULL) {
+		if (tbuf_left > 1) {
+			*p++ = ':';
+			tbuf_left--;
+		}
+		if (tbuf_left > 1) {
+			*p++ = ' ';
+			tbuf_left--;
+		}
+	}
+
+	/* strerror() is not reentrant */
+
+	for (t = fmt_cpy, fmt_left = FMT_LEN; (ch = *fmt); ++fmt) {
+		if (ch == '%' && fmt[1] == 'm') {
+			++fmt;
+			if (data == &sdata) {
+				prlen = snprintf_int(t, fmt_left, "%s",
+				    strerror(saved_errno)); 
+			} else {
+				prlen = snprintf_int(t, fmt_left, "Error %d",
+				    saved_errno); 
+			}
+			if (prlen < 0)
+				prlen = 0;
+			if (prlen >= fmt_left)
+				prlen = fmt_left - 1;
+			t += prlen;
+			fmt_left -= prlen;
+		} else if (ch == '%' && fmt[1] == '%' && fmt_left > 2) {
+			*t++ = '%';
+			*t++ = '%';
+			fmt++;
+			fmt_left -= 2;
+		} else {
+			if (fmt_left > 1) {
+				*t++ = ch;
+				fmt_left--;
+			}
+		}
+	}
+	*t = '\0';
+
+	prlen = vsnprintf_int(p, tbuf_left, fmt_cpy, ap);
+	DEC();
+	cnt = p - tbuf;
+
+	/* Output to stderr if requested. */
+	if (data->log_stat & LOG_PERROR) {
+		struct iovec iov[2];
+
+		iov[0].iov_base = stdp;
+		iov[0].iov_len = cnt - (stdp - tbuf);
+		iov[1].iov_base = "\n";
+		iov[1].iov_len = 1;
+		(void)writev(STDERR_FILENO, iov, 2);
+	}
+
+	/* Get connected, output the message to the local logger. */
+	if (!data->opened)
+		openlog_r(data->log_tag, data->log_stat, 0, data);
+	connectlog_r(data);
+
+	/* If we have a SOCK_STREAM connection, also send ASCII NUL as
+	   a record terminator.  */
+	if (LogType == SOCK_STREAM)
+		cnt++;
+
+	/*
+	 * If the send() failed, there are two likely scenarios:
+	 *  1) syslogd was restarted
+	 *  2) /dev/log is out of socket buffer space
+	 * We attempt to reconnect to /dev/log to take care of
+	 * case #1 and keep send()ing data to cover case #2
+	 * to give syslogd a chance to empty its socket buffer.
+	 */
+	if ((error = send(data->log_file, tbuf, cnt, 0)) < 0) {
+		if (errno != ENOBUFS) {
+			disconnectlog_r(data);
+			connectlog_r(data);
+		}
+		do {
+			usleep(1);
+			if ((error = send(data->log_file, tbuf, cnt, 0)) >= 0)
+				break;
+		} while (errno == ENOBUFS);
+	}
+
+	/*
+	 * Output the message to the console; try not to block
+	 * as a blocking console should not stop other processes.
+	 * Make sure the error reported is the one from the syslogd failure.
+	 */
+	if (error == -1 && (data->log_stat & LOG_CONS) &&
+	    (fd = open(_PATH_CONSOLE, O_WRONLY|O_NONBLOCK, 0)) >= 0) {
+		struct iovec iov[2];
+		
+		p = strchr(tbuf, '>') + 1;
+		iov[0].iov_base = p;
+		iov[0].iov_len = cnt - (p - tbuf);
+		iov[1].iov_base = "\r\n";
+		iov[1].iov_len = 2;
+		(void)writev(fd, iov, 2);
+		(void)close(fd);
+	}
+
+	if (data != &sdata)
+		closelog_r(data);
+}
+
+static void
+disconnectlog_r(struct syslog_data *data)
+{
+	/*
+	 * If the user closed the FD and opened another in the same slot,
+	 * that's their problem.  They should close it before calling on
+	 * system services.
+	 */
+	if (data->log_file != -1) {
+		close(data->log_file);
+		data->log_file = -1;
+	}
+	data->connected = 0;		/* retry connect */
+}
+
+static void
+connectlog_r(struct syslog_data *data)
+{
+	struct sockaddr_un SyslogAddr;	/* AF_UNIX address of local logger */
+
+again:
+	if (data->log_file == -1) {
+		if ((data->log_file = socket(AF_UNIX, LogType, 0)) == -1)
+			return;
+		(void)fcntl(data->log_file, F_SETFD, 1);
+	}
+	if (data->log_file != -1 && !data->connected) {
+		int old_errno;
+		
+		memset(&SyslogAddr, '\0', sizeof(SyslogAddr));
+		SyslogAddr.sun_family = AF_UNIX;
+		strncpy(SyslogAddr.sun_path, _PATH_LOG,
+		    sizeof(SyslogAddr.sun_path));
+		old_errno = errno;
+		if (connect(data->log_file, (struct sockaddr *)&SyslogAddr,
+		    sizeof(SyslogAddr)) == -1) {
+			int save_errno = errno;
+			(void)close(data->log_file);
+			data->log_file = -1;
+			if (LogType == SOCK_DGRAM && save_errno == EPROTOTYPE) {
+				/* retry with SOCK_STREAM */
+				LogType = SOCK_STREAM;
+				errno = old_errno;
+				goto again;
+			}
+		} else
+			data->connected = 1;
+	}
+}
+
+void
+openlog_r(const char *ident, int logstat, int logfac, struct syslog_data *data)
+{
+	if (ident != NULL)
+		data->log_tag = ident;
+	data->log_stat = logstat;
+	if (logfac != 0 && (logfac &~ LOG_FACMASK) == 0)
+		data->log_fac = logfac;
+
+	if (data->log_stat & LOG_NDELAY)	/* open immediately */
+		connectlog_r(data);
+
+	data->opened = 1;	/* ident and facility has been set */
+}
+
+void
+closelog_r(struct syslog_data *data)
+{
+	(void)close(data->log_file);
+	data->log_file = -1;
+	data->connected = 0;
+	data->log_tag = NULL;
+}
+
+/* setlogmask -- set the log mask level */
+int
+setlogmask_r(int pmask, struct syslog_data *data)
+{
+	int omask;
+
+	omask = data->log_mask;
+	if (pmask != 0)
+		data->log_mask = pmask;
+	return (omask);
+}
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
new file mode 100644
index 0000000..eabe83f
--- /dev/null
+++ b/lib/vsprintf.c
@@ -0,0 +1,619 @@
+#ident "$Id: vsprintf.c,v 1.1 2005/05/01 09:48:34 raven Exp $"
+/*
+ *  Stolen from the linux kernel.
+ *
+ *  License: GPL
+ */
+/*------------------ Original Copyright -----------------*/
+/*
+ *  linux/lib/vsprintf.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+/* vsprintf.c -- Lars Wirzenius & Linus Torvalds. */
+/*
+ * Wirzenius wrote this portably, Torvalds fucked it up :-)
+ */
+
+/* 
+ * Fri Jul 13 2001 Crutcher Dunnavant <crutcher+kernel@datastacks.com>
+ * - changed to provide snprintf and vsnprintf functions
+ * So Feb  1 16:51:32 CET 2004 Juergen Quade <quade@hsnr.de>
+ * - scnprintf and vscnprintf
+ */
+
+/* Also copied from: */
+
+/*
+ *  linux/lib/string.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+/*
+ * stupid library routines.. The optimized versions should generally be found
+ * as inline code in <asm-xx/string.h>
+ *
+ * These are buggy as well..
+ *
+ * * Fri Jun 25 1999, Ingo Oeser <ioe@informatik.tu-chemnitz.de>
+ * -  Added strsep() which will replace strtok() soon (because strsep() is
+ *    reentrant and should be faster). Use only strsep() in new code, please.
+ *
+ * * Sat Feb 09 2002, Jason Thomas <jason@topic.com.au>,
+ *                    Matthew Hawkins <matt@mh.dropbear.id.au>
+ * -  Kissed strtok() goodbye
+ */
+/*-------------------------------------------------------*/
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <ctype.h>
+#include <sys/types.h>
+#include <stdint.h>
+#include <unistd.h>
+
+#define BITS_PER_LONG	__WORDSIZE
+#define PAGE_SIZE	getpagesize()
+
+
+#if BITS_PER_LONG == 64
+
+# define do_div(n,base) ({					\
+	uint32_t __base = (base);				\
+	uint32_t __rem;						\
+	__rem = ((uint64_t)(n)) % __base;			\
+	(n) = ((uint64_t)(n)) / __base;				\
+	__rem;							\
+ })
+
+#elif BITS_PER_LONG == 32
+
+/* Not needed on 64bit architectures */
+uint32_t __div64_32(uint64_t *n, uint32_t base)
+{
+	uint64_t rem = *n;
+	uint64_t b = base;
+	uint64_t res, d = 1;
+	uint32_t high = rem >> 32;
+
+	/* Reduce the thing a bit first */
+	res = 0;
+	if (high >= base) {
+		high /= base;
+		res = (uint64_t) high << 32;
+		rem -= (uint64_t) (high*base) << 32;
+	}
+
+	while ((int64_t)b > 0 && b < rem) {
+		b = b+b;
+		d = d+d;
+	}
+
+	do {
+		if (rem >= b) {
+			rem -= b;
+			res += d;
+		}
+		b >>= 1;
+		d >>= 1;
+	} while (d);
+
+	*n = res;
+	return rem;
+}
+
+/* The unnecessary pointer compare is there
+ * to check for type safety (n must be 64bit)
+ */
+# define do_div(n,base) ({				\
+	uint32_t __base = (base);			\
+	uint32_t __rem;					\
+	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
+	if (((n) >> 32) == 0) {				\
+		__rem = (uint32_t)(n) % __base;		\
+		(n) = (uint32_t)(n) / __base;		\
+	} else 						\
+		__rem = __div64_32(&(n), __base);	\
+	__rem;						\
+ })
+
+# else
+
+# error do_div() does not yet support the C64
+
+#endif /* BITS_PER_LONG */
+
+
+/**
+ * strnlen - Find the length of a length-limited string
+ * @s: The string to be sized
+ * @count: The maximum number of bytes to search
+ */
+size_t strnlen(const char * s, size_t count)
+{
+	const char *sc;
+
+	for (sc = s; count-- && *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+
+/**
+ * simple_strtoul - convert a string to an unsigned long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+unsigned long simple_strtoul(const char *cp,char **endp,unsigned int base)
+{
+	unsigned long result = 0,value;
+
+	if (!base) {
+		base = 10;
+		if (*cp == '0') {
+			base = 8;
+			cp++;
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
+				cp++;
+				base = 16;
+			}
+		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && toupper(cp[1]) == 'X')
+			cp += 2;
+	}
+	while (isxdigit(*cp) &&
+	       (value = isdigit(*cp) ? *cp-'0' : toupper(*cp)-'A'+10) < base) {
+		result = result*base + value;
+		cp++;
+	}
+	if (endp)
+		*endp = (char *)cp;
+	return result;
+}
+
+/**
+ * simple_strtol - convert a string to a signed long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+long simple_strtol(const char *cp,char **endp,unsigned int base)
+{
+	if(*cp=='-')
+		return -simple_strtoul(cp+1,endp,base);
+	return simple_strtoul(cp,endp,base);
+}
+
+/**
+ * simple_strtoull - convert a string to an unsigned long long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+unsigned long long simple_strtoull(const char *cp,char **endp,unsigned int base)
+{
+	unsigned long long result = 0,value;
+
+	if (!base) {
+		base = 10;
+		if (*cp == '0') {
+			base = 8;
+			cp++;
+			if ((toupper(*cp) == 'X') && isxdigit(cp[1])) {
+				cp++;
+				base = 16;
+			}
+		}
+	} else if (base == 16) {
+		if (cp[0] == '0' && toupper(cp[1]) == 'X')
+			cp += 2;
+	}
+	while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
+	    ? toupper(*cp) : *cp)-'A'+10) < base) {
+		result = result*base + value;
+		cp++;
+	}
+	if (endp)
+		*endp = (char *)cp;
+	return result;
+}
+
+/**
+ * simple_strtoll - convert a string to a signed long long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ */
+long long simple_strtoll(const char *cp,char **endp,unsigned int base)
+{
+	if(*cp=='-')
+		return -simple_strtoull(cp+1,endp,base);
+	return simple_strtoull(cp,endp,base);
+}
+
+static int skip_atoi(const char **s)
+{
+	int i=0;
+
+	while (isdigit(**s))
+		i = i*10 + *((*s)++) - '0';
+	return i;
+}
+
+#define ZEROPAD	1		/* pad with zero */
+#define SIGN	2		/* unsigned/signed long */
+#define PLUS	4		/* show plus */
+#define SPACE	8		/* space if plus */
+#define LEFT	16		/* left justified */
+#define SPECIAL	32		/* 0x */
+#define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
+
+static char * number(char * buf, char * end, unsigned long long num, int base, int size, int precision, int type)
+{
+	char c,sign,tmp[66];
+	const char *digits;
+	static const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
+	static const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
+	int i;
+
+	digits = (type & LARGE) ? large_digits : small_digits;
+	if (type & LEFT)
+		type &= ~ZEROPAD;
+	if (base < 2 || base > 36)
+		return NULL;
+	c = (type & ZEROPAD) ? '0' : ' ';
+	sign = 0;
+	if (type & SIGN) {
+		if ((signed long long) num < 0) {
+			sign = '-';
+			num = - (signed long long) num;
+			size--;
+		} else if (type & PLUS) {
+			sign = '+';
+			size--;
+		} else if (type & SPACE) {
+			sign = ' ';
+			size--;
+		}
+	}
+	if (type & SPECIAL) {
+		if (base == 16)
+			size -= 2;
+		else if (base == 8)
+			size--;
+	}
+	i = 0;
+	if (num == 0)
+		tmp[i++]='0';
+	else while (num != 0)
+		tmp[i++] = digits[do_div(num,base)];
+	if (i > precision)
+		precision = i;
+	size -= precision;
+	if (!(type&(ZEROPAD+LEFT))) {
+		while(size-->0) {
+			if (buf <= end)
+				*buf = ' ';
+			++buf;
+		}
+	}
+	if (sign) {
+		if (buf <= end)
+			*buf = sign;
+		++buf;
+	}
+	if (type & SPECIAL) {
+		if (base==8) {
+			if (buf <= end)
+				*buf = '0';
+			++buf;
+		} else if (base==16) {
+			if (buf <= end)
+				*buf = '0';
+			++buf;
+			if (buf <= end)
+				*buf = digits[33];
+			++buf;
+		}
+	}
+	if (!(type & LEFT)) {
+		while (size-- > 0) {
+			if (buf <= end)
+				*buf = c;
+			++buf;
+		}
+	}
+	while (i < precision--) {
+		if (buf <= end)
+			*buf = '0';
+		++buf;
+	}
+	while (i-- > 0) {
+		if (buf <= end)
+			*buf = tmp[i];
+		++buf;
+	}
+	while (size-- > 0) {
+		if (buf <= end)
+			*buf = ' ';
+		++buf;
+	}
+	return buf;
+}
+
+/**
+ * vsnprintf_int - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * The return value is the number of characters which would
+ * be generated for the given input, excluding the trailing
+ * '\0', as per ISO C99. If you want to have the exact
+ * number of characters written into @buf as return value
+ * (not including the trailing '\0'), use vscnprintf. If the
+ * return is greater than or equal to @size, the resulting
+ * string is truncated.
+ *
+ * Call this function if you are already dealing with a va_list.
+ * You probably want snprintf instead.
+ */
+int vsnprintf_int(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int len;
+	unsigned long long num;
+	int i, base;
+	char *str, *end, c;
+	const char *s;
+
+	int flags;		/* flags to number() */
+
+	int field_width;	/* width of output field */
+	int precision;		/* min. # of digits for integers; max
+				   number of chars for from string */
+	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
+				/* 'z' support added 23/7/1999 S.H.    */
+				/* 'z' changed to 'Z' --davidm 1/25/99 */
+
+	/* Reject out-of-range values early */
+	if ((int) size < 0)
+		return 0;
+
+	str = buf;
+	end = buf + size - 1;
+
+	if (end < buf - 1) {
+		end = ((void *) -1);
+		size = end - buf + 1;
+	}
+
+	for (; *fmt ; ++fmt) {
+		if (*fmt != '%') {
+			if (str <= end)
+				*str = *fmt;
+			++str;
+			continue;
+		}
+
+		/* process flags */
+		flags = 0;
+		repeat:
+			++fmt;		/* this also skips first '%' */
+			switch (*fmt) {
+				case '-': flags |= LEFT; goto repeat;
+				case '+': flags |= PLUS; goto repeat;
+				case ' ': flags |= SPACE; goto repeat;
+				case '#': flags |= SPECIAL; goto repeat;
+				case '0': flags |= ZEROPAD; goto repeat;
+			}
+
+		/* get field width */
+		field_width = -1;
+		if (isdigit(*fmt))
+			field_width = skip_atoi(&fmt);
+		else if (*fmt == '*') {
+			++fmt;
+			/* it's the next argument */
+			field_width = va_arg(args, int);
+			if (field_width < 0) {
+				field_width = -field_width;
+				flags |= LEFT;
+			}
+		}
+
+		/* get the precision */
+		precision = -1;
+		if (*fmt == '.') {
+			++fmt;	
+			if (isdigit(*fmt))
+				precision = skip_atoi(&fmt);
+			else if (*fmt == '*') {
+				++fmt;
+				/* it's the next argument */
+				precision = va_arg(args, int);
+			}
+			if (precision < 0)
+				precision = 0;
+		}
+
+		/* get the conversion qualifier */
+		qualifier = -1;
+		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
+		    *fmt =='Z' || *fmt == 'z') {
+			qualifier = *fmt;
+			++fmt;
+			if (qualifier == 'l' && *fmt == 'l') {
+				qualifier = 'L';
+				++fmt;
+			}
+		}
+
+		/* default base */
+		base = 10;
+
+		switch (*fmt) {
+			case 'c':
+				if (!(flags & LEFT)) {
+					while (--field_width > 0) {
+						if (str <= end)
+							*str = ' ';
+						++str;
+					}
+				}
+				c = (unsigned char) va_arg(args, int);
+				if (str <= end)
+					*str = c;
+				++str;
+				while (--field_width > 0) {
+					if (str <= end)
+						*str = ' ';
+					++str;
+				}
+				continue;
+
+			case 's':
+				s = va_arg(args, char *);
+				if ((unsigned long)s < PAGE_SIZE)
+					s = "<NULL>";
+
+				len = strnlen(s, precision);
+
+				if (!(flags & LEFT)) {
+					while (len < field_width--) {
+						if (str <= end)
+							*str = ' ';
+						++str;
+					}
+				}
+				for (i = 0; i < len; ++i) {
+					if (str <= end)
+						*str = *s;
+					++str; ++s;
+				}
+				while (len < field_width--) {
+					if (str <= end)
+						*str = ' ';
+					++str;
+				}
+				continue;
+
+			case 'p':
+				if (field_width == -1) {
+					field_width = 2*sizeof(void *);
+					flags |= ZEROPAD;
+				}
+				str = number(str, end,
+						(unsigned long) va_arg(args, void *),
+						16, field_width, precision, flags);
+				continue;
+
+
+			case 'n':
+				/* FIXME:
+				* What does C99 say about the overflow case here? */
+				if (qualifier == 'l') {
+					long * ip = va_arg(args, long *);
+					*ip = (str - buf);
+				} else if (qualifier == 'Z' || qualifier == 'z') {
+					size_t * ip = va_arg(args, size_t *);
+					*ip = (str - buf);
+				} else {
+					int * ip = va_arg(args, int *);
+					*ip = (str - buf);
+				}
+				continue;
+
+			case '%':
+				if (str <= end)
+					*str = '%';
+				++str;
+				continue;
+
+				/* integer number formats - set up the flags and "break" */
+			case 'o':
+				base = 8;
+				break;
+
+			case 'X':
+				flags |= LARGE;
+			case 'x':
+				base = 16;
+				break;
+
+			case 'd':
+			case 'i':
+				flags |= SIGN;
+			case 'u':
+				break;
+
+			default:
+				if (str <= end)
+					*str = '%';
+				++str;
+				if (*fmt) {
+					if (str <= end)
+						*str = *fmt;
+					++str;
+				} else {
+					--fmt;
+				}
+				continue;
+		}
+		if (qualifier == 'L')
+			num = va_arg(args, long long);
+		else if (qualifier == 'l') {
+			num = va_arg(args, unsigned long);
+			if (flags & SIGN)
+				num = (signed long) num;
+		} else if (qualifier == 'Z' || qualifier == 'z') {
+			num = va_arg(args, size_t);
+		} else if (qualifier == 'h') {
+			num = (unsigned short) va_arg(args, int);
+			if (flags & SIGN)
+				num = (signed short) num;
+		} else {
+			num = va_arg(args, unsigned int);
+			if (flags & SIGN)
+				num = (signed int) num;
+		}
+		str = number(str, end, num, base,
+				field_width, precision, flags);
+	}
+	if (str <= end)
+		*str = '\0';
+	else if (size > 0)
+		/* don't write out a null byte if the buf size is zero */
+		*end = '\0';
+	/* the trailing null byte doesn't count towards the total
+	* ++str;
+	*/
+	return str-buf;
+}
+
+/**
+ * snprintf_int - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @...: Arguments for the format string
+ *
+ * The return value is the number of characters which would be
+ * generated for the given input, excluding the trailing null,
+ * as per ISO C99.  If the return is greater than or equal to
+ * @size, the resulting string is truncated.
+ */
+int snprintf_int(char * buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i=vsnprintf_int(buf,size,fmt,args);
+	va_end(args);
+	return i;
+}
+
-- 
1.7.3.4
