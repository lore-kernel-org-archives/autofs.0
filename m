From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Re: [patch, rfc] fix hung automounter issues
Date: Mon, 18 Apr 2005 19:55:02 -0400
Message-ID: <16996.18646.775008.395575@segfault.boston.redhat.com>
References: <16990.26693.814813.479017@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504182108230.14946@donald.themaw.net>
	<Pine.LNX.4.62.0504182136110.14946@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504182136110.14946@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>, Dan.Berrange@ubs.com

==> Regarding Re: [autofs] Re: [patch, rfc] fix hung automounter issues; raven@themaw.net adds:

raven> On Mon, 18 Apr 2005 raven@themaw.net wrote:

raven> Hang on, I think I've got a problem with white space and my mailer.

raven> If you have problems with the patch in the previous mail try this one 
raven> instead (maybe just use this one).

Okay, I've reviewed all parts except for the actual logging functions.  I'm
actually not convinced this is the right approach.  The overhead of setting
up and tearing down the signal mask is quite expensive.  I fear that
environments with a great number of mounts will fall over when debugging is
turned on, and that is the very thing we are trying to save.  Perhaps it is
worth another look at a separate logging process.

Having said that, the rest of your patch is still relevant.  I've spent a
good deal of time looking it over, and here are my comments.

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

Doesn't need to be volatile, so far as I can tell.  Also note that we need
to be careful to reset in_interrupt if we ever fork() from a signal
handler.


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

This would be okay, except that the AUTOFS_IOC_ASKUMOUNT won't always
be run at shutdown.  See below.


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

I think we should set state to ST_READY here.  That would make things a bit
more clear.

+	while (ap.state != ST_SHUTDOWN) {
+		switch (ap.state) {
+		case ST_READMAP:
+			st_readmap();

No check of return value?

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

Hmm, this is simply not safe, we can lose signals.  You really need to
either block signals and implement a queue, or use a pipe like we do with
indirect maps.

@@ -1644,8 +1674,23 @@ int handle_mounts(char *path)
  		kill(my_pid, SIGSTOP);

  	while (ap.state != ST_SHUTDOWN) {
-		if (handle_packet() && errno != EINTR)
-			break;
+		if (handle_packet() && errno != EINTR) {

The checking of errno here is completely bogus.  You can simply get rid of
it, I think.  (this is what I was referring to above, about the ioctl not
always being run).

+			int ret, status = 0;
+
+			ret = ioctl(ap.ioctlfd, AUTOFS_IOC_ASKUMOUNT, &status);
+			/* 
+			 * If the ioctl fails assume the kernel doesn't have
+			 * AUTOFS_IOC_ASKUMOUNT and just continue.
+			 */
+			if (!ret && status)
+				break;

Consider handling EINTR for the ioctl call.

+
+			/* Failed shutdown returns to ready */
+			warn("can't shutdown: filesystem %s still busy",
+				     ap.path);
+			ap.state = ST_READY;

I think we should be blocking signals when modifying ap.state.

+			alarm(ap.exp_runfreq);
+		}
  	}

  	/* Mop up remaining kids */


Okay, random tangent:

static void sig_statemachine(int sig)
{
	int save_errno = errno;
	enum states next = ap.state;

	in_interrupt++;
	switch (sig) {
	default:		/* all the "can't happen" signals */
		error("process %d got unexpected signal %d!", getpid(), sig);
		break;
		/* don't FALLTHROUGH */
	...
	}

	debug("sig %d switching from %d to %d", sig, ap.state, next);

	errno = save_errno;
	in_interrupt--;
}

So, for sigsegv, sigbus, sigfpe, etc, we are simply trying to continue?
That doesn't seem right to me, and the comment in setup_signals agrees:

#ifndef DEBUG
	/* When debugging, these signals should be in the default state; when
	   in production, we want to at least attempt to catch them and shut down. */

Also note this from the sigaction man page:
       According to POSIX, the behaviour of a process is  undefined  after  it
       ignores  a  SIGFPE, SIGILL, or SIGSEGV signal that was not generated by
       the kill() or the raise() functions.   Integer  division  by  zero  has
       undefined result.  On some architectures it will generate a SIGFPE sig-
       nal.  (Also dividing the most  negative  integer  by  -1  may  generate
       SIGFPE.)  Ignoring this signal might lead to an endless loop.

Anyway, something to fix for later, I guess.


diff -Nurp autofs-4.1.4.orig/include/automount.h autofs-4.1.4/include/automount.h
--- autofs-4.1.4.orig/include/automount.h	2005-01-26 21:03:02.000000000 +0800
+++ autofs-4.1.4/include/automount.h	2005-04-17 21:07:27.000000000 +0800
@@ -109,7 +109,7 @@ struct autofs_point {
  	volatile pid_t exp_process;		/* Process that is currently expiring */
  	volatile struct pending_mount *mounts;	/* Pending mount queue */
  	struct lookup_mod *lookup;		/* Lookup module */
-	enum states state;
+	volatile enum states state;

Again, why the volatile?  Are you worried that the compiler is going to
optimize out some code?  We certainly don't have issues with multiple
threads accessing the data...

-Jeff
