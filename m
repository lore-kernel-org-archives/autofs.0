From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/6] Teach autofs about RCU-walk
Date: Mon, 25 Aug 2014 08:42:35 +1000
Message-ID: <20140824223628.16196.5795.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>

Hi Andrew,
 this series teaches autofs about RCU-walk so that we don't drop
 straight into REF-walk when we hit an autofs directory, and so that
 we avoid spinlocks as much as possible when performing an RCU-walk.

 This is needed so that the benefits of the recent NFS support for
 RCU-walk are fully available when NFS filesystems are automounted.

 Patches have been carefully reviewed and tested both with test suites
 and in production - thanks a lot to Ian Kent for his support there.

 If they could be queued for 3.18, I would appreciate it.

Thanks,
NeilBrown

---

NeilBrown (6):
      autofs4: allow RCU-walk to walk through autofs4.
      autofs4: factor should_expire() out of autofs4_expire_indirect.
      autofs4: make "autofs4_can_expire" idempotent.
      autofs4: avoid taking fs_lock during rcu-walk
      autofs4: d_manage() should return -EISDIR when appropriate in rcu-walk mode.
      autofs: the documentation I wanted to read


 Documentation/filesystems/autofs4.txt |  520 +++++++++++++++++++++++++++++++++
 fs/autofs4/autofs_i.h                 |    6 
 fs/autofs4/dev-ioctl.c                |    2 
 fs/autofs4/expire.c                   |  210 ++++++++-----
 fs/autofs4/root.c                     |   62 +++-
 5 files changed, 698 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/filesystems/autofs4.txt

-- 
Signature

