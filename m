From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 1/5] use PATH
Date: Fri, 11 Feb 2005 11:59:50 +0200
Message-ID: <200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WIIDCpSmcyHzcUt"
In-Reply-To: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
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


--Boundary-00=_WIIDCpSmcyHzcUt
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Use exec*p() so that root can use PATH to direct automount
to desired mount binary and the like

This time, even with patch attached :)
--
vda

--Boundary-00=_WIIDCpSmcyHzcUt
Content-Type: text/x-diff;
  charset="koi8-r";
  name="414b1.01.exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="414b1.01.exec.patch"

diff -urpN autofs-4.1.4_beta1.orig/daemon/spawn.c autofs-4.1.4_beta1_1/daemon/spawn.c
--- autofs-4.1.4_beta1.orig/daemon/spawn.c	Mon Jan 17 17:22:28 2005
+++ autofs-4.1.4_beta1_1/daemon/spawn.c	Fri Feb 11 10:49:53 2005
@@ -225,8 +225,8 @@ static int do_spawn(int logpri, int use_
 		dup2(pipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 
-		execv(prog, (char *const *) argv);
-		_exit(255);	/* execv() failed */
+		execvp(prog, (char *const *) argv);
+		_exit(255);	/* exec() failed */
 	} else {
 		/* Careful here -- if we enable SIGCHLD yet we may not receive the
 		   waitpid() at the end */
diff -urpN autofs-4.1.4_beta1.orig/modules/lookup_program.c autofs-4.1.4_beta1_1/modules/lookup_program.c
--- autofs-4.1.4_beta1.orig/modules/lookup_program.c	Fri Dec 31 08:30:09 2004
+++ autofs-4.1.4_beta1_1/modules/lookup_program.c	Fri Feb 11 10:49:53 2005
@@ -139,8 +139,8 @@ int lookup_mount(const char *root, const
 		dup2(epipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 		close(epipefd[1]);
-		execl(ctxt->mapname, ctxt->mapname, name, NULL);
-		_exit(255);	/* execl() failed */
+		execlp(ctxt->mapname, ctxt->mapname, name, NULL);
+		_exit(255);	/* exec() failed */
 	}
 	close(pipefd[1]);
 	close(epipefd[1]);
diff -urpN autofs-4.1.4_beta1.orig/modules/mount_autofs.c autofs-4.1.4_beta1_1/modules/mount_autofs.c
--- autofs-4.1.4_beta1.orig/modules/mount_autofs.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4_beta1_1/modules/mount_autofs.c	Fri Feb 11 10:49:53 2005
@@ -159,7 +159,7 @@ int mount_mount(const char *root, const 
 		goto error;
 	} else if (slave == 0) {
 		/* Slave process */
-		execv(PATH_AUTOMOUNT, argv);
+		execvp(PATH_AUTOMOUNT, argv);
 		_exit(255);
 	}
 

--Boundary-00=_WIIDCpSmcyHzcUt
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_WIIDCpSmcyHzcUt--

