From: Ian Kent <ikent@redhat.com>
Subject: [ANNOUNCE] autofs 5.0.2 release
Date: Mon, 18 Jun 2007 18:58:45 +0800
Message-ID: <1182164325.16346.29.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hi all,

This is the first bug fix release following the initial release of
version 5. There are many bug fixes. Two critical ones are updated
kernel patches for kernels prior to 2.6.21, that fix a race between
mount and expire operations and a fix for the daemon to resolve a
possible deadlock in the alarm handler. Also of note are corrections
to wildcard entry handling, checks for out of date maps and their
re-reading and the addition of support for "ldaps:" as a map source.

See below for more information.

Known issues
============

Quoted strings in the master map are not yet handled.
This has been delayed again, hopefully I'll be able to fix this in
the next release.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.2.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.2.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.2.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

18/06/2007 autofs-5.0.2
-----------------------
- fix return check for getpwuid_r and getgrgid_r.
- give up trying to update exports list while host is mounted.
- fix to "@network" matching.
- check for fstab update and retry if not updated.
- change file map lexer to allow white-space only blank lines.
- remove macro substitution in automount.8 man page (Guillaume Rousse).
- correct hesiod library check in configure (Guillaume Rousse).
- drop "DEFAULT_" prefix from configuration names (Guillaume Rousse).
- remove redundant ident macros.
- various configure cleanups (Richard Daniel).
- various code cleanups (Richard Daniel).
- fixed numeric export match.
- add option to select replicated server at random (instead of
  response time).
- fix incorrect cast in directory cleanup routines.
- fix directory creation for browse mounts.
- fix wildcard map handling and improve nsswitch source map re-reading.
- fix "null" domain netgroup match for "-hosts" map.
- update kernel patches.
- add configuration variable to control appending of global options.
- add command option to set a global mount options string.
- add check for labeled local filesystems (Matthias Koenig).
- disable exports check for "-hosts" map.
- fix memory allocation problem with global options patch.
- fix master map lexer to admit "." in macro values (Mike Matera).
- make ldap attribute match case insensitive.
- add missed man page update for APPEND_OPTIONS config option.
- add ldaps protocol support.
  - note: it's no longer possible to multiple hosts in an ldap map spec.
  - note: if this is needed use only the map name and configure the URI
    entry in the ldap client configuration.
- correct mistake in logic test in wildcard lookup.
- fix deadlock in alarm manager module.
- allow for older schemas that allow "*" as a key value.
- update master map lexer to also allow "." in macro name.
- allow for "#" and "@" in hostname validation for sshfs mounts.
- set working directory to base of mount before invoking program map.
- simplify alarm_handler function (Anders Blomdell).

Ian


