From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/27] Still trying to get 5.1.4 released
Date: Mon, 11 Dec 2017 16:56:58 +0800
Message-ID: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

I have committed the last series I posted to the autofs repository,
expect for the "fix ordering of seteuid/setegid in do_spawn()" patch
which changed order in the queue during the discussion of the previous
series.

But now there are a number of additional patches that I really
would like to include in 5.1.4 too.

Comments welcome.
---

Ian Kent (25):
      autofs-5.1.3 - handle additional nfs versions in mount_nfs.c
      autofs-5.1.3 - fix symlink option passthrough in mount_nfs.c
      autofs-5.1.3 - update configure to check for pipe2(2)
      autofs-5.1.3 - fix open calls not using open_xxxx() calls
      autofs-5.1.3 - move open_xxxx() functions to spawn.c
      autofs-5.1.3 - serialize calls to open_xxxx() functions
      autofs-5.1.3 - improve debug logging of lookup key
      autofs-5.1.3 - fix typo in amd_parse.c
      autofs-5.1.3 - add missing MODPREFIX to logging in amd parser
      autofs-5.1.3 - fix symlink false negative in umount_multi()
      autofs-5.1.3 - remove expand_selectors() call on amd parser entry
      autofs-5.1.3 - fix amd defaults map entry handling
      autofs-5.1.3 - refactor amd_parse.c
      autofs-5.1.3 - fix amd parser double quote handling
      autofs-5.1.3 - fix expandamdent() quote handling
      autofs-5.1.3 - fix possible memory leak during amd parse
      autofs-5.1.3 - remove path restriction of amd external mount
      autofs-5.1.3 - add function umount_amd_ext_mount()
      autofs-5.1.3 - add function ext_mount_inuse()
      autofs-5.1.3 - add function construct_argv()
      autofs-5.1.3 - add amd mount type program mount support
      autofs-5.1.3 - fix memory leak in umount_amd_ext_mount()
      autofs-5.1.3 - fix strerror_r() parameter declaration in do program_mount()
      autofs-5.1.3 - fix incorrect check in validate_program_options()
      autofs-5.1.3 - fix log message in spawn_umount()

Jeff Mahoney (1):
      autofs-5.1.3 - fix ordering of seteuid/setegid in do_spawn()

Thiago Rafael Becker (1):
      autofs-5.1.3 - Fix two typos


 CHANGELOG                |   26 ++
 README.amd-maps          |    6 -
 configure                |   18 ++
 configure.in             |    2 
 daemon/automount.c       |   29 ---
 daemon/spawn.c           |  185 +++++++++++++++++
 include/automount.h      |  134 +------------
 include/config.h.in      |    3 
 include/mounts.h         |    2 
 include/parse_amd.h      |    3 
 include/parse_subs.h     |    1 
 lib/mounts.c             |   96 +++++++--
 lib/parse_subs.c         |  103 ++++++++--
 man/auto.master.5.in     |    2 
 man/automount.8          |    2 
 modules/amd_parse.y      |  489 ++++++++++++++++++++++++++++++++++------------
 modules/amd_tok.l        |    4 
 modules/lookup_file.c    |   14 +
 modules/lookup_hesiod.c  |   20 ++
 modules/lookup_ldap.c    |   15 +
 modules/lookup_nisplus.c |   15 +
 modules/lookup_program.c |    3 
 modules/lookup_yp.c      |   43 ++--
 modules/mount_nfs.c      |   13 +
 modules/parse_amd.c      |  302 ++++++++++++++++++++++------
 25 files changed, 1105 insertions(+), 425 deletions(-)

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
