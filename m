From: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 20:00:05 +0300
Message-ID: <20060503170005.GD1982@kaminsky>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032354490.31402@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3034418327727415390=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605032354490.31402@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============3034418327727415390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ian Kent <raven@themaw.net> [03/05/06 19:15]:
> On Wed, 3 May 2006, Moshe Kaminsky wrote:
>=20
> >=20
> > I modified the ebuild for autofs4 and tried to compile. I get:
> >=20
> > gcc -g -Os -march=3Dathlon-tbird -pipe -fomit-frame-pointer -D_REENTRAN=
T -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=
=3D\"/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=3D\"/etc/autofs\" -DAUTOFS_CONF_DI=
R=3D\"/etc/sysconfig\" -DVERSION_STRING=3D\"5.0.0_beta1\" -c direct.c
> > direct.c: In function `handle_packet_expire_direct':
> > direct.c:969: error: label at end of compound statement
> > direct.c: In function `handle_packet_missing_direct':
> > direct.c:1260: error: label at end of compound statement
> > make[1]: *** [direct.o] Error 1
> > make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/work/au=
tofs-5.0.0_beta1/daemon'
>=20
> I'm not sure this will make a difference but could you give it a try.

This didn't help.

>=20
>=20
> You'll have to review the Gentoo init script also.
> A starting point is the one in the tarball. It should be fairly close but=
=20
> you'll need to review it.
>=20

I'll do that once I get this to compile.

Thanks,
Moshe

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEWOGVkBjmVsKMBeMRAij0AJ9mPgGFxtOrr5aAgvkZhNLPoJPz2wCgs1cD
Lf+f9EYzYRG9lLhCLZf7ojo=
=/X1M
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--


--===============3034418327727415390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3034418327727415390==--

