From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: automounted filesystems being unmounted and
	mounted	every minute
Date: Fri, 27 Oct 2006 11:29:42 -0400
Message-ID: <1161962982.11403.7.camel@pc.ilinx>
References: <0F5A1C742BC73849AFF518F1F8249D4D0181D362@mtpx3m2.mtp.emea.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4109990280791153521=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <0F5A1C742BC73849AFF518F1F8249D4D0181D362@mtpx3m2.mtp.emea.dell.com>
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
To: Scott_Rochford@DELL.com
Cc: autofs@linux.kernel.org


--===============4109990280791153521==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hMBsC6yFPQgI4y5fE2ky"


--=-hMBsC6yFPQgI4y5fE2ky
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-27-10 at 16:14 +0100, Scott_Rochford@DELL.com wrote:
> Hi,

Hello,

> I've been puzzling over a similar problem with mounts of long since
> removed users' home directories occurring every few minutes for some
> time and was thrilled to discover this thread on the subject, however
> after enabling debugging as instructed I only get:
>=20
> Oct 27 16:06:04 e1shdb03 automount[16563]: handle_packet: type =3D 0
> Oct 27 16:06:04 e1shdb03 automount[16563]: handle_packet_missing: token
> 1487772, name scott
> Oct 27 16:06:04 e1shdb03 automount[16563]: attempting to mount entry
> /users/scott
>=20
> RHEL AS 3
> autofs-4.1.3-154
> 2.4.21-37.0.1.ELhugemem
>=20
> Do you have any other suggestions for methods to identify the processes
> that are triggering these mount attempts?

The instructions at http://people.redhat.com/jmoyer were very helpful on
my Mandriva boxes as it would print the pid.  On my Ubuntu Edgy box
though no pids to be found.  :-(

In my case I found two causes:

     1. Having an automounted share in my GTK "bookmarks" was causing a
        ping-pong effect where as soon as it was unmounted, gnome-panel
        wanted to go stat it.  Stupid.
     2. An open Nautilus window and/or a Nautilus desktop icon on/for an
        automounted share was causing the same kind of ping pong.

b.

--=20
My other computer is your Microsoft Windows server.

Brian J. Murrell

--=-hMBsC6yFPQgI4y5fE2ky
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFQiXml3EQlGLyuXARAhuZAKDhBzzhO1vL2lZ3Q3fKOMI6ZO1AkwCfWBri
8cqFx8SnsRBLQRDebsHedzw=
=14Lz
-----END PGP SIGNATURE-----

--=-hMBsC6yFPQgI4y5fE2ky--


--===============4109990280791153521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4109990280791153521==--

