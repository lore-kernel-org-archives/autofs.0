From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs-4.1.1 patch] free of ap.path happens too early in cleanup
Date: Tue, 16 Mar 2004 16:43:38 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16471.29962.851785.48804@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

ap.path gets free-d before we are done with it.  Specifically, callers of
umount_autofs often-times reference ap.path when next calling
cleanup_exit.  This patch moves the free-ing of ap.path to cleanup_exit.
Comments welcome.

-Jeff


--- autofs-4.1.1/daemon/automount.c.orig	2004-03-07 07:17:54.000000000 -0500
+++ autofs-4.1.1/daemon/automount.c	2004-03-16 16:27:49.000000000 -0500
@@ -364,8 +364,6 @@ static int do_umount_autofs(void)
 			rm_unwanted(ap.path, 1, 1);
 	}
 
-	free(ap.path);
-
 	return rv;
 }
 
@@ -1327,6 +1325,8 @@ static void cleanup_exit(const char *pat
 		if (rmdir(path) == -1)
 			warn("failed to remove dir %s: %m", path);
 
+	free(ap.path);
+
 	exit(exit_code);
 }
