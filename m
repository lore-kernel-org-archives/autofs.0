From: raven@themaw.net
Subject: [ANNOUNCE] autofs 4.1.3 another bug fix release + kernel module
 update
Date: Wed, 19 May 2004 21:39:29 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405192132160.15255@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

It's release time.

Things have settled down and it's seems like a good time to put together a 
release. I know there are a few things outstanding but I'd like to start 
that work from what seems to be a fairly stable base.

autofs
======

As usual the package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4

It is autofs-4.1.3.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-4.1.3.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-4.1.3.tar.gz

Changes (taken from the CHANGELOG):

- fixed bug processing --verbose option in init scripts.
- added missing parameter in call to run fsck on ext2 module (Jeff Moyer).
- added check for executable existance in getldapmounts in init script.
- updated comment about option handling in getmounts in init script.
- updated kernel module patches.
- fix to init script for reload option (Michael Blandford).
- autofs now requires autoconf later than 2.5.
- replicated server fixup.
- fix segv in NIS lookup module (Jeff Moyer).
- init script fix for Debian (Thorild Selen).
- fix pie option not checking for runable executable.
- add NFS V3 and TCP to rpc discovery.
- make nonstrict the default for multi-mount map entries.


Kernel module build kit
======================

The kernel module build kit for kernel 2.4 is back. There is one
requirement. If you wish to use it there is a mandatory patch that
must be aplied to the kernel and a recomile done for it to work.
On the other hand it only needs be applied once. Subsequent updates
can then be done without recompiling your kernel. The patches in the
module-patches directory do not have this patch. If you are using the
kit and you wish to patch the kernel source tree both patches in the
kernel-patches and the patch in the module-pathes directories are
required.

NOTE: The kernel module WILL NOT WORK unless, at least, the mandatory
      patch that lives in the kernel-patches and the approiate patch
      from module-pathes directory are applied.

The kernel module build kit is:

autofs4-2.4-module-20040508.tar.[gz|bz2]


Kernel patches
==============

These kernel module patches include the mandatory patch
mentioned above and the optional doco patch from the module
build kit.

The latest kernel patches are:

autofs4-2.4.18-20040508.patch
  current autofs4 patch for kernel 2.4.18 and below.

autofs4-2.4.20-20040508.patch
  current autofs4 patch for kernel 2.4.19 through 2.4.21

autofs4-2.4.20-redhat9-20040508.patch
  current autofs4 patch for RedHat 9 kernel 2.4.20 series.

autofs4-2.4.22-20040508.patch
  current autofs4 patch for kernel 2.4.22 and above.

autofs4-2.4.22-fc1-20040508.patch
  current autofs4 patch for Fedora 1 kernels. If there
  are problems with earlier kernel versions please let
  me know.

autofs4-2.6.0-20040508.patch
  current autofs4 patch for vanila kernels 2.4.0 through
  2.6.3.

autofs4-2.6.4-20040508.patch
  current autofs4 patch for vanila kernels 2.4.4 and
  above. If there are problems with later kernels let
  me know.

I'm hoping that these updates will make it into the mainline kernel
soon. They have been in  the mm tree for a while now and have been
passed on to Linus by Andrew Morten the other day.

Ian
