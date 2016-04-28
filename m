From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 13:26:48 +0200
Message-ID: <20160428112648.GS30271@bccms.uni-bremen.de>
References: <1461559248.3012.24.camel@themaw.net>
 <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461842809;
	bh=/vaBsmXznZQzlUAZ6dWLop4gAlWS/1geS1R494bb+mQ=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=Z6OXLhIXaBxKEMg/YhHuCaPlplaPMqAu9hf6KWwxj5Ms0swxAkZfvRyugYQBSsuF+
	 TMVOSpfEZgl35qsacu+fIV0wwMmFBPjMrvMUlxDMQGzYOQeGGZLM/b/GF4oXLuXa/f
	 gNB1rxoBXbSO1LOD1JoynSwcy0ZAxPUE5QH3wNig=
Content-Disposition: inline
In-Reply-To: <1461840658.3063.18.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

On Thu, Apr 28, 2016 at 06:50:58PM +0800, Ian Kent wrote:
> On Thu, 2016-04-28 at 11:10 +0200, Christof Koehler wrote:
>=20
> Sounds like I'll need to actually have a look at that RFC before doin=
g
> anything, ;)
These might be nicer reads:
http://biplane.com.au/blog/?p=3D22
http://biplane.com.au/blog/?p=3D30

Please note that the actual "ip addrlabel" output on a pristine 16.04
is=20
prefix ::1/128 label 0=20
prefix ::/96 label 3=20
prefix ::ffff:0.0.0.0/96 label 4=20
prefix 2001::/32 label 6=20
prefix 2001:10::/28 label 7=20
prefix 3ffe::/16 label 12=20
prefix 2002::/16 label 2=20
prefix fec0::/10 label 11=20
prefix fc00::/7 label 5=20
prefix ::/0 label 1
so that catches ULAs in the fc00::/7 already with a label separating
them. I additional add
prefix 2001:638:708:1261:2000::/96 label 99=20
prefix 2001:638:708:1261:1000::/96 label 99
but that should not matter.

> > However, ping times (response times) on ethernet effectively show
> > random variations, sometimes in the millisecond range.
>=20
> True but the worst case is you end up with a trivial load balancing
> effect.

If addresses are equivalent that is a desirable effect. My goal however
was to distinguish between GUA and ULA relying on the RFC for selection
to avoid headaches. I will have to rethink this for sure.

> Say, for example, you had multiple distinct interfaces on a machine t=
o
> increase available throughput (believe it or not I've seen it done) t=
hen
> this sort of load balancing could be beneficial.

Yes, been there, done that; but I would consider that something no long=
er needed=20
in this enlightened age:
https://help.ubuntu.com/community/UbuntuBonding#Descriptions_of_bonding=
_modes
Especially Mode 4. But I think you know them :-)


>=20
> Mmm .. you should be able to put addresses in the map.
I will try again to make sure.

>=20
> The ppa is done, to the extent that I wanted too, so check it out.
> Have a look at https://launchpad.net/~raven-au.
>=20
Thank you, I will try and report back.


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
