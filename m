From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/5] RCU-walk support for autofs
Date: Mon, 18 Aug 2014 16:33:00 +1000
Message-ID: <20140818062844.9860.43007.stgit@notabene.brown>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ian,
 Have you had a chance to run your tests in these patches yet?
 I've done what testing I can think of and cannot fault them.

 This set is against 3.17-rc1 and make use of the new -EISDIR handling
 for d_manage() and assumes the other patches which already went in
 through Andrew Morton.

 I've added a section to autofs4.txt about mount namespaces, but it is
 otherwise unchanged.

 If I could get an {Acked,Reviewed,Tested}-By in the next few weeks so
 I can send them on to Andrew I would really appreciate it.

Thanks,
NeilBrown



---

NeilBrown (5):
      autofs4: allow RCU-walk to walk through autofs4.
      autofs4: factor should_expire() out of autofs4_expire_indirect.
      autofs4: avoid taking fs_lock during rcu-walk
      autofs4: d_manage() should return -EISDIR when appropriate in rcu-walk mode.
      autofs: the documentation I wanted to read


 Documentation/filesystems/autofs4.txt |  520 +++++++++++++++++++++++++++++++++
 fs/autofs4/autofs_i.h                 |    6 
 fs/autofs4/dev-ioctl.c                |    2 
 fs/autofs4/expire.c                   |  200 ++++++++-----
 fs/autofs4/root.c                     |   62 +++-
 5 files changed, 694 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/filesystems/autofs4.txt

-- 
Signature

