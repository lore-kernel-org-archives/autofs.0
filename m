From: Christoph Hellwig <hch@lst.de>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing
 causes regression in -next was Re: 5.9.0-next-20201015: autofs oops
 in update-binfmts
Date: Sun, 18 Oct 2020 09:22:43 +0200
Message-ID: <20201018072243.GA15356@lst.de>
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net> <20201017100234.GA3797@amd> <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>, Christoph Hellwig <hch@lst.de>, kernel list <linux-kernel@vger.kernel.org>, autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Peter Anvin <hpa@zytor.com>

On Sat, Oct 17, 2020 at 11:05:06AM -0700, Linus Torvalds wrote:
> On Sat, Oct 17, 2020 at 3:02 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Bad Linus!
> 
> Christ people.
> 
> The bug is in linux-next, not in mainline.  I've told the people
> involved already over a week ago.
> 
> I can't do anything about linux-next being broken and people not fixing it.

While it took longer than I would have preferred, Al has commited the
fix to his for-next tree a few days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=4c207ef48269377236cd38979197c5e1631c8c16
