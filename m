From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] close open file descriptors in daemonize
Date: Wed, 08 Nov 2006 20:54:41 -0500
Message-ID: <x494pt9peou.fsf@segfault.boston.devel.redhat.com>
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

Our daemonize function should really close open file descriptors that
were leaked to us.  This actually did result in a bug, whereby an "rpm
-Uvh" from an ssh session would leave the user unable to logout.

It's a pretty simple patch.  Comments welcome.

-Jeff

diff --git a/daemon/automount.c b/daemon/automount.c
index 3c42c8a..c09eaf6 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1436,10 +1436,15 @@ static void become_daemon(void)
 	pid_t pid;
 	int nullfd;
 	int pfds[2];
+	int i;
 
 	/* Don't BUSY any directories unnecessarily */
 	chdir("/");
 
+	/* close open file descriptors, stdin/out/err are handled below */
+	for (i = 3; i < 255; i++)
+		close(i);
+
 	/* Detach from foreground process */
 	if (!submount) {
 		if (pipe(pfds) < 0) {
