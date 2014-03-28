From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 5.0.9 release
Date: Fri, 28 Mar 2014 15:21:12 +0800
Message-ID: <1395991272.2704.16.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LDsRlOBtqTRj6+DRClSC"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:content-type:mime-version; s=
	mesmtp; bh=vfSzG0ny5ZnYqpFrTesWygFytwI=; b=x1tP6zW/mDlkyFEIXV/Zb
	6JRr53TBpClPmWdmPSvvt+v0OKU9hdToV/uR56OEApz6Th4ngeQFhkoUPmP1f8nT
	1cOfm/fvIQm9hckn89UJxm8hML7LOM+jHxLLucOtr7LESiwsVZxFlSnkxyqDs5Xo
	ZYnunRlTizX/tRN03h9oSA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:content-type:mime-version; s=smtpout; bh=vfSzG0ny5ZnYqpFrTesWyg
	FytwI=; b=l/XnU0aKtQCJMLpcL0qZ3GIh1UIuLhnqzOsb8WnxnOWi/4C6nmvu8n
	nR7VxkwWOzcabgL55LcKa2C4xILs5fYx2rnBeYRXhvSbXQXe8OWXJaRfd7R8TaoN
	fJEhmAET+al/kJrTaRwp9iGXqTfwDSj9eMUjHUPTANLqIofQ/Vrx8=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


--=-LDsRlOBtqTRj6+DRClSC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Here is a bug fix release for autofs.

For those that have clones of the git repository the master branch
will progress to autofs-5.1.0 and autofs-5.0 will continue to be
updated with bug fixes (and periodic releases) on the new branch
autofs-5.0-stable.

For those that have git clones that include the branch autofs-5.0
you probably want to prune your remote as that branch has been
deleted.

autofs
=3D=3D=3D=3D=3D=3D

The package can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5

It is autofs-5.0.9.tar.[gz|bz2|xz]

No source rpm is there as it can be produced by using:

rpmbuild -ts autofs-5.0.9.tar.gz

and the binary rpm by using:

rpmbuild -tb autofs-5.0.9.tar.gz

See the INSTALL file for information about configure options and
kernel requirements.

Here are the entries from the CHANGELOG which outline the updates:
- fix undefined authtype_requires_creds err if ldap enabled but without sas=
l.
- fix master map type check.
- fix task manager not getting signaled.
- allow --with-systemd to take a path arg.
- fix WITH_LIBTIRPC function name.
- fix ipv6 libtirpc getport.
- fix ipv6 link local address handling.
- fix fix ipv6 libtirpc getport.
- get_nfs_info() should query portmapper if port is not given.
- fix rpc_portmap_getport() proto not set.
- fix protmap not trying proto v2.
- fix rpc_getport() when libtirpc is disabled.
- fix rpc_getrpcbport() when libtirpc is disabled.
- don't reset errno.
- extend fix for crash due to thread unsafe use of libldap.
- fix deadlock in init_ldap_connection.
- fix options compare.
- fix negative status being reset on map read.
- check for existing offset mount before mounting.
- fix max() declaration.
- fix symlink fail message in mount_bind.c.
- fix cache readlock not taken on lookup.
- pass map_source as function paramter where possible.
- check for bind onto self in mount_bind.c.
- fix symlink expire.
- dont clobber mapent for negative cache.
- fix macro_addvar() and move init to main thread.
- change walk_tree() to take ap.
- add negative cache lookup to hesiod lookup.
- fix external env configure.
- make autofs(5) consistent with auto.master(5).
- fix map source with type lookup.
- fix lookup_nss_mount() map lookup.
- dont ignore null cache entries on multi mount umount.
- fix inconsistent error returns in handle_packet_missing_direct().
- simple coverity fixes.
- fix fix options compare.
- use open(2) instead of access(2) to trigger dependent mounts.
- fix fix map source with type lookup.
- fixes for samples/auto.master.
- fix variable substitution description.
- fix incorrect append options description in README.v5-release.

Ian


--=-LDsRlOBtqTRj6+DRClSC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJTNSLoAAoJEOdnc4D1T9ipjxcP+gLSHyPYAaKEoVO5VniQzWrD
0x/hPNCSFnkBBQKstliuJalZJNSijZMEm9yLpPU+/+sNom/2SuwobR27w4vo9ZMw
ubEFiRUIADFa4PugCStmeYYEF1Kn0Dmoy+7ZhT6gZGlGd+UO5hiMzzCGRM+M5OFG
driOV5z/1QtXk7sUAlHxutTr49AYTX1Q93kpaDHNWMgmqDJP5aJlpiJVFj1q9+yi
fzzZuH7hFdb0rGba78hSprnazS0FRggGiHE+DSLsvQl/OiWDGo+TTGz2P+6eJjYC
Y55fKMVLg7sseVpcwbi/4luEccXH+sPFtuHw2IrwtUKLZoZNplbrSkIp5QlhIKah
pLkmSsWSvxyW+n6Us9LdyMDCmyjhyd1ZngKuRVOMKKZIcI8h4tCnCqtCRQsf4wB6
Nk0u3ldCM2wNdXVmcouKviKb1dC/o0HxiqvZ8CfrPjbjc6uyQUT8BvS6M9ndju6a
s6L/uaB7vyNqF3Zi6lGq2db7E1qd0qDyzaGVvp/zGbuLrDtiVQBfcuYTbu8SSjK9
vQ0qBAJ+r4A85F6ATWaMKIFSTo6wfF4iJBqaXw9V63rYFMi1I6Cwn3NAaTnYOzV8
vMKXeG6yxMyhcDfIrWxWOUidHQAfqdWuQ/8xUczJ2jNaCAPJogcLZVyQgoS7d2/I
m77UzzTmemV8Xw8q1E3d
=Xflv
-----END PGP SIGNATURE-----

--=-LDsRlOBtqTRj6+DRClSC--

