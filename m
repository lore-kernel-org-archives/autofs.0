From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 8 Jan 2004 21:08:08 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0401082106500.354-100000@donald.themaw.net>
References: <Pine.LNX.4.44.0401082026340.354-100000@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401082026340.354-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 8 Jan 2004, Ian Kent wrote:

Oh! This should have related to the comments about removing autofs from
the kernel.

Sorry about the confusion.

> On Wed, 7 Jan 2004, Mike Waychison wrote:
>
> >
> > This is a good example of why this stuff should probably be merged into
> > VFS,  autofs4 has yet to be updated to use this lock.  This comes with
> > the decision to a) no longer support it as a module, only built in, or
> > b) make vfsmount_lock accessible to modules.
>
> Please don't say it this way.
>
> A new implementation may mean current autofs becomes depricated but
> this is a deprecation process, not a slash and burn, and needs to be
> managed.
>

