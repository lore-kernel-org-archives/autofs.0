From: Mike Fleetwood <mike@rockover.demon.co.uk>
Subject: Tiny patch enabling autofs mounting of ncpfs
Date: Mon, 9 Aug 2004 19:21:58 +0100 (BST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0408091916590.24976-100000@rockover.demon.co.uk>
References: <D1596EFFBEFCDA40AFA41442A3E9384395817A@clinmail1.clinphone.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <D1596EFFBEFCDA40AFA41442A3E9384395817A@clinmail1.clinphone.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs list <autofs@linux.kernel.org>

Hi all,

Below is a very small fix to autofs to mount ncpfs.  It just removes 
the exclusion preventing mount_generic from being used to mount ncpfs.

This fix worked for me on Suse 9.1 with kernel 2.6.5 and ncpfs 2.2.4 for 
both autofs 3.1.7 and 4.0.0.  I suspect it will work almost anywhere 
provided that all the required ncpfs mount options can be passed as -o 
options to /bin/mount.  ncpmount(8) is very informative in this respect.

Patch:
----8<--------8<----
diff -urN autofs-4.0.0.orig/daemon/mount.c autofs-4.0.0/daemon/mount.c
--- autofs-4.0.0.orig/daemon/mount.c    2003-09-10 15:27:41.000000000 +0100
+++ autofs-4.0.0/daemon/mount.c 2004-08-05 10:36:51.813852608 +0100
@@ -26,7 +26,7 @@

 /* These filesystems are known not to work with the "generic" module */
 /* Note: starting with Samba 2.0.6, smbfs is handled generically.    */
-static char *not_generic[] = { "nfs", "ncpfs", "userfs", "afs",
+static char *not_generic[] = { "nfs", "userfs", "afs",
                               "autofs", "changer", "bind", NULL };

 int do_mount(const char *root, const char *name, int name_len,
----8<--------8<----

Searching this list's archive and googling found nothing useful so I am 
including extra hints of how I worked out how to configure automounting of 
ncpfs.  (The ncpfs options you require will very likely be different to 
those shown here.  See ncpmount(8) for the possible options).

1) Get cmd line mounting working using ncpmount working first:
      ncpmount -S novellservername -U username -A dnsname -V volname /mnt
         (Enter Novell password for username when prompted)
      umount /mnt

2) Switch to using /bin/mount with -o options:
      mount -t ncpfs -o ipserver=dnsname,volume=volname,passwd=XXXXXX \
         novellservername/username /mnt
      umount /mnt
   (Note that there are other ways of supplying a password to ncpmount
   besides specifying it on the cmd line).

3) Use /etc/fstab entry to provide all the options to mount.
   Add /etc/fstab entry like:
      # Device                    Mount Dir   FS Type   Options                                         FSCK   Dump
      novellservername/username   /mnt        ncpfs     ipserver=dnsname,volume=volname,passwd=XXXXXX   0      0

      mount /mnt
      umount /mnt

4) Switch to using autofs.  Add /etc/auto.master entry:
      # Mount Dir   Map File
      /novell       /etc/auto.ncpfs

   Create /etc/auto.ncpfs as:
      # Key   -Options                                                      Location
      dir     -fstype=ncpfs,ipserver=dnsname,volume=volname,passwd=XXXXXX   :novellservername/username

   ls /novell/dir


All the best,
Mike
-- 
 __  __ _ _     ___    ____ _    ___  ___  _           ___  ___    _
|  \/  (_| | _ / _ \  | ___| |  / _ \/ _ \| |_ _  _  _/   \/   \ _| |
| |\/| | | |/ |  ___| | _| | |_|  __|  ___| __| \/ \/|  O |  O  / _ |
|_|  |_|_|_|\_\\___|  |_|  |____\___|\___||____\_/^\_/\___/\___/\___|
