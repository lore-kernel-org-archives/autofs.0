From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH] 5.0.0_beta1: use PATH in execXX()
Date: Wed, 26 Sep 2007 11:00:54 +0100
Message-ID: <200709261100.54397.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W3i+GU9hUHNJHMj"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--Boundary-00=_W3i+GU9hUHNJHMj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ian,

I want automount to use PATH when it tries to run e.g. "mount",
because I want it to work regardless where my mount binary is
(/bin or /usr/bin or...). I do have different system with different
paths to some binaries, and it is pain in the ass - I have
no way to explain to automount binary that it needs to look
in another directory.

I am trying to make automount using 'short' names it by passing
variables to configure:

MOUNT="mount" \
UMOUNT="umount" \
E2FSCK="fsck.ext2" \
E3FSCK="fsck.ext3" \
./configure ............

I think it's reasonably safe since automount is started by root
and root is expected to set PATH sanely.

And it still doesn't work, because you are using execv(), not execvp().

This patch replaces execv() with execvp().

It should change nothing for 'normally' configured automount since
it passes fully qualified names ("/bin/mount") to exec and PATH
is not used in this case.

Please consider applying.
--
vda

--Boundary-00=_W3i+GU9hUHNJHMj
Content-Type: text/x-diff; charset="us-ascii";
	name="autofs-5.0.0_beta1-PATH.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs-5.0.0_beta1-PATH.patch"

diff -d -urpN autofs-5.0.0_beta1-stderr/daemon/spawn.c autofs-5.0.0_beta1-PATH/daemon/spawn.c
--- autofs-5.0.0_beta1-stderr/daemon/spawn.c	2006-05-02 08:37:35.000000000 +0100
+++ autofs-5.0.0_beta1-PATH/daemon/spawn.c	2007-09-26 10:35:59.000000000 +0100
@@ -291,8 +291,12 @@ static int do_spawn(logger *log, int use
 		dup2(pipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 
-		execv(prog, (char *const *) argv);
-		_exit(255);	/* execv() failed */
+		/* Why execv_p_? Normally argv[0] has fully qualified path
+		 * and it doesn't matter, but it can be overridden
+		 * at build time to e.g. simple "mount".
+		 * Clearly, user wants to use PATH in this case. */
+		execvp(prog, (char *const *) argv);
+		_exit(255);	/* exec() failed */
 	} else {
 		close(pipefd[1]);
 
diff -d -urpN autofs-5.0.0_beta1-stderr/modules/lookup_program.c autofs-5.0.0_beta1-PATH/modules/lookup_program.c
--- autofs-5.0.0_beta1-stderr/modules/lookup_program.c	2006-05-02 08:37:35.000000000 +0100
+++ autofs-5.0.0_beta1-PATH/modules/lookup_program.c	2007-09-26 10:36:24.000000000 +0100
@@ -171,8 +171,12 @@ int lookup_mount(struct autofs_point *ap
 		dup2(epipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 		close(epipefd[1]);
-		execl(ctxt->mapname, ctxt->mapname, name, NULL);
-		_exit(255);	/* execl() failed */
+		/* Why execl_p_? Normally argv[0] has fully qualified path
+		 * and it doesn't matter, but it can be overridden
+		 * at build time to e.g. simple "mount".
+		 * Clearly, user wants to use PATH in this case. */
+		execlp(ctxt->mapname, ctxt->mapname, name, NULL);
+		_exit(255);	/* exec() failed */
 	}
 	close(pipefd[1]);
 	close(epipefd[1]);

--Boundary-00=_W3i+GU9hUHNJHMj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_W3i+GU9hUHNJHMj--

