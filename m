From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: autofs {3, 4,
	5} and bind mounts which point to other automount points
Date: Thu, 24 Aug 2006 15:44:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
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
To: autofs@linux.kernel.org

Hi,

We like to preconfigure an number of our (1000ish) users' applications. 
Typically, this might necessitate hard-coding their home directories in 
dot-files, so we specify their home directory in the passwd map as 
/homes/$LOGNAME, and make this an (LDAP) automount map which might point 
to ":/server/{servername}/{volumename}/$LOGNAME" (via a bind mount), where 
/server/{servername}/{volumename} would be the "real" NFS mount.

This allows us to move the physical location of any user's home directory 
without upsetting their application settings. (Some applications seem to 
prefer using full paths.)

Our scheme all worked fine in autofs 3.

In autofs 4, it worked but with a 10 or 15s delay which we got around via 
the following patch:

--- modules/mount_bind.c.orig   2004-10-29 14:46:11.000000000 +0100
+++ modules/mount_bind.c        2004-11-01 12:49:54.000000000 +0000
@@ -126,7 +126,10 @@
                 }

                 debug(MODPREFIX "calling mount --bind %s %s", what, fullpath);
-
+/* 'what' may itself be on an automounted file system so we need to access it */
+/* to ensure it gets mounted before calling wait_for_lock() inorder to avoid a*/
+/* long delay */
+               (void)access(what,F_OK);
                 wait_for_lock();
                 err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
                              PATH_MOUNT, PATH_MOUNT, "--bind",


In autofs 5, it doesn't work at all, claiming no hostname was supplied. Is 
there any way we can achieve what we want? I can't find any documentation.

Matt
