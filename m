From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs - fix slab out of bounds read in
 getname_kernel()
Date: Thu, 5 Jul 2018 16:58:42 -0700
Message-ID: <20180705165842.856d66594bf695f4f688ccfa@linux-foundation.org>
References: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <153060031527.26631.18306637892746301555.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomas Bortoli <tomasbortoli@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Vyukov <dvyukov@google.com>

On Tue, 03 Jul 2018 14:45:15 +0800 Ian Kent <raven@themaw.net> wrote:

> Initial patch contributed by Tomas Bortoli.
> 
> The autofs subsystem does not check that the "path" parameter is
> present for all cases where it is required when it is passed in
> via the "param" struct.
> 
> In particular it isn't checked for the AUTOFS_DEV_IOCTL_OPENMOUNT_CMD
> ioctl command.
> 
> To solve it, modify validate_dev_ioctl() function to check that a
> path has been provided for ioctl commands that require it.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Signed-off-by: Ian Kent <raven@themaw.net>
> Reported-by: syzbot+60c837b428dc84e83a93@syzkaller.appspotmail.com

So who is the primary author of this?  I'm assuming "Tomas" from the
signoff order?

The way of signifying this is to put the other author's From: line right
at the top of changelog.

I assume this is a root-only bug, so we don't need to backport the fix?

