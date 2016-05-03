From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Tue, 03 May 2016 15:58:38 +0800
Message-ID: <1462262318.3034.35.camel@themaw.net>
References: <20160427165250.GM30271@bccms.uni-bremen.de>
	 <1461812190.3083.101.camel@themaw.net>
	 <20160428091019.GO30271@bccms.uni-bremen.de>
	 <1461840658.3063.18.camel@themaw.net>
	 <20160428112648.GS30271@bccms.uni-bremen.de>
	 <1461894846.3033.14.camel@themaw.net>
	 <20160429141044.GA30271@bccms.uni-bremen.de>
	 <1461986471.3848.84.camel@themaw.net>
	 <20160430113600.GI30271@bccms.uni-bremen.de>
	 <1462168902.2983.72.camel@themaw.net>
	 <20160502160810.GE6794@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=l/CJ9QGNZisBYq9lAHw6jPQgDZs=; b=LuVLQD
	viYJ+PH4kgve9o9m3+3SL4hKbCjSbzKbNNt4n7xMa7Nizwlp4dI+kSwTQ7+VIf1k
	rCEopD5TZNnUH6qtXqIpkiWf0PMshonPmMNFXgWjkP5jB64X5phL3ECxjtygSvPF
	m3tw28il5jm/zW5JDLcwZMmdLvwYbwqrbn6Ns=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=l/CJ9QGNZisBYq9
	lAHw6jPQgDZs=; b=eqibQrQndbE1G/vWMyrXNRWdtnEADDoP0YJa7L/zWvx2oFR
	yD68WgEYWRF3QZWpwthq+hX1+EBurkGiKjo77/wKFaQhyMUzsp1iJN4RUJ6IydrK
	0s/ER9ISf82IKKa1CpUhlu3GXx26tpy630iAAHvH2Wg4bmTYLzVmw9WcGWi0=
In-Reply-To: <20160502160810.GE6794@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: christof.koehler@bccms.uni-bremen.de
Cc: autofs@vger.kernel.org

On Mon, 2016-05-02 at 18:08 +0200, Christof Koehler wrote:
> Hello,
> 
> I did three tests now, each with my self-built packages and the ones
> from tour ppa:
> 
> 1. multiple IPv6 addresses
> 2. square bracketed IPv6 address from map
> 3. new situation, "failover": the server has several IPv6 and one IPv4
>    address, but the server exports only to one IPv6 address
> 
> There does not appear to be any difference depending on the package
> versions
> used. Log output for each using the packages from your ppa is
> attached.

OK, I'll have a look at those.

> 
> In test 1 one address is selected based on response time, in tests 2
> there is a successfull mount using the specified address and in the
> new
> test 3 autofs starts with the address with the lowest response time
> but
> once it fails it proceeds trying the others. No user noticeable
> delays.
> 
> Especially this failover behaviour is very nice. Effectively this
> makes
> steering the address selection towards what I want from a client side
> into a server side problem ! I can simply export just to ULAs and
> autofs
> figures this out for me. Is that correct ? If so, this is all I ever
> wanted, I can put simply a readable hostname in the map and use the
> server's /etc/exports to fix the address. Sorry for not making the
> connection 
> earlier.

LOL, I didn't get it either.

The proximity and availability selection code came about originally
because Linux NFS doesn't support read-only replicated NFS mounts.
Selecting the best mount I can at mount time was all I could do.

But it has grown into an essential method of establishing if a target
server is available and what protocols are offered in a more suitable
time frame (than just trying to mount and handling error returns) for
interactive use.

So, yes, what your seeing is what it's supposed to do, ;)

Certainly, controlling what services are available for which address
only in the exports seems like the most sensible way to do what you
need, particularly for a maintenance POV.

I must admit I was a little concerned with what it sounded like you
needed to do. It seemed like there were going to be too many places were
things would need to be set properly and I thought that would quickly
become a burden.

So, hopefully, the autofs probing code will provide what you need.

