From: Aaron Straus <aaron@merfinllc.com>
Subject: Re: autofs does not umount
Date: Thu, 27 Aug 2009 16:27:53 -0700
Message-ID: <20090827232753.GA26300@merfinllc.com>
References: <20090827222825.GA23043@merfinllc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9056109802702113565=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090827222825.GA23043@merfinllc.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>, autofs@linux.kernel.org
Cc: viro@zeniv.linux.org.uk


--===============9056109802702113565==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 27 03:28 PM, Aaron Straus wrote:
>   I was testing kernel 2.6.31-rc7 and noticed that autofs4 doesn't seem
> to be umounting file systems anymore. =20
>=20
>   In particular after the timeout expires file systems seem to stay
> mounted.  Furthermore if I do a umount of the file system by hand it
> works i.e. the file system isn't busy.  Also sending a USR1 signal to
> the automount process does not cause an umount either.
>=20
>   I've initially observed this behavior with NFS mounts, but set up just
> a single, local bind mount (in the automount tables) and the bad
> behavior is still there.
>=20
>   I reverted to 2.6.30.5 and automount works as expected.  This is on a
> Ubuntu Hardy system running the autofs 4.1.4+debian-2.1ubuntu1 package.
>=20
>   Anybody else having this problem?  Any additional info I can provide?

Update.  Bisection seems to yield this as the first bad commit:

commit 9393bd07cf218ca51d0e627653f906a9d76a9131
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Apr 18 13:58:15 2009 -0400

    switch follow_down()
   =20
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


Al CC'd.

Thanks!

					=3Da=3D



--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Aaron Straus
aaron@merfinllc.com

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFKlxZ5r/o4YuvB+jgRAqRGAKCR2R26P+VpnJw6AGlM8ZN2mL4uNwCgwhsC
LU5gowEUcEtzmZ7lb+XzuZs=
=GsI+
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


--===============9056109802702113565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============9056109802702113565==--

