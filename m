From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 8 Apr 2016 17:32:24 +0200
Message-ID: <20160408153224.GY15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460129546;
	bh=DxFg8isYejFYL685pbQ/uj7p6glzTznkI95E/YcZp4U=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=Ey7MM4g05PZj3AI6AuUAfEBnENbrbWT9jfqFTodwAQfFfge8unfqCNSQD9bjYtPdF
	 83cMJrY0hvsoiqbj846oqCespFBbC9RgSLH4GzTSDJEWCD+NbLGhsvmq9juUnXC04V
	 U2DkU3VrPG6wnP/4r1tQL5J6C1vZZEyOoKrCdW2A=
Content-Disposition: inline
In-Reply-To: <20160408142907.GX15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@vger.kernel.org

Hello,

I might add that using an IPv6 address, i.e.
[2001:638:708:1261:2000::118]:/locals, in the automounter map does not
work either while an IPv4 address, i.e. 192.168.220.118:/locals, works
without a hitch. Is it desirable to be able to specify IPv6 addresses  =
?
I am just noting the inconsistency.

Have a nice weekend !

Apr  8 17:25:24 core324 automount[24310]: attempting to mount entry /lo=
cal/core330
Apr  8 17:25:24 core324 automount[24310]: lookup_mount: lookup(program)=
: core330 -> -fstype=3Dnfs4,rw,intr,nosuid,soft,nodev 192.168.220.118:/=
locals
Apr  8 17:25:24 core324 automount[24310]: lookup_mount: lookup(program)=
: looking up core330
Apr  8 17:25:24 core324 automount[24310]: lookup_mount: lookup(program)=
: core330 -> -fstype=3Dnfs4,rw,intr,nosuid,soft,nodev [2001:638:708:126=
1:2000::118]:/locals
Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun): expa=
nded entry: -fstype=3Dnfs4,rw,intr,nosuid,soft,nodev [2001:638:708:1261=
:2000::118]:/locals
Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun): gath=
ered options: fstype=3Dnfs4,rw,intr,nosuid,soft,nodev
Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun): dequ=
ote("[2001:638:708:1261:2000::118]:/locals") -> [2001:638:708:1261:2000=
::118]:/locals
Apr  8 17:25:24 core324 automount[24310]: parse_mount: parse(sun): core=
 of entry: options=3Dfstype=3Dnfs4,rw,intr,nosuid,soft,nodev,loc=3D[200=
1:638:708:1261:2000::118]:/locals
Apr  8 17:25:24 core324 automount[24310]: sun_mount: parse(sun): mounti=
ng root /local, mountpoint core330, what [2001:638:708:1261:2000::118]:=
/locals, fstype nfs4, options rw,intr,nosuid,soft,nodev
Apr  8 17:25:24 core324 automount[24310]: mount_mount: mount(nfs): root=
=3D/local name=3Dcore33
0 what=3D[2001:638:708:1261:2000::118]:/locals, fstype=3Dnfs4, options=3D=
rw,intr,nosuid,soft,nod
ev
Apr  8 17:25:24 core324 automount[24310]: mount_mount: mount(nfs): nfs =
options=3D"rw,intr,no
suid,soft,nodev", nobind=3D0, nosymlink=3D0, ro=3D0
Apr  8 17:25:24 core324 automount[24310]: mount(nfs): no hosts availabl=
e
Apr  8 17:25:24 core324 automount[24310]: dev_ioctl_send_fail: token =3D=
 1923
Apr  8 17:25:24 core324 automount[24310]: failed to mount /local/core33=
0
Apr  8 17:25:24 core324 automount[24310]: handle_packet: type =3D 3
Apr  8 17:25:24 core324 automount[24310]: handle_packet_missing_indirec=
t: token 1924, name core330, request pid 24519
Apr  8 17:25:24 core324 automount[24310]: dev_ioctl_send_fail: token =3D=
 1924

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
