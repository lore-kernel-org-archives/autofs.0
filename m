From: Frank Thommen <fthommen@embl.de>
Subject: Re: [autofs] autofs does not resolve names ?
Date: Sat, 16 Jul 2011 15:01:51 +0200
Message-ID: <4E218BBF.6010700@embl.de>
References: <20110716030141.3e6916e3@werewolf.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110716030141.3e6916e3@werewolf.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-9"; format="flowed"
To: =?ISO-8859-1?Q?JA_Magall=F3n?= <jamagallon@ono.com>
Cc: autofs@linux.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

JA Magall=F3n wrote:
> [...]
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

Did you check your /etc/hosts file?

>=20
> [...]
>=20


frank
