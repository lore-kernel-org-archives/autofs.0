From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 14:40:12 +0200
Message-ID: <20160428124012.GW30271@bccms.uni-bremen.de>
References: <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461847213;
	bh=nAfZCaiv5MubnIB/7pBj6xyLSNVqwDV6b1LZ3uINhPc=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=yAI6AVrOSQ7kBLQbMOe0eTqmcLElyAawapBlSZdwYr//lsLMtDFUiDFc76U/hfQoP
	 z6AtkTPOI9WtbkeEAwtuFXR57yw0oDopwr40e1fj4lbHHAJ1pqGGAZ2xrEVFChjb6X
	 /NyDZkNvN1BN4l/Gqu2TFLVNIfraPKb/7jiLL9fc=
Content-Disposition: inline
In-Reply-To: <20160428112648.GS30271@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,
I should add http://biplane.com.au/blog/?p=3D122 for the easy read on=20
destination address selection (/etc/gai.conf).

Quite a machinery if the application chooses to use it.

Best Regards

Christof

On Thu, Apr 28, 2016 at 01:26:48PM +0200, Christof Koehler wrote:
> Hello,
>=20
> On Thu, Apr 28, 2016 at 06:50:58PM +0800, Ian Kent wrote:
> > On Thu, 2016-04-28 at 11:10 +0200, Christof Koehler wrote:
> >=20
> > Sounds like I'll need to actually have a look at that RFC before do=
ing
> > anything, ;)
> These might be nicer reads:
> http://biplane.com.au/blog/?p=3D22
> http://biplane.com.au/blog/?p=3D30
>=20
> Please note that the actual "ip addrlabel" output on a pristine 16.04
> is=20
> prefix ::1/128 label 0=20
> prefix ::/96 label 3=20
> prefix ::ffff:0.0.0.0/96 label 4=20
> prefix 2001::/32 label 6=20
> prefix 2001:10::/28 label 7=20
> prefix 3ffe::/16 label 12=20
> prefix 2002::/16 label 2=20
> prefix fec0::/10 label 11=20
> prefix fc00::/7 label 5=20
> prefix ::/0 label 1
> so that catches ULAs in the fc00::/7 already with a label separating
> them. I additional add
> prefix 2001:638:708:1261:2000::/96 label 99=20
> prefix 2001:638:708:1261:1000::/96 label 99
> but that should not matter.
>=20
> > > However, ping times (response times) on ethernet effectively show
> > > random variations, sometimes in the millisecond range.
> >=20
> > True but the worst case is you end up with a trivial load balancing
> > effect.
>=20
> If addresses are equivalent that is a desirable effect. My goal howev=
er
> was to distinguish between GUA and ULA relying on the RFC for selecti=
on
> to avoid headaches. I will have to rethink this for sure.
>=20
> > Say, for example, you had multiple distinct interfaces on a machine=
 to
> > increase available throughput (believe it or not I've seen it done)=
 then
> > this sort of load balancing could be beneficial.
>=20
> Yes, been there, done that; but I would consider that something no lo=
nger needed=20
> in this enlightened age:
> https://help.ubuntu.com/community/UbuntuBonding#Descriptions_of_bondi=
ng_modes
> Especially Mode 4. But I think you know them :-)
>=20
>=20
> >=20
> > Mmm .. you should be able to put addresses in the map.
> I will try again to make sure.
>=20
> >=20
> > The ppa is done, to the extent that I wanted too, so check it out.
> > Have a look at https://launchpad.net/~raven-au.
> >=20
> Thank you, I will try and report back.
>=20
>=20
> Best Regards
>=20
> Christof
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
