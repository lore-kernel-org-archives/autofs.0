From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 5/7] autofs4 - fix direct mount pending expire race
Date: Sat, 19 Jul 2008 15:21:03 +0800
Message-ID: <1216452065.3210.25.camel@raven.themaw.net>
References: <20080718023651.12802.59107.stgit@raven.themaw.net>
	 <20080718023725.12802.74137.stgit@raven.themaw.net>
	 <x49bq0vc5wb.fsf@segfault.boston.devel.redhat.com>
	 <1216433386.3210.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1216433386.3210.16.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>


On Sat, 2008-07-19 at 10:09 +0800, Ian Kent wrote:
> On Fri, 2008-07-18 at 16:08 -0400, Jeff Moyer wrote:
> > 
> > This makes me uneasy.  This should take d_mounted to zero.  Then, when
> > the daemon actually does the unmount, won't the d_mounted drop below
> > zero?  Following calls to d_mountpoint will return a negative value, but
> > everyone treats it as a boolean, so it will evaluate to true for a brief
> > time.  Or did I miss something?
> 
> Yes, I thought about doing exactly that.
> 
> But the thing that effects d_mounted is mounted on the dentry and so
> d_mounted may be decremented during the expire. So if we set it
> explicitly it would be incorrect at the end. While the
> decrement/increment isn't always correct throughout the expire we need
> to handle the mount following in ->follow_link() anyway and then the
> decrement/increment ends up with the correct value once the expire is
> complete.
> 
> One problem that has occurred to me is that user space could could
> manually umount it just when we change it. So a follow up patch to add a
> lock around the increment/decrement in fs/namespace.c and
> fs/autofs4/expire.c is in order. I'm having a look at that now.

DOH, this is rubbish.

I often wonder why I forget what I've done so quickly.

Of course user space can't umount this because every process except the
daemon is blocked in ->follow_link() during the expire. But we can't
rely on the the return from user space and cannot know if the mount was
actually umounted so the decrement/increment will maintain the
status-quo. If d_mounted does become negative during the expire then we
will still be sent to ->follow_link() as follow_down() will fail.

Ian

