From: Richard Zidlicky <rz@linux-m68k.org>
Subject: [patch] ext2 (auto)fsck
Date: Sun, 21 Dec 2003 23:54:58 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031221225457.GA14777@linux-m68k.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

I came across this, doesnt look like the intended behaviour:

--- autofs-3.1.7/modules/mount_ext2.c.rz	Sun Dec 21 23:33:44 2003
+++ autofs-3.1.7/modules/mount_ext2.c	Sun Dec 21 23:34:51 2003
@@ -58,7 +58,7 @@
 
   syslog(LOG_DEBUG, MODPREFIX "calling fsck.ext2 -p %s", what);
   err = spawnl(LOG_DEBUG, PATH_E2FSCK, PATH_E2FSCK, "-p", what, NULL);
-  if ( err & ~7 ) {
+  if ( err & 7 ) {
     syslog(LOG_ERR, MODPREFIX "%s: filesystem needs repair, won't mount",
 	   what);
     return 1;

Actually it may be better to simply err out on any fsck error
and not try to interpret e2fsck error codes?

Richard
