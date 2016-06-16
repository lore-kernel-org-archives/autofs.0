From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: don't stuck in a loop if vfs_write returns an
 error
Date: Thu, 16 Jun 2016 15:58:48 +0800
Message-ID: <1466063928.3157.6.camel@themaw.net>
References: <1459487558-21258-1-git-send-email-avagin@gmail.com>
	 <1459496266.2974.1.camel@themaw.net>
	 <CANaxB-wWRaQYz5cku5iQ=HpA34Fzijz0UvYvFJnbCgrXHwX12A@mail.gmail.com>
	 <1464053664.3108.21.camel@themaw.net> <1464587527.3025.6.camel@themaw.net>
	 <1465435406.3154.4.camel@themaw.net>
	 <20160610120720.60e26470d41b002db9218c10@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=EK5Kt/XtCPWKcGcxf5bYfLLXQu8=; b=YPBNFu
	GNt1L/VHlZtfAwxSASNkkTCcGFSRFThhu5aGiohUc7rDJSvzzFTEKsB2wT7Wq2te
	2sXdJSS5G9h7ze3iWaqmm0Kb4lv89zoU5iPYzULQVYEJGeQoVwv38IwISgt1v69W
	jjF1WeeVIgNu3x+MgSU9pyMJtaiAiEW+Osd7w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=EK5Kt/XtCPWKcGc
	xf5bYfLLXQu8=; b=MnXfUk8wjydne71yE8KfsHFskfPOBwo7X/P094YpKkV9Np/
	NDTH0Lg8wFl0rRmeEhs/ku5AjkD8qcJzoF6mwvRw+PcW5qfC0pv2sxOFuRJZUa21
	dE5lAQ79/Pl0lwBdzQ9G0k/rkDbVDgZEcQrfCpDqay8/1Xyh1o1qPrmfPXB4=
In-Reply-To: <20160610120720.60e26470d41b002db9218c10@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrei Vagin <avagin@gmail.com>, autofs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, 2016-06-10 at 12:07 -0700, Andrew Morton wrote:
> On Thu, 09 Jun 2016 09:23:26 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > > I was getting ready to send these over to Andrew and found that opendir(3)
> > > is
> > > failing on a number of tests (51 of 230, 9 fails are expected) with 4.6.0.
> > > 
> > > It's not the patches, yours or mine and it doesn't happen with 4.4.x
> > > kernels.
> > > 
> > > Looks like I'm going to have to bisect to work out what's going on and
> > > that
> > > will
> > > take a while.
> > 
> > The regression has been fixed now.
> > 
> > Al Viro sent a patch for it to Linus yesterday, it's commit e6ec03a25f1 in
> > the
> > Linux tree.
> > 
> > I can send my patches to Andrew (after re-testing) but any autofs related
> > testing of linux.next will need the above commit.
> > 
> > Andrew, surely this isn't the first time this type of problem has happened,
> > how 
> > is it usually handled, what do I need to do to make this go smoothly?
> 
> e6ec03a25f1 is in Linus's tree now so everything should be good.

Everything was good.

There's another autofs patch in Al's for-linus tree now and I don't know when it
will go to Linus.

That one will definitely cause merge conflicts.

After thinking about it, it's probably best to defer the module rename series
until after the next merge window, after all it's not urgent (apart from being
needed for so long).

I'll send over Andrei's patch alone soonish.

Thanks all for your patience,
Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
