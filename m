From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 30 Apr 2016 17:15:37 +0200
Message-ID: <20160430151536.GA31813@bccms.uni-bremen.de>
References: <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
 <20160430113600.GI30271@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462029338;
	bh=nWaVsGPDLcnwbfZiHNf/ljlNJoP1Eb2XfUyq1H+ORcc=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=zCEolpmrsV0xN3eO499leaAMqnZ3w5gyQH/G0Uyi2dAq6x82E9qUkqM7ZKut9yHVp
	 Jr8ZvnfftnO7vVA4EopCOZLYZH0dXQeRbgKtVTMda1CDsc5+6jr1QSBCQHB79UsGd+
	 H9VE2jCxhP7OBDW/CupHQ+D6wS4+Yfbu0dzayEqI=
Content-Disposition: inline
In-Reply-To: <20160430113600.GI30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

Sorry for replying to myself again ... but this is important.

>=20
> That is why I tried to explain the big picture. For me it is importan=
t that it=20
> consistently selects the ULA unless specifically instructed to do oth=
erwise.
I used this small program
http://www.logix.cz/michal/devel/various/getaddrinfo.c.xp
to check how the getaddrinfo output is actually sorted. The result (sev=
eral runs
not shown) on the vm with ubuntu 16.04 is

tckoe@core400:~$ ./a.out core330.bccms.uni-bremen.de
Host: core330.bccms.uni-bremen.de
IPv6 address: fd5f:852:a27c:1261:2000::118 (core330.bccms.uni-bremen.de=
)
IPv6 address: 2001:638:708:1261:2000::118 ((null))
IPv4 address: 192.168.220.118 ((null))
tckoe@core400:~$ ./a.out core330.bccms.uni-bremen.de
Host: core330.bccms.uni-bremen.de
IPv6 address: 2001:638:708:1261:2000::118 (core330.bccms.uni-bremen.de)
IPv6 address: fd5f:852:a27c:1261:2000::118 ((null))
IPv4 address: 192.168.220.118 ((null))

So clearly IPv6 is sorted before IPv4 (40 program runs) but the orderin=
g of=20
IPv6 addresses is not guaranteed. My basic assumption was wrong in that
respect. getaddrinfo does not reliably prefer the ULA if left alone.=20

Adding "precedence  fc00::/7      45" to /etc/gai.conf (destination
address selection rule) fixes checking with 20 tests the order in the g=
etaddrinfo=20
output. Source address selection ("ip addrlabel") does not come into
this.

To conclude: Even without the response time considerations using pure
getaddrinfo output would not have done what I wanted. If I had not
noticed mount behaving against my expectations I might not have tested
this.

Second, I modified the map with an square bracketed IPv6 address instea=
d=20
of a hostname. Using my own autofs package recompiled against libtirpc.=
=20
Trying to mount I see that passing the IPv6 address to autofs in fact
appears to work now, it mounts as expected. See attached log fragment.
Response time checks do not appear to be actually used which is reasona=
ble.
So the idea that there was a problem was probably an artefact of using =
that
autofs binary without libtiprc on 14.04 , too.

Appart from somehow dealing with the general question of perhaps
making libtirpc a requirement the only request remaining from my
perspective is:
- Would it be possible to document the libtirpc requirement for IPv6 in
  the man page along with a warning about autofs's current behaviour=20
  without libtirpc if IPv6 is available ? That might also warn
  distro maintainers.

I think everything is else is settled then. Thank you very much for you
patients and help. And my appologies for perhaps wasting some of your
time, I should have checked getaddrinfo's output directly when you ment=
ioned it.=20

I will try the binaries from your ppa next week to see if anything chan=
ges.
If you would like to test other things a will of course try to help wit=
h
that, too.

Still, I may be a able to save you a bit of time looking up the
interface specifier conventions and requirements for link local
addresses if you still need that information.

getaddrinfo(3) reads  "getaddrinfo() supports the address%scope-id nota=
tion for=20
specifying the IPv6 scope-ID". Here scope-ID can mean interface as in
"%eth0" for link local addresses. So the syntax is quite universal.
Confirm RFC 4007 Section 11 on which this is probably based.

Making an interface specifier a required address component when using l=
ink local=20
addresses would be consistent with the example in nfs(5)=20
"This  example  shows  how to mount an NFS server using a raw IPv6 link=
-
 local address.
 [fe80::215:c5ff:fb3e:e2b1%eth0]:/export /mnt nfs defaults 0 0"
which I would read to imply that %interface must always be supplied wit=
h
link local addresses, although it does not say so directly in the text.

This requirement would also be conforming to RFC 4007, e.g. Section 11

"
As already mentioned, to specify an IPv6 non-global address without
   ambiguity, an intended scope zone should be specified as well.  As a
   common notation to specify the scope zone, an implementation SHOULD
   support the following format:
            <address>%<zone_id>

=2E..

An implementation could also use interface names as <zone_id> for
   scopes larger than links, but there might be some confusion in this
   use.=20
"



Have a nice Weekend, thank you very much for all your effort and again =
my=20
apologies for checking some thinks too late !


Best Regards

Christof

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
