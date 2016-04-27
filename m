From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Wed, 27 Apr 2016 10:27:23 +0800
Message-ID: <1461724043.4208.38.camel@themaw.net>
References: <1460090760.3135.53.camel@themaw.net>
	 <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net> <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=0nErOcwHHNYxMHPUrF90dSUSYdU=; b=WfETPy
	R2Ia4eh/OVeifeMxuGh2zvaB3x1WeTgc40J46OCFIFk5f8mSSAJHJyzxjsv/YLjc
	Htc2B41lUWYYqJrZOqhxYYE/UJ5oJb0751o2N44f1tNfF6rxDOrzfraDGGnewiKZ
	9rLQkrcN1rMurM1j1x9o/BBsSHeFuwYarrmc0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0nErOcwHHNYxMHP
	UrF90dSUSYdU=; b=rSEOZ39EXT3tCMWfAHi3v122Emx+QpN/wk+nV/aftZsMvfQ
	Lqct+N4Ql9EPqdcFoLyBTfOidd5SM2cCQnR+7rPYRVomM7auoCFfdnnL/ncBYew8
	S6ZpkxAySZ48TccKYFBACsoNGxbvoBM+9ZyVfa7F4rXRiTWle0/l+2eOfrf0=
In-Reply-To: <1461722078.4208.31.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Wed, 2016-04-27 at 09:54 +0800, Ian Kent wrote:
> On Tue, 2016-04-26 at 17:27 +0200, Christof Koehler wrote:
> > 
> > While I am at it I will see that basic IPv6 tests (with and without
> > libtirpc) are done in any case.
> 
> That will be useful.

Don't forget that the glibc RPC implementation shouldn't work with IPv6
and autofs relies on RPC calls for it's proximity and availability
checks so IPv6 without libtirpc probably won't work and that's what we
have seen so far.

You can set some specific autofs configuration options to prevent the
proximity and availability checks for most cases in which case the host
name would be passed on to mount.nfs(8) and work ok for IPv6 mounting to
the extent that mount.nfs(8) does.

But that's not really testing autofs IPv6 handling though.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
