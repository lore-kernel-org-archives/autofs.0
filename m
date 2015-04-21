From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.1.1 release
Date: Tue, 21 Apr 2015 18:20:04 +0800
Message-ID: <1429611604.2694.1.camel@pluto.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-V8vzokaLMXOX848QGhvW"
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-type:date:from:message-id:mime-version:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=w5Q9GXywqPI0PWgFimJppuGo5Ck
	=; b=HcesmD55ck/7arGZ0WpJbrfvAhzy6U40N09mB8AahsTny0rTY09iu/NprxP
	lsx0h586wqHE8h5Q2U5SJsCXrUpkkdZq/rE1/vJdI2oneaLcnh2Jaid8rDO3sfVR
	mIWD9qgkmkqnCop5mnT6aY+zKYntp0FV8l3vYii3F6ll8t9k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=w5
	Q9GXywqPI0PWgFimJppuGo5Ck=; b=H/QAKJcgjRWYni9CcYhlrp8mfDtJSrLKAg
	W7ZKeMrDm0wnsIgbBRYzK1FkF9aJcIOIokiMNxlVoEDhvsWAKCW+yywHwsFI/2ba
	jVeIj9PFmlMW3eUYGKhJH5gEzm8CXmX26C/18T3KHV5umKbFT82XNL4w8EK1xwWu
	OPCLlLTnw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


--=-V8vzokaLMXOX848QGhvW
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

It is autofs-5.1.1.tar.[gz|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.1.1.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.1.1.tar.gz

See the README.amd-maps file for information about using amd format
maps.

Here are the entries from the CHANGELOG which outline the updates:

21/04/2015 autofs-5.1.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- fix compile error in defaults.c.
- add serialization to sasl init.
- dont allocate dev_ctl_ops too early.
- fix incorrect round robin host detection.
- fix race accessing qdn in get_query_dn().
- fix leak in cache_push_mapent().
- fix config entry read buffer not checked.
- fix FILE pointer check in defaults_read_config().
- fix memory leak in conf_amd_get_log_options().
- fix signed comparison in inet_fill_net().
- fix buffer size checks in get_network_proximity().
- fix leak in get_network_proximity().
- fix buffer size checks in merge_options().
- check amd lex buffer len before copy.
- add return check in ldap check_map_indirect().
- check host macro is set before use.
- check options length before use in parse_amd.c.
- fix some out of order evaluations in parse_amd.c.
- fix copy and paste error in dup_defaults_entry().
- fix leak in parse_mount().
- add mutex call return check in defaults.c.
- force disable browse mode for amd format maps.
- fix hosts map options check in lookup_amd_instance().
- fix memory leak in create_client().
- fix memory leak in get_exports().
- fix memory leak in get_defaults_entry().
- fix out of order clearing of options buffer.
- fix reset amd lexer scan buffer.
- ignore multiple commas in options strings.
- fix typo in flagdir configure option.
- clarify multiple mounts description.
- gaurd against incorrect umount return.
- update man page autofs(8) for systemd.
- dont pass sloppy option for other than nfs mounts.
- make service want network-online.
- fix fix master map type check.
- init qdn before use in get_query_dn().
- fix typo in update_hosts_mounts().
- fix hosts map update on reload.
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

--=-V8vzokaLMXOX848QGhvW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJVNiRmAAoJEOdnc4D1T9ip67cQAMy18CXlGP6qR0Q0Pmkd5GFf
0I5oAozVhQDID5oG7Htiiej+kfJijTNgJ4rIi795PcBc6D3D7hOyWs309oE+U6iy
yxReQaZxEuCv0d4f9BBrRcgxrjyFDZ3Cb1tY/DonmFSFnBO8csQHQUKhXFzMcZK8
7ZCgcEwZR/Xsqqo+ga78loxGf+oKZ+VveE6O1hsUkkiAeFmVgYUdnFcLRYw9HcjA
mY4nYZPUCeu2OdSU4qGCkQS1x6PsyOtRfW+w0kssUAt3EaMM7LKQ9bLSIl6m8LDS
fu0imYRnJDlqiAUCPqfAL65jWyDR50GHyt8DarrufrmtdAlxfj2ZdJ+HlB4TK47F
eLkdga2MNqcsyMNRbf1G78sUfSjiRxGRXuIluMi6hgCJ0RpopA54JE6yIRBdXJJ8
j0lkZVozfZsgX9iRTRsfnlAdTOpFgOU1hI3XzjT73hkOLsAAMNjv56eauX5Tm/gY
HyA8cK4udOwXImPH1g7JLcSAlxsMNk2wVWKpaG+fCkdnwnVcxhsA2q7WvxuxB5aD
vrUXFqGrWHhaMx+repuu7wqrhiPf/CEx6JVY18oFzh/nCPPFCDnjUGftP+200QW4
hJEGotBg5y7lLJ2hA3u8gbuPJLfDhpsmKlVnsfuk31KtHE+IhLyn9JMsqJQ2Mw/5
5O8tm/+pNs7aDpHZnrgq
=AYeS
-----END PGP SIGNATURE-----

--=-V8vzokaLMXOX848QGhvW--
