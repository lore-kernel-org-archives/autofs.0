From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 8 Apr 2016 18:15:53 +0200
Message-ID: <20160408161553.GA15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
 <20160408161226.GZ15153@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460132154;
	bh=21ekA5h/S7xt1AXDlSqy7SqUu5Beq9fGv0TA/HxVy/Y=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=b6LI0YZ3kIZHUTF48PiWPPaJgffKau6ilHFFB4B0jpTGI1VYIAzrM5ObApa/a2g9g
	 5f3dapAWfTTbtvXJH2ron7DKSAsudgAt0+aD6fGt/RqkP1qaJKPMIAmVEWYicqh1Ck
	 OL+eithLU4OhkV+/czKFLbUEAD1Uo3DmnraXmNLI=
Content-Disposition: inline
In-Reply-To: <20160408161226.GZ15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org

OK, this actually fails to mount anything at all

Apr  8 18:12:53 core324 automount[963]: parse_mount: parse(sun): core o=
f entry: options=3Dfstype=3Dnfs4,rw,intr,nosuid,soft,nodev, loc=3Dcore3=
20:/locals
Apr  8 18:12:53 core324 automount[963]: sun_mount: parse(sun): mounting=
 root /local, mountpoint core320, what core320:/locals, fstype nfs4, op=
tions rw,intr,nosuid,soft,nodev
Apr  8 18:12:53 core324 automount[963]: mount_mount: mount(nfs): root=3D=
/local name=3Dcore320 what=3Dcore320:/locals, fstype=3Dnfs4, options=3D=
rw,intr,nosuid,soft,nodev
Apr  8 18:12:53 core324 automount[963]: mount_mount: mount(nfs): nfs op=
tions=3D"rw,intr,nosuid,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D0
Apr  8 18:12:53 core324 automount[963]: get_nfs_info: called with host =
core320(192.168.220.70) proto 6 version 0x40
Apr  8 18:12:53 core324 automount[963]: get_nfs_info: called with host =
core320(2001:638:708:1261:2000::70) proto 6 version 0x40
Apr  8 18:12:53 core324 automount[963]: mount(nfs): no hosts available
Apr  8 18:12:53 core324 automount[963]: dev_ioctl_send_fail: token =3D =
3006
Apr  8 18:12:53 core324 automount[963]: failed to mount /local/core320
Apr  8 18:12:53 core324 automount[963]: handle_packet: type =3D 3

Maybe I am missing dependencies ...=20


On Fri, Apr 08, 2016 at 06:12:26PM +0200, Christof Koehler wrote:
> Hello,
>=20
> I managed to build a new autofs 5.1.1 from the ubuntu 16.04 source
> package after throwing out all systemd dependencies. With that
>=20
> root@core324:~/autofs-5.1.1# ldd /usr/lib/x86_64-linux-gnu/autofs/mou=
nt_nfs.so
>         linux-vdso.so.1 =3D>  (0x00007ffff7ffd000)
>         libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0 (0=
x00007ffff7b73000)
>         libtirpc.so.1 =3D> /lib/x86_64-linux-gnu/libtirpc.so.1 (0x000=
07ffff794b000)
>         libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6 (0x00007ffff75=
85000)
>         /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)
>         libgssglue.so.1 =3D> /lib/x86_64-linux-gnu/libgssglue.so.1 (0=
x00007ffff737b000)
>         libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007ffff=
7177000)
>=20
> However, I had to edit lib/rpc_subs.c as indicated in=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679, otherwise=
 it would not=20
> work (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol=
: auth_put).
>=20
> With the new binary /local/core330 does not mount either, but the err=
or message is
> probably an improvement:
>=20
> Apr  8 18:05:25 core324 automount[963]: parse_mount: parse(sun): dequ=
ote("core330:/locals"
> ) -> core330:/locals
> Apr  8 18:05:25 core324 automount[963]: parse_mount: parse(sun): core=
 of entry: options=3Dfs
> type=3Dnfs4,rw,intr,nosuid,soft,nodev, loc=3Dcore330:/locals
> Apr  8 18:05:25 core324 automount[963]: sun_mount: parse(sun): mounti=
ng root /local, mount
> point core330, what core330:/locals, fstype nfs4, options rw,intr,nos=
uid,soft,nodev
> Apr  8 18:05:25 core324 automount[963]: mount_mount: mount(nfs): root=
=3D/local name=3Dcore330=20
> what=3Dcore330:/locals, fstype=3Dnfs4, options=3Drw,intr,nosuid,soft,=
nodev
> Apr  8 18:05:25 core324 automount[963]: mount_mount: mount(nfs): nfs =
options=3D"rw,intr,nosu
> id,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D0
> Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with hos=
t core330(192.168.220
> .118) proto 6 version 0x40
> Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with hos=
t core330(fd5f:852:a27c:1261:2000::118) proto 6 version 0x40
> Apr  8 18:05:25 core324 automount[963]: get_nfs_info: called with hos=
t core330(2001:638:708:1261:2000::118) proto 6 version 0x40
> Apr  8 18:05:25 core324 automount[963]: mount(nfs): no hosts availabl=
e
> Apr  8 18:05:25 core324 automount[963]: dev_ioctl_send_fail: token =3D=
 3004
