From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: Re: [PATCH] avoid calling mount during configure
Date: Sun, 21 Apr 2013 20:29:09 +0200
Message-ID: <51742FF5.1070301@gmx.net>
References: <5173AD94.9080301@gmx.net> <5173B722.1030807@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2DTVMQHOLNFQSUALJXJKM"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <5173B722.1030807@msgid.tls.msk.ru>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: Michael Tokarev <mjt@tls.msk.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2DTVMQHOLNFQSUALJXJKM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21.04.2013 11:53, Michael Tokarev wrote:
> 21.04.2013 13:12, Martin von Gagern wrote:
>> The configure script unconditionally calls "mount -s" in an attempt to=

>> figure out whether the command supports that option or not. This can
>=20
> The support for old mount command, together with pre-2.2-something kern=
el,
> should be just dropped from automount, together with all these configur=
e
> checks, instead of inventing even more workarounds.  In my opinion anyw=
ay.

I hadn't been aware that the -s option has been around for as long as it
apparently has. Dropping old legacy is fine by me, as long as there is a
way to avoid running mount. Do you need a patch for that approach as
well, or can I leave that to the maintainers?

Greetings,
 Martin


------enig2DTVMQHOLNFQSUALJXJKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlF0L/oACgkQRhp6o4m9dFuSdQCfaU/L1XKphA5dF1LBjBmZVxOq
DsAAnjhXmTW7ODeRM2j6cotdg/Q4zsEF
=rP6w
-----END PGP SIGNATURE-----

------enig2DTVMQHOLNFQSUALJXJKM--
