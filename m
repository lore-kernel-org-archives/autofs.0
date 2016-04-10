From: Ian Kent <raven@themaw.net>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Sun, 10 Apr 2016 10:17:17 +0800
Message-ID: <1460254637.3508.12.camel@themaw.net>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
	 <1460090760.3135.53.camel@themaw.net> <1460110224.2979.35.camel@themaw.net>
	 <20160408122552.GW15153@bccms.uni-bremen.de>
	 <20160408142907.GX15153@bccms.uni-bremen.de>
	 <20160408161226.GZ15153@bccms.uni-bremen.de>
	 <20160408161553.GA15153@bccms.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=HO0FhkeQ3jBBSSoUSNW5TGlm55Y=; b=DkO1CD
	pZK/Z66rOmi5a0SnqPqsQy736ECKKpwv+MaghmV740kI6BT8JWtJSDdu+t23k0dI
	8x6N0B8Fg+FDM0pOvas+YwdYAzJR4CdjtmUdU0t+9yIR3Gfnd+s96b4IxdSo8v0x
	or+Wt82zdeJ3p9VFs3noBp8oi3e24WZKEWtAw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=HO0FhkeQ3jBBSSo
	USNW5TGlm55Y=; b=EvL9IjwPKgzs6pOc8KgCyfJuUWmn1Yznw0gtKhJ1uowl2U8
	i4jIWFclcORBA+D3sWHx6yX9BNmIyCciHW5uJQiypdZt4eXkuoTZmzOhsCl/0Jm6
	hXrf5swDHH3KRoDM+WgzkuMcj3qyLhmrvBE3rrnXYhqopMSrzW3B3AGR/6bA=
In-Reply-To: <20160408161553.GA15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: christof.koehler@bccms.uni-bremen.de, autofs@vger.kernel.org

On Fri, 2016-04-08 at 18:15 +0200, Christof Koehler wrote:
> OK, this actually fails to mount anything at all

That's right, as I say the RPC communication isn't failing in an
unexpected way so we aren't seeing any error messages.

About all that can be done is to add a patch that adds some extra
logging to try and get to the bottom of it.

