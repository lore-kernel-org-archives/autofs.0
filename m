From: raven@themaw.net
Subject: Re: [PATCH] Remove prototypes of nonexistent functions from fs/autofs4
 files
Date: Mon, 19 Jul 2004 20:43:59 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0407192042330.1373@donald.themaw.net>
References: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265048AbUGSM5v@vger.kernel.org>
In-Reply-To: <20040718185909.22648.qmail@web53801.mail.yahoo.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carl Spalletta <cspalletta@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org


Thanks Carl.

I'll have a quick check and get this to Andrew soonish.

On Sun, 18 Jul 2004, Carl Spalletta wrote:

> diff -ru linux-2.6.7-orig/fs/autofs4/autofs_i.h linux-2.6.7-new/fs/autofs4/autofs_i.h
> --- linux-2.6.7-orig/fs/autofs4/autofs_i.h      2004-06-15 22:19:42.000000000 -0700
> +++ linux-2.6.7-new/fs/autofs4/autofs_i.h       2004-07-18 08:49:11.000000000 -0700
> @@ -138,7 +138,6 @@
>  }
> 
>  struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
> -struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
>  void autofs4_free_ino(struct autofs_info *);
> 
>  /* Expiration */
> 
