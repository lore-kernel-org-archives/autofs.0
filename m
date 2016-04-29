From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 29 Apr 2016 09:54:06 +0800
Message-ID: <1461894846.3033.14.camel@themaw.net>
References: <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net> <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
	 <20160427165250.GM30271@bccms.uni-bremen.de>
	 <1461812190.3083.101.camel@themaw.net>
	 <20160428091019.GO30271@bccms.uni-bremen.de>
	 <1461840658.3063.18.camel@themaw.net>
	 <20160428112648.GS30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=DO9vVA1ky+ZQOwEqvGaM8brX2qE=; b=ceqcdP
	nKt4rE6UE36V9npUZZGSkRKTlwaIojHa5NoAcdrb6Z35J1ImlTf5N9lk7zsusON7
	tdsOL8leNjibYQ4VYKBt7twsWxcZGbnKdAtLXjgOewobfuviICLMgm+SU3G+cUgr
	IXOFzarhuoMOb73i6kW8N0c90KnDhNvHjMvJ8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=DO9vVA1ky+ZQOwE
	qvGaM8brX2qE=; b=aYkkyszltEjFVzD3Q9e5Q5RZ0erigFTvPJGi1J9g2f/d+Z8
	FlD6PfDgbSA7pUI17d6eplIckYHiYpuNSFrBc+cGllp/yzs9keDf/1zQ8Kzno8Wr
	pY/NqH2vBCd548qzOPRe3pcwZhiD2IpfLJceYY0ThT5r6mTmjuTVTrwoqX0w=
In-Reply-To: <20160428112648.GS30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Thu, 2016-04-28 at 13:26 +0200, Christof Koehler wrote:
> Hello,
> 
> On Thu, Apr 28, 2016 at 06:50:58PM +0800, Ian Kent wrote:
> > On Thu, 2016-04-28 at 11:10 +0200, Christof Koehler wrote:
> > 
> > Sounds like I'll need to actually have a look at that RFC before
> > doing
> > anything, ;)
> These might be nicer reads:
> http://biplane.com.au/blog/?p=22
> http://biplane.com.au/blog/?p=30
> 
> Please note that the actual "ip addrlabel" output on a pristine 16.04
> is 
> prefix ::1/128 label 0 
> prefix ::/96 label 3 
> prefix ::ffff:0.0.0.0/96 label 4 
> prefix 2001::/32 label 6 
> prefix 2001:10::/28 label 7 
> prefix 3ffe::/16 label 12 
> prefix 2002::/16 label 2 
> prefix fec0::/10 label 11 
> prefix fc00::/7 label 5 
> prefix ::/0 label 1
> so that catches ULAs in the fc00::/7 already with a label separating
> them. I additional add
> prefix 2001:638:708:1261:2000::/96 label 99 
> prefix 2001:638:708:1261:1000::/96 label 99
> but that should not matter.
> 
> > > However, ping times (response times) on ethernet effectively show
> > > random variations, sometimes in the millisecond range.
> > 
> > True but the worst case is you end up with a trivial load balancing
> > effect.
> 
> If addresses are equivalent that is a desirable effect. My goal
> however
> was to distinguish between GUA and ULA relying on the RFC for
> selection
> to avoid headaches. I will have to rethink this for sure.

I've had a quick look at this and I'm not sure I need to do much at all
to help with this.

The proximity values I use for list insertion are fairly simple mined
and I use gataddrinfo(3) everywhere.

If I add an additional sort value for IPv6 addresses that lies between
local address proximity and the next lower proximity sort value and use
the order of addresses returned by getaddrinfi(3) I should get an order
that is rfc 3484 with some adjustments made by glibc for real world
experience and possibly some adjustments related to rfc 6724 to the
extent glibc has been willing to adopt them.

All I would need to do then is check the local interface comparison code
since addresses corresponding to a local interface have special
handling.

The only difficulty would be with IPv4 addresses that also correspond to
a local interface, due to the special handling.

Would that approach help with what you're trying to achieve?

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
