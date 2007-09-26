From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH] 5.0.0_beta1: uncomment "-f --foreground..." help
	text; comment out unused stuff.
Date: Wed, 26 Sep 2007 10:48:47 +0100
Message-ID: <200709261048.48044.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Asi+GzcorIOA1ER"
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

--Boundary-00=_Asi+GzcorIOA1ER
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ian,

Please apply attached trivial patch. It is run-tested.
--
vda

--Boundary-00=_Asi+GzcorIOA1ER
Content-Type: text/x-diff; charset="us-ascii";
	name="autofs-5.0.0_beta1-fg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs-5.0.0_beta1-fg.patch"

diff -d -urpN autofs-5.0.0_beta1/daemon/automount.c autofs-5.0.0_beta1-fg/daemon/automount.c
--- autofs-5.0.0_beta1/daemon/automount.c	2006-05-02 08:37:35.000000000 +0100
+++ autofs-5.0.0_beta1-fg/daemon/automount.c	2007-09-26 10:27:30.000000000 +0100
@@ -413,6 +413,7 @@ int count_mounts(struct autofs_point *ap
 	return counter.count;
 }
 
+/* UNUSED
 static void check_rm_dirs(struct autofs_point *ap, const char *path, int incl)
 {
 	if ((!ap->ghost) ||
@@ -423,6 +424,7 @@ static void check_rm_dirs(struct autofs_
 	else if (ap->ghost && (ap->type == LKP_INDIRECT))
 		rm_unwanted(path, 0, ap->dev);
 }
+*/
 
 /* umount all filesystems mounted under path.  If incl is true, then
    it also tries to umount path itself */
@@ -717,6 +719,7 @@ static int handle_packet(struct autofs_p
 	return -1;
 }
 
+
 static void become_daemon(unsigned foreground)
 {
 	FILE *pidfp;
@@ -1278,7 +1281,7 @@ static void usage(void)
 		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
 		"	-v --verbose	be verbose\n"
 		"	-d --debug	log debuging info\n"
-		/*"	-f --foreground do not fork into background\n" */
+		"	-f --foreground do not fork into background\n"
 		"	-V --version	print version and exit\n"
 		, program);
 }
diff -d -urpN autofs-5.0.0_beta1/daemon/direct.c autofs-5.0.0_beta1-fg/daemon/direct.c
--- autofs-5.0.0_beta1/daemon/direct.c	2006-05-02 08:37:35.000000000 +0100
+++ autofs-5.0.0_beta1-fg/daemon/direct.c	2007-09-26 10:24:17.000000000 +0100
@@ -213,7 +213,8 @@ int umount_autofs_direct(struct autofs_p
 static int unlink_mount_tree(struct list_head *list, const char *mount)
 {
 	struct list_head *p;
-	int rv, ret, need_umount;
+	int rv, ret;
+/*	int need_umount; */
 	pid_t pgrp = getpgrp();
 	char spgrp[10];
 /*

--Boundary-00=_Asi+GzcorIOA1ER
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_Asi+GzcorIOA1ER--

