From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.1 rc2 release candidate
Date: Fri, 1 Sep 2006 15:37:27 +0800
Message-ID: <200609010737.k817bRFX001809@raven.themaw.net>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hi all,

Time to consolidate again.

I've decided to consolidate before working on further code cleanups
as there have been a lot of changes and a couple of kernel module
updates.

Known issues
============

There is a problem that's proving really hard to track down. It results
in a "not found" error when a mount and an expire is happening at the
same time for a given mount. Needless to say it's also quite hard to make
it happen and even harder to get any info at all about what's causing it
as introducing debug print statements seems to make it to go away.

Recursively referenced bind mounts weren't working so I've attempted to
fix it. I'm unable to break the fix myself but Matt Bernstein reports
that it works only on some clients. I hope that getting wider exposure
for this will shake out the problem.

Please find a little time to check this out.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.1-rc2.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.1-rc2.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.1-rc2.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

1/9/2006 autofs-5.0.1 rc2
--------------------------
- code cleanup.
- fix race for current map source.
- cthon map parser corrections.
- cthon multi-map locking fix and current race corrections.
- cthon shutdown expire fix.
- cthon more map parser corrections.
- cthon cleanup and corrections.
- cthon more cleanup and corrections.
- cthon correction to host validation.
- cthon fix submount operation broken by above.
- cthon more parser corrections and attempt to fix multi-mounts
  with various combinations of submounts (still broken).
- cthon fix expire of various forms of nested mounts.
- cthon fix some shutdown races.
- cthon corrections for above patch and fix shutdown expire.
- cthon fix expire of wildcard and program mounts broken by above patches.
- tidy up directory cleanup and add validation check to rmdir_path.
- remove SIGCHLD handler.
- alter expire locking of multi-mounts to lock sub-tree instead of
  entire tree.
- review verbose message feedback and update.
- correction for expire of multi-mounts.
- spelling corrections to release notes (Jeff Moyer).
- expire individual submounts.
- add ino_index locking.
- fix nested submount expiring away when pwd is base of submount.
- more expire re-work to cope better with shutdown following cthon tests.
- allow hostname to start with numeric when validating.
- fix included map lookup.
- fix directory cleanup on expire.
- fix task cancelation at shutdown.
- fix included map wild card key lookup.
- fix task cancelation at shutdown (more).
- fix concurrent mount and expire race with nested submounts.
- fix colon escape handling.
- fix recusively referenced bind automounts.
- update kernel patches.

Ian

