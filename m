From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Tue, 3 May 2016 17:13:45 +0200
Message-ID: <20160503151345.GH6794@bccms.uni-bremen.de>
References: <20160428091019.GO30271@bccms.uni-bremen.de>
 <1461840658.3063.18.camel@themaw.net>
 <20160428112648.GS30271@bccms.uni-bremen.de>
 <1461894846.3033.14.camel@themaw.net>
 <20160429141044.GA30271@bccms.uni-bremen.de>
 <1461986471.3848.84.camel@themaw.net>
 <20160430113600.GI30271@bccms.uni-bremen.de>
 <1462168902.2983.72.camel@themaw.net>
 <20160502160810.GE6794@bccms.uni-bremen.de>
 <1462262318.3034.35.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1462288427;
	bh=LVVjUuSfN6P0F2FEigtBqzTGIFWTF9eK4G6wXypM2HA=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=eaV64Ex6nZGrnT08p2HC0n49hFn6jxJnDsfsaeJdRoE2TGW1u4IpOvhZ6WjD0uf8k
	 9Eu3myFo4Ihhrm7OXwAw0S727bGSu9TX4MQPaIiiBmbVyhxx8pq47o0upnaIfn0qgL
	 7rrnGsB7cXTAWC9afX6ojOkBnZ8SteTOYbsQfc24=
Content-Disposition: inline
In-Reply-To: <1462262318.3034.35.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello,

On Tue, May 03, 2016 at 03:58:38PM +0800, Ian Kent wrote:
> On Mon, 2016-05-02 at 18:08 +0200, Christof Koehler wrote:
> > We are still using NIS and actually we had the autofs map in  NIS
> > for years.=20
>=20
> Actually I hadn't thought about NIS and IPv6 and I haven't seen any
> discussion about it so it probably isn't ok with IPv6.
Still, if you need any tests ...

>=20
> The autofs LDAP code is complicated, it's difficult to work with.
>=20
> Anyway, for my part, if you have a system that your site is comfortab=
le
> with that suits your needs, and you don't have a compelling reason to
> move to LDAP, I'd recommend holding back from moving to it.

I believe that, especially considering that there are three (?) differe=
nt
schemas for storing them. That's sufficient to convince me to not store=
 our=20
non-executable maps in LDAP (if I ever move to LDAP). I can manage them
fine using ansible I believe.


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
