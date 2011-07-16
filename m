From: JA =?ISO-8859-1?B?TWFnYWxs824=?= <jamagallon@ono.com>
Subject: Re: [autofs] autofs does not resolve names ?
Date: Sun, 17 Jul 2011 01:37:46 +0200
Message-ID: <20110717013746.5c5e477a@werewolf.home>
References: <20110716030141.3e6916e3@werewolf.home>
	<1310783458.3171.2.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310783458.3171.2.camel@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: autofs@linux.kernel.org

On Sat, 16 Jul 2011 10:30:58 +0800, Ian Kent <raven@themaw.net> wrote:

(CC LKML for info and completeness...)

> On Sat, 2011-07-16 at 03:01 +0200, JA Magall=F3n wrote:
> > Hi all...
> >=20
> > Since the update to autofs-5.0.6, I have a curious problem. Probabl=
y it is not autofs
> > to blame, but I ask here to see if someone can give me some light..=
=2E
>=20
> Have you applied autofs-5.0.6-fix-ipv6-name-for-lookup-fix.patch?
> Which fixes a stupid mistake on my part.
>=20

Love you ! That did the trick, everything works again.

Are you planning to release a 5.0.7 with the fix ?

> >=20
> > Setup:
> > /etc/autofs/auto.master:
> >=20
> > /home   ldap://danae-nfs.cps.unizar.es/automountMapName=3Dauto_home=
,o=3Ddiis --timeout=3D60,tcp,nobrowse
> >=20
> > (user homes map from LDAP, shared homes at a server)
> >=20
> > The name is resolved:
> >=20
> > annwn:/etc/autofs# host danae-nfs
> > danae-nfs.cps.unizar.es has address 155.210.152.202
> > annwn:/etc/autofs# ping danae-nfs
> > PING danae-nfs.cps.unizar.es (155.210.152.202) 56(84) bytes of data=
=2E
> > 64 bytes from danae-nfs.cps.unizar.es (155.210.152.202): icmp_req=3D=
1 ttl=3D255 time=3D0.339 ms
> > ...
> >=20
> > But when I access home (ssh the box):
> >=20
> > Jul 15 01:39:31 annwn automount[7774]: Starting automounter version=
 5.0.6, master map auto.master
> > Jul 15 01:39:31 annwn automount[7774]: using kernel protocol versio=
n 5.02
> > Jul 15 01:39:31 annwn automount[7774]: lookup_nss_read_master: read=
ing master files auto.master
> > ...
> > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): roo=
t=3D/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/m=
agallon, fstype=3Dnfs, options=3Dtcp,quota
> > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): nfs=
 options=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > Jul 15 01:39:31 annwn automount[7774]: get_nfs_info: called with ho=
st danae-nfs(69.65.19.116) proto udp version 0x30
> > Jul 15 01:39:37 annwn automount[7774]: get_nfs_info: called with ho=
st danae-nfs(69.65.19.116) proto tcp version 0x30
> >=20
> > Where the hell does it get that IP address for my server ????
> >=20
> > Diggin a bit more:
> >=20
> > annwn:/var/log# host 69.65.19.116
> > 116.19.65.69.in-addr.arpa domain name pointer nx-deleted-host-1.no-=
ip.com
> >=20
> > because I have at /etc/resolv.conf:
> >=20
> > search cps.unizar.es unizar.es no-ip.org
> >=20
> > Why did it not resolved first with the first domain ?
> >=20
> > If I delete the no-ip.org domain, I get:
> >=20
> > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): roo=
t=3D/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/m=
agallon, fstype=3Dnfs, options=3Dtcp,quota
> > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): nfs=
 options=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > Jul 15 01:47:20 annwn automount[8068]: add_host_addrs: hostname loo=
kup failed: Name or service not known
> > Jul 15 01:47:20 annwn automount[8068]: mount(nfs): no hosts availab=
le
> > Jul 15 01:47:20 annwn automount[8068]: dev_ioctl_send_fail: token =3D=
 28
> > Jul 15 01:47:20 annwn automount[8068]: failed to mount /home/magall=
on
> >=20
> > automount does not add the search domains and resolve ? what am I d=
oing wrong ?
> > is it a bug ? uuhhh ?
> >=20
> > TIA
> >=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=20
J.A. Magallon <jamagallon()ono!com>     \                 Winter is com=
ing...
