From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.10 release
Date: Tue, 21 Apr 2015 18:22:06 +0800
Message-ID: <1429611726.2694.3.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-E5HNdJ/7/9hDI3zLC82S"
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-type:date:from:message-id:mime-version:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=qeH6LFv2SgaQ+VeOVAYg19IDZ8c
	=; b=Oww+PmxxeTeERDRMcs2LUbbBDR033pbdTxYzdUcj3TiuNJB+to7jGPb+kxA
	qffN3Jif9buVAKZGoEeFU2keO3nA6fjmUngG9mxHMTZ7WghKHda8MJTnas04uyQt
	KQX7XqvyPxvgJcI6mEOuZ/TvDZ4zMnvb49zxSwSAWVY/G/yc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qe
	H6LFv2SgaQ+VeOVAYg19IDZ8c=; b=svgd1taLf9ISXjvrFeFMYghk3dVi8qD7Qk
	dl2g9A1McmLyWeTZtskPhvsTFF5aEx6T37i7TDF2fq3bUqrAMZkHncVlBUHrxwH7
	8gN7pUP3+6xC7nLMm852BrXMnSJDDUR8AKuMsAoro00jnFlRgDY8qvF/kHbpJxjQ
	qciQ2XsS0=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


--=-E5HNdJ/7/9hDI3zLC82S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

The thing to watch out for in this release is a change made to program
map execution environments. The standard environment added at program
map execution introduced a security problem when interpreted languages
like python were used. By default, a prefix is now added to these names
to avoid the problem and, for those that wish to force the use of
standard
names, a configuration option has been added to do that.

autofs
=3D=3D=3D=3D=3D=3D

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.10.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.10.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.10.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

21/04/2015 autofs-5.0.10
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- fix mistake in assignment.
- check for non existent negative entries in lookup_ghost().
- fix reset flex scan buffer on init.
- wait for master map available at start.
- add master read wait option.
- add serialization to sasl init.
- dont allocate dev_ctl_ops too early.
- fix race accessing qdn in get_query_dn().
- fix incorrect round robin host detection.
- fix memory leak in create_client().
- fix memory leak in get_exports().
- fix typo in flagdir configure option.
- clarify multiple mounts description.
- gaurd against incorrect umount return.
- update man page autofs(8) for systemd.
- dont pass sloppy option for other than nfs mounts.
- make service want network-online.
- fix fix master map type check.
- init qdn before use in get_query_dn().
- fix typo in update_hosts_mounts().
- make negative cache update consistent for all lookup modules.
- ensure negative cache isn't updated on remount.
- dont add wildcard to negative cache.
- add a prefix to program map stdvars.
- add config option to force use of program map stdvars.
- fix incorrect check in parse_mount().
- handle duplicates in multi mounts.
- revert special case cifs escapes.
- fix map option parsing for 'strictatime'.
- fix showmount search in auto.net.
- remove obsolete comment in auto.net.
- fix macro usage in lookup_program.c.
- fix gcc5 complaints.
- remove unused offset handling code.
- fix mount as you go offset selection.
- link daemon with pthread library (Debian patch).
- manpage corrections (Debian patch).
- fix manpages hyphenation (Debian patch).

Ian



--=-E5HNdJ/7/9hDI3zLC82S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVNiTOAAoJEOdnc4D1T9ip+WAP/3yed/DLKcIs1tW1O+2OVg9j
txZ/tV411zXq8vCfM/pUKmlyCOQFA/UkJpGnBFHNjhHW9DrWluIPGnNW4WjNItYW
razRL9vhgHWlgw5RHnlC10fd/Yt7gV8xUSYDk/BERIGeAHu6DQFLLxeZbU17xXgh
Q3ONgZTN6HNpCW2GPYbf21D+aoBC9d5q5eUEZ0yUQU8hYlVj3/CfD40H3dman5hT
zb5jGajGjhFDbWowFVIxFXNu96WDHEGBr7khtqaRwGoOd30arEqONLdq5e9WHTKu
MW4KlS7v7zspifBkEEAPBaZO7eN4Ch1qDWXiNw6ITqiSB9ub/vzZDt0UwjZpBSqH
DMW1asRip6f0yNrQ3OgwGkFbhsSSDKmnmVCBA72DAt8Legwf8F26yWrhCZSNc9Gt
tlmN+t/OX/pAoAVEY9hkIo+O93IuyaB4qHkbB9zlmVnHbyC6uc13Dd8Kj+CeUilz
Q0wVjEB+ptF4mAfTdFHmw/tR9uA4GSwwcnYN/ItAGbJyKxXSYMNv3DHeo3i1DnhJ
KxRevqYjYLS6gmjrna8tc47ThEMWl8tTtqbVTvEVYsZ8NNPKMKv2waoC5vtksJAt
UGGB+jnRQgTCImQrD22mdzNLxFtcI3xSD4TysFRdtYEXodsmAbC7P8odnZ1Pcnrv
ANs/TEFqXqf3zmf3mUi2
=O4Zw
-----END PGP SIGNATURE-----

--=-E5HNdJ/7/9hDI3zLC82S--

