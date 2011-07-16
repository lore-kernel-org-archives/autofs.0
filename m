From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] autofs does not resolve names ?
Date: Sat, 16 Jul 2011 10:30:58 +0800
Message-ID: <1310783458.3171.2.camel@perseus.themaw.net>
References: <20110716030141.3e6916e3@werewolf.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=zk4pZBs9MRdDuGWAirZcvyxOWLk=; b=RXM7XrR/JqgbXGrnCkdxG4EhWPRUgohAoTLkqUqcGrAp3V/UmnT0//A6/ocdnEjaQTbG/6Tua1uVK3hXlJ0e0TKnC2VozQD7/mQTMkB6rr598KpF5x984z2r9TjG/lWH8Kce+4os/jUYkhds737URwcpFQcEdbAtFvgzzhhBTY0=
In-Reply-To: <20110716030141.3e6916e3@werewolf.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: JA =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: autofs@linux.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Sat, 2011-07-16 at 03:01 +0200, JA Magall=C3=B3n wrote:
> Hi all...
>=20
> Since the update to autofs-5.0.6, I have a curious problem. Probably =
it is not autofs
> to blame, but I ask here to see if someone can give me some light...

Have you applied autofs-5.0.6-fix-ipv6-name-for-lookup-fix.patch?
Which fixes a stupid mistake on my part.

>=20
> Setup:
> /etc/autofs/auto.master:
>=20
> /home   ldap://danae-nfs.cps.unizar.es/automountMapName=3Dauto_home,o=
=3Ddiis --timeout=3D60,tcp,nobrowse
>=20
> (user homes map from LDAP, shared homes at a server)
>=20
> The name is resolved:
>=20
> annwn:/etc/autofs# host danae-nfs
> danae-nfs.cps.unizar.es has address 155.210.152.202
> annwn:/etc/autofs# ping danae-nfs
> PING danae-nfs.cps.unizar.es (155.210.152.202) 56(84) bytes of data.
> 64 bytes from danae-nfs.cps.unizar.es (155.210.152.202): icmp_req=3D1=
 ttl=3D255 time=3D0.339 ms
> ...
>=20
> But when I access home (ssh the box):
>=20
> Jul 15 01:39:31 annwn automount[7774]: Starting automounter version 5=
=2E0.6, master map auto.master
> Jul 15 01:39:31 annwn automount[7774]: using kernel protocol version =
5.02
> Jul 15 01:39:31 annwn automount[7774]: lookup_nss_read_master: readin=
g master files auto.master
> ...
> Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): root=3D=
/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/magal=
lon, fstype=3Dnfs, options=3Dtcp,quota
> Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): nfs o=
ptions=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> Jul 15 01:39:31 annwn automount[7774]: get_nfs_info: called with host=
 danae-nfs(69.65.19.116) proto udp version 0x30
> Jul 15 01:39:37 annwn automount[7774]: get_nfs_info: called with host=
 danae-nfs(69.65.19.116) proto tcp version 0x30
>=20
> Where the hell does it get that IP address for my server ????
>=20
> Diggin a bit more:
>=20
> annwn:/var/log# host 69.65.19.116
> 116.19.65.69.in-addr.arpa domain name pointer nx-deleted-host-1.no-ip=
=2Ecom
>=20
> because I have at /etc/resolv.conf:
>=20
> search cps.unizar.es unizar.es no-ip.org
>=20
> Why did it not resolved first with the first domain ?
>=20
> If I delete the no-ip.org domain, I get:
>=20
> Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): root=3D=
/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/magal=
lon, fstype=3Dnfs, options=3Dtcp,quota
> Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): nfs o=
ptions=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> Jul 15 01:47:20 annwn automount[8068]: add_host_addrs: hostname looku=
p failed: Name or service not known
> Jul 15 01:47:20 annwn automount[8068]: mount(nfs): no hosts available
> Jul 15 01:47:20 annwn automount[8068]: dev_ioctl_send_fail: token =3D=
 28
> Jul 15 01:47:20 annwn automount[8068]: failed to mount /home/magallon
>=20
> automount does not add the search domains and resolve ? what am I doi=
ng wrong ?
> is it a bug ? uuhhh ?
>=20
> TIA
>=20

