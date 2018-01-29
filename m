From: NeilBrown <neilb@suse.com>
Subject: [PATCH 0/3] Assorted autofs fixes
Date: Mon, 29 Jan 2018 18:19:54 +1100
Message-ID: <151721021295.27355.1968703903360394469.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hi Ian,
 following are three fixes for the autofs patches.
 The first is a revised version of a patch were have been
 discussing that relates to use_hostname_for_mounts.
 Rather than comparing weight and path and hostname etc to see
 if two 'struct host' came from the same config-file entry,
 I thought it would be best to record and index number and
 just compare that.  Hopefully that makes it more obvious
 what is happening.

 The second fixes that monotonic_elapsed() problem we discussed at
 LCA.  Customer has confirmed that this fixes the problem.

 The third fixes a small Makefile bug

Thanks,
NeilBrown


---

NeilBrown (3):
      use_hostname_for_mounts shouldn't prevent selection among replicas
      Fix monotonic_elapsed.
      Makefiles.rules: remove 'samples' from SUBDIRS


 Makefile.rules       |    2 +-
 include/replicated.h |    3 ++-
 lib/rpc_subs.c       |    4 ++--
 modules/mount_nfs.c  |    2 +-
 modules/replicated.c |   35 ++++++++++++++++++++---------------
 5 files changed, 26 insertions(+), 20 deletions(-)

--
Signature

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
