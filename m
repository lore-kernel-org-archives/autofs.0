From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.1 rc1 release candidate
Date: Thu, 13 Jul 2006 16:36:37 +0800
Message-ID: <200607130836.k6D8abN7022238@raven.themaw.net>
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

There has been a change in the version labeling because of bad
naming on my part. It would have caused conflicts for those that
use rpms built from the included spec file. In order to have the
built rpms upgrade smoothly the version number has been changed
to 5.0.1. But as I would like to consolidate as many corrections
into the final relaese as I can I've decided to also mark this
as a release candidate rather than a final release. A lot of
fixes have been made but I'm sure there are more we can find.

Please find a little time to check this out.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.1i-rc1.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.1-rc1.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.1-rc1.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

13/7/2006 autofs-5.0.1 rc1
--------------------------
- merge LDAP authentication update for GSSAPI (Jeff Moyer).
- update default auth config to add options documenetation (Jeff Moyer).
- workaround segfaults at exit after using GSSAPI library.
- fix not checking return in init_ldap_connection (Jeff Moyer).
- correct test for existence of auth config file.
- correct shutdown log message print.
- correct auth init test when no credentials required.
- correct auto.net installed as auto.smb.
- update LDAP auth - add autodectect option.
- correct test for libhesiod.
- correct directory cleanup in mount modules.
- merge key and wildcard LDAP query for lookups.
- add cacheing of negative lookups to reduce unneeded map lookups.
- version number change to allow update from beta for rpm packages.

Ian

