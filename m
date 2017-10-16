From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/35] Current autofs patch queue (lets try again)
Date: Mon, 16 Oct 2017 13:05:49 +0800
Message-ID: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Unfortunately I didn't get to commit the series I posted on the 2nd of August
so lets try again.

I'm hoping to commit these in the next few days and, because of a couple
of regressions introduced in 5.1.3, and I'm still keen to release 5.1.4.

---

Ian Kent (33):
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
      autofs-5.1.3 - fix possible map instance memory leak
      autofs-5.1.3 - check map instances for staleness on map update
      autofs-5.1.3 - allow dot in OPTIONSTR value lexer pattern
      autofs-5.1.3 - fix autofs_use_lofs description
      autofs-5.1.3 - fix amd parser error buffer size
      autofs-5.1.3 - make spawn_bind_mount() use mount_wait as well
      autofs-5.1.3 - document ghost option in auto.master man page
      autofs-5.1.3 - only take master map mutex for master map update
      autofs-5.1.3 - revert fix argc off by one in mount_autofs.c
      autofs-5.1.3 - fix nisplus lookup init not configured check
      autofs-5.1.3 - make open_lookup() error handling more consistent
      autofs-5.1.3 - be silent about sss library not found
      autofs-5.1.3 - be silent about nis domain not set
      autofs-5.1.3 - make map source reference message debug only
      autofs-5.1.3 - improve description of mount_nfs_default_protocol
      autofs-5.1.3 - port option should not behave like nobind option

NeilBrown (1):
      autofs-5.1.3 - Add -c option when calling /bin/umount - if supported.

Waldemar Brodkorb (1):
      autofs-5.1.3 - use pkg-config to search for libtirpc to fix cross-compilation


 CHANGELOG                      |   39 ++++
 Makefile.conf.in               |    3 
 Makefile.rules                 |    2 
 aclocal.m4                     |   66 ++-----
 autofs.spec                    |    2 
 configure                      |  362 +++++++++++++++++++++++++++++++++-------
 configure.in                   |   30 +++
 daemon/flag.c                  |   35 ++++
 daemon/lookup.c                |   11 +
 daemon/module.c                |   14 +-
 daemon/spawn.c                 |   46 ++++-
 daemon/state.c                 |    5 -
 include/config.h.in            |    3 
 include/master.h               |    1 
 include/replicated.h           |    4 
 include/rpc_subs.h             |    3 
 lib/macros.c                   |    8 +
 lib/master.c                   |   49 ++++-
 lib/master_tok.l               |    4 
 lib/mounts.c                   |    1 
 lib/parse_subs.c               |    2 
 lib/rpc_subs.c                 |  171 ++++++-------------
 man/auto.master.5.in           |   13 +
 man/autofs.5                   |    6 -
 man/autofs.8.in                |    8 -
 man/autofs.conf.5.in           |   15 +-
 man/autofs_ldap_auth.conf.5.in |    2 
 man/automount.8                |    4 
 modules/amd_parse.y            |    2 
 modules/base64.c               |    2 
 modules/lookup_file.c          |    4 
 modules/lookup_hesiod.c        |    3 
 modules/lookup_nisplus.c       |    3 
 modules/lookup_sss.c           |    4 
 modules/lookup_yp.c            |    2 
 modules/mount_autofs.c         |    8 -
 modules/mount_nfs.c            |   30 ++-
 modules/replicated.c           |   79 ++++++++-
 redhat/autofs.conf.default.in  |   13 +
 samples/autofs.conf.default.in |   13 +
 samples/autofs.service.in      |    3 
 41 files changed, 712 insertions(+), 363 deletions(-)

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
