From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 4.1.2 another bug fix release + kernel module
 update
Date: Wed, 7 Apr 2004 22:45:26 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404072228530.4973@raven.themaw.net>
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


autofs
======

As usual the package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4

It is autofs-4.1.2.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-4.1.2.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-4.1.1.tar.gz

Changes (taken from the CHANGELOG):

- merge patches from Jeff Moyer.
   - Change (back) compile option -fpic -> -fPIC.
   - add code to recognise old LDAP master map format.
   - document limitation of direct mounts obscuring mount
     points in README.direct.
   - fix error in detecting duplicate master map entries
     in init script.
   - add check for automount base already mounted.
   - check for pie support and enable compile option if
     available.
   - corrections to init script including send HUP signal
     on reload.
- fix unchecked return from get_best_mount.
- add example file master map using LDAP.
- 1st attempt to deal with smb mounts that go away while
  mounted.
- updated kernel patches.

Kernel patches
==============

Unfortuneately the kernel module build kit is no more. Sorry to
those that don't feel comfortable building kernels but it
couldn't be avoided. The kernel changes needed for autofs can
no longer be contained entirely within the autofs4 module due
to a recent bug fix. So a kernel build must be done for proper
operation.

The patches are:

autofs4-2.4.18-20040404.patch
  current autofs4 patch for kernel 2.4.18 and below.

autofs4-2.4.20-20040404.patch
  current autofs4 patch for kernel 2.4.19 through 2.4.21

autofs4-2.4.20-27.9-20040404.patch
  current autofs4 patch for RedHat kernel 2.4.20 series.
  As far as I can tell this RedHat kernel series has a
  patch which changes the task structure which is not
  present in other RedHat kernels. If you get compile
  errors in waitq.c try the other 2.4.20 patch.

autofs4-2.4.22-20040404.patch
  current autofs4 patch for kernel 2.4.22 and above.

autofs4-2.4.22-1.2174.nptl-20040404.patch
  current autofs4 patch for Fedora 1 kernels. If there
  are problems with earlier kernel versions please let
  me know.

Ian