>=20
> Apr  8 18:12:53 core324 automount[963]: parse_mount: parse(sun): core
> of entry: options=3Dfstype=3Dnfs4,rw,intr,nosuid,soft,nodev,
> loc=3Dcore320:/locals
> Apr  8 18:12:53 core324 automount[963]: sun_mount: parse(sun):
> mounting root /local, mountpoint core320, what core320:/locals, fstyp=
e
> nfs4, options rw,intr,nosuid,soft,nodev
> Apr  8 18:12:53 core324 automount[963]: mount_mount: mount(nfs):
> root=3D/local name=3Dcore320 what=3Dcore320:/locals, fstype=3Dnfs4,
> options=3Drw,intr,nosuid,soft,nodev
> Apr  8 18:12:53 core324 automount[963]: mount_mount: mount(nfs): nfs
> options=3D"rw,intr,nosuid,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D=
0
> Apr  8 18:12:53 core324 automount[963]: get_nfs_info: called with hos=
t
> core320(192.168.220.70) proto 6 version 0x40
> Apr  8 18:12:53 core324 automount[963]: get_nfs_info: called with hos=
t
> core320(2001:638:708:1261:2000::70) proto 6 version 0x40
> Apr  8 18:12:53 core324 automount[963]: mount(nfs): no hosts availabl=
e
> Apr  8 18:12:53 core324 automount[963]: dev_ioctl_send_fail: token =3D
> 3006
> Apr  8 18:12:53 core324 automount[963]: failed to mount /local/core32=
0
> Apr  8 18:12:53 core324 automount[963]: handle_packet: type =3D 3
>=20
> Maybe I am missing dependencies ...=20
>=20
>=20
> On Fri, Apr 08, 2016 at 06:12:26PM +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > I managed to build a new autofs 5.1.1 from the ubuntu 16.04 source
> > package after throwing out all systemd dependencies. With that
> >=20
> > root@core324:~/autofs-5.1.1# ldd /usr/lib/x86_64-linux
> > -gnu/autofs/mount_nfs.so
> >         linux-vdso.so.1 =3D>  (0x00007ffff7ffd000)
> >         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> > (0x00007ffff7b73000)
> >         libtirpc.so.1 =3D> /lib/x86_64-linux-gnu/libtirpc.so.1
> > (0x00007ffff794b000)
> >         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> > (0x00007ffff7585000)
> >         /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
> >         libgssglue.so.1 =3D> /lib/x86_64-linux-gnu/libgssglue.so.1
> > (0x00007ffff737b000)
> >         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
> > (0x00007ffff7177000)
> >=20
> > However, I had to edit lib/rpc_subs.c as indicated in=20
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679, otherwi=
se
> > it would not=20
> > work (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined
> > symbol: auth_put).
> >=20
> > With the new binary /local/core330 does not mount either, but the
> > error message is
> > probably an improvement:
> >=20
> > Apr  8 18:05:25 core324 automount[963]: parse_mount: parse(sun):
> > dequote("core330:/locals"
> > ) -> core330:/locals
> > Apr  8 18:05:25 core324 automount[963]: parse_mount: parse(sun):
> > core of entry: options=3Dfs
> > type=3Dnfs4,rw,intr,nosuid,soft,nodev, loc=3Dcore330:/locals
> > Apr  8 18:05:25 core324 automount[963]: sun_mount: parse(sun):
> > mounting root /local, mount
> > point core330, what core330:/locals, fstype nfs4, options
> > rw,intr,nosuid,soft,nodev
> > Apr  8 18:05:25 core324 automount[963]: mount_mount: mount(nfs):
> > root=3D/local name=3Dcore330=20
> > what=3Dcore330:/locals, fstype=3Dnfs4, options=3Drw,intr,nosuid,sof=
t,nodev
> > Apr  8 18:05:25 core324 automount[963]: mount_mount: mount(nfs): nf=
s
> > options=3D"rw,intr,nosu
> > id,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D0
> > Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with
> > host core330(192.168.220
> > .118) proto 6 version 0x40
> > Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with
> > host core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
> > Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with
> > host core330(2001:638:708:1261:2000::118) proto 6 version 0x40
> > Apr  8 18:05:25 core324 automount[963]: mount(nfs): no hosts
> > available
> > Apr  8 18:05:25 core324 automount[963]: dev_ioctl_send_fail: token =
=3D
> > 3004
> > Apr  8 18:05:25 core324 automount[963]: failed to mount
> > /local/core330
> > Apr  8 18:05:25 core324 automount[963]: handle_packet: type =3D 3
> > Apr  8 18:05:25 core324 automount[963]:
> > handle_packet_missing_indirect: token 3005, name core330, request
> > pid 2397
> >=20
> > I had no success trying to get the 5.0.7 source package to actually
> > link libtirpc,=20
> > no idea why.
> > =20
> > Best Regards
> >=20
> > Christof
> >=20
> > On Fri, Apr 08, 2016 at 04:29:07PM +0200, Christof Koehler wrote:
> > > Hello,
> > >=20
> > > apparently I confused my 5.1.1 source built experiment and my
> > > debian
> > > package rebuild experiment when I reported that libtirpc was used
> > > in my
> > > last email. So here is a new try to rebuild the deb source with
> > > --with-libtirpc.
> > >=20
> > > I did a apt-get source autofs and added --with-libtirpc to debian
> > > rules.
> > > After that it would of course not allow me to build a package,
> > > "aborting
> > > due to unexpected upstream changes". So I just did a "dpkg
> > > -buildpackage
> > > -b" and then dpkg -i autofs... . Attached is the file build.out.g=
z
> > > which
> > > contains the stdout output. Clearly libtirpc is used somehow in
> > > the build.
> > >=20
> > > After restoring maps in /etc I did a service restart autofs and
> > > with
> > > debug loglevel I get=20
> > >=20
> > > Apr  8 16:20:33 core324 automount[14615]: open_mount:247:
> > > parse(sun):
> > > cannot open mount module nfs
> > > (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
> > > clnt_dg_create)
> > >=20
> > > as reported. I then double checked and actually
> > >=20
> > > root@core324:~# ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so
> > >         linux-vdso.so.1 =3D>  (0x00007ffff7ffd000)
> > >         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> > > (0x00007ffff79f3000)
> > >         /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
> > >=20
> > > no libtirpc.=20
> > >=20
> > > I will have to read up on how to properly rebuild the package. Th=
e
> > > debian documentation is unfortunately not very user friendly, any
> > > hints are appreciated.
> > >=20
> > > Best Regards
> > >=20
> > > Christof
> > >=20
> > > On Fri, Apr 08, 2016 at 02:25:52PM +0200, Christof Koehler wrote:
> > > > Hello again,
> > > > > I've been thinking about this and I have a couple of thoughts=
=2E
> > > > >=20
> > > > > As far a IPv6 goes using glibc RPC is, I think, not going to
> > > > > work!
> > > > >=20
> > > > > That's the first thing that needs to be sorted out.
> > > > >=20
> > > > > I've been using libtirpc in Fedora and RHEL builds for nearly
> > > > > 10 years
> > > > > so I don't think the library problem is with autofs.
> > > > >=20
> > > > > This is an indication someone is doing something a little
> > > > > dumb:
> > > > >=20
> > > > > automount[20444]: open_mount:247: parse(sun): cannot open
> > > > > mount module
> > > > > nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined
> > > > > symbol:
> > > > > clnt_dg_create)
> > > >=20
> > > > concerning my failures to build autofs. First the client has al=
l
> > > > libtirpc packages I think are necessary:
> > > > # dpkg -l libtirpc\*|grep ii
> > > > ii  libtirpc-dev                                   0.2.2
> > > > -5ubuntu2
> > > > ii  libtirpc1:amd64                                0.2.2
> > > > -5ubuntu2
> > > >=20
> > > > We have libtirpc1 on the machines by default and I had to
> > > > install libtirpc-dev so that ./configure would conclude that
> > > > --with-libtirpc should do anything.=20
> > > >=20
> > > > Actually I tried to compile autofs 5.1.1 from source and a new
> > > > 5.0.7
> > > > package from ubuntu's source deb.
> > > >=20
> > > > Using the sources at=20
> > > > https://www.kernel.org/pub/linux/daemons/autofs/v5/
> > > > I was basically confused what to do about the patches. Do I hav=
e
> > > > to
> > > > apply everything in patches-5.1.2 to autofs-5.1.1.tar.gz to get
> > > > 5.1.2 ?=20
> > > > How do I do that automatically ? I noticed that autofs
> > > > -5.1.1.tar.gz
> > > > misses the patch mentioned in message 15 of
> > > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679
> > > > but contained in autofs-5.1.1-revert-fix-libtirpc-name
> > > > -clash.patch.
> > > >=20
> > > > So to make it short I certainly messed something up
> > > > somewhere, the final binary and libs were no success .
> > > > Additionally
> > > > installation did not play nice, although --prefix=3D was set it
> > > > overwrote
> > > > configuration files in /etc.  But I think I
> > > > cleaned everything up afterwards.
> > > >=20
> > > > If someone can provide some hints I would try it again.
> > > >=20
> > > > After that I rebuild the 5.0.7 package from source deb after
> > > > adding
> > > > --with-libtirpc to debian/rules as suggested in the bug reports=
=2E
> > > > I
> > > > installed from that package.  I checked with ldd after
> > > > installing
> > > > that ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so was buil=
d
> > > > with a
> > > > reference to libtirpc.=20
> > > >=20
> > > > This try gave the error message in the ubuntu bug
> > > > report=20
> > > > https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> > > >=20
> > > > So, any hints are appreciated. As long as I can stick to 5.0.7
> > > > rebuilt
> > > > from the source deb installing/re-installing is no problem and =
I
> > > > can try
> > > > different things you might want. Assuming I can get the program
> > > > to work :-)
> > > >=20
> > > > Thank you very much for all your help !
> > > >=20
> > > >=20
> > > > Best Regards
> > > >=20
> > > > Christof
> > > >=20
> > > >=20
> > > >=20
> > > > --=20
> > > > Dr. rer. nat. Christof K=C3=B6hler       email:=20
> > > > c.koehler@bccms.uni-bremen.de
> > > > Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-6233=
4
> > > > Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> > > > 28359 Bremen =20
> > > >=20
> > > > PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > autofs" in
> > >=20
> > > --=20
> > > Dr. rer. nat. Christof K=C3=B6hler       email:=20
> > > c.koehler@bccms.uni-bremen.de
> > > Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> > > Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> > > 28359 Bremen =20
> > >=20
> > > PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> >=20
> >=20
> >=20
> > --=20
> > Dr. rer. nat. Christof K=C3=B6hler       email:=20
> > c.koehler@bccms.uni-bremen.de
> > Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> > Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> > 28359 Bremen =20
> >=20
> > PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> > --
> > To unsubscribe from this list: send the line "unsubscribe autofs" i=
n
>=20
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
