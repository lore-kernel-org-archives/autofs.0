From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 4.1.1 mostly bug fix release
Date: Sun, 14 Mar 2004 20:55:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403142049180.6039@raven.themaw.net>
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

As usual the package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4

It is:

autofs-4.1.1.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-4.1.1.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-4.1.1.tar.gz

Changes (taken from the CHANGELOG):

- added CHANGELOG.
- fixed error in some ident tags.
- merge debian patch 032 document nonstrict special option.
- updated spec file to standardise paths etc.
- reintroduced some 4.0.0 init script code to help serialise
  shutdown signaling and umount of submounts. This should
  alieviate some of the contention for umount at shutdown.
- fix invalid path reference on error exit.
- merged debian patches.
   - 030 man page corrections in autofs(5) and automount(8).
   - 033 correct url in man page automount(8).
   - 034 correct mount call in mount_changer.c.
   - 040 document gid option in man page autofs(5).
- change fsck return code check.
   - still try to mount if fsck fails to run.
   - error only if fsck finds uncorrectable errors.
- fixed lookup problem with wildcard order in map.
- fixed lookup problem relating to directory tidyup.
- merge Jim Carters' buffer management and expire limit patch.
- remove make requirement for hesoid and ldap presence.
- add check for submount point itself busy.
   - requires autofs4 4.04 kernel module.
- added --verbose and --debug options to quieten daemon and
  provide ability to get debug output when needed. Default
  is produce no output except error messages.
- merge Mike Blandfords' replicated server patches.
- added ability to access external environment var.
   - set by default, use --disable-ext-env to turn of.
