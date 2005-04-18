From: raven@themaw.net
Subject: Re: [patch, rfc] fix hung automounter issues
Date: Mon, 18 Apr 2005 21:26:28 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16990.26693.814813.479017@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Dan.Berrange@ubs.com

On Thu, 14 Apr 2005, Jeff Moyer wrote:

> Hi, Ian,
>
> Dan Berrange did a spectacular job of diagnosing some autofs hangs he was
> experiencing.  The automount daemon would appear hung, and an an strace of
> the process would show sys_futex on the call stack.  Through his
> debugging, he figured out that the problem was autofs issuing syslog calls
> while in a signal handler.
>
> So, there are a few ways to fix this that come to mind.
>
> o We could not log in signal handlers.  I don't consider this an acceptable
>  solution, as we really need the debug messages generated there.
> o We could defer logging to non-signal handler context.  This is in fact
>  what the attached pattch does.  It queues the syslog messages, and
>  flushes them upon the next syslog that occurs outside of signal handler
>  context.
> o We could open /dev/log directly.  This is likely a bad idea as there is
>  no standard for the interface there.
> o We could have a separate logging process, which we write to via a pipe.
>  I'm not keen on this as it adds yet another process, and makes shutdown
>  that much more complicated.
>
> Note that in all of the above cases, we still need to implement a
> signal-safe vsprintf.  That is what the bulk of this patch is.
>
> So, here is a rough take on implementing the second bullet point.  I
> wholesale copied a bunch of code from the linux kernel for doing vsprintf.
> That bit is ugly.  I'd also move the definition of the new logging routines
> into the vsprintf file, and rename it.  In short, this is a proof of
> concept (shown to resolve the issues).  I'm happy to clean it up, but I
> want to be sure that this is the direction we want to go in, first.
>
> Limitations of this approach: we won't flush the logs that were issued in
> signal handler context until another syslog call is made.  One improvement
> that could be made straight-away is to have all of the logging routines
> call flush_logs, even if the log priority is set low enough that they
> wouldn't otherwise log.
>
> Comments encouraged.  Thanks again to Dan!

Hi Jeff,

There were a few things missed in the patch as there's a few other places 
that calls to illegal routines are made.

I did a bit of work on it over the weekend.

Basically the changes I have made are:

- moved calls to signal_children out of signal handler.
- created seperate module for safe_syslog implementation.
- changed assert to use safe_syslog also.
- removed assertions from safe logging routines as it also calls
   (safe_)syslog.
- added attempt at last gasp message in queue_syslog.
- added some string termination logic to queue_syslog.

There's probably stuff that I've missed.
I've done some basic testing but more is needed.

Can you review this and alter as you see fit please Jeff?

This just leaves the ioctl calls.
I'm hoping we can verify they are safe. We can check the kernel control 
path and if we can verify that the glibc code is suitably reentrant they 
are probably OK. I'm having trouble finding the right code in glibc. Do 
you have a glibc person that could point us in the right direction Jeff?

We probably should agree on a name for the patch to avoid confusion later.
I've called mine autofs-4.1.4-signal-safe-logging.patch. What name do you 
like?

Ian

diff -Nurp autofs-4.1.4.orig/daemon/automount.c autofs-4.1.4/daemon/automount.c
--- autofs-4.1.4.orig/daemon/automount.c	2005-03-06 17:43:55.000000000 +0800
+++ autofs-4.1.4/daemon/automount.c	2005-04-18 20:59:43.000000000 +0800
@@ -5,7 +5,7 @@
   *
   *   Copyright 1997 Transmeta Corporation - All Rights Reserved
   *   Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
- *   Copyright 2001-2003 Ian Kent <raven@themaw.net>
+ *   Copyright 2001-2005 Ian Kent <raven@themaw.net>
   *
   *   This program is free software; you can redistribute it and/or modify
   *   it under the terms of the GNU General Public License as published by
@@ -39,7 +39,14 @@
  #include <linux/auto_fs4.h>

  #ifndef NDEBUG
-#define assert(x)	do { if (!(x)) { syslog(LOG_CRIT, __FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
+#define assert(x) 							   \
+	do { 								   \
+		if (!(x)) {						   \
+			safe_logger(LOG_CRIT,				   \
+				    __FILE__ ":%d: assertion failed: " #x, \
+				    __LINE__);				   \
+		}							   \
+	} while(0)
  #else
  #define assert(x)	do { } while(0)
  #endif
