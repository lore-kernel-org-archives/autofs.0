From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 11:12:19 +0200
Message-ID: <20160428091219.GP30271@bccms.uni-bremen.de>
References: <20160409095659.GB15153@bccms.uni-bremen.de>
 <1461559248.3012.24.camel@themaw.net>
 <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
 <1461813711.3083.111.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461834741;
	bh=KOwYhE8T6aBghxQjiwk27Pt3tB8ssrueCfvnsDhFJHE=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=HhlCPDNlJprnQAbQSJyZ+Je16cIeUMI8l69HKIb9/kr7PXRlemLFIXBdg/rZHMwIM
	 fN0OIznZuNwfkFZjFcduibV/IFCQdDpsi7nkqsmLXFcckiX5NnqRJP3Bukrqf8M/bq
	 gvR6XFcWtTBbpCR7M5eRIz9rLFS5Y0uFVjF/DRYI=
Content-Disposition: inline
In-Reply-To: <1461813711.3083.111.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

so about the same problem quota/ rpc.quotad has with the export root. I
had that already.

I will simply try it by installing the server os into another vm.=20

Best Regards

Christof

On Thu, Apr 28, 2016 at 11:21:51AM +0800, Ian Kent wrote:
> On Thu, 2016-04-28 at 10:56 +0800, Ian Kent wrote:
> > >=20
> > > Another question: What is your expectation in a situation where o=
nly
> > > IPv6 is available, no IPv4 for the server ? Is  the one mentioned=
 in
> > > #25 of
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679
> > > expected to be still a working solution ? I might have an NFS ser=
ver
> > > soon
> > > which, due to a routing conflict difficult to resolve, would only
> > > get
> > > an IPv6 address visible to the clients. I should test this case w=
ith
> > > a
> > > dedicated vm as server anyway ...
> >=20
> > I think we've covered that above.
>=20
> Actually, maybe not.
>=20
> There's a rather long story associated with the use of NFSv4 and the =
the
> associated server mount (or export) path.
>=20
> It depends on kernel version and nfs-utils version.
>=20
> Put simply Linux NFS originally only allowed the use of "/" for NFSv4
> mounts but autofs couldn't work out if a translation was needed becau=
se
> of limited information available from the server.
>=20
> So Linux NFS was changed to behave like other implementations and all=
ow
> the same paths as is used in NFSv3 (and v2). That has the benefit of
> allowed for consistent fall back from v4 to v3 as well.
>=20
> >=20
> > The scenario in that bug shows autofs behaving as expected due to l=
ack
> > of IPv6 support in glibc I think.
> >=20
> > I hope that the autofs ppa version will perform the mount fine, as
> > long
> > as the server is responding but that's one thing we're here to sort
> > out,
> > ;)
> >=20
> > Ian
> > --
> > To unsubscribe from this list: send the line "unsubscribe autofs" i=
n

--=20
Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni-bre=
men.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen =20

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
