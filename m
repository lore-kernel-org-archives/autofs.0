From: "Arthur Korn" <arthur@korn.ch>
Subject: help needed for LDAP autofs master map support
Date: Mon, 27 Sep 2004 22:44:47 +0200
Message-ID: <20040927204418.GA3443@turing>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <bounce-debian-devel=debian-devel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
Resent-Message-ID: <nT6bMB.A._SE.EvHWBB@murphy>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:debian-devel@lists.debian.org>
List-Help: <mailto:debian-devel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-devel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-devel-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-devel/>
To: debian-devel@lists.debian.org, autofs@linux.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

[ debian-devel: please Cc answers to the autofs list, I'm not
subscribed ]

The new autofs 4.1.3 packages are coming along nicely, I'm
letting it in experimental until my next release to make
shure we won't end up with major errors from me in sarge. Please
try it out if you're interested in it.

Since I hardly know LDAP I need some advice on the way I should
fetch master maps from LDAP.

Debian autofs 3*-4.0.0pre10 packages (current unstable) do this
with ldapsearch. Now in 4.1.3 upstream has integrated a
dedicated tool "autofs-ldap-auto-master" from RH for this
purpose.

Now I'm unsure which of the two is the Right Thing.

Further, does autofs-ldap-auto-master merge LDIF continued
lines? (which was an issue before)

How is autofs-ldap-auto-master told where to query and what DN
to bind to? (authentication?) Debian offered variables for this
in /etc/defaults/autofs before, and I'd prefer not to break this
wrt our current stable release.

You can fetch binary and source packages from
http://packages.debian.org/experimental/utils/autofs

In the root of the source package there are still the patches
sitting which implemented LDAP master map support in stable,
they are named:
043_nsswitch_and_auto.master_in_ldap	# nsswitch supported already
044_handle_ldif_continued_lines_in_init_script

Thanks in advance, 2ri
--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
Why is "abbreviation" such a long word?

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBWHu+NgpsykSg/LgRAqGqAKDO6Mr7wdhhGVQpEuZ50aXBf2oSxQCgjTmI
+dielUEHd1h581WCitaBUDw=
=TzgQ
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

