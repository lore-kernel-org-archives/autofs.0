From: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 19:58:29 +0300
Message-ID: <20060503165829.GC1982@kaminsky>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032311080.31306@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0500979308425458652=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605032311080.31306@raven.themaw.net>
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


--===============0500979308425458652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ian Kent <raven@themaw.net> [03/05/06 18:30]:
> On Wed, 3 May 2006, Moshe Kaminsky wrote:
>=20
> > gcc -g -Os -march=3Dathlon-tbird -pipe -fomit-frame-pointer
>  -D_REENTRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE
>  -I../include -DAUTOFS_LIB_DIR=3D\"/usr/lib/autofs\"=20
>  -DAUTOFS_MAP_DIR=3D\"/etc/autofs\" -DAUTOFS_CONF_DIR=3D\"/etc/sysconfig\=
" -DVERSION_STRING=3D\"5.0.0_beta1\" -c direct.c
>=20
> There's something else wrong with the build.
> Shouldn't AUTOFS_CONF_DIR be /etc/conf.d instead of /etc/sysconfig?
> configure should look for the directory?
> What did I get wrong there?
> Does /etc/sysconfig exist on you system?
> Maybe it should be set explicitly at configure time.
>=20
> Ian
>=20

The /etc/sysconfig does exist (don't know why), and the configure takes=20
it first. I added --with-confdir=3D/etc/conf.d to the ebuild, and it=20
solved the problem.

Thanks,
Moshe


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEWOE1kBjmVsKMBeMRAlhcAKDeSCdWakXtOorkKbHVklsa9yL6jQCguY5L
bgHBiPTdKO4utc3Dm4WsOQw=
=scwa
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--


--===============0500979308425458652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============0500979308425458652==--

