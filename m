From: Jeff Mahoney <jeffm@suse.com>
Subject: mount -oaddr=<ipaddr> ?
Date: Mon, 4 Apr 2016 20:55:32 -0400
Message-ID: <57030D04.7010805@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mufwAXxXOGtlt4QDK74N2nKg1GBtvlWbi"
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org, Ian Kent <raven@themaw.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mufwAXxXOGtlt4QDK74N2nKg1GBtvlWbi
Content-Type: multipart/mixed; boundary="1k3jll9HPAXulEXPJ6UM99R9E90844UP0"
From: Jeff Mahoney <jeffm@suse.com>
To: autofs@vger.kernel.org, Ian Kent <raven@themaw.net>
Message-ID: <57030D04.7010805@suse.com>
Subject: mount -oaddr=<ipaddr> ?

--1k3jll9HPAXulEXPJ6UM99R9E90844UP0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all -

I'm investigating an issue where our user updated from SLE11 to SLE12
and the hostname for autofs mounts stopped appearing in the 'mount'
output.  I know why this happens, what the reason for it being this way
is, and that it can be overridden by setting the
use_hostname_for_mounts=3Dyes option (and the side effects).  Before I go=

and write up the patch implementing it, is there a reason why autofs
doesn't pass the hostname in the mount source and specify the ip address
using the -oaddr=3D<ipaddr> option?  Was this tried and found to be
wanting somehow?

Thanks,

-Jeff

--=20
Jeff Mahoney
SUSE Labs


--1k3jll9HPAXulEXPJ6UM99R9E90844UP0--

--mufwAXxXOGtlt4QDK74N2nKg1GBtvlWbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJXAw0HAAoJEB57S2MheeWyGbkQAKn/tNp5UDaosFyzBsA/xuDy
3LBC/0+cldMSKTXewoAsVQV2ssACxFsjYp3T52Ow+wW9qTwemxKIotj/zI5WpqxR
r4NWIjtn9niO2sCzFW2a9oqgQ1eHAbqDailFhbI4A4nGN3jqZTHzBpHr19DvF7lV
7X2HPWZI0aHgKKLX06Vc6O6Vo6onS9B4e2+2EOung/pDjeguG+b+hu8Ob5q48t6n
k7uLORG4xVY0OzhBdG/IlJN6+SPFnF6vBf3/Au3zzsak0saheF7aViR2bHtp6Caj
omD7enUJk/N2oePyqTrYcK6ubdRoNQ/MHTGvDQ/DMdPIuiujhD1Xw6lfBzyI2OnD
Bk1XLyjNN6SMJPADfmIjUcptiO0LRobxhy7C+XJ5jqrw2VUMYhZ7Zne2zfevl3yc
JqrVSq0LxEdeW/s30i33V33vSoRL4QStMdB9My+GohXv0OLMu5fApfBogY4X0xN5
hgCQrHa8lLIpnm1tLfFxd2lqdYg7eFRxlyk/n98cFLgVMpsYV5e4eqzDLL/zS6GU
OLNTW5ZkvKCcFcify47fP8o3Y4k76N1uo1uKG2Cmrgq1Yd+J534zCIFlYo5FEXsb
a1YTqsp7apkwtLfNZhiv1RWrCi1WqfKQ8bxZukYCDcIVNB8yKUsG4Np2uyOpTGpX
BSaVxmdBV7zBbZBderVT
=zjY3
-----END PGP SIGNATURE-----

--mufwAXxXOGtlt4QDK74N2nKg1GBtvlWbi--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
