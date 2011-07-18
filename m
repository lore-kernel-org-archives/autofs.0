From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] autofs does not resolve names ?
Date: Mon, 18 Jul 2011 09:57:08 +0800
Message-ID: <1310954228.3164.5.camel@perseus.themaw.net>
References: <20110716030141.3e6916e3@werewolf.home>
	 <1310783458.3171.2.camel@perseus.themaw.net>
	 <20110717013746.5c5e477a@werewolf.home>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding; s=smtpout; bh=r5qvGW8ncvMIJI+Tm3eyMs2EhOc=; b=QNhCbuUqLuxiEmJY31b//YLtTjxTSV5Qq+h1to2d3IeWfi7puGxKFGuEH41QeVM00h1mDlcJFFCCTwlL+exJ9vRMAC1QDhIsvjI0z1JnDHNGfHKKaEzDqikTRGHwaHeSmB4EiSqsjaLtFR9bTHWv5X6A6uJGkHd0DAAX0fE5PMc=
In-Reply-To: <20110717013746.5c5e477a@werewolf.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: JA =?ISO-8859-1?Q?Magall=F3n?= <jamagallon@ono.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Sun, 2011-07-17 at 01:37 +0200, JA Magall=C3=B3n wrote:
> On Sat, 16 Jul 2011 10:30:58 +0800, Ian Kent <raven@themaw.net> wrote=
:
>=20
> (CC LKML for info and completeness...)
>=20
> > On Sat, 2011-07-16 at 03:01 +0200, JA Magall=C3=B3n wrote:
> > > Hi all...
> > >=20
> > > Since the update to autofs-5.0.6, I have a curious problem. Proba=
bly it is not autofs
> > > to blame, but I ask here to see if someone can give me some light=
=2E..
> >=20
> > Have you applied autofs-5.0.6-fix-ipv6-name-for-lookup-fix.patch?
> > Which fixes a stupid mistake on my part.
> >=20
>=20
> Love you ! That did the trick, everything works again.
>=20
> Are you planning to release a 5.0.7 with the fix ?

That will go into 5.0.7 but it probably won't be released for a while.
Patches, such as this, are available on
http://www.kernel.org/pub/linux/daemons/autofs/v5 as soon as they are
committed to the autofs repository.

>=20
> > >=20
> > > Setup:
> > > /etc/autofs/auto.master:
> > >=20
> > > /home   ldap://danae-nfs.cps.unizar.es/automountMapName=3Dauto_ho=
me,o=3Ddiis --timeout=3D60,tcp,nobrowse
> > >=20
> > > (user homes map from LDAP, shared homes at a server)
> > >=20
> > > The name is resolved:
> > >=20
> > > annwn:/etc/autofs# host danae-nfs
> > > danae-nfs.cps.unizar.es has address 155.210.152.202
> > > annwn:/etc/autofs# ping danae-nfs
> > > PING danae-nfs.cps.unizar.es (155.210.152.202) 56(84) bytes of da=
ta.
> > > 64 bytes from danae-nfs.cps.unizar.es (155.210.152.202): icmp_req=
=3D1 ttl=3D255 time=3D0.339 ms
> > > ...
> > >=20
> > > But when I access home (ssh the box):
> > >=20
> > > Jul 15 01:39:31 annwn automount[7774]: Starting automounter versi=
on 5.0.6, master map auto.master
> > > Jul 15 01:39:31 annwn automount[7774]: using kernel protocol vers=
ion 5.02
> > > Jul 15 01:39:31 annwn automount[7774]: lookup_nss_read_master: re=
ading master files auto.master
> > > ...
> > > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): r=
oot=3D/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga=
/magallon, fstype=3Dnfs, options=3Dtcp,quota
> > > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): n=
fs options=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > > Jul 15 01:39:31 annwn automount[7774]: get_nfs_info: called with =
host danae-nfs(69.65.19.116) proto udp version 0x30
> > > Jul 15 01:39:37 annwn automount[7774]: get_nfs_info: called with =
host danae-nfs(69.65.19.116) proto tcp version 0x30
> > >=20
> > > Where the hell does it get that IP address for my server ????
> > >=20
> > > Diggin a bit more:
> > >=20
> > > annwn:/var/log# host 69.65.19.116
> > > 116.19.65.69.in-addr.arpa domain name pointer nx-deleted-host-1.n=
o-ip.com
> > >=20
> > > because I have at /etc/resolv.conf:
> > >=20
> > > search cps.unizar.es unizar.es no-ip.org
> > >=20
> > > Why did it not resolved first with the first domain ?
> > >=20
> > > If I delete the no-ip.org domain, I get:
> > >=20
> > > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): r=
oot=3D/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga=
/magallon, fstype=3Dnfs, options=3Dtcp,quota
> > > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): n=
fs options=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > > Jul 15 01:47:20 annwn automount[8068]: add_host_addrs: hostname l=
ookup failed: Name or service not known
> > > Jul 15 01:47:20 annwn automount[8068]: mount(nfs): no hosts avail=
able
> > > Jul 15 01:47:20 annwn automount[8068]: dev_ioctl_send_fail: token=
 =3D 28
> > > Jul 15 01:47:20 annwn automount[8068]: failed to mount /home/maga=
llon
> > >=20
> > > automount does not add the search domains and resolve ? what am I=
 doing wrong ?
> > > is it a bug ? uuhhh ?
> > >=20
> > > TIA
> > >=20
> >=20
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

