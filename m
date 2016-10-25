From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/37] Current patch queue for review
Date: Tue, 25 Oct 2016 09:17:24 +0800
Message-ID: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=mesmtp; bh=51pHn4OoZl
        CRq8cS5+a1EF9FX/I=; b=TEgLVC9LsXTSFk2ScKu45lsKAp5Io4A85sklufdCop
        zAzxyfmi/TXJsc2259BWSNOwtgmCwd7tcuqW6Voovfmkw+JcSQkpGHL/NlItTh5c
        YGrE/3VPpS4WAFf81L7LvQdCqcRQRuHXD0P2KGFGFv8hDkXlJ0I6hQmU0Nud/CzG
        4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:mime-version:content-type:content-transfer-encoding;
         s=smtpout; bh=51pHn4OoZlCRq8cS5+a1EF9FX/I=; b=A4FS/nJVk9jRiMh6k
        TaLvg3MZ3qMvBg8Pz4RVW7fvHi/yHwJv05SgRSs0enRvC2sjyLYpyB9MvvNjbXQ2
        7OfjxztRnOlMVlc8OXyu2XQdVTf8zM+vqpnoVlz+9GF7JCo2tlXJ7NSVgZYEfR0d
        aYAzWYoARskIKfHqOUr2BPQbOs=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Hi all,

The patch queue is well overdue for a commit but since there's
been increased contributions for others recently I thought it
would be useful to post the patches for review and give a brief
description of what's in the queue and what still needs work. 

Many of the patches are striaght forward and I expect to commit
then in a week or so. Also keep in mind the commit order might
be different when the commit is actually done.

The patches around those titled "autofs-5.1.2 - wait for master
map available at start" and "autofs-5.1.2 - add master read wait
option" have been around for quite a while and have been a problem
in the past (which is why they haven't been committed yet) so I'm
not sure about them yet.

The series to add browse support for amd maps is not yet complete
so they will likely stay in the queue a bit longer. But I am keen
to get this functionality into a release as I know it is something
that at least a few people would like.

Anyway review of the patches would be appreciated.

---

Gustavo Zacarias (1):
      autofs-5.1.2 - build: check for clock_gettime in librt

Ian Kent (25):
      autofs-5.1.2 - fix release date in CHANGELOG
      autofs-5.1.2 - fix file map changed check
      autofs-5.1.2 - fix short memory allocation in lookup_amd_instance()
      autofs-5.1.2 - fix count_mounts() function
      autofs-5.1.2 - fix typo in MOUNT_FLAG_GHOST comment
      autofs-5.1.2 - fix cachefs parse message not being logged
      autofs-5.1.2 - fix argc off by one in mount_autofs.c
      autofs-5.1.2 - fix _strncmp() usage
      autofs-5.1.1 - fix create_client() RPC client handling
      autofs-5.1.2 - update and add README for old autofs schema
      autofs-5.1.2 - wait for master map available at start
      autofs-5.1.2 - add master read wait option
      autofs-5.1.2 - work around sss startup delay
      autofs-5.1.2 - add sss master map wait config option
      autofs-5.1.2 - fix typos in README.amd-maps
      autofs-5.1.2 - add ref counting to struct map_source
      autofs-5.1.2 - add support for amd browsable option
      autofs-5.1.2 - add function conf_amd_get_map_name()
      autofs-5.1.2 - add function conf_amd_get_mount_paths()
      autofs-5.1.2 - include amd mount section mounts in master mounts list
      autofs-5.1.2 - check for conflicting amd section mounts
      autofs-5.1.2 - add function conf_get_map_options()
      autofs-5.1.2 - capture cache option and its settings during parsing
      autofs-5.1.2 - handle map_option cache for top level mounts
      autofs-5.1.2 - handle amd cache option all in amd type auto mounts

Martin von Gagern (1):
      autofs-5.1.2 - fix libtirpc detection with -Wl,--as-needed

Thomas Petazzoni (1):
      autofs-5.1.2 - configure: add cache variable for Linux proc filesystem check

Tomohiro Kusumi (9):
      autofs-5.1.2 - Fix compiler warning in try_remount()
      autofs-5.1.2 - Drop redundant \n in logerr()
      autofs-5.1.2 - Fix size arg of fgets(3)
      autofs-5.1.2 - Fix a typo in CREDITS
      autofs-5.1.2 - Change .requestor to .requester for consistency
      autofs-5.1.2 - Remove unused local 2KB buffer
      autofs-5.1.2 - Fix typos in error messages
      autofs-5.1.2 - Fix fgets(3) size argument (another one)
      autofs-5.1.2 - Avoid local variable name shadowing another


 CHANGELOG                      |   40 ++++++++
 CREDITS                        |    2 
 Makefile.conf.in               |    3 +
 Makefile.rules                 |    2 
 README.amd-maps                |   64 ++++++++++---
 README.autofs-schema           |   18 ++++
 aclocal.m4                     |   21 ++--
 configure                      |   66 +++++++++++--
 configure.in                   |    4 +
 daemon/automount.c             |  107 +++++++++++++++++----
 daemon/indirect.c              |    7 +
 daemon/lookup.c                |  116 +++++++++++++++++++----
 daemon/module.c                |    4 -
 daemon/state.c                 |    4 -
 include/automount.h            |    9 +-
 include/defaults.h             |    8 ++
 include/dev-ioctl-lib.h        |    2 
 include/master.h               |    4 +
 include/parse_amd.h            |    7 +
 lib/defaults.c                 |  137 +++++++++++++++++++++++++++
 lib/dev-ioctl-lib.c            |   10 +-
 lib/master.c                   |  202 ++++++++++++++++++++++++++++++++++++++++
 lib/master_parse.y             |   30 +++++-
 lib/mounts.c                   |    9 +-
 lib/nss_parse.y                |    2 
 lib/rpc_subs.c                 |   21 ++--
 man/autofs.conf.5.in           |   27 +++++
 man/automount.8                |    4 +
 modules/amd_parse.y            |   16 ++-
 modules/amd_tok.l              |    2 
 modules/lookup_file.c          |   15 ++-
 modules/lookup_ldap.c          |   10 +-
 modules/lookup_nisplus.c       |   24 +++--
 modules/lookup_sss.c           |   72 +++++++++++++-
 modules/lookup_yp.c            |   23 +++--
 modules/mount_autofs.c         |   84 +++++++++++------
 modules/mount_ext2.c           |    2 
 modules/parse_amd.c            |    2 
 redhat/autofs.conf.default.in  |   24 ++++-
 samples/autofs.conf.default.in |   24 ++++-
 samples/autofs.schema          |   24 ++---
 41 files changed, 1042 insertions(+), 210 deletions(-)
 create mode 100644 README.autofs-schema

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
