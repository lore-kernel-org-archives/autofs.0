From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 30 Apr 2016 11:21:11 +0800
Message-ID: <1461986471.3848.84.camel@themaw.net>
References: <1461632818.3218.29.camel@themaw.net>
	 <1461664433.3218.42.camel@themaw.net>
	 <20160426152711.GF30271@bccms.uni-bremen.de>
	 <1461722078.4208.31.camel@themaw.net>
	 <20160427165250.GM30271@bccms.uni-bremen.de>
	 <1461812190.3083.101.camel@themaw.net>
	 <20160428091019.GO30271@bccms.uni-bremen.de>
	 <1461840658.3063.18.camel@themaw.net>
	 <20160428112648.GS30271@bccms.uni-bremen.de>
	 <1461894846.3033.14.camel@themaw.net>
	 <20160429141044.GA30271@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=MN8vtfba/fm7j29+zHNhj8NTRSM=; b=KBhrgG
	gccyqGX3mdu6IbNgEwHNCyFKzaEGZHKkDxZCmpHrDdU7dhEx80WjZBJ45wcdYpQ1
	U9gqJhq2JRDYEBHl34AdB2wTdo4DpFctlw2dMIR9rkM/Ky8m4dzPOS1caZH4GD+T
	Ik65AvRMEttVl983b+7+kVNAozgMAU1wM6ihM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MN8vtfba/fm7j29
	+zHNhj8NTRSM=; b=OExPZ0Ou7oVb7RwMpPeZKUR32nBOuqLyuLW/+dFZ2BpQ9Az
	ELa2ZKCdgHFbi25viU1VU0Le8O7XGCWCKhxmEmQHYuL3pyT6u4cJeiPtQqULz9Pa
	smihAhzH/cVvUrzK3bsk2iuICPwbk+xMZjjYvjGzFj46q/QdK2mvFBW0mMp8=
In-Reply-To: <20160429141044.GA30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Fri, 2016-04-29 at 16:10 +0200, Christof Koehler wrote:
> Hello,
> 
> > 
> > Would that approach help with what you're trying to achieve?
> > 
> 
> I am not sure of anything right now anymore after noticing what mount 
> does. On top, I am not sure if I understand what you are proposing :-)

I'll need to review what we've said already for the problem with
mount.nfs(8).

> 
> So, please allow me to write down what my thinking was and what I 
> thought I needed instead of answering straight away. I will try to be
> brief about it. Maybe you have a different perspective on what I am 
> trying to do and can point out if it is unreasonable or if it is
> something with can/should be solved on mounts or autofs's level at all
> or not at all.

I can probably make suggestions but, TBH, I haven't paid enough
attention to IPv6 and the book that I originally bought to get basic
information is quite old and is out of date.

So I'm on a bit of a catchup with this.

I'll need to re-read what we've said later in this mail because there
seems to be quite a few moving parts.

I think the problems your tackling need to be simplified a lot to make
progress.

Trying to hold the big picture all at once is going to be confusing and
will make the issues seem much more complicated than they are. That
doesn't mean the big picture should be ignored when in doing this, just
not letting it block progress is the goal.

So lets take a small chunk of the problem, resolve it and look at what's
left.

> 
> Independent of that maybe a) fixing the situation where
> autofs/mount falls back to IPv4, which I understand is a bug, and b)

Partly, the situation I described so far is, IPv6 won't work at all if
not using libtirpc, that's fixed by building autofs with libtirpc
support, no big deal there, we have that already.

There is a problem with how autofs decides if a server has multiple
addresses, not hard to fix but I should check why I changed it, the
person that reported the problem might have had a good reason for
requesting the change. And may actually be what we want in the case here
anyway.

I believe we originally started talking about IPv4 fall back because of
the lack of libtirpc support in Ubuntu autofs.

That lead to a discussion about how autofs establishes the order of host
addresses it tries and I also said that, for IPv6, that's not properly
done. Unfortunately that became clouded with talk of other aspects of
what the autofs availability probe does.

The other thing that was discussed was how autofs decides whether to use
an address or a name. The answer to that is simple, if autofs thinks a
host has more than one address it will use the address not the name in
mount attempts.

That may need some work due to inconsistencies between usage of returned
addresses (having multiple addresses) and hosts available for mount
(addresses that responded to the availability check).

There was also uncertainty about how mount.nfs(8) ends with an address.
Lets leave that alone for the moment.

So I went looking and found that the order of addresses returned by
getaddrinfo(3) is in fact a modified rfc 3484 ordering.

I then responded saying this ordering may be sufficient, and a fairly
simple way to implement the needed address selection (and I mostly
ignored IPv4 with this suggestion).

I guess what I'm saying for this bit of the problem is, I think I can
just use the order of hosts returned by getaddrinfo(3) for address
ordering (ie. the order mounts are tried) and how to decided if a host
has multiple addresses should just be worked out along the way,
depending on what we actually need.

Having done that adding an autofs configuration option to not use IPv4
addresses for hosts with multiple addresses should be sufficient to
force IPv6 only use. Also not difficult but I Think will have some
special cases to consider. I didn't mention this before because I
thought the first thing to resolve was address selection.

As I say, I'll need to re-read what we have said and compare again to
the rfc ordering to work out if that is close to what you need but I had
the impression it was.

The remaining problem is that autofs will remove host addresses from the
list if it thinks they are not responding.

Availability really must be checked because trying to mount from a host
that isn't responding can result in lengthy delays which is really bad
for interactive use.

This is something of an autofs problem in itself because autofs can't
know if a host is really unavailable or simply rebooting.

This is the main reason for lengthy waits, the kernel RPC can't afford
to give up just because an RPC call takes longer than expected for fear
of causing file system corruption for NFS mounts.

But having said that, the availability check can be bypassed, if
required, by setting single autofs configuration option.

Umm .. am I in close to what we've discussed or have I misunderstood?

Will this approach move closer to what you need?

> having the possibility to pass IPv6 addresses as a result of an
> exectutable map lookup (as is possible with IPv4 adresses) is what I
> really 
> need.  I assume these two might be easier to do ? If I can pass IPv6
> addresses 
> from the exectuable map I can shell script what I think I need
> myselves. Of
> course I still have to check if passing IPv6 is actually not possible
> as
> I speculated earlier.

Right, but AFAIK (and there might be problems with it) I think that is a
mater of address specification.

The brackets vs. without brackets usage for example.

There's also the question of whether autofs handles link local addresses
properly, I think they can (or are required to) specify an interface as
well.

Certainly, there's plenty of room for inconsistent handling of addresses
so I probably will need to spend time on it.

I haven't yet had a chance to study the logs you sent so I may get more
information from them. Was there an example of this in those?

Anyway, with a little work this should be resolved and is something
that's needed.

I'm going to stop here because I think sorting out these two things
needs to be done before re-assessing what the remaining situation is.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
