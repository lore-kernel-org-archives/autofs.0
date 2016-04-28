From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Thu, 28 Apr 2016 11:10:19 +0200
Message-ID: <20160428091019.GO30271@bccms.uni-bremen.de>
References: <1460166126.3073.20.camel@themaw.net>
 <20160409095659.GB15153@bccms.uni-bremen.de>
 <1461559248.3012.24.camel@themaw.net>
 <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
 <20160427165250.GM30271@bccms.uni-bremen.de>
 <1461812190.3083.101.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461834621;
	bh=YbCf8AclYr/7ghch6cyrwl93SWoql47FBCghARMKRp4=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=Jtj3vxhY4MTx5GjpkTD96U+8bKhMPJjc8Q8UChQM0faPvpUJTIjyf6zVDWNlzOzKL
	 QBmvz9jYtahblmVqBIaMq8NH54izY8jE2vsuVgYBEKCbhtWF+77KeXI5PddnqC0FMq
	 Tby2yyv+kieyjBbVaD1i3lqC8Scr/LISv/RIofJc=
Content-Disposition: inline
In-Reply-To: <1461812190.3083.101.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

Hello.

On Thu, Apr 28, 2016 at 10:56:30AM +0800, Ian Kent wrote:
> On Wed, 2016-04-27 at 18:52 +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > I have the system running and did first tests. This was=20
> > interesting although I observed basically the behaviour you were=20
> > expecting.
> >=20
>=20
> I might not get this quite right but I'll try.
>=20
> What release of Ubuntu are we talking about here?
This is the vm with 16.04.

>=20
> The other thing to be aware of is that autofs can't know if a host th=
at
> resolves to multiple addresses corresponds to a single host that has
> multiple address or if there are multiple distinct hosts that have th=
e
> same file system available and the addresses are being used for load
> balancing in some way.
OK, I was not fully aware of that.

>=20
> I'm more inclined to make the package require libtirpc and remove the
> option to not use it altogether given that libtirpc has been generall=
y
> available in distros for quite a while now.
I might point out that libtirpc is already a hard package dependency of
nfs-common on debian testing and ubuntu 16.04.

>=20
> > From what I see without libtirpc (standard package), autofs is as
> > expected oblivious to IPv6. It passes the servers hostname to mount=
,
> > which=20
> > in the case of IPv4 and a single IPv6 address in the end uses the I=
Pv6
> > one.=20
> > In the case of two IPv6 addresses it falls back to IPv4 for some
> > reason. So=20
> > that is unrelated to autofs then (and I should ask somewhere else) =
? I
> > attached two syslog ouputs (debug level) covering the single IPv6=20
> > (single_log_wo_tirpc.txt.gz) and double IPv6
> > (multi_log_wo_tirpc.txt.gz) cases.
>=20
> Umm ... we are talking without libtirpc, right?
Yes. This is the behaviour with the packages as provided by the
distribution. Same behaviour on 16.04 as observded on 14.04.

> I think I answered that above, without having looked at the log I
> believe it is an autofs problem.

Yes, you are right. I misread the logs and was looking at the line
mount_mount: mount(nfs): root=3D/local name=3Dcore330 what=3Dcore330:/l=
ocals,
fstype=3Dnfs4, options=3Drw,intr,nosuid,soft,nodev
instead of
mount(nfs): calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev
192.168.220.118:/locals /local/core330

>=20
> I had problems with the build in both so I just went for the latest
> version of libtirpc.
No problems at all, just adding --with-libtirpc as the next to last arg=
ument to
configure and un-patching rpc_subs.c did the trick. Built went smooth,
my indirect maps worked without a hitch. Should I sent you a diff outpu=
t
on the sources ?

> >=20
> > It is unclear to me how it decides if an IP address or an
> > hostname should be passed to mount, might this be multi-homed or
> > failover behaviour ? But then even with IPv4 and a single IPv6 addr=
ess
> > the host
> > sould be considered multi-homed for that purpose and not only if it
> > has
> > multiple IPv6 addresses ?
>=20
> Yes, that is a problem I mentioned in an earlier post.
But please keep in mind that I misread logs, see above. So I was
confused.

