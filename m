From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.0 beta2
Date: Tue, 9 May 2006 18:53:00 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605091848390.12829@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi all,

It's time for an updated beta.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.0_beta2.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.0_beta2.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.0_beta2.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

9/5/2006 autofs-5.0.0_beta2
---------------------------
- re-organize functions for direct mount and expire to eliminate
  pthread compile error.
- reap return code from child at startup.
- add check for self inclusion when including maps.
- add plus map inclusion depth limit.
- fix logic to check if map update is needed.
- fix shutdown wait for submounts again (and again ...).
- add check for filesystem autofs in /proc/filesystems in case
  it's complied in the kernel.
- update Gentoo ebuild.
- updated man pages based on feedback from Jeff Moyer.

Ian


