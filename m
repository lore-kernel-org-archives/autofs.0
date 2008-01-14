From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.3 release
Date: Mon, 14 Jan 2008 14:22:26 +0900
Message-ID: <1200288146.3075.10.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: linux-fsdevel@vger.kernel.org

Hi all,

This release is long overdue and is very much needed to consolidate
the many patches we now have against 5.0.2.

See below for more information.

Known issues
============

- Restarting autofs when there are busy mount (with configure option
  --enable-ignore-busy enabled) doesn't work properly. This is going
  to require implementing an alternate ioctl interface before I can
  start work on this within the daemon. I'm working on that now.

- Quoted strings in the master map are still not yet handled.
  I have spent more time on this but it is still not done.

autofs
======

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.3.tar.[gz|bz2]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.3.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.3.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:

14/01/2008 autofs-5.0.3
-----------------------
- include krb5.h in lookup_ldap.h (some openssl doesn't implicitly include it).
- correct initialization of local var in parse_server_string.
- add missing "multi" map support.
- add multi nsswitch lookup.
- change random multiple server selection option name to be consistent
  with existing downstream version 4 naming.
- fix mount point directory creation for bind mounts.
- add quoting for exports gathered by hosts map.
- fix wait time resolution in alarm and state queue handlers.
- fix handling of quoted slash alone.
- fix parse confusion between attribute and attribute value.
- fix version passed to get_supported_ver_and_cost.
- mark map instances stale so they aren't "cleaned" during updates.
- fix large file compile time option.
- don't fail on empty master map.
- add support for the "%" hack for case insensitive attribute schemas.
- fix "nosymlink" option handling and add desription to man page.
- fix don't fail on empty master map.
- if there's no "automount" entry in nsswitch.conf use "files" source.
- add LDAP schema discovery if no schema is configured.
- add random selection as a master map entry option.
- fix couple of edge case parse fails of timeout option.
- check for "*" when looking up wildcard in LDAP.
- fix LDAP schema discovery.
- add SEARCH_BASE configuration option.
- work around segv at exit due to libxml2 tsd usage.
- re-read config on HUP signal.
- add LDAP_URI, LDAP_TIMEOUT and LDAP_NETWORK_TIMEOUT configuration options.
- fix forground logging and add option to man page.
- remove unjustified, nasty comment about krb5 package.
- fix deadlock in submount mount module.
- fix lack of ferror() checking when reading files.
- fix typo in autofs(5) man page.
- fix map entry expansion when undefined macro is present.
- remove unused export validation code.
- add dynamic logging (adapted from v4 patch from Jeff Moyer).
- fix recursive loopback mounts (Matthias Koenig).
- add map re-load to verbose logging.
- fix handling of LDAP base dns with spaces.
- handle MTAB_NOTUPDATED status return from mount.
- when default master map, auto.master, is used also check for auto_master.
- fix schema selection in LDAP schema discovery.
- update negative mount timeout handling.
- fix large group handling (Ryan Thomas).
- fix for dynamic logging breaking non-sasl build (Guillaume Rousse)
- eliminate NULL proc ping for singleton host or local mounts.
- fix incorrect read/write size of startup status token (Matthias Koenig).
- fix off-by-one error for lookup of map keys exactly 255 characters long.
- improve handling of server not available.
- fix LDAP_URI server selection.
- add authentication option for using an external credential cache.
- expand support for the "%" hack.
- fix to quoting for exports gathered by hosts map.
- use mount option "nosuid" for "-hosts" map unless "suid" is explicily specified.
- second attempt fixing quoting for exports gathered by hosts map.
- quell annoying "cannot open mount module" message.
- fix for improve handling of server not available.
- use mount option "nodev" for "-hosts" map unless "dev" is explicily specified.
- add LDAP paged query handling to deal with query size restrictions (Edward Newman).
- add additional case for "mark map instances stale so they aren't "cleaned" during updates".
- fix race during sub-mount shutdown.
- fix add SEARCH_BASE configuration option.
- update kernel patches.

Ian



