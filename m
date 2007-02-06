From: Jan Christoph Nordholz <hesso@pool.math.tu-berlin.de>
Subject: Re: Race condition in autofs 4.1.4
Date: Tue, 6 Feb 2007 10:45:56 +0100
Message-ID: <20070206094556.GA14111@pool.math.tu-berlin.de>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven>
	<1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170084830.2817.19.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170727482.3378.30.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3978514784637136628=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170727482.3378.30.camel@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============3978514784637136628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ian,

> I've just remembered that there are a number of patches for 4.1.4
> (mostly from Jeff Moyer) that I need to review and merge but I haven't
> got to it get.
>=20
> One of them changes autofs to use /proc/mounts instead of /etc/mtab
> which may be more appealing than using the symlink approach.
>=20
> We could try this patch but I don't have a Debian install to check if
> the patch applies to it. It would be out of order as well so may be a
> bit of work to merge. I'm also not sure what patches are included in the
> Debian package. I could just make it apply to 4.1.4 on top of the
> patches on kernel.org and see how it goes for you.

I could certainly lend a hand wrt testing its integration into Debian.
Is there a place where unofficial or unreviewed patches are kept, so I
could have a look? - Btw, how did Steinar usually forward patch suggestions
upstream? Is there a dedicated address or a subject convention to tag those
messages?


Regards,

Jan

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFyE5UJnGRgaR03R4RAv9ZAJ9rdaziuZ3lShqNjpi8mL4CWLK1RwCg0Xye
hDIqH3kz7qqdSj+DFqWdFk0=
=cvrj
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============3978514784637136628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3978514784637136628==--

