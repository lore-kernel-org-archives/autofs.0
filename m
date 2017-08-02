From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/19] Current autofs patch queue
Date: Wed, 02 Aug 2017 10:17:03 +0800
Message-ID: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

This is the current autofs patch queue.

I'm hoping to commit these in the next few days and, because of a couple
of regressions introduced in 5.1.3, I'm keen to release 5.1.4.

Any concerns or comments are welcome.

---

Ian Kent (17):
      autofs-5.1.3 - fix spec file url
      autofs-5.1.3 - fix unset tsd group name handling
      autofs-5.1.3 - remove some redundant rpc library code
      autofs-5.1.3 - add port parameter to rpc_ping()
      autofs-5.1.3 - dont probe NFSv2 by default
      autofs-5.1.3 - add version parameter to rpc_ping()
      autofs-5.1.3 - fix typo in autofs config file comments
      autofs-5.1.3 - fix typos in autofs man pages
      autofs-5.1.3 - fix incorrect status return in get_nfs_info()
      autofs-5.1.3 - fix a couple of compiler warnings
      autofs-5.1.3 - set systemd KillMode to process
      autofs-5.1.3 - fix mount.nfs blocks on first mount
      autofs-5.1.3 - fix some man page problems
      autofs-5.1.3 - add some more debug logging to get_nfs_info()
      autofs-5.1.3 - add some more debug logging to get_supported_ver_and_cost()
      autofs-5.1.3 - fix ipv6 proto option handling
      autofs-5.1.3 - also check flag file exe name

NeilBrown (1):
      autofs-5.1.3 - Add -c option when calling /bin/umount - if supported.

Waldemar Brodkorb (1):
      autofs-5.1.3 - use pkg-config to search for libtirpc to fix cross-compilation


 CHANGELOG                      |   23 ++-
 Makefile.conf.in               |    3 
 Makefile.rules                 |    2 
 aclocal.m4                     |   66 ++-----
 autofs.spec                    |    2 
 configure                      |  362 +++++++++++++++++++++++++++++++++-------
 configure.in                   |   30 +++
 daemon/flag.c                  |   35 ++++
 daemon/spawn.c                 |   43 +++--
 include/config.h.in            |    3 
 include/replicated.h           |    4 
 include/rpc_subs.h             |    3 
 lib/macros.c                   |    8 +
 lib/master_tok.l               |    2 
 lib/mounts.c                   |    1 
 lib/parse_subs.c               |    2 
 lib/rpc_subs.c                 |  171 ++++++-------------
 man/auto.master.5.in           |    4 
 man/autofs.5                   |    6 -
 man/autofs.8.in                |    8 -
 man/autofs.conf.5.in           |    4 
 man/autofs_ldap_auth.conf.5.in |    2 
 man/automount.8                |    4 
 modules/base64.c               |    2 
 modules/lookup_file.c          |    4 
 modules/lookup_hesiod.c        |    3 
 modules/mount_nfs.c            |   17 ++
 modules/replicated.c           |   79 ++++++++-
 redhat/autofs.conf.default.in  |    2 
 samples/autofs.conf.default.in |    2 
 samples/autofs.service.in      |    3 
 31 files changed, 604 insertions(+), 296 deletions(-)

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
