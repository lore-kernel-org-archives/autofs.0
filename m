From: "Arthur Korn" <arthur@korn.ch>
Subject: Re: autofs init script doesn't support exclude
Date: Thu, 23 Sep 2004 12:54:27 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040923105426.GA3372@turing>
References: <20040920224949.GL23879@merlins.org>
	<20040921203920.GA9988@turing>
	<Pine.LNX.4.58.0409221533390.25785@wombat.indigo.net.au>
	<16721.32274.474781.773811@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0409231120110.17889@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============042467143951903097=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409231120110.17889@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============042467143951903097==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Ian Kent schrieb:
> I think this will need thought wrt what distros use which directories.
> Perhaps some work on configure to make it happen right and at least a dea=
l=20
> of work on the init script.
>=20
> My question is "can we try to do this in a reasonably distribution=20
> independent manner". Having each distro carry its own patches is one way=
=20
> to identify the needs.

Actually I don't like this at all. The debian patches to the
init script of autofs3 are the reason why autofs4 is not even in
unstable yet: they are copious in size and fix some delicate
(shell coding, ldap) issues, so it's not obvious wheter they
need to be applied to the new init script and how these problems
are best fixed. Partly that's an issue of badly documented
patches, but they shoudln't have accumulated like this in the
first place.

What I'd much prefer to see (and actually thought about doing
myself) is removing the whole "plug the master map together" and
direct interaction with automount processes from the init
script. Instead there should be a autofscontrol tool (similar to
the ones for apache, bind, ntpd, etc; interactive operation is
not strictly a requirement though) which can start, stop, reload
and display status information. This would have to be able to
act globally on _all_ automount instances.

The init script could then stick to assuring a sane environment
and calling this control tool in the way desired by the user.

> The reason I piped up here is that I have a crazy idea that it would be=
=20
> good to be able to use autofs in a range of distributions. Not just RedHa=
t=20
> and Debian as it is now in the init script. But I'm not sure how I can do=
=20
> that yet.

Separating distribution specific stuff from generic code would
be a first step towards that goal IMHO.

ciao, 2ri
--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
"Never" is almost always earlier than you think.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBUqtiNgpsykSg/LgRAr/UAJ9ebUDfHxrM2jWTHtCCyfLWGf/7PgCgnNqk
YRiycZzQNZi9YOSnj/heWZU=
=W5B1
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--


--===============042467143951903097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============042467143951903097==--

