From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 29 Apr 2016 16:42:50 +0200
Message-ID: <20160429144250.GD30271@bccms.uni-bremen.de>
References: <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461940972;
	bh=yNKKustrUtzIGTEP8EuHFpofGqX2zJfahwa/nF6FT18=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=L5Zb8Ch7HAV3Rdujp48P1O1gM4husiFF9t6fTDvhq/g5LXf2SJ3EuItzo6lyyeE4e
	 UxROsDr+kSthrmvTpuc3HY+guyT4Eb+qNfYsoo7QF/bMx0eIRBo/P65lsBcRKTn25C
	 dGGSrSOznqtDdo/vbvnzA1YUpBfOJrpS+mEYCmtU=
Content-Disposition: inline
In-Reply-To: <20160429141044.GA30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

I should add that routers usually do not carry routes for ULAs in the
first place, because every individual can generate his own addresses ou=
t
of fc00::/7 and there is no central registration authority or even a=20
requirement. Our packets would in the worst case vanish at the DFN [1]=20
exchange nodes to the internet if they ever would leak out of the=20
universities network. And there is no route into the universities
network for any ULA. So it is IMHO a bit better than pure security by o=
bscurity.

[1] https://en.wikipedia.org/wiki/Deutsches_Forschungsnetz

On Fri, Apr 29, 2016 at 04:10:44PM +0200, Christof Koehler wrote:
> Hello,
>=20
> >=20
> > Would that approach help with what you're trying to achieve?
> >=20
>=20
> I am not sure of anything right now anymore after noticing what mount=
=20
> does. On top, I am not sure if I understand what you are proposing :-=
)
>=20
> So, please allow me to write down what my thinking was and what I=20
> thought I needed instead of answering straight away. I will try to be
> brief about it. Maybe you have a different perspective on what I am=20
> trying to do and can point out if it is unreasonable or if it is
> something with can/should be solved on mounts or autofs's level at al=
l
> or not at all.
>=20
> Independent of that maybe a) fixing the situation where
> autofs/mount falls back to IPv4, which I understand is a bug, and b)
> having the possibility to pass IPv6 addresses as a result of an
> exectutable map lookup (as is possible with IPv4 adresses) is what I =
really=20
> need.  I assume these two might be easier to do ? If I can pass IPv6 =
addresses=20
> from the exectuable map I can shell script what I think I need myselv=
es. Of
> course I still have to check if passing IPv6 is actually not possible=
 as
> I speculated earlier.
>=20
> But please read on keeping in mind that the original observation whic=
h started=20
> this was my surprise discovering autofs/mount suddenly falling back t=
o IPv4 while
> I was still naively assuming IPv6 would simply work at that time.
>=20
> As you know it is completely normal with IPv6 that a machine (server =
or client)=20
> has several IP adresses: link local fe80:: (always there, I will igno=
re
> it), one (or more) statically assigned 2001:: GUAs (-> DNS AAAA), dyn=
amically=20
> assigned GUA/derived GUA privacy address, fd5f:: ULA (should not be i=
n public=20
> visible DNS and should not get routed beyond the organizations bounda=
ry) and on=20
> top of that one IPv4 address.
>=20
> In the first (out of the box) setup we had (GUA only) mount/autofs (a=
nd=20
> everything else like ssh) were happiliy using the privacy address wit=
h limited=20
> lifetime to connect to (NFS) servers, both workstations and dedicted=20
> fileservers. This strikes me as problematic for several reasons:
> 1. The privacy address is supposed to change after some time (old
>    becomes deprecated), so I cannot easily identify the client on the=
 server
> 2. I have to NFS export unconditionally to at least a whole /64. I li=
ke to
>    export on a per client basis, either hostname or IP; but see [1]
> 3. If the lifetime of the privacy address ends it becomes deprecated =
and
>    (I did not test that) NFS requests my then suddenly arrive from th=
e
>    current privacy address while the mount was made via a no longer
>    existing (or at least deprecated) one ? Not sure, but I would like=
 to avoid=20
>    situations like that from the beginning.
>=20
> Manually adding the two addrlabels mentioned in my previous mail make=
s sure=20
> that the clients will use their statically assigned GUAs to connect t=
o the
> servers if using mount or autofs with only a single IPv6 GUA entry in=
 the
> private DNS.
>=20
> Still, I was not completely at ease with using GUAs like this:
> 1. You have to make sure/be sure the manual addrlabel is always there
>    and you might forget that there was a modification to defaults at
>    inconvenient moments ("principle of least undocumented change" ;-)
> 2. The NFS servers/clients are on a GUAs and might leak in theory tra=
ffic=20
>    all over the internet. In our situation we have to use VRF routing=
 on the
>    Universities Cisco 6500 Routers, one typo and we get world
>    accessible. Of course there a firewalls and ip6table rules on the
>    servers themselves. Also client traffic might get misdirected and =
leak out=20
>    on a GUA. On top,  rpc listening on every address it can find and =
the=20
>    kitchen sink is a little problem anyway.  See also [1].
> 3. The NFS servers share a /64 with random laptops; we (i.e. "me" ) c=
ould put
>    different VLANs on different wall outlets, but in practice with th=
e
>    way people (scientists) behave ...
>=20
> In theory using ULAs instead of GUAs for NFS sounds like a nice thing
> then.=20
>=20
> Favouring ULA over GUA if possible is the RFC's default, so no manual
> addrlabel required.
> Internal traffic would use ULAs (which all routers here blackhole) an=
d
> therefore stays internal. Outside DNS queries would not resolve ULAs
> anyway. Only traffic directed outside goes outside using the=20
> approrpiate GUAs. There is a weak separation from the laptops, they c=
an
> still ssh in via the static GUA assigned to every server (workstation=
),
> but I can restrict NFS exports to the known ULAs easily.=20
> On top, in the unlikely event that we ever have to
> change GUAs ("renumbering" in IPv6 terms) the ULAs would stay stable.
>=20
> Only: neither mount (which I just discovered now) nor autofs take the=
 ULA=20
> vs. GUA preference or the possibility that not all addresses might be
> equal into account as I initially assumed, with autofs eventually eve=
n falling=20
> back to IPv4 due to the bug you mentioned. So this is where my idea t=
o
> use ULAs clearly does not work. I am no longer sure it should work,
> anyway.  Also, as you can see I could work with GUAs only, but someon=
e else=20
> might stumble upon the same situation later if IPv6 ever gets real wi=
despread.
>=20
>=20
> Thank you very much for reading all this !
>=20
>=20
> Best Regards
>=20
> Christof
>=20
> [1] I am aware that with NFS4 the solution is of course to use Kerber=
os
> security. However, currently the old cluster (Ubuntu 10.04 with hand
> rolled kernels, drivers and OFED stack; tcp6 transport for NFS is onl=
y
> available on 10.10 or later) is using the same servers and when a
> Kerberos Ticket runs out while a calculation is running (think 10 day
> jobs) you have a problem. Also queuing systems (Toreque/Maui, SLURM) =
are not=20
> really able to take care of Kerberos for the user. This situation wil=
l change=20
> with the new cluster which is completely separated.  Then I will thin=
k about=20
> moving to Kerberos again.
>=20
>=20
> --=20
> Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-b=
remen.de
> Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> 28359 Bremen =20
>=20
> PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
