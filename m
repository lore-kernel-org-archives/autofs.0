From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: Re: [PATCH 0/5] fyi, here are the patches that I haven't yet committed
Date: Tue, 24 Dec 2013 16:38:25 +0800
Message-ID: <CAF1ZMEf+Bd664eVgkLOvGKTFGBzpgS+UoDZmJyFK-f=Rv59bkg@mail.gmail.com>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d0tvPBCwQyKzTYx/B1O8UmabASRXiz5DIZczw6dEQmM=;
        b=Hnbo2fNRwBIdUp8sPOz28uaCKCZrwQx1x2fipItVzmxAlkg665bZVpJiAuUcORT94g
         +E1+jm+t8scRAVW/fsl5dkLdC7MsnAoqH/JKxXAJ3m2FM9/r5jYAYEIEt3rOKGBqy3xJ
         hMJ7D49tYKWOrEzB6jMzldnhQGG0Kb3QX91uBZmoyqMAs0Ot/nfVtlzTj6dqGkuBfogN
         If71RSR01eeOtr3WTCbfPAGUhI2l45sCNPmYASVODHQZvLlz+dGmp22t1gMmWlNraw87
         DqaG85DLWWBHGG/xdqKzIZPm1lK3vzx4WnvkbyR3IjRHqs90SixdE3QI1y4V8acLxdUc
         ayNw==
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

Hi Ian:
  Do you mind push a temporary branch into your git repo (if you don't
want to queue other patches)?
That would much convenient for me to test.
  Thanks.

Lan

On Tue, Dec 24, 2013 at 4:02 PM, Ian Kent <raven@themaw.net> wrote:
> Let's try that again.
>
> Not certain yet what the problem is but today I investigated a problem
> reported against host map not working and it was something quite different.
>
> There are a couple of patches here that are most likely needed in addition
> to the currently committed patches.
>
> In paticualar
> autofs-5.0.8 - fix fix ipv6 libtirpc getport
> autofs-5.0.8 - fix rpc_portmap_getport() proto not set
> and possibly
> autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given
>
> might be useful.
>
> ---
>
> Ian Kent (4):
>       autofs-5.0.8 - fix ipv6 link local address handling
>       autofs-5.0.8 - fix fix ipv6 libtirpc getport
>       autofs-5.0.8 - fix rpc_portmap_getport() proto not set
>       autofs-5.0.8 - fix options compare
>
> Scott Mayhew (1):
>       autofs-5.0.8 - get_nfs_info() should query portmapper if port is not given
>
>
>  include/automount.h    |    1 +
>  lib/cat_path.c         |    9 +++++++++
>  lib/rpc_subs.c         |   14 +++++++++-----
>  modules/mount_autofs.c |   12 ++++++------
>  modules/mount_bind.c   |    2 +-
>  modules/mount_ext2.c   |    2 +-
>  modules/mount_nfs.c    |   34 +++++++++++++++++-----------------
>  modules/parse_sun.c    |   22 +++++++++++-----------
>  modules/replicated.c   |    9 ++++++---
>  9 files changed, 61 insertions(+), 44 deletions(-)
>
> --
> Ian
