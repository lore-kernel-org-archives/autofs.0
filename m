From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an
 error
Date: Fri, 10 Jun 2016 12:07:20 -0700
Message-ID: <20160610120720.60e26470d41b002db9218c10@linux-foundation.org>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
	<1459496266.2974.1.camel@themaw.net>
	<CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
	<1464053664.3108.21.camel@themaw.net>
	<1464587527.3025.6.camel@themaw.net>
	<1465435406.3154.4.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1465435406.3154.4.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Andrei Vagin <avagin@gmail.com>, autofs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, 09 Jun 2016 09:23:26 +0800 Ian Kent <raven@themaw.net> wrote:

> > I was getting ready to send these over to Andrew and found that opendir(3) is
> > failing on a number of tests (51 of 230, 9 fails are expected) with 4.6.0.
> > 
> > It's not the patches, yours or mine and it doesn't happen with 4.4.x kernels.
> > 
> > Looks like I'm going to have to bisect to work out what's going on and that
> > will
> > take a while.
> 
> The regression has been fixed now.
> 
> Al Viro sent a patch for it to Linus yesterday, it's commit e6ec03a25f1 in the
> Linux tree.
> 
> I can send my patches to Andrew (after re-testing) but any autofs related
> testing of linux.next will need the above commit.
> 
> Andrew, surely this isn't the first time this type of problem has happened, how 
> is it usually handled, what do I need to do to make this go smoothly?

e6ec03a25f1 is in Linus's tree now so everything should be good.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
