From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 0/2] struct pid-ify autofs4
Date: Wed, 19 Sep 2012 17:29:34 +0200
Message-ID: <1348068576-21363-1-git-send-email-miklos@szeredi.hu>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=qbfCywI4VhBi9gZqnN+A4oP2iJHx8gt0Vzjcram/7hM=;
        b=hDPiUUHs6C5XdCJjtB9q40XoSeld34Tjb44bQuPOWprn1P5uhosOrfrQbIJkitVJBp
         feSX7eKzLASruompsvDOiF6dK/M2CDLk/FfvtKushpGTUFcTJ5WxDSpSR4HS7MUqW7si
         3CJ7B1iOBwR+k8jgvOevHkX4MzKfyhYFmNrZg=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com, serge.hallyn@canonical.com, ebiederm@xmission.com, mszeredi@suse.cz


These two patches change autofs4 to store struct pid pointers instead of pid_t
values.

Fixed various issues with the previous post.  Not tested, handle with care!

Thanks,
Miklos
---


Serge Hallyn (1):
      autofs4: store struct pids in autofs_waitqs

Sukadev Bhattiprolu (1):
      Replace pid_t in autofs4 with struct pid reference.

---
 fs/autofs4/autofs_i.h  |    8 ++++----
 fs/autofs4/dev-ioctl.c |    3 ++-
 fs/autofs4/inode.c     |   22 +++++++++++++++-------
 fs/autofs4/waitq.c     |   19 +++++++++++++------
 4 files changed, 34 insertions(+), 18 deletions(-)