> Apr  8 18:05:25 core324 automount[963]: failed to mount /local/core33=
0
> Apr  8 18:05:25 core324 automount[963]: handle_packet: type =3D 3
> Apr  8 18:05:25 core324 automount[963]: handle_packet_missing_indirec=
t: token 3005, name core330, request pid 2397
>=20
> I had no success trying to get the 5.0.7 source package to actually l=
ink libtirpc,=20
> no idea why.
> =20
> Best Regards
>=20
> Christof
>=20
> On Fri, Apr 08, 2016 at 04:29:07PM +0200, Christof Koehler wrote:
> > Hello,
> >=20
> > apparently I confused my 5.1.1 source built experiment and my debia=
n
> > package rebuild experiment when I reported that libtirpc was used i=
n my
> > last email. So here is a new try to rebuild the deb source with
> > --with-libtirpc.
> >=20
> > I did a apt-get source autofs and added --with-libtirpc to debian r=
ules.
> > After that it would of course not allow me to build a package, "abo=
rting
> > due to unexpected upstream changes". So I just did a "dpkg-buildpac=
kage
> > -b" and then dpkg -i autofs... . Attached is the file build.out.gz =
which
> > contains the stdout output. Clearly libtirpc is used somehow in the=
 build.
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
> >=20
> > I will have to read up on how to properly rebuild the package. The
> > debian documentation is unfortunately not very user friendly, any
> > hints are appreciated.
> >=20
> > Best Regards
> >=20
> > Christof
> >=20
> > On Fri, Apr 08, 2016 at 02:25:52PM +0200, Christof Koehler wrote:
> > > Hello again,
> > > > I've been thinking about this and I have a couple of thoughts.
> > > >=20
> > > > As far a IPv6 goes using glibc RPC is, I think, not going to wo=
rk!
> > > >=20
> > > > That's the first thing that needs to be sorted out.
> > > >=20
> > > > I've been using libtirpc in Fedora and RHEL builds for nearly 1=
0 years
> > > > so I don't think the library problem is with autofs.
> > > >=20
> > > > This is an indication someone is doing something a little dumb:
> > > >=20
> > > > automount[20444]: open_mount:247: parse(sun): cannot open mount=
 module
> > > > nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined s=
ymbol:
> > > > clnt_dg_create)
> > >=20
> > > concerning my failures to build autofs. First the client has all
> > > libtirpc packages I think are necessary:
> > > # dpkg -l libtirpc\*|grep ii
> > > ii  libtirpc-dev                                   0.2.2-5ubuntu2
> > > ii  libtirpc1:amd64                                0.2.2-5ubuntu2
> > >=20
> > > We have libtirpc1 on the machines by default and I had to
> > > install libtirpc-dev so that ./configure would conclude that
> > > --with-libtirpc should do anything.=20
> > >=20
> > > Actually I tried to compile autofs 5.1.1 from source and a new 5.=
0.7
> > > package from ubuntu's source deb.
> > >=20
> > > Using the sources at https://www.kernel.org/pub/linux/daemons/aut=
ofs/v5/
> > > I was basically confused what to do about the patches. Do I have =
to
> > > apply everything in patches-5.1.2 to autofs-5.1.1.tar.gz to get 5=
=2E1.2 ?=20
> > > How do I do that automatically ? I noticed that autofs-5.1.1.tar.=
gz
> > > misses the patch mentioned in message 15 of
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D737679
> > > but contained in autofs-5.1.1-revert-fix-libtirpc-name-clash.patc=
h.
> > >=20
> > > So to make it short I certainly messed something up
> > > somewhere, the final binary and libs were no success . Additional=
ly
> > > installation did not play nice, although --prefix=3D was set it o=
verwrote
> > > configuration files in /etc.  But I think I
> > > cleaned everything up afterwards.
> > >=20
> > > If someone can provide some hints I would try it again.
> > >=20
> > > After that I rebuild the 5.0.7 package from source deb after addi=
ng
> > > --with-libtirpc to debian/rules as suggested in the bug reports. =
I
> > > installed from that package.  I checked with ldd after installing
> > > that ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so was build =
with a
> > > reference to libtirpc.=20
> > >=20
> > > This try gave the error message in the ubuntu bug
> > > report https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564=
380
> > >=20
> > > So, any hints are appreciated. As long as I can stick to 5.0.7 re=
built
> > > from the source deb installing/re-installing is no problem and I =
can try
> > > different things you might want. Assuming I can get the program t=
o work :-)
> > >=20
> > > Thank you very much for all your help !
> > >=20
> > >=20
> > > Best Regards
> > >=20
> > > Christof
> > >=20
> > >=20
> > >=20
> > > --=20
> > > Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.u=
ni-bremen.de
> > > Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> > > Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> > > 28359 Bremen =20
> > >=20
> > > PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe autofs"=
 in
> >=20
> > --=20
> > Dr. rer. nat. Christof K=C3=B6hler       email: c.koehler@bccms.uni=
-bremen.de
> > Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> > Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> > 28359 Bremen =20
> >=20
> > PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
>=20
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
