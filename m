From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] mount_ext2 forgets MOUNTED_LOCK in spawnl
Date: Tue, 20 Apr 2004 10:46:21 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16517.14269.189595.323548@segfault.boston.redhat.com>
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

Hi Ian,

Seems you missed an option to spawnl for the ext2 fsck call.  Nils Philipp
found (and fixed) this bug while trying to automount filesystems on loop
devices.

-Jeff

--- autofs-4.1.2/modules/mount_ext2.c.ext2	2004-01-29 17:01:22.000000000 +0100
+++ autofs-4.1.2/modules/mount_ext2.c	2004-04-20 14:57:00.524935974 +0200
@@ -87,10 +87,10 @@
 #endif
 	if (ro) {
 		debug(MODPREFIX "calling %s -n %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-n", what, NULL);
+		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-n", what, NULL);
 	} else {
 		debug(MODPREFIX "calling %s -p %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-p", what, NULL);
+		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-p", what, NULL);
 	}
 
 	if (err & ~6) {
