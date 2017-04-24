From: Ian Kent <raven@themaw.net>
Subject: [PATCH 00/34] fyi ... current patch list
Date: Mon, 24 Apr 2017 09:00:12 +0800
Message-ID: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=zqStrXxZM1x76q7koypeiI44fZJFNlm/p4huZpPSl
        sk=; b=iZfLV6o9H2l6kNDjzGrUvXlz4Z4d/Fx6sBsaxvoUla0z0tDWkxA8087gL
        VKTvAEejaw+hMGz44VnIbsMuxJ3gZxWo9iVL2PRePG/17/lfgR/Datv5aK98mRWa
        pIjWG1N5p/6KJgB3fdoQdzBe+TM7gavRP/VbfVAKr9VHHhcyZ/7dfF5YiuTm5gta
        RgXQxV0XzpdNK6XzWzDx8jsOi6ghrNutZxxS9ndHfyYPNWBxguZ8z4HxWJSI9ngh
        +qKUCk2UMLF3fIz6+XUNfxAu8DEtFW37VStla88++1pgzam5yYaw9iQzoyapohps
        SlpvHV09Ym/Kni2FktfPq6MK/Tbhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=zqStrXxZM1x76q7koy
        peiI44fZJFNlm/p4huZpPSlsk=; b=MHvHn4rYeuYzFd4x0Lh2+XSFh+c7IoCP1g
        Dz8nEj6A2v9UTTfmbqciCg4SUUiFrXx1KYxNoYmTNXk0UzDAxJN6Na4nP5eyujX5
        ASj++NUGcfJWd6Mv8PE14d0D9vvE+t+ODIlWk5XMtQVtm14SvrKS4YWp4NkcfsH/
        bxvnIozkxmq95N8JApRgdSLDoYBu90AVo8APvkJQAc6LBN2P8VybFQ20mIIk2kUy
        pXqTK7IOvC/K8Iq1V3MF3Wba43FutGlMis103qZDF6tJC1TrYq1FWicS1Wdnc+FL
        Ky2v2HxZu+HC+k/OCYWb+QWG2DKAls6k6q+ShcJJY7Ukl5ax2J6w==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Here is my current patch list.

If there are no concerns from anyone I expect to commit them to the repo.
some time in the next few days.

Most notable change is the addition of browse support for amd format maps.

I'd like to get the amd browse changes into a release so hopefully that
will follow not too long after the commit.

---

David Jeffery (1):
      autofs-5.1.2 - honor last rw in mount options when doing a bind mount

Ian Kent (30):
      autofs-5.1.2 - fix included master map not found return
      autofs-5.1.2 - dont exit on master map read fail timeout
      autofs-5.1.2 - set sane default master read wait timeout
      autofs-5.1.2 - don't return until after master map retry read
      autofs-5.1.2 - make lookup_nss_read_master() return nss status
      autofs-5.1.2 - check NFS server availability on local mount fallback
      autofs-5.1.2 - make set_direct_mount_catatonic() more general
      autofs-5.1.2 - set autofs mounts catatonic at exit
      autofs-5.1.2 - fix typos in README.amd-maps
      autofs-5.1.2 - add ref counting to struct map_source
      autofs-5.1.2 - add support for amd browsable option
      autofs-5.1.2 - add function conf_amd_get_map_name()
      autofs-5.1.2 - add function conf_amd_get_mount_paths()
      autofs-5.1.2 - include amd mount section mounts in master mounts list
      autofs-5.1.2 - check for conflicting amd section mounts
      autofs-5.1.2 - add function conf_amd_get_map_options()
      autofs-5.1.2 - capture cache option and its settings during parsing
      autofs-5.1.2 - handle map_option cache for top level mounts
      autofs-5.1.2 - handle amd cache option all in amd type auto mounts
      autofs-5.1.2 - fix bogus check in expire_cleanup()
      autofs-5.1.2 - delay submount exit for amd submounts
      autofs-5.1.2 - factor out set_thread_mount_request_log_id()
      autofs-5.1.2 - add config option to use mount request log id
      autofs-5.1.2 - use autofs_point to store expire timeout where possibe
      autofs-5.1.2 - fix possible NULL derefernce
      autofs-5.1.2 - fix work around sss startup delay
      autofs-5.1.2 - fix invalid reference in remount_active_mount()
      autofs-5.1.2 - use malloc for expanded map location
      autofs-5.1.2 - fix offset mount location multiple expansion
      autofs-5.1.2 - increase worker thread per-thread stack size

Lars R. Damerow (3):
      autofs-5.1.2 - add the mount requestor's pid to pending_args
      autofs-5.1.2 - create thread-local ID for mount attempts
      autofs-5.1.2 - log functions to prefix messages with attempt_id if available


 CHANGELOG                      |   34 +++++++
 README.amd-maps                |   64 ++++++++++---
 daemon/automount.c             |   89 +++++++++++++-----
 daemon/direct.c                |   85 ++---------------
 daemon/indirect.c              |   15 ++-
 daemon/lookup.c                |  126 ++++++++++++++++++++-----
 daemon/state.c                 |   34 +++++--
 include/automount.h            |   12 ++
 include/defaults.h             |    7 +
 include/master.h               |    4 +
 include/mounts.h               |    4 +
 include/parse_amd.h            |    7 +
 lib/defaults.c                 |  121 ++++++++++++++++++++++++
 lib/log.c                      |  164 +++++++++++++++++++++++++++-----
 lib/master.c                   |  202 ++++++++++++++++++++++++++++++++++++++++
 lib/master_parse.y             |   55 ++++++++---
 lib/mounts.c                   |  160 ++++++++++++++++++++++++++++++--
 lib/rpc_subs.c                 |   11 ++
 man/autofs.conf.5.in           |   25 ++++-
 modules/amd_parse.y            |   15 ++-
 modules/amd_tok.l              |    2 
 modules/lookup_dir.c           |    2 
 modules/lookup_file.c          |   20 +++-
 modules/lookup_ldap.c          |   10 +-
 modules/lookup_nisplus.c       |   10 +-
 modules/lookup_sss.c           |   18 ++--
 modules/lookup_yp.c            |   10 +-
 modules/mount_autofs.c         |   79 ++++++++++------
 modules/mount_nfs.c            |   17 +++
 modules/parse_amd.c            |    2 
 modules/parse_sun.c            |   90 +++++++++++++++---
 redhat/autofs.conf.default.in  |   20 +++-
 samples/autofs.conf.default.in |   20 +++-
 33 files changed, 1236 insertions(+), 298 deletions(-)

--
Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
