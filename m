From: "D. Bahi" <dbahi@enterasys.com>
Subject: Re: auto direct
Date: Tue, 20 Jul 2004 11:06:39 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40FD34FF.9000408@enterasys.com>
References: <200407162031.i6GKVHK32402@ns2.ypf.com.ar>
	<Pine.LNX.4.58.0407200926070.26260@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74700319759929856=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0407200926070.26260@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============74700319759929856==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig313928B8A3FFC26276549E84"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig313928B8A3FFC26276549E84
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

well - to be helpful - direct mounts are supported if you have
a non-root mount point (a mount point other than '/')

/etc/auto.direct (works):

/mount/auto  -options server:/path/to/mount/point

but

/etc/auto.direct (won't work):

/mountauto  -options server:/path/to/mount/point


Ian Kent wrote:

> On Fri, 16 Jul 2004 EAGOMEZC@REPSOLYPF.COM wrote:
>=20
>=20
>>Hi,=20
>>
>>i=B4ll need to setup direct maps in a linux box using a nis server on S=
olaris 8.=20
>>This option is not supported in autofs 4.
>>
>>I don=B4t know why is not supported, why ? is not implemented, or are t=
here any security tip ?=20
>>
>>Are there another way to mount direct maps ?
>>
>=20
>=20
> Your not entirely correct.
>=20
> Maybe you should investigate a bit before making these assumptions.
>=20
> Ian
>=20
>=20
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

--=20
db


--------------enig313928B8A3FFC26276549E84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (MingW32)

iD8DBQFA/TT/3XQ4zakZ3z4RAmRVAJ9hXMnTKuG548dDyqCuXczqX35NUQCeJlf8
pnnbjeqVxQBOOa9Gfh4S9uA=
=1F53
-----END PGP SIGNATURE-----

--------------enig313928B8A3FFC26276549E84--


--===============74700319759929856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============74700319759929856==--

