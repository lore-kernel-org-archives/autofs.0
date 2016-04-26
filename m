From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Tue, 26 Apr 2016 17:27:11 +0200
Message-ID: <20160426152711.GF30271@bccms.uni-bremen.de>
References: <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
 <1460166126.3073.20.camel@themaw.net>
 <20160409095659.GB15153@bccms.uni-bremen.de>
 <1461559248.3012.24.camel@themaw.net>
 <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461684433;
	bh=4sZEec+1jQgXuYr4qfC+CGPssU+b5BKbn9dbzIh+3CI=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=euUtbYspxqt1vQk9DvBXEx/6TIIgdqKcIxBByJbgykjtzBFrk0nUQn5WHpP4Z8rhD
	 ZyuYCZ6b20a1NWIY+IDfRnbcQT3aAP1ciB+zzoLkwfe+9Gs6Xagn6Ye3Mu3Dt6dtrL
	 0NwEEP/TQooumhMBhP7wVdCXaoJ4rddv3uV3z8uA=
Content-Disposition: inline
In-Reply-To: <1461664433.3218.42.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

this appears to be a matryoshka of problems.

>=20
> The resulting autofs package didn't show the problem I saw with the
> internal hosts map.
>=20
> So I'd have to say this looks like a library version problem after al=
l.
OK, thank you for looking into this.

>=20
> It seems to me that spending some time to work out how to provide a
> lanchpad ppa is probably the best way to get you to a position to tes=
t
> the IPv6 functionality.
I will configure that 16.04 vm this week and integrate it into the
network as a "first class" workstation. It should be ready as a testbed
(including snapshot capability) then for whenever it is actually needed=
=2E

While I am at it I will see that basic IPv6 tests (with and without
libtirpc) are done in any case.

>=20
> That also means that in time there could be a 14.04 build too, not su=
re
> about that though.
We will move our workstations to 16.04.1 after it is released (provided=
=20
it has no show stoppers), so 14.04 is not important at all. Do not both=
er=20
with it.

>=20
> I can't spend more time on this for a little while so I'll need some
> time to work out how to do the ppa thing, if in fact I can.
I am not sure about it. If it is easier for you to provide patches I ca=
n also
recompile. Or I could provide a possibility to upload packages, the
University has its own file hosting service (think dropbox). If I am=20
installing binary or source packages I have to trust their origin anywa=
y.
Whatever is easiest for you.

In any case take your time ! We await delivery of a new mid-size
HPC cluster in May (completely unrelated to autofs). As soon as it is=20
here I will be absorbed in configuration and migration for some time.

>=20
> I guess the other thing to worry about is if doing this will annoy th=
e
> official downstream maintainer ... maybe we should attempt to make
> contact some time.
>=20


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
