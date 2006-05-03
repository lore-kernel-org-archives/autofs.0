From: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 16:16:37 +0300
Message-ID: <20060503131637.GA30523@kaminsky>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7384813653260195019=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
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
To: autofs@linux.kernel.org


--===============7384813653260195019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ian Kent <raven@themaw.net> [02/05/06 20:30]:
>=20
> Hi all,
>=20
> I've finally got to a point where I can release a beta of
> autofs 5.0.0.
>=20
> I would really appreciate some real world testing of this
> so I hope some of you are able to help.
>=20
> Feedback is welcome.
>=20
> autofs
> =3D=3D=3D=3D=3D=3D
>=20
> For the moment the package can be found at:
>=20
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4
>=20
> It is autofs-5.0.0_beta1.tar.[gz|bz2]
>=20
> No source rpm is there as it can be produced by using:
>=20
> rpmbuild -ts autofs-5.0.0_beta1.tar.gz
>=20
> and the binary rpm by using:
>=20
> rpmbuild -tb autofs-5.0.0_beta1.tar.gz
>=20
> See the INSTALL file for information about configure options and
> kernel requirements.
>=20
> I have no way to test the Gentoo portage build and the build
> files will need to be modified for beta1. It would be great
> if someone could get this working and forward a patch before
> the final release.
>=20

I modified the ebuild for autofs4 and tried to compile. I get:

gcc -g -Os -march=3Dathlon-tbird -pipe -fomit-frame-pointer -D_REENTRANT -D=
_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=3D\"=
/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=3D\"/etc/autofs\" -DAUTOFS_CONF_DIR=3D\=
"/etc/sysconfig\" -DVERSION_STRING=3D\"5.0.0_beta1\" -c direct.c
direct.c: In function `handle_packet_expire_direct':
direct.c:969: error: label at end of compound statement
direct.c: In function `handle_packet_missing_direct':
direct.c:1260: error: label at end of compound statement
make[1]: *** [direct.o] Error 1
make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/work/autofs=
-5.0.0_beta1/daemon'

Note that I removed all the patches that were used for autofs4. I'm=20
using gcc 3.4.6.

Another question I have: I once asked if it's possible to run the actual=20
mount command as the user trying to read the directory, instead of root.=20
I was told that this is impossible in version 4. Will it be possible=20
now?

Thanks,
Moshe

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEWK01kBjmVsKMBeMRAk8sAJ9icTnW6Df+nXArOUdv6OQXGVc8IACfWkFH
jYXLVKDCChwAyd5vrprUqGo=
=Y/xB
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--


--===============7384813653260195019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7384813653260195019==--

