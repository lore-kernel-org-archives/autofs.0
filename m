From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Wed, 27 Apr 2016 09:54:38 +0800
Message-ID: <1461722078.4208.31.camel@themaw.net>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=nsEKJhmpoXny86aCNrZk3DaZWHE=; b=NDkyvb
	B6B0/WwDGbTB7FWOKt9B1nGmOC80I+TlfYmVa8uBcgZ9dl2o17ul9N4WPxhm+L76
	hIreQm3mVr9d4UTi0wOJZ5P7bGEqQ24bIa7lvhKoo3n/HwH501RREfvs0MSLxbm+
	sA/J3DhrW/YrVHkmrVdmAXD9fUK6VoLlFY0N8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=nsEKJhmpoXny86a
	CNrZk3DaZWHE=; b=DdocIMeG5n3NFeWy3k/n3kVEU88grpOoUuw/3Y/Qpyaq8hH
	+VZ+akHcGTGyk3AZ5B4KYF8Y2Ma3uJdt3heuZyttDdkDFFzbFoM+fUIjfHJS5pZN
	8kpaN7czGCluJ3cVHYycDDpY3AKDDGLE+INpgYYuMJjGO/SwbF79xPCq4dC4=
In-Reply-To: <20160426152711.GF30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Tue, 2016-04-26 at 17:27 +0200, Christof Koehler wrote:
> Hello,
> 
> this appears to be a matryoshka of problems.

LOL, I had to look matryoshka up in the dictionary.

Perhaps but it is difficult for downstream maintainers to be up with
what's happening with packages especially when there are quite a few
changes over time.

Not only that, when those changes silently depend on other libraries
it's easy to get caught.
 
> 
> > 
> > The resulting autofs package didn't show the problem I saw with the
> > internal hosts map.
> > 
> > So I'd have to say this looks like a library version problem after
> > all.
> OK, thank you for looking into this.
> 
> > 
> > It seems to me that spending some time to work out how to provide a
> > lanchpad ppa is probably the best way to get you to a position to
> > test
> > the IPv6 functionality.
> I will configure that 16.04 vm this week and integrate it into the
> network as a "first class" workstation. It should be ready as a
> testbed
> (including snapshot capability) then for whenever it is actually
> needed.
> 
> While I am at it I will see that basic IPv6 tests (with and without
> libtirpc) are done in any case.

That will be useful.

IPv6 mounts should work, that's what we need to check first, of course.

There's been fairly limited use of the IPv6 code. I've tried to fix
things that have been reported but there are still things that need
checking.

For example, network proximity.

Because autofs provides interactive access to mounts there needs to be a
way to avoid trying to mount from hosts that are not responding and
there are some rules about multi-host selection relating to proximity
and response time.

There's also reserved port exhaustion difficulties that is increased due
to the need to calculate proximity and response time.

That's why I need to use lower level RPC calls for these tasks and
that's where the problem we have here originates.

When I wrote the IPv6 code I wasn't sure how to make the IPv6 proximity
relate to the IPv4 proximity. It should be the same for all addresses of
a multi-homed host but it might not be.

So we could have the situation where, if there are both IPv6 and IPv4
addresses for a host, one is always preferred over the other.

Then there's the question of order of addresses to try.
Should IPv6 addresses be higher priority than IPv4?

Should I even use IPv4 addresses when IPv6 addresses are present and
fall back to IPv4 if all IPv6 addresses fail?

If there is more than one distinct host and a host with only an IPv4
address is "closer" (that's the proximity question and also response
time) than another host with only an IPv6 address, what selection policy
should I use?

These probably aren't going to all be covered by us but perhaps it will
give me some more insight into the questions above.

I haven't looked at the code yet so maybe it isn't the problem I think
it might be.

And setting up a IPv6 test environment is difficult so having someone
that needs this is useful.

Thanks fr doing this.

> 
> > 
> > That also means that in time there could be a 14.04 build too, not
> > sure
> > about that though.
> We will move our workstations to 16.04.1 after it is released
> (provided 
> it has no show stoppers), so 14.04 is not important at all. Do not
> bother 
> with it.

Too late, it's already done, ;)

> 
> > 
> > I can't spend more time on this for a little while so I'll need some
> > time to work out how to do the ppa thing, if in fact I can.
> I am not sure about it. If it is easier for you to provide patches I
> can also
> recompile. Or I could provide a possibility to upload packages, the
> University has its own file hosting service (think dropbox). If I am 
> installing binary or source packages I have to trust their origin
> anyway.
> Whatever is easiest for you.

Providing packages via a ppa seems straight forward enough.

I need to remove all the packages and install from the ppa for each
release to check they work (once they have been built by the launchpad
system).

I really need to leave that for a little bit later though.

> 
> In any case take your time ! We await delivery of a new mid-size
> HPC cluster in May (completely unrelated to autofs). As soon as it is 
> here I will be absorbed in configuration and migration for some time.

LOL, you won't have much time once you get into that, ;)

Anyway, I'll reply with the ppa instructions once I've checked they work
ok.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
