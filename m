From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: [RFC PATCH 0/2] autofs: fix autofs_v5_packet dlivery in compat mode
Date: Fri, 01 Sep 2017 15:21:39 +0400
Message-ID: <20170901110906.2669.1577.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

The problem is that in compat mode struct autofs_v5_packet has to have different size
(i.e. 4 bytes less).

This is RFC because:
1) This issue is hidden, because autofs pipe has O_DIRECT and the rest of the
epacket is truncated when read.
2) X86 arch doesn't have is_compat_task() helper
3) It's now clear, what to do if "pgrp" option is specified.

The following series implements...

---

Stanislav Kinsburskiy (2):
      autofs: set compat flag on sbi when daemon uses 32bit addressation
      autofs: sent 32-bit sized packet for 32-bit process


 fs/autofs4/autofs_i.h  |    3 +++
 fs/autofs4/dev-ioctl.c |    3 +++
 fs/autofs4/inode.c     |    4 +++-
 fs/autofs4/waitq.c     |    5 +++++
 4 files changed, 14 insertions(+), 1 deletion(-)
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
