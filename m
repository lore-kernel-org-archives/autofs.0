From: Ian Kent <raven@themaw.net>
Subject: [PATCH v2 0/5] autofs updates
Date: Fri, 23 Nov 2018 18:41:41 +0800
Message-ID: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

- improve file system verification for ioctl case.
- fix potential inode leak in mount code.
- add "strictexpire" autofs mount option.

v2 changes:
- fix compile error.
- deffer some of the mount option re-factoring to try and
  avoid any conflicts with linux-next.

---

Ian Kent (5):
      autofs - improve ioctl sbi checks
      autofs - fix possible inode leak in autofs_fill_super()
      autofs - simplify parse_options() function call
      autofs - change catatonic setting to a bit flag
      autofs - add strictexpire mount option


 fs/autofs/autofs_i.h         |   11 ++++--
 fs/autofs/dev-ioctl.c        |   29 +++++-----------
 fs/autofs/init.c             |    2 +
 fs/autofs/inode.c            |   75 +++++++++++++++++++++++++-----------------
 fs/autofs/root.c             |   16 ++++++---
 fs/autofs/waitq.c            |   10 +++---
 include/uapi/linux/auto_fs.h |    2 +
 7 files changed, 78 insertions(+), 67 deletions(-)

--
Ian
