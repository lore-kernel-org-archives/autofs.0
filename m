From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: automounted filesystems being unmounted
	and	mounted	every minute
Date: Mon, 16 Oct 2006 15:00:41 -0400
Message-ID: <1161025241.3184.34.camel@pc.ilinx>
References: <1161005417.3184.5.camel@pc.ilinx>
	<1161016376.3085.86.camel@localhost>
	<1161019573.3184.15.camel@pc.ilinx>
	<x49d58sxhes.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4299147343263158471=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49d58sxhes.fsf@segfault.boston.devel.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============4299147343263158471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IPKgl4KbsKG/5rHarXkX"


--=-IPKgl4KbsKG/5rHarXkX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-16-10 at 14:08 -0400, Jeff Moyer wrote:
>=20
> Take a look at http://people.redhat.com/jmoyer for documentation on how t=
o
> gather debug information from the automounter.  Basically, you need to lo=
g
> daemon.* somewhere.

gnome-panel?

Oct 16 14:54:51 jenny automount[24104]: handle_packet: type =3D 3
Oct 16 14:54:51 jenny automount[24104]: handle_packet_missing_indirect: tok=
en 19801, name share, request pid 14360
Oct 16 14:54:51 jenny automount[24104]: attempting to mount entry /autohome=
/share
Oct 16 14:54:51 jenny automount[24104]: lookup_mount: lookup(file): looking=
 up share
Oct 16 14:54:51 jenny automount[24104]: lookup_mount: lookup(file): share -=
> -rw,soft,intr,rsize=3D8192,wsize=3D8192^Ilinux:/home/share
Oct 16 14:54:51 jenny automount[24104]: parse_mount: parse(sun): expanded e=
ntry: -rw,soft,intr,rsize=3D8192,wsize=3D8192^Ilinux:/home/share
Oct 16 14:54:51 jenny automount[24104]: parse_mount: parse(sun): gathered o=
ptions: rw,soft,intr,rsize=3D8192,wsize=3D8192
Oct 16 14:54:51 jenny automount[24104]: parse_mount: parse(sun): dequote("l=
inux:/home/share") -> linux:/home/share
Oct 16 14:54:51 jenny automount[24104]: parse_mount: parse(sun): core of en=
try: options=3Drw,soft,intr,rsize=3D8192,wsize=3D8192, loc=3Dlinux:/home/sh=
are
Oct 16 14:54:51 jenny automount[24104]: sun_mount: parse(sun): mounting roo=
t /autohome, mountpoint share, what linux:/home/share, fstype nfs, options =
rw,soft,intr,rsize=3D8192,wsize=3D8192
Oct 16 14:54:51 jenny automount[24104]: mount_mount: mount(nfs): root=3D/au=
tohome name=3Dshare what=3Dlinux:/home/share, fstype=3Dnfs, options=3Drw,so=
ft,intr,rsize=3D8192,wsize=3D8192
Oct 16 14:54:51 jenny automount[24104]: mount_mount: mount(nfs): nfs option=
s=3D"rw,soft,intr,rsize=3D8192,wsize=3D8192", nosymlink=3D0, ro=3D0
Oct 16 14:54:51 jenny automount[24104]: mount_mount: mount(nfs): calling mk=
dir_path /autohome/share
Oct 16 14:54:51 jenny automount[24104]: mount_mount: mount(nfs): calling mo=
unt -t nfs -s -o rw,soft,intr,rsize=3D8192,wsize=3D8192 linux:/home/share /=
autohome/share
Oct 16 14:54:51 jenny automount[24104]: mount(nfs): mounted linux:/home/sha=
re on /autohome/share
Oct 16 14:54:51 jenny automount[24104]: send_ready: token =3D 19801
Oct 16 14:54:51 jenny automount[24104]: mounted /autohome/share
Oct 16 14:54:51 jenny automount[24104]: expire_proc_indirect: 2 remaining i=
n /autohome
Oct 16 14:54:51 jenny automount[24104]: mount still busy /autohome
Oct 16 14:54:51 jenny automount[24104]: expire_cleanup: got thid 3074386848=
 path /autohome stat 3
Oct 16 14:54:51 jenny automount[24104]: expire_cleanup: sigchld: exp 307438=
6848 finished, switching from 2 to 1
Oct 16 14:54:51 jenny automount[24104]: st_ready: st_ready(): state =3D 2 p=
ath /autohome

$ ps -p14360 f
  PID TTY      STAT   TIME COMMAND
14360 ?        Ss     8:53 gnome-panel --sm-config-prefix /gnome-panel-dbYk=
Zn/ -

I wonder why gnome-panel would be touching /autohome/share.

I guess what I wonder also about all of this is that isn't there some
period of "idleness" required before anything is unmounted?  Is that the
60s that I am seeing?  If I increase that to a period longer than the
periodic access by gnome-panel should that not stop the trashing of the
mount?

b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-IPKgl4KbsKG/5rHarXkX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFM9bZl3EQlGLyuXARAiNpAJ9eHc1uqO1YiqEc+JU4J/OThzoUzQCeKP5r
EQ7kl8IFOHdb/SR91fjqllA=
=VIER
-----END PGP SIGNATURE-----

--=-IPKgl4KbsKG/5rHarXkX--


--===============4299147343263158471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4299147343263158471==--