@@ -58,14 +65,12 @@ int kproto_sub_version = 0;	/* Kernel pr

  static int submount = 0;

-int do_verbose = 0;		/* Verbose feedback option */
-int do_debug = 0;		/* Enable full debug output */
-
  sigset_t ready_sigs;		/* signals only accepted in ST_READY */
  sigset_t lock_sigs;		/* signals blocked for locking */
  sigset_t sigchld_mask;

  struct autofs_point ap;
+extern volatile int in_interrupt;

  volatile struct pending_mount *junk_mounts = NULL;

@@ -490,6 +495,7 @@ static void sig_statemachine(int sig)
  	int save_errno = errno;
  	enum states next = ap.state;

+	in_interrupt++;
  	switch (sig) {
  	default:		/* all the "can't happen" signals */
  		error("process %d got unexpected signal %d!", getpid(), sig);
@@ -521,6 +527,7 @@ static void sig_statemachine(int sig)
  	debug("sig %d switching from %d to %d", sig, ap.state, next);

  	errno = save_errno;
+	in_interrupt--;
  }

  static int send_ready(unsigned int wait_queue_token)
@@ -565,7 +572,7 @@ static enum states handle_child(int hang

  		/* Check to see if expire process finished */
  		if (pid == ap.exp_process) {
-			int success, ret;
+			int success;

  			if (!WIFEXITED(status))
  				continue;
@@ -594,15 +601,8 @@ static enum states handle_child(int hang

  			case ST_SHUTDOWN_PENDING:
  				next = ST_SHUTDOWN;
-				if (success) {
-					ret = ioctl(ap.ioctlfd,
-						AUTOFS_IOC_ASKUMOUNT, &status);
-					if (!ret) {
-						if (status)
-							break;
-					} else
-						break;
-				}
+				if (success)
+					break;

  				/* Failed shutdown returns to ready */
  				warn("can't shutdown: filesystem %s still busy",
@@ -661,6 +661,7 @@ static void sig_child(int sig)
  	int save_errno = errno;
  	enum states next;

+	in_interrupt++;
  	if (sig != SIGCHLD)
  		return;

@@ -669,6 +670,7 @@ static void sig_child(int sig)
  		nextstate(next);

  	errno = save_errno;
+	in_interrupt--;
  }

  static int st_ready(void)
@@ -1487,6 +1489,7 @@ static void sig_supervisor(int sig)
  {
  	int save_errno = errno;

+	in_interrupt++;
  	switch (sig) {
  	default:		/* all the signals not handled */
  		error("process %d got unexpected signal %d!", getpid(), sig);
@@ -1495,13 +1498,11 @@ static void sig_supervisor(int sig)

  	case SIGTERM:
  	case SIGUSR2:
-		/* Tell everyone to finish up */
-		signal_children(sig);
+		ap.state = ST_SHUTDOWN_PENDING;
  		break;

  	case SIGUSR1:
-		/* Pass on the prune event and ignore self signal */
-		signal_children(sig);
+		ap.state = ST_PRUNE;
  		break;

  	case SIGCHLD:
@@ -1509,20 +1510,18 @@ static void sig_supervisor(int sig)
  		break;

  	case SIGHUP:
-		ap.lookup->lookup_ghost(ap.path, ap.ghost, 0, ap.lookup->context);
-
  		/* Pass on the reread event and ignore self signal */
-		kill(0, SIGHUP);
-		discard_pending(SIGHUP);
-
+		ap.state = ST_READMAP;
  		break;
  	}
  	errno = save_errno;
+	in_interrupt--;
  }

  int supervisor(char *path)
  {
  	unsigned int map = 0;
+	int ret;

  	ap.path = alloca(strlen(path) + 1);
  	strcpy(ap.path, path);
@@ -1538,6 +1537,37 @@ int supervisor(char *path)

  	setup_signals(sig_supervisor, sig_supervisor);

+	while (ap.state != ST_SHUTDOWN) {
+		switch (ap.state) {
+		case ST_READMAP:
+			st_readmap();
+			signal_children(SIGHUP);
+			ap.state = ST_READY;
+			break;
+		case ST_SHUTDOWN_PENDING:
+			ret = signal_children(SIGUSR2);
+			if (!ret) {
+				ap.state = ST_SHUTDOWN;
+				break;
+			}
+
+			/* Failed shutdown returns to ready */
+			warn("can't shutdown: filesystem %s still busy",
+				     ap.path);
+			ap.state = ST_READY;
+			break;
+		case ST_PRUNE:
+			/* Pass on the prune event and ignore self signal */
+			signal_children(SIGUSR1);
+			ap.state = ST_READY;
+			break;
+		default:
+			ap.state = ST_READY;
+			break;
+		}
+		sleep(1);
+	}
+
  	while (waitpid(0, NULL, 0) > 0);

  	return 0;
@@ -1644,8 +1674,23 @@ int handle_mounts(char *path)
  		kill(my_pid, SIGSTOP);

  	while (ap.state != ST_SHUTDOWN) {
-		if (handle_packet() && errno != EINTR)
-			break;
+		if (handle_packet() && errno != EINTR) {
+			int ret, status = 0;
+
+			ret = ioctl(ap.ioctlfd, AUTOFS_IOC_ASKUMOUNT, &status);
+			/* 
+			 * If the ioctl fails assume the kernel doesn't have
+			 * AUTOFS_IOC_ASKUMOUNT and just continue.
+			 */
+			if (!ret && status)
+				break;
+
+			/* Failed shutdown returns to ready */
+			warn("can't shutdown: filesystem %s still busy",
+				     ap.path);
+			ap.state = ST_READY;
+			alarm(ap.exp_runfreq);
+		}
  	}

  	/* Mop up remaining kids */
diff -Nurp autofs-4.1.4.orig/include/automount.h autofs-4.1.4/include/automount.h
--- autofs-4.1.4.orig/include/automount.h	2005-01-26 21:03:02.000000000 +0800
+++ autofs-4.1.4/include/automount.h	2005-04-17 21:07:27.000000000 +0800
@@ -109,7 +109,7 @@ struct autofs_point {
  	volatile pid_t exp_process;		/* Process that is currently expiring */
  	volatile struct pending_mount *mounts;	/* Pending mount queue */
  	struct lookup_mod *lookup;		/* Lookup module */
-	enum states state;
+	volatile enum states state;
  	int state_pipe[2];
  	unsigned dir_created;		/* Was a directory created for this
  					   mount? */
@@ -283,24 +283,53 @@ int has_fstab_option(const char *path, c
  int allow_owner_mount(const char *);

  /* log notification */
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
+extern int do_verbose;		/* Verbose feedback option */
+extern int do_debug;		/* Enable full debug output */
+void safe_logger(int priority, const char *format, ...);
+
+#define debug(msg, args...)				\
+do {							\
+	if (do_debug)					\
+		safe_logger(LOG_DEBUG, msg, ##args);	\
+} while (0)
+
+#define info(msg, args...)				\
+do {							\
+	if (do_verbose || do_debug)			\
+		safe_logger(LOG_INFO, msg, ##args);	\
+} while (0)
+
+#define notice(msg, args...)				\
+do {							\
+	if (do_verbose || do_debug)			\
+		safe_logger(LOG_NOTICE, msg, ##args);	\
+} while (0)
+
+#define warn(msg, args...)				\
+do {							\
+	if (do_verbose || do_debug)			\
+		safe_logger(LOG_WARNING, msg, ##args);	\
+} while (0)
+
+#define error(msg, args...)				\
+do {							\
+	safe_logger(LOG_ERR, msg, ##args);		\
+} while (0)
+
+#define crit(msg, args...)				\
+do {							\
+	safe_logger(LOG_CRIT, msg, ##args);		\
+} while (0)
+
+#define alert(msg, args...)				\
+do {							\
+	safe_logger(LOG_ALERT, msg, ##args);		\
+} while (0)
+
+#define emerg(msg, args...)				\
+do {							\
+	safe_logger(LOG_EMERG, msg, ##args);		\
+} while (0)

  #endif

diff -Nurp autofs-4.1.4.orig/lib/Makefile autofs-4.1.4/lib/Makefile
--- autofs-4.1.4.orig/lib/Makefile	2005-01-09 17:16:43.000000000 +0800
+++ autofs-4.1.4/lib/Makefile	2005-04-17 15:41:54.000000000 +0800
@@ -9,10 +9,12 @@ include ../Makefile.rules
  RPCGEN = /usr/bin/rpcgen
  RANLIB = /usr/bin/ranlib

-SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c
+SRCS = cache.c listmount.c cat_path.c rpc_subs.c mounts.c lock.c \
+	safe_logger.c vsprintf.c
  RPCS = mount.h mount_clnt.c mount_xdr.c
  OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o \
-	cat_path.o rpc_subs.o mounts.o lock.o
+	cat_path.o rpc_subs.o mounts.o lock.o \
+	safe_logger.o vsprintf.o

  LIB = autofs.a

diff -Nurp autofs-4.1.4.orig/lib/safe_logger.c autofs-4.1.4/lib/safe_logger.c
--- autofs-4.1.4.orig/lib/safe_logger.c	1970-01-01 08:00:00.000000000 +0800
+++ autofs-4.1.4/lib/safe_logger.c	2005-04-17 21:22:52.000000000 +0800
@@ -0,0 +1,116 @@
+#ident "$Id$"
+/* ----------------------------------------------------------------------- *
+ * 
+ *  safe_logger.c - module to provide signal safe syslog
+ *
+ *   Copyright 2005 Jeff Moyer <jmoyer@redhat.com> - All Rights Reserved
+ *   Copyright 2005 Ian Kent <raven@themaw.net> - All Rights Reserved
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,
+ *   USA; either version 2 of the License, or (at your option) any later
+ *   version; incorporated herein by reference.
+ *
+ * ----------------------------------------------------------------------- */
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+
+int do_verbose = 0;		/* Verbose feedback option */
+int do_debug = 0;		/* Enable full debug output */
+
+#define LOGQUEUE_LINE_LEN 256
+#define LOGQUEUE_MAX      256
+
+struct log_queue {
+	int  pri;
+	char buf[LOGQUEUE_LINE_LEN];
+};
+static struct log_queue logbuf[LOGQUEUE_MAX + 1];
+static int ringlen = 0;
+
+volatile int in_interrupt = 0;	/* keeps us from logging in a signal handler */
+
+extern int vsnprintf_int(char *buf, size_t size, const char *fmt, va_list args);
+
+static void block_signals(sigset_t *set)
+{
+	sigset_t allsigs;
+
+	sigfillset(&allsigs);
+	sigprocmask(SIG_BLOCK, &allsigs, set);
+}
+
+static void unblock_signals(sigset_t *set)
+{
+	sigprocmask(SIG_SETMASK, set, NULL);
+}
+
+static void flush_log(void)
+{
+	int i;
+
+	for (i = 0; i < ringlen; i++)
+		syslog(logbuf[i].pri, logbuf[i].buf);
+	ringlen = 0;
+}
+
+static void queue_syslog(int priority, const char *format, va_list args)
+{
+	struct log_queue *rp;
+	int written;
+	sigset_t set;
+
+	block_signals(&set);
+	if (ringlen >= LOGQUEUE_MAX) {
+		/* At least attempt to give some info */
+		ringlen = LOGQUEUE_MAX;
+		flush_log();
+		/* Last gasp message */
+		syslog(LOG_EMERG, "fatal: logbuffer overflow"); 
+		unblock_signals(&set);
+#ifdef DEBUG
+		/*
+		 * We want to know if we are exceeding the max number of
+		 * log entrise.
+		 */
+		*(void *)0 = 0;
+#else
+		 return;
+#endif
+	}
+	rp = &logbuf[ringlen];
+	ringlen++;
+	unblock_signals(&set);
+
+	rp->pri = priority;
+	written = vsnprintf_int(rp->buf, LOGQUEUE_LINE_LEN, format, args);
+	if (written >= LOGQUEUE_LINE_LEN)
+		rp->buf[LOGQUEUE_LINE_LEN - 1] = '\0';
+	else
+		rp->buf[written] = '\0';
+}
+
+void safe_logger(int priority, const char *format, ...)
+{
+	va_list args;
+	sigset_t set;
+
+	va_start(args, format);
+	if (in_interrupt)
+		queue_syslog(priority, format, args);
+	else {
+		block_signals(&set);
+		flush_log();
+		vsyslog(priority, format, args);
+		unblock_signals(&set);
+	}
+	va_end(args);
+}
+
diff -Nurp autofs-4.1.4.orig/lib/vsprintf.c autofs-4.1.4/lib/vsprintf.c
--- autofs-4.1.4.orig/lib/vsprintf.c	1970-01-01 08:00:00.000000000 +0800
+++ autofs-4.1.4/lib/vsprintf.c	2005-04-17 13:01:12.000000000 +0800
@@ -0,0 +1,594 @@
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
