From: "Arthur Korn" <arthur@korn.ch>
Subject: Re: Debian diff remaining in autofs 4.1.3
Date: Sun, 5 Sep 2004 13:40:31 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040905114031.GB3169@turing>
References: <20040904200654.GA26488@turing>
	<Pine.LNX.4.58.0409051011510.18618@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============42100244699876826=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409051011510.18618@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net
Cc: autofs@linux.kernel.org


--===============42100244699876826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

raven@themaw.net schrieb:
> Is there any way I can get hold of the soure package?

I've just uploaded it to experimental.

It is indeed experimental, since I didn't merge any init-script
changes yet (I want to try to stick with your scripts as much as
possible).

There are a couple of doc patches left too.

> Are there any plans to add a kernel patch for 2.4 and possibly for early=
=20
> 2.6 kernels? Perhaps I could help with that.

Debian will ship recent 2.6 kernels in sarge (we can't change
woody anymore).

Maybe the autofs4 patches have already been applied to our stock
2.4 kernels. If not, you could try to convince the
kernel-image-2.4.27-i386 maintainers to integrate the patch in
stock kernels, build a kernel-patch-autofs4 package
(impractical, requires rebuild of entier kernel for this single
module) or build your own autofs4-module(-source) kernel module
package (which would be overkill IMHO).

HTH, 2ri
--=20
Help securing email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
The game was soon followed up by a round of "Alphabet Implementation" where
each employee took turns suggesting a different language, tool, methodology=
, or
approach to a new business requirement, vehemently disapproving of all other
ideas. This game awards double points for using an acronymn unknown by the =
rest
of the group, but imposes heavy penalties on making one up.
	    -- Bryan Douglas <bryantdouglas@yahoo.com> on segfault.org

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBOvsvNgpsykSg/LgRAiYeAKCG3MdvLN8qGUwHfwUKCplSPs2IMgCgtRLZ
kDrX5uRH02zjfSLzV0sRUgo=
=akI5
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


--===============42100244699876826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============42100244699876826==--

