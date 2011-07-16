From: JA =?ISO-8859-1?B?TWFnYWxs824=?= <jamagallon@ono.com>
Subject: Re: autofs does not resolve names ?
Date: Sun, 17 Jul 2011 01:17:51 +0200
Message-ID: <20110717011751.697645c1@werewolf.home>
References: <20110716030141.3e6916e3@werewolf.home>
	<1310783458.3171.2.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1310783458.3171.2.camel@perseus.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

On Sat, 16 Jul 2011 10:30:58 +0800, Ian Kent <raven@themaw.net> wrote:

> On Sat, 2011-07-16 at 03:01 +0200, JA Magall=F3n wrote:
> > Hi all...
> > =

> > Since the update to autofs-5.0.6, I have a curious problem. Probably it=
 is not autofs
> > to blame, but I ask here to see if someone can give me some light...
> =

> Have you applied autofs-5.0.6-fix-ipv6-name-for-lookup-fix.patch?
> Which fixes a stupid mistake on my part.
> =


Don't know, will check my distro src.rpm. Thanks for the pointer.

> > =

> > Setup:
> > /etc/autofs/auto.master:
> > =

> > /home   ldap://danae-nfs.cps.unizar.es/automountMapName=3Dauto_home,o=
=3Ddiis --timeout=3D60,tcp,nobrowse
> > =

> > (user homes map from LDAP, shared homes at a server)
> > =

> > The name is resolved:
> > =

> > annwn:/etc/autofs# host danae-nfs
> > danae-nfs.cps.unizar.es has address 155.210.152.202
> > annwn:/etc/autofs# ping danae-nfs
> > PING danae-nfs.cps.unizar.es (155.210.152.202) 56(84) bytes of data.
> > 64 bytes from danae-nfs.cps.unizar.es (155.210.152.202): icmp_req=3D1 t=
tl=3D255 time=3D0.339 ms
> > ...
> > =

> > But when I access home (ssh the box):
> > =

> > Jul 15 01:39:31 annwn automount[7774]: Starting automounter version 5.0=
.6, master map auto.master
> > Jul 15 01:39:31 annwn automount[7774]: using kernel protocol version 5.=
02
> > Jul 15 01:39:31 annwn automount[7774]: lookup_nss_read_master: reading =
master files auto.master
> > ...
> > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): root=3D=
/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/magallon,=
 fstype=3Dnfs, options=3Dtcp,quota
> > Jul 15 01:39:31 annwn automount[7774]: mount_mount: mount(nfs): nfs opt=
ions=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > Jul 15 01:39:31 annwn automount[7774]: get_nfs_info: called with host d=
anae-nfs(69.65.19.116) proto udp version 0x30
> > Jul 15 01:39:37 annwn automount[7774]: get_nfs_info: called with host d=
anae-nfs(69.65.19.116) proto tcp version 0x30
> > =

> > Where the hell does it get that IP address for my server ????
> > =

> > Diggin a bit more:
> > =

> > annwn:/var/log# host 69.65.19.116
> > 116.19.65.69.in-addr.arpa domain name pointer nx-deleted-host-1.no-ip.c=
om
> > =

> > because I have at /etc/resolv.conf:
> > =

> > search cps.unizar.es unizar.es no-ip.org
> > =

> > Why did it not resolved first with the first domain ?
> > =

> > If I delete the no-ip.org domain, I get:
> > =

> > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): root=3D=
/home name=3Dmagallon what=3Ddanae-nfs:/export/home/usuarios/giga/magallon,=
 fstype=3Dnfs, options=3Dtcp,quota
> > Jul 15 01:47:18 annwn automount[8068]: mount_mount: mount(nfs): nfs opt=
ions=3D"tcp,quota", nobind=3D0, nosymlink=3D0, ro=3D0
> > Jul 15 01:47:20 annwn automount[8068]: add_host_addrs: hostname lookup =
failed: Name or service not known
> > Jul 15 01:47:20 annwn automount[8068]: mount(nfs): no hosts available
> > Jul 15 01:47:20 annwn automount[8068]: dev_ioctl_send_fail: token =3D 28
> > Jul 15 01:47:20 annwn automount[8068]: failed to mount /home/magallon
> > =

> > automount does not add the search domains and resolve ? what am I doing=
 wrong ?
> > is it a bug ? uuhhh ?
> > =

> > TIA
> > =

> =

> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- =

J.A. Magallon <jamagallon()ono!com>     \                 Winter is coming.=
..
