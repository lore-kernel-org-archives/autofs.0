From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.0 release
Date: Thu, 05 Jun 2014 13:45:23 +0800
Message-ID: <1401947123.2560.19.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-RHIMmcwtTCGGXhPGq5M/"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:content-type:mime-version; s=
	mesmtp; bh=3e44OcEJjJopxwncYB1B05IDSQM=; b=AFNrsYekItIzmtvMUEZ+e
	lhbXMQuYDsm3qXKa4kfpomXvj3eIkZazsygvGpV70NXdWsRlBgI6eoZOtKXx4NWg
	PHYlfLJ0Aue0N8+wNYxywoWER43JDI9BLjXb66ohq4c++jf/GvAuxBXELkrZojFM
	HEjVx9UkmvKDe8JGNoijY0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:content-type:mime-version; s=smtpout; bh=3e44OcEJjJopxwncYB1B05
	IDSQM=; b=JE6ptaK1fdEpl+x1YNPMmQadv4F17ZICQd03VRZPmMpLi8m8cnVaTP
	kUJHX9KX+NGm26rSU/6yGR5sv5qBjbRFnHCVRKcS/jEtGSJWjYNftg6yonmgLOtj
	Do70ILHpNaqwpORvCJD/28dmerI0KWu5gpCj/r1EdcsulNt7adovg=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


--=-RHIMmcwtTCGGXhPGq5M/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

A lot of testing has been done to check that the amd format map
implementation doesn't break existing function. There's more to
do but it's time to release 5.1.0.

autofs
=3D=3D=3D=3D=3D=3D

The package can be found at:
ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
It is autofs-5.1.0.tar.[gz|xz]

No source rpm is there as it can be produced by using:
rpmbuild -ts autofs-5.1.0.tar.gz

and the binary rpm by using:
rpmbuild -tb autofs-5.1.0.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:
- fix mistake in assignment (included in 5.1.0-beta1).
- add amd map format parser (included in 5.1.0-beta1).
- check for non existent negative entries in lookup_ghost().
- fix reset flex scan buffer on init.
- fix fix negative status being reset on map read.
- amd lookup update lookup ldap to handle amd keys.
  - inadvertantly dropped from initial series.
- amd lookup update lookup hesiod to handle amd keys.
  - inadvertantly dropped from initial series.
- fix wildcard key lookup.
- fix out of order amd timestamp lookup.
- fix ldap default schema config.
- fix ldap default master map name config.
- fix map format init in lookup_init().
- fix incorrect max key length in defaults get_hash().
- fix xfn sets incorrect lexer state.
- fix old style key lookup.
- fix expire when server not responding.
- fix ldap_uri config update.
- fix typo in conf_load_autofs_defaults().
- fix hash on confg option add and delete.
- add plus to path match pattern.
- fix multi entry ldap option handling.
- cleanup options in amd_parse.c
- allow empty value for some map options.
- allow empty value in macro selectors.

Ian


--=-RHIMmcwtTCGGXhPGq5M/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTkAQOAAoJEOdnc4D1T9ip3ScQAI0MtG8PgZwNMqh9CDW4BGYP
XTgVP0kaJJ9crt57leRHKR46rZsEcG+9NxQyC98R/xmi1vUR0I0C8UPXq94yJF8k
RErTKJAyRbggOSrbJqsf0eGXs5IJaulappS328RPOfLrMuYpHv4ksfMbLnhQGBAn
eknu1oErfLJe77J97W+lrlfY7jnLsDumlWNKAYwaM54SRXc1vBhr8VsQVSol7bP9
lwohIpXwVtYLEqnse6Mkm3PhoFm3UtkXvEgVOJTzxqMicc3eD/yT46YqqwHRuD3f
q643UZ8x1pS5ZD1UChhjF2fcNu6ir/bmq6cqxdwU6jkXE+xnRUWlbGp9Vfk0ocA5
pXthoWzSukUeb9r8ofV3tWTnT8tA8lAbAUKUdjW2hTjcnwrG07Hh1M2fF6hWzd8f
wETQppLK2FEccJyy+TvBRq3Y4gqT+cV0vz5XSGnOgqNXHwffpvkhhpoSe+DQiAv8
Rdl4sTBuhHr1iYiudjkRTPvCyhsD7IcrIEixoSsxt/QqTFJ18DLdoEaUrdSbPzt2
xJlS/MoG9EUFAgn6kyNgQQTH+Jr3EGOiS1C/dETQD5+vIFVfviFUKHwxHG/UlBad
uW1W3n+FMvPv6CBBrqZ17osXdld3gf/KljMDVP+KQ04AZ+st2J2yTXknmbaYihWt
bP6WBbKpnO6MvPLHh9hr
=d8So
-----END PGP SIGNATURE-----

--=-RHIMmcwtTCGGXhPGq5M/--