> >=20
> > RFC 6724's Abstract says:=20
> > "In dual-stack implementations, the destination address
> > selection algorithm can consider both IPv4 and IPv6 addresses --
> > depending on the available source addresses, the algorithm might
> > prefer IPv6 addresses over IPv4 addresses, or vice versa."
> >=20
> > and in Section 10.3.
> > "The default policy table gives IPv6 addresses higher precedence th=
an
> > IPv4 addresses.  This means that applications will use IPv6 in
> > preference to IPv4 when the two are equally suitable."
>=20
> And these certainly imply I should prefer IPv6 over IPv4.
> But they also assume IPv6 usage is prevalent and that's been a long t=
ime
> coming and I'm not sure it's quite here yet either.
Yes.

>=20
> Perhaps it is time to add this preference now anyway.

Perhaps I should point out that there is one more indirect factor for
consideration: mount.=20

In principle RFC 6724 also contains recommendations what IPv6 address t=
o
pick (GUA or ULA for example, or among multiple GUAs), in fact that is
its main subject. As far as I understand it, and observed what ssh does=
,
if there is a GUA and ULA the ULA (fd5f:... in this case) should be
prefered (selected). Obviously mount (mount.nfs4) does not care about
this recommendation either, in my test it choose randomly (?) one or th=
e
other IPv6 address. May be due to the order of addresses in the DNS
reply. I will try to understand this better.=20

So even mount does not fully care about RFC 6724 or my basic assumption
about the whole process is wrong in some way. I have to work that out. =
In
worst case my expectation has been wrong from the beginning when I
brought this question up.

>=20
> I think the only the only question I need to answer is what influence
> (if any) response time should play between IPv4 and IPv6. I think it
> best to not use it at all to start with (which I think should be the =
way
> it is now, once a v6 over v4 ordering preference is added).
In principle I would agree, ignoring RFC6724 IPv6 address selection
recommendations which, as you pointed out, are not covering this case
when response times are important.

My current understanding of RFC6724 leads to two remarks then:

As far as I understand the log output you are deciding on a hard
comparison basis, so even a one microsecond difference decides.
However, ping times (response times) on ethernet effectively show
random variations, sometimes in the millisecond range.
In numerics (when comparing results) you would define an intervall wher=
e=20
numbers are considered to be effectively equal to catch rounding errors=
=2E
One could use RFC6724 to decide within such an interval. I have no idea
about the complexity involved, though. How does ssh handle that ?
Probably it relies to some service mechanism to get this handled for it=
=2E

With the above in mind  people also might like to pass hard IPv4 and IP=
v6
addresses from the map to autofs to not rely on its decisions (because =
they (think)
know their network better). I vaguely remember I could not put an []
quoted IPv6 address in my executable map while IPv4 was fine or
something like that ? Was there an earlier mail ?

>=20
> > I am unsure how to reproduce what you did.
>=20
> I'm using launchpad to provide a ppa apt source.
>=20
> So the installed debs will replace existing packages, notably libtirp=
c,
> rpcbind, nfs-common and autofs.
>=20
Yes, I did not think you had libtirpc 1.0.1 as debian package. That
explains it then. I will have to check how to do this then.

>=20
> Don't be confused by the change in autofs configuration location in
> autofs 5.1.1 (/etc/autofs.conf).
>=20
> If you only change the autofs configuration in /etc/default/autofs
> (IIRC) that will override the new configuration allowing you to switc=
h
> between older and newer versions of autofs without configuration
> inconsistencies.
OK.

>=20
> I hope that the autofs ppa version will perform the mount fine, as lo=
ng
> as the server is responding but that's one thing we're here to sort o=
ut,
> ;)
>=20
If you could provide a link I can try that. Making a snapshot before an=
d there
are no problems going back.

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
