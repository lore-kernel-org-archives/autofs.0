From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] fix e2fsck error code check
Date: Wed, 17 May 2006 18:06:58 -0400
Message-ID: <x494pzol30d.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@linux.kernel.org>

Hi, Ian,

The patch is pretty self-explanatory.  Comments are welcome, as always.

-Jeff

--- autofs-4.1.3/modules/mount_ext2.c.orig	2006-05-17 17:57:19.000000000 -0400
+++ autofs-4.1.3/modules/mount_ext2.c	2006-05-17 18:00:56.000000000 -0400
@@ -98,7 +98,13 @@ int mount_mount(const char *root, const 
 		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-p", what, NULL);
 	}
 
-	if (err & ~6) {
+	/*
+	 * spawnl returns the error code, left shifted by 8 bits.  We are
+	 * interested in the following error bits from the fsck program:
+	 *    2 - File system errors corrected, system should be rebooted
+	 *    4 - File system errors left uncorrected
+	 */
+	if ((err >> 8) & 6) {
 		error(MODPREFIX "%s: filesystem needs repair, won't mount",
 		      what);
 		return 1;
