From: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 20:33:52 +0300
Message-ID: <20060504173352.GB12272@kaminsky>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032232220.31300@raven.themaw.net>
	<20060503165542.GB1982@kaminsky>
	<Pine.LNX.4.64.0605040124240.31510@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3228593551671963649=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605040124240.31510@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


--===============3228593551671963649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ian Kent <raven@themaw.net> [03/05/06 20:45]:
> On Wed, 3 May 2006, Moshe Kaminsky wrote:
>=20
> > * Ian Kent <raven@themaw.net> [03/05/06 18:00]:
> > > On Wed, 3 May 2006, Moshe Kaminsky wrote:
> > > > Another question I have: I once asked if it's possible to run the=
=20
> > > > actual mount command as the user trying to read the directory,=20
> > > > instead of root. I was told that this is impossible in version 4.=
=20
> > > > Will it be possible now?
> > >=20
> > > Do you have a mount that will work for a user?
> > >=20
> > > You can use the $USER substitution variable now to mount with a=20
> > > "user=3D${USER}" option or $UID and $GID with "uid=3D${UID}" and "gid=
=3D${GID}"=20
> > > in your map. Will that help?
> > >=20
> >=20
> > I don't think so. What I have in mind is that a user will be able to=20
> > automount his home directory on a remote machine using sshfs. For this,=
=20
> > that user has to actually run the mount command, so that his ~/.ssh is=
=20
> > used.
>=20
> The problem here is that mount(8) will only allow the "user" option if=20
> an entry is present in the fstab which defeats the purpose of using=20
> autofs.

Funny. It appears that you're right. I'm sure it used to work, though=20
(maybe something changed in the kernel?)

Thanks,
Moshe

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEWjsAkBjmVsKMBeMRAqtHAJ4mFPQKJS9INi6iY++Iv5XeckYaXQCg12QJ
aTb92C47mA1kyano316Qa5Q=
=3Fzw
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--


--===============3228593551671963649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3228593551671963649==--

