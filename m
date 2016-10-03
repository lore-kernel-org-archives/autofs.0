From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 0/8] Patch series to fix autofs unreliable usage of
 d_mountpoint()
Date: Mon, 03 Oct 2016 08:46:22 +0800
Message-ID: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=Kes
        FRPhopN8LGPrcvMTc8qkw334=; b=GzEP/4vg0N/bcJwa8blseqmZMlqWU2mdqgP
        8UlbNbfKed7r4BKxJUe76it9QZTVtkEztF5TypVcmPAKdSEUjuCW3JSwxeLB3Clt
        6NRK2ccTwxESH/h9yIHLA8jIEKoVOSV9oLOUPXHSoVcoSeFf1c4VVH27ubklXfMh
        /1XgizxA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=KesFRPhopN8LGPrcvMTc8qkw334=; b=sG4Er
        j4jv73hKh3wx5adYXHdsfSNGIdk7x6C9T/JR3ifzTq0oscBHcjDd60lltcpD5Vbp
        G6Z5HbvolYobiljB6YqTxsjG1JnvOnEcA5xJiHLqW3YCGaOPkLt1ZET57wl7oZso
        9Ki1L8/UtyvfADFDZ5slVn5sGLtLZX1R7PqyNI=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

This series fixes the potential problem of autofs returning ELOOP when
a mount exists in a propogation private mount namespace other than the
namespace in which the mount is to be performed.

I'm posting the series as an RFC in the hope of catching stupid mistakes
that I may have made before submitting to mmotm. Please note the series
here is against the current Linus tree and may be slightly different when
posted for inclusion in mmotm.

Please review and post any comments.
---

Ian Kent (8):
      vfs - change d_manage() to take a struct path
      vfs - add path_is_mountpoint() helper
      vfs - add path_has_submounts()
      autofs - change autofs4_expire_wait() to take struct path
      autofs - change autofs4_wait() to take struct path
      autofs - use path_is_mountpoint() to fix unreliable d_mountpoint() checks
      autofs - use path_has_submounts() to fix unreliable have_submount() checks
      vfs - remove unused have_submounts() function


 Documentation/filesystems/Locking |    2 +
 Documentation/filesystems/vfs.txt |    2 +
 fs/autofs4/autofs_i.h             |    4 +-
 fs/autofs4/dev-ioctl.c            |    4 +-
 fs/autofs4/expire.c               |    8 +++-
 fs/autofs4/root.c                 |   71 +++++++++++++++++++++----------------
 fs/autofs4/waitq.c                |   13 +++++--
 fs/dcache.c                       |   36 ++++++++++---------
 fs/namei.c                        |   13 +++----
 fs/namespace.c                    |   43 ++++++++++++++++++++++
 include/linux/dcache.h            |    4 +-
 include/linux/fs.h                |    2 +
 12 files changed, 133 insertions(+), 69 deletions(-)

--
Ian
