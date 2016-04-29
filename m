From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 29 Apr 2016 16:10:44 +0200
Message-ID: <20160429141044.GA30271@bccms.uni-bremen.de>
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
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461939045;
	bh=neFfAIIy1VkZ55M3Dqe47yHUFngGFTxZ3UXIIZO6W7M=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=uPBvDK9qgafTS4OsZ82Y6M1Wt5qXzoizQwkbV1FMlJjiJIrwujvewATamKFo8viiO
	 rWH9M+whyBsdJQFs/CY5bWOIvN1CXWWERqqcA3nip3qK8zTrQUo2l6tXWHXK/0ktjq
	 gsydk7GdPPvfyWzuRwuJcje3S9Geaz5QZwkqhukM=
Content-Disposition: inline
In-Reply-To: <1461894846.3033.14.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

>=20
> Would that approach help with what you're trying to achieve?
>=20

I am not sure of anything right now anymore after noticing what mount=20
does. On top, I am not sure if I understand what you are proposing :-)

So, please allow me to write down what my thinking was and what I=20
thought I needed instead of answering straight away. I will try to be
brief about it. Maybe you have a different perspective on what I am=20
trying to do and can point out if it is unreasonable or if it is
something with can/should be solved on mounts or autofs's level at all
or not at all.

Independent of that maybe a) fixing the situation where
autofs/mount falls back to IPv4, which I understand is a bug, and b)
having the possibility to pass IPv6 addresses as a result of an
exectutable map lookup (as is possible with IPv4 adresses) is what I re=
ally=20
need.  I assume these two might be easier to do ? If I can pass IPv6 ad=
dresses=20
from the exectuable map I can shell script what I think I need myselves=
=2E Of
course I still have to check if passing IPv6 is actually not possible a=
s
I speculated earlier.

But please read on keeping in mind that the original observation which =
started=20
this was my surprise discovering autofs/mount suddenly falling back to =
IPv4 while
I was still naively assuming IPv6 would simply work at that time.

As you know it is completely normal with IPv6 that a machine (server or=
 client)=20
has several IP adresses: link local fe80:: (always there, I will ignore
it), one (or more) statically assigned 2001:: GUAs (-> DNS AAAA), dynam=
ically=20
assigned GUA/derived GUA privacy address, fd5f:: ULA (should not be in =
public=20
visible DNS and should not get routed beyond the organizations boundary=
) and on=20
top of that one IPv4 address.

In the first (out of the box) setup we had (GUA only) mount/autofs (and=
=20
everything else like ssh) were happiliy using the privacy address with =
limited=20
lifetime to connect to (NFS) servers, both workstations and dedicted=20
fileservers. This strikes me as problematic for several reasons:
1. The privacy address is supposed to change after some time (old
   becomes deprecated), so I cannot easily identify the client on the s=
erver
2. I have to NFS export unconditionally to at least a whole /64. I like=
 to
   export on a per client basis, either hostname or IP; but see [1]
3. If the lifetime of the privacy address ends it becomes deprecated an=
d
   (I did not test that) NFS requests my then suddenly arrive from the
   current privacy address while the mount was made via a no longer
   existing (or at least deprecated) one ? Not sure, but I would like t=
o avoid=20
   situations like that from the beginning.

Manually adding the two addrlabels mentioned in my previous mail makes =
sure=20
that the clients will use their statically assigned GUAs to connect to =
the
servers if using mount or autofs with only a single IPv6 GUA entry in t=
he
private DNS.

Still, I was not completely at ease with using GUAs like this:
1. You have to make sure/be sure the manual addrlabel is always there
   and you might forget that there was a modification to defaults at
   inconvenient moments ("principle of least undocumented change" ;-)
2. The NFS servers/clients are on a GUAs and might leak in theory traff=
ic=20
   all over the internet. In our situation we have to use VRF routing o=
n the
   Universities Cisco 6500 Routers, one typo and we get world
   accessible. Of course there a firewalls and ip6table rules on the
   servers themselves. Also client traffic might get misdirected and le=
ak out=20
   on a GUA. On top,  rpc listening on every address it can find and th=
e=20
   kitchen sink is a little problem anyway.  See also [1].
3. The NFS servers share a /64 with random laptops; we (i.e. "me" ) cou=
ld put
   different VLANs on different wall outlets, but in practice with the
   way people (scientists) behave ...

In theory using ULAs instead of GUAs for NFS sounds like a nice thing
then.=20

=46avouring ULA over GUA if possible is the RFC's default, so no manual
addrlabel required.
Internal traffic would use ULAs (which all routers here blackhole) and
therefore stays internal. Outside DNS queries would not resolve ULAs
anyway. Only traffic directed outside goes outside using the=20
approrpiate GUAs. There is a weak separation from the laptops, they can
still ssh in via the static GUA assigned to every server (workstation),
but I can restrict NFS exports to the known ULAs easily.=20
On top, in the unlikely event that we ever have to
change GUAs ("renumbering" in IPv6 terms) the ULAs would stay stable.

Only: neither mount (which I just discovered now) nor autofs take the U=
LA=20
vs. GUA preference or the possibility that not all addresses might be
equal into account as I initially assumed, with autofs eventually even =
falling=20
back to IPv4 due to the bug you mentioned. So this is where my idea to
use ULAs clearly does not work. I am no longer sure it should work,
anyway.  Also, as you can see I could work with GUAs only, but someone =
else=20
might stumble upon the same situation later if IPv6 ever gets real wide=
spread.


Thank you very much for reading all this !


Best Regards

Christof

[1] I am aware that with NFS4 the solution is of course to use Kerberos
security. However, currently the old cluster (Ubuntu 10.04 with hand
rolled kernels, drivers and OFED stack; tcp6 transport for NFS is only
available on 10.10 or later) is using the same servers and when a
Kerberos Ticket runs out while a calculation is running (think 10 day
jobs) you have a problem. Also queuing systems (Toreque/Maui, SLURM) ar=
e not=20
really able to take care of Kerberos for the user. This situation will =
change=20
with the new cluster which is completely separated.  Then I will think =
about=20
moving to Kerberos again.


--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
