From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sat, 9 Apr 2016 11:56:59 +0200
Message-ID: <20160409095659.GB15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
 <1460166126.3073.20.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460195821;
	bh=NVJJvTbgL/9gdL899Piymot3N719Wkqz+LCQd1r2wxQ=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=cNahSescDBzakwiK9+ZOhfY/GnEaecp16YkRVtW1fyf+OZGJGCw62IPk7QjLHCE9a
	 92PoUwT3uiLsYjbk6/bJreXTOH3oNirRyGQArUsKYswNogZyeKOUz2L3vrFgKSz/jd
	 Q098J/TI01o9pJ68R0k71oT7waBwQ9b/keYVdihk=
Content-Disposition: inline
In-Reply-To: <1460166126.3073.20.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@vger.kernel.org

Hello,

yes, indeed the 5.0.7 source deb rebuild is very strange. I also checke=
d
the libraries under debian/usr/lib/... in the build directory and they
do not contain a libtirpc reference.

I can see two possible strategies:
1.  Concentrate on the 5.1.1 deb source I grabbed from ubuntu 16.04 and=
 the=20
deb package rebuild from that. Those libraries obviously contain a refe=
rence
to libtirpc but do not mount anything. Too old libtirpc comes to mind t=
hen ?
2.  Another approach would be to wait for 16.04 release. I will start
deploying 16.04.1 once it is release in the second half of this year. I
would then try to rebuild from the deb source including libtirpc (which
would be 0.2.5) again and report back. So, basically defering this.

If you do not have another idea to get the 5.1.1 deb package rebuild to
work I would think that defering and trying with matched and current
versions is the right thing to do.

=46inally to clarify: the comments on manually applying patches and --p=
refix=3D refer to=20
building from the pristine source available=20
at https://www.kernel.org/pub/linux/daemons/autofs/v5/, no deb
source or package involved. I was working outside the package
system. But obviously I do not know enough about building
from the pristine source.

Thank your very much !

Best Regards

Christof





On Sat, Apr 09, 2016 at 09:42:06AM +0800, Ian Kent wrote:
> On Fri, 2016-04-08 at 16:29 +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > apparently I confused my 5.1.1 source built experiment and my debia=
n
> > package rebuild experiment when I reported that libtirpc was used i=
n
> > my
> > last email. So here is a new try to rebuild the deb source with
> > --with-libtirpc.
> >=20
> > I did a apt-get source autofs and added --with-libtirpc to debian
> > rules.
> > After that it would of course not allow me to build a package,
> > "aborting
> > due to unexpected upstream changes". So I just did a "dpkg
> > -buildpackage
> > -b" and then dpkg -i autofs... . Attached is the file build.out.gz
> > which
> > contains the stdout output. Clearly libtirpc is used somehow in the
> > build.
> >=20
> > After restoring maps in /etc I did a service restart autofs and wit=
h
> > debug loglevel I get=20
> >=20
> > Apr  8 16:20:33 core324 automount[14615]: open_mount:247: parse(sun=
):
> > cannot open mount module nfs
> > (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
> > clnt_dg_create)
> >=20
> > as reported. I then double checked and actually
> >=20
> > root@core324:~# ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so
> >         linux-vdso.so.1 =3D>  (0x00007ffff7ffd000)
> >         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> > (0x00007ffff79f3000)
> >         /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
> >=20
> > no libtirpc.=20
>=20
> And yet the build from the log looks ok....
> There's no even a link entry there which implies it hasn't been built
> using libtirpc but the build looks like it is using it... puzzling.
>=20
> Ian
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
