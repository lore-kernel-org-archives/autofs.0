From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [NFS] nfs or autofs related hangs
Date: Sun, 15 Feb 2004 19:53:52 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040215222107.7E4382C2D8@lists.samba.org>
References: <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net>
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-reply-to: Your message of "Sun, 08 Feb 2004 23:32:08 +0800."
             <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> 
List-Id: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net

In message <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> you write:
> +static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;

Is this __cacheline_aligned_in_smp really required?

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
