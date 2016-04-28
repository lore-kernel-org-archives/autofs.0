From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 18:50:58 +0800
Message-ID: <1461840658.3063.18.camel@themaw.net>
References: <1460166126.3073.20.camel@themaw.net>
	 <20160409095659.GB15153@bccms.uni-bremen.de>
	 <1461559248.3012.24.camel@themaw.net>
	 <20160425150638.GC30271@bccms.uni-bremen.de>
	 <1461632818.3218.29.camel@themaw.net> <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
	 <20160427165250.GM30271@bccms.uni-bremen.de>
	 <1461812190.3083.101.camel@themaw.net>
	 <20160428091019.GO30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=j0xpfUuF7bEM7x+g314Y5jZ/a+I=; b=vvWgU2
	kpEotCsAAU1249KgeYmXMerhGcF3DdmnVNShaK+N9tuxLMgW+fvRLIaSk6RxnB1m
	3E4chJ2YdZMSZbBi4IjsXaf6u1aiJjLmBHuFfn7v58A4Atc8MFpCW+MLc6vnkZyn
	lNBt6F9dQd2uXV9/uImj/oaiD40M3ReL+2Rxs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=j0xpfUuF7bEM7x+
	g314Y5jZ/a+I=; b=V4jOtLd1eZNsVx8hgQZJhfBBkAd2W61ifA/CSwQ4XltRAUL
	ZCnrbFshSSdDcCYqvNM0pnZmZbMOGENGfpQwaK+q65XWLPpilTjOoXtbcuQmEQTV
	ncR1/pb4Sp3AqCO5CGPMk/Vi/b9jgG8Inw1z2WMIDw/5SgMjDGesxShtlXU4=
In-Reply-To: <20160428091019.GO30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Thu, 2016-04-28 at 11:10 +0200, Christof Koehler wrote:
> 
> > 
> > Perhaps it is time to add this preference now anyway.
> 
> Perhaps I should point out that there is one more indirect factor for
> consideration: mount. 
> 
> In principle RFC 6724 also contains recommendations what IPv6 address
> to
> pick (GUA or ULA for example, or among multiple GUAs), in fact that is
> its main subject. As far as I understand it, and observed what ssh
> does,
> if there is a GUA and ULA the ULA (fd5f:... in this case) should be
> prefered (selected). Obviously mount (mount.nfs4) does not care about
> this recommendation either, in my test it choose randomly (?) one or
> the
> other IPv6 address. May be due to the order of addresses in the DNS
> reply. I will try to understand this better. 

Right, there's no guarantee of order of returned results from DNS, I
believe.

> 
> So even mount does not fully care about RFC 6724 or my basic
> assumption
> about the whole process is wrong in some way. I have to work that out.
> In
> worst case my expectation has been wrong from the beginning when I
> brought this question up.

Sounds like I'll need to actually have a look at that RFC before doing
anything, ;)

> 
> > 
> > I think the only the only question I need to answer is what
> > influence
> > (if any) response time should play between IPv4 and IPv6. I think it
> > best to not use it at all to start with (which I think should be the
> > way
> > it is now, once a v6 over v4 ordering preference is added).
> In principle I would agree, ignoring RFC6724 IPv6 address selection
> recommendations which, as you pointed out, are not covering this case
> when response times are important.
> 
> My current understanding of RFC6724 leads to two remarks then:
> 
> As far as I understand the log output you are deciding on a hard
> comparison basis, so even a one microsecond difference decides.
> However, ping times (response times) on ethernet effectively show
> random variations, sometimes in the millisecond range.

True but the worst case is you end up with a trivial load balancing
effect.

Say, for example, you had multiple distinct interfaces on a machine to
increase available throughput (believe it or not I've seen it done) then
this sort of load balancing could be beneficial.

But then we're talking about actual IPv6 address type selection ...

> In numerics (when comparing results) you would define an intervall
> where 
> numbers are considered to be effectively equal to catch rounding
> errors.
> One could use RFC6724 to decide within such an interval. I have no
> idea
> about the complexity involved, though. How does ssh handle that ?
> Probably it relies to some service mechanism to get this handled for
> it.

Still, it may be worth considering, yes.

> 
> With the above in mind  people also might like to pass hard IPv4 and
> IPv6
> addresses from the map to autofs to not rely on its decisions (because
> they (think)
> know their network better). I vaguely remember I could not put an []
> quoted IPv6 address in my executable map while IPv4 was fine or
> something like that ? Was there an earlier mail ?

Mmm .. you should be able to put addresses in the map.

I recall some problems around the issue of bracketed addresses.

Internally, some operations require not having them while others require
them and when I originally wrote the IPv6 code I didn't consider this
(in fact I wasn't ware of the conventions that were developing at the
time).

I'm fairly sure the "with or without square brackets" isn't consistent
or documented (or convention usage in autofs decided for that matter)
from an autofs user perspective.

That's something that needs to be fixed.

> 
> > 
> > > I am unsure how to reproduce what you did.
> > 
> > I'm using launchpad to provide a ppa apt source.
> > 
> > So the installed debs will replace existing packages, notably
> > libtirpc,
> > rpcbind, nfs-common and autofs.
> > 
> Yes, I did not think you had libtirpc 1.0.1 as debian package. That
> explains it then. I will have to check how to do this then.
> 
> > 
> > Don't be confused by the change in autofs configuration location in
> > autofs 5.1.1 (/etc/autofs.conf).
> > 
> > If you only change the autofs configuration in /etc/default/autofs
> > (IIRC) that will override the new configuration allowing you to
> > switch
> > between older and newer versions of autofs without configuration
> > inconsistencies.
> OK.
> 
> > 
> > I hope that the autofs ppa version will perform the mount fine, as
> > long
> > as the server is responding but that's one thing we're here to sort
> > out,
> > ;)
> > 
> If you could provide a link I can try that. Making a snapshot before
> and there
> are no problems going back.

The ppa is done, to the extent that I wanted too, so check it out.
Have a look at https://launchpad.net/~raven-au.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
