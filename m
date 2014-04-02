From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.0 beta1 release
Date: Wed, 02 Apr 2014 16:30:12 +0800
Message-ID: <1396427412.2726.21.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-pISYbW3eMeTGKZf99V+U"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:content-type:mime-version; s=
	mesmtp; bh=W89g8qo+O4RzUlL1PSNiEtVDRQI=; b=dEASkFbgwcefdqfkd55oq
	2vANchk6PGSnkv07GHhxmSfZQ6I0rFLlj7fIZID1eqt1oDnuiszJYWhsQQN63apT
	Qu76ShPoBM98Ov2WBokMAB2Nkes3YQYV0pKhtIp2bs8wHG2F49oU5oMae4GxfFbF
	yosJZzstftj93hmIqFEY+U=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:content-type:mime-version; s=smtpout; bh=W89g8qo+O4RzUlL1PSNiEt
	VDRQI=; b=mzVKPvpz//3B6Az6M0z+8/ZTqSYepF/rASimj/65+B/cBqPtSOcLfj
	AJ1v3kRL1LGRY1Y+xVWxb09e0kXnUFcI8gF/fiHnVjoQteNhT8awJLNv5UtBgrOx
	WNJt6GHMHUx30bH/zZpokI1ibfzkvE1BqkySYSF68vH/2cJjbUBJY=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


--=-pISYbW3eMeTGKZf99V+U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

This is an initial beta release which adds the ability of autofs
to understand the amd map format.

Making autofs understand the amd map format is a significant change
and, due to the way it's implemented, forms the basis for further
changes for autofs 5.1. However, most of these changes won't add
functionality, they are meant to improve the current implementation.

One functionality change that this will eventually lead to is the
alility to specify a custom umount program in a map entry, but an
awful lot needs to be done before that can be added.

autofs
=3D=3D=3D=3D=3D=3D

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.1.0-beta1.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.0-beta1.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.0-beta1.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Ian

--=-pISYbW3eMeTGKZf99V+U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJTO8qUAAoJEOdnc4D1T9ipRYgP/3PMaUxHySCNX4g3YOV0oft5
uJaUvSAWWR8fE5rB589CX8IiucYzSyLXlR/n1VrpsIihbrgfDDU7r1+lHVRQdwM2
E5/SLE4ycm2MOfM32OlX1QamMZ51jVhM6pf6zQt9ZbWH0hM6zItx10H3nKnaBTtl
Zru5+GkL5PKLiUGAxjCu8p1CuOlmLe4ej4yFvN/JHZALIcH6qlvNxbzpn7URCdxp
6W1rmW10bmGXX783lbPVpv7o6945s+HPolvfqDwdEgYQlWjcPNyhyUwxsxeFtjPH
B21Mj3sGXAbmBGbfTN23i+lRHg6HGQAiNa3GpLTrHj3IAaU8XOszHtlXdAsCk9H+
OOhjG8VgcqAN9vQfwW8sEIxOOOI3ZEOaRSToUscOaYLd89IXWHPTzP7+8MJraxIS
nJC9FEfZCbAv0TH5R8mRMN3q1BxzX5kZM2ePUdu+bPqriaUQa4pLlCo0QwyTQt74
lEBpSngox1JSZSBe94BeQSGgCl/EOVQNP7XYi8ewcb67qRhlIpx5/lmAmGusnmLQ
9gTUXtxKW8b6g7EHBY7pRUmDt0Pslt3N8i4NJ3lSOaGOU1kXknfbVt59NPB8U6dw
09XpG5hvE4m96SynhThN8UX4r3L/oqXnsnutr9fDDsP1epbf3s7uRZCzcf+U7Ggk
0f8HR/7DLFVeqKGuhFCw
=hil/
-----END PGP SIGNATURE-----

--=-pISYbW3eMeTGKZf99V+U--

