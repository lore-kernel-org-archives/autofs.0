From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 01/10] autofs4 - merge auto_fs.h and auto_fs4.h
Date: Mon, 14 May 2018 04:15:09 +0100
Message-ID: <20180514031509.GC30522@ZenIV.linux.org.uk>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 14, 2018 at 11:03:50AM +0800, Ian Kent wrote:
> The autofs module has long since been removed so there's no need to have
> two separate include files for autofs.

Umm...  Why does fs/compat_ioctl.c need either include, actually?

> --- a/fs/compat_ioctl.c
> +++ b/fs/compat_ioctl.c
> @@ -39,7 +39,6 @@
>  #include <linux/if_pppox.h>
>  #include <linux/mtio.h>
>  #include <linux/auto_fs.h>
> -#include <linux/auto_fs4.h>
>  #include <linux/tty.h>
>  #include <linux/vt_kern.h>
>  #include <linux/fb.h>

AFAICS, we can just delete both.  Matter of fact, a *lot* of those includes are
pointless nowadays...
