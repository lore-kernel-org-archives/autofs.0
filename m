From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs-4.1 slow to mount
Date: Thu, 13 May 2004 10:30:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16547.34453.14284.235161@segfault.boston.redhat.com>
References: <200405101900.i4AJ09pH031586@hera.kernel.org>
	<40A0CC37.3080003@gxt.com>
	<Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405130639030.16060@www.wm7d.net>
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
To: Joseph Mack NA3T <jmack@wm7d.net>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] autofs-4.1 slow to mount; Joseph Mack NA3T <jmack@wm7d.net> adds:

jmack> Linux-2.4.26, autofs4 as module, libc-2.3.2 mounting zip disk by
jmack> autofs

jmack> with automount-4.0.0pre10, the disk mounts in 1sec

jmack> (interval between "attempting to mount entry /removable/zip" and
jmack> "kernel: kjournald starting. Commit interval 5 seconds" messages)

jmack> with automount-4.1.2 the same interval is 11 secs.

Not sure what the issue here is.  Trying with my latest rpm would provide a
useful data point.  See below.

jmack> on another similar machine, automount-4.1.2 won't mount the zip
jmack> disk, giving "e2fsck: need terminal for interactive repairs".
jmack> Running fsck from the command line shows a clean zip disk.
jmack> automount-4.0.0pre10 mounts zip disk OK.

Hmm.  This second issue sounds like the spawnl issue discovered a little
while back.  Could you try the autofs package from my people page:

      http://people.redhat.com/~jmoyer/

Or, you could try the attached patch.

Thanks!

Jeff

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
