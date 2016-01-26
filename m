From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs: show pipe inode in mount options
Date: Tue, 26 Jan 2016 11:55:56 +0800
Message-ID: <1453780556.3067.15.camel@themaw.net>
References: <20151216120222.19097.54512.stgit@localhost.localdomain>
	 <568E8840.3010801@odin.com> <1452237640.2973.19.camel@themaw.net>
	 <568F9D85.6070601@odin.com> <1452257913.7030.25.camel@themaw.net>
	 <568FD028.5090207@odin.com> <1452303110.3067.29.camel@themaw.net>
	 <5693931F.9070101@odin.com> <56A213CA.5090704@odin.com>
	 <1453509017.3042.7.camel@themaw.net>
	 <20160126101907.388686e7@canb.auug.org.au>
	 <20160125154834.3afe2ede52d0342b61120943@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=ji4MvQsgbDYZXz1+auexryL4J8I=; b=I22Hbg
	5Nc1Ki4f9r+IiSMO2004NRixsmWM6uKg2RoIir1veF+ob89VpefVPQ3YTCjoNstS
	ccjAH+iuLk2mzCQZfQjbF4qsyAhzzDZYV3cEUaoBkqyvzR2SzSct3CetlzqQgaKH
	S5JVHJWRW6EWmuWicIitn6CxuhkUXhxHLrBTc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ji4MvQsgbDYZXz1
	+auexryL4J8I=; b=ANBo75Helax7Ay/hibJhZwlul23eihEeuHxe9Kxs4y9jJyP
	wyFZXAljnVO95iFqMxINo4D4BwEJjfEX6IeqI/+ANF3snbP4ckX1K1bVAraFCp7h
	y2aipBjXPa7ygVjG6ChgnN2XFT8EiNnku8Rgh8Vsuo9Qs+aDPKLHNU/zi17g=
In-Reply-To: <20160125154834.3afe2ede52d0342b61120943@linux-foundation.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: skinsbursky@virtuozzo.com, criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>

On Mon, 2016-01-25 at 15:48 -0800, Andrew Morton wrote:
> On Tue, 26 Jan 2016 10:19:07 +1100 Stephen Rothwell <
> sfr@canb.auug.org.au> wrote:
> 
> > Hi Ian,
> > 
> > On Sat, 23 Jan 2016 08:30:17 +0800 Ian Kent <raven@themaw.net>
> > wrote:
> > > 
> > > I haven't had anything significant enough for autofs to warrant
> > > maintaining a tree and sending push requests so I'll need to ask
> > > Stephen what I need to do (perhaps you could offer some advise on
> > > that
> > > now Stephen, please).
> > 
> > I guess if its just a few patches every now and then, then Andrew
> > Morton may be the best person to shepherd them upstream.
> 
> yup, send 'em along.
> 
> I actually was handling the autofs4 stuff back in 2014 for a bit.

Thanks Andrew.

Last time I tried to send the module rename series we got confused some
how, patches not seen leading to conflicts in applying later patches
IIRC, which lead to the recommendation I send them to linux-next.

The series has grown a bit too now but I'm thinking I should send them
in smaller groups, such as coding style fixes and white space fixes,
change to use pr* logging, etc.

Hopefully that will make the process much more straight forward.

The thing is the patches are mostly not urgent which is why I keep
postponing sending them when higher priority things come up.

As for the patch from Stanislav, I'll put that at the top of my patch
queue, have a quick look at it and send it over so that, hopefully, it
can get merged.

I'll probably send a couple of others too to get things going on with
(what I'm calling) the module rename series.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