> 
> On Mon, May 02, 2016 at 02:01:42PM +0800, Ian Kent wrote:
> > On Sat, 2016-04-30 at 13:36 +0200, Christof Koehler wrote:
> > 
> > I'll update the man pages to talk about libtirpc.
> > In particular I'll say that libtirpc is required for IPv6.
> Thank you. Eventually this will also alert distro maintainers that
> their
> build should change, autofs with the same libtirpc requirement than
> nfs-common. May be it goes into debian testing in time for
> ubuntu 18.04 LTS :-)
> 
> But for now rebuilding appears to work anyway. I should update the bug
> report in the ubuntu tracker.
> 
> > What I didn't see is trying different addresses over retry on
> > failure
> > but mount.nfs(8) has never claimed to do that.
> 
> And on top the failover feature in autofs does what I wanted in the
> first place. I only was not conciously aware of it.
> 
> > I also saw a few mailing list posts that implied the selection had
> > been
> > modified over time and there was mention of rfc 6724 in some posts.
> I belive the difference is primarily that some address classes were
> deprecated in the real world between, see
> https://tools.ietf.org/html/rfc6724#appendix-B
> 
> > 
> > I can help with that if there are any problems.
> 
> Works apparently now with test 2 and 3 above. So no changes needed if
> 2
> and 3 are the desired behaviour from your side ! Thank you for your
> patience.
> 
> > 
> > I don't think I require square brackets on IPv6 addresses but they
> > shouldn't cause the mount to fail either, if they are present.
> Well, apparently the string from the map is passed verbatim to mount.
> Without brackets mount is unhappy if I remember my own testing
> correctly, 
> confirm also nfs(5). According to nfs(5) mount needs them.
> 
> autofs and mount are both client side programs. So requiring square
> brackets appears to be a reasonable convention. /etc/exports is server
> side 
> and does not allow square brackets. I could live with that.

I thought I added the square brackets for some operations, I thought
mount was one, I'll need to look into that.

I'm not sure I will be able to do it but ideally I'd accept either.

But I suspect I'll probably need to require brackets, the sun format
maps already have an ambiguous syntax which makes writing a parser
generator definition really hard so not adding to that by introducing
further ambiguity in IPv6 addresses is probably best.

> 
> > 
> > It's a little hard to work out actually because the parsing code for
> > sun
> > format mount maps (but not the master map) is in several different
> > locations (a background task I have is to change this to a YACC
> > parser
> > and do almost all the parsing in one place).
> That I do not know. I see the problem.
> 
> But may be related to this:
> We are still using NIS and actually we had the autofs map in  NIS
> for years. 
> If you want I can try what happens if I put an IPv6 address into one
> of
> our nis maps (reactivate one of the autofs maps). The server is a
> debian 
> oldstable.
> 
> I removed the autofs maps from nis because I am not sure if NIS is 
> supported over IPv6 and so might not be a viable option if we have
> IPv6
> only machines as mentioned earlier. I am looking at openldap/kerberos 
> every few months trying to convince myselves that moving to it is
> worth 
> the effort compared to keeping everything in ansible managed local
> files.
> 
> There is http://www.linux-nis.org/nis-ipv6/, but a
> ldd /usr/sbin/ypbind|grep rpc comes up empty.

Actually I hadn't thought about NIS and IPv6 and I haven't seen any
discussion about it so it probably isn't ok with IPv6.

The autofs LDAP code is complicated, it's difficult to work with.

Just recently I had a very difficult problem that appeared to be caused
by an OpenLDAP build that autofs having changing from OpenSSL to NSS
(and related libraries).

There appeared to be thread safety problems with that code so all I
could do is widen the mutual exclusion regions to get around it as well
as some other not so simple changes for other problems.

Don't get me wrong, during the the investigation I found a number of
problems with the autofs code too, so I can't point the finger at others
for code that isn't quite right either, ;)

Anyway, for my part, if you have a system that your site is comfortable
with that suits your needs, and you don't have a compelling reason to
move to LDAP, I'd recommend holding back from moving to it.

> 
> > The list is constructed on the fly at mount time and those that
> > don't
> > respond are removed leaving only hosts (or addresses) that need a
> > mount
> > to be attempted.
> That is test 3 above, right ? Appears to work fine. Thank you for
> bringing this up, I got the idea then.

LOL, great.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
