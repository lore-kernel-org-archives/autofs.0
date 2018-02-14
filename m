From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/20] Current patch queue
Date: Wed, 14 Feb 2018 14:42:51 +0800
Message-ID: <151859051902.8026.13693256398323544616.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Here are the patches I currently have in my queue.
I hope to commit them by the end of the week if possible.

Comments welcome.

---

Ian Kent (17):
      autofs-5.1.4 - fix flag file permission
      autofs-5.1.4 - fix directory create permission
      autofs-5.1.4 - fix use after free in do_master_list_reset()
      autofs-5.1.4 - fix deadlock in dumpmaps
      autofs-5.1.4 - dont use array for path when not necessary
      autofs-5.1.4 - fix prefix option handling in expand_entry()
      autofs-5.1.4 - fix sublink option not set from defaults
      autofs-5.1.4 - fix error return in do_nfs_mount()
      autofs-5.1.4 - add error handling for ext_mount_add()
      autofs-5.1.4 - account for recent libnsl changes
      autofs-5.1.4 - dont allow trailing slash in master map mount points
      autofs-5.1.4 - fix libresolv configure check
      autofs-5.1.4 - add fedfs-getsrvinfo.c
      autofs-5.1.4 - add mount.fedfs.c
      autofs-5.1.4 - add fedfs-map-nfs4.c
      autofs-5.1.4 - add conditional inclusion of fedfs binaries
      autofs-5.1.4 - add an example fedfs master map entry to the installed master map

NeilBrown (3):
      autofs-5.1.4 - use_hostname_for_mounts shouldn't prevent selection among replicas
      autofs-5.1.4 - fix monotonic_elapsed
      autofs-5.1.4 - Makefiles.rules: remove 'samples' from SUBDIRS


 CHANGELOG                |   22 ++
 Makefile                 |    3 
 Makefile.conf.in         |    6 -
 Makefile.rules           |    8 -
 aclocal.m4               |   45 ++++
 autofs.spec              |   20 ++
 configure                |  345 +++++++++++++++++++++++++++++++--
 configure.in             |   40 ++--
 daemon/automount.c       |   10 +
 daemon/direct.c          |    4 
 daemon/flag.c            |    2 
 daemon/indirect.c        |    2 
 daemon/lookup.c          |    2 
 daemon/spawn.c           |    1 
 fedfs/Makefile           |   44 ++++
 fedfs/fedfs-getsrvinfo.c |  311 +++++++++++++++++++++++++++++
 fedfs/fedfs-getsrvinfo.h |   52 +++++
 fedfs/fedfs-gpl-boiler.h |   40 ++++
 fedfs/fedfs-map-nfs4.c   |  204 +++++++++++++++++++
 fedfs/fedfs-nls.h        |   38 ++++
 fedfs/fedfs-token.h      |   40 ++++
 fedfs/mount.fedfs.c      |  485 ++++++++++++++++++++++++++++++++++++++++++++++
 include/automount.h      |    1 
 include/config.h.in      |    3 
 include/replicated.h     |    3 
 lib/master_parse.y       |    5 
 lib/mounts.c             |    5 
 lib/rpc_subs.c           |    4 
 modules/Makefile         |   10 +
 modules/mount_bind.c     |    6 -
 modules/mount_changer.c  |    2 
 modules/mount_ext2.c     |    2 
 modules/mount_generic.c  |    2 
 modules/mount_nfs.c      |    4 
 modules/parse_amd.c      |   75 ++++++-
 modules/replicated.c     |   35 ++-
 samples/auto.master      |    6 +
 37 files changed, 1792 insertions(+), 95 deletions(-)
 create mode 100644 fedfs/Makefile
 create mode 100644 fedfs/fedfs-getsrvinfo.c
 create mode 100644 fedfs/fedfs-getsrvinfo.h
 create mode 100644 fedfs/fedfs-gpl-boiler.h
 create mode 100644 fedfs/fedfs-map-nfs4.c
 create mode 100644 fedfs/fedfs-nls.h
 create mode 100644 fedfs/fedfs-token.h
 create mode 100644 fedfs/mount.fedfs.c

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
