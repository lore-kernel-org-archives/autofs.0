From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] allow the automount daemon to dump core
Date: Fri, 19 Jun 2009 15:06:22 -0400
Message-ID: <x49prd0f3gx.fsf@segfault.boston.devel.redhat.com>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Charlie Wyse <cwyse@redhat.com>

Hi,

Right now, the automount daemon blocks all signals.  We should at least
unblock those that will cause us to dump core.  Otherwise, I think the
behaviour could be, umm, interesting.

I tested this by sending SIGBUS and SIGSEGV to the automount daemon.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/daemon/automount.c b/daemon/automount.c
index 80691fa..04fa304 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1324,6 +1324,10 @@ static void *statemachine(void *arg)
 	sigfillset(&signalset);
 	sigdelset(&signalset, SIGCHLD);
 	sigdelset(&signalset, SIGCONT);
+	sigdelset(&signalset, SIGBUS);
+	sigdelset(&signalset, SIGSEGV);
+	sigdelset(&signalset, SIGILL);
+	sigdelset(&signalset, SIGFPE);
 
 	while (1) {
 		sigwait(&signalset, &sig);
@@ -1817,6 +1821,11 @@ int main(int argc, char *argv[])
 	};
 
 	sigfillset(&allsigs);
+	/* allow for the dropping of core files */
+	sigdelset(&allsigs, SIGBUS);
+	sigdelset(&allsigs, SIGSEGV);
+	sigdelset(&allsigs, SIGILL);
+	sigdelset(&allsigs, SIGFPE);
 	sigprocmask(SIG_BLOCK, &allsigs, NULL);
 
 	program = argv[0];
