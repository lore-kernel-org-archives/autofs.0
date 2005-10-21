From: Rainer Krienke <krienke@uni-koblenz.de>
Subject: Re: Unable to mount with autofs-4.1.4: aquire_lock: can't
	lock lock file timed out: /var/lock/autofs
Date: Fri, 21 Oct 2005 09:07:20 +0200
Message-ID: <200510210907.20809.krienke@uni-koblenz.de>
References: <200510181321.08443.krienke@uni-koblenz.de>
	<Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2105259747=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510192336180.2071@donald.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

--===============2105259747==
Content-Type: multipart/signed; boundary="nextPart1350766.i67HbQU8ME";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1350766.i67HbQU8ME
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mittwoch 19 Oktober 2005 17:55, Ian Kent wrote:
> As Jeff has said this sort of nesting of mounts is, in general, not
> supported by autofs and it worked previously because the locking was less
> broken in 4.1.3 than in 4.1.4 (yes its still broken in 4.1.4).
>
> Can this case be done safely?
>
> I'm not entirely sure of the answer to this but I've never liked using
> locking in autofs. I introduced it only to prevent mtab corruption during
> mount (correct me if you have a different recollection Jeff). It happens
> during rapid mount activity such as when there as a largish number of
> entries in the master map (of the order of 50 or more).
>
> The mtab locking should be done in mount which narrows the scope of the
> lock enough to allow this case to function as requested.
>

=46or me it would be important to learn if this feature will be possible in=
 the=20
future or if it is decided that for whatever reason it will not be. The=20
former case would be the best thing for me because I would not have to find=
 a=20
new solution for mounting home directories and I guess other people with a=
=20
large user base would also welcome it. In the latter case I have to think=20
about a alternative way to go for the future. At the moment my solution is =
to=20
use an older version of autofs for suse10.0 installations since this older=
=20
autofs version simply works for me but this is of course not an ideal=20
solution.

Any comments?

Thanks
Rainer Krienke
=2D-=20
=2D------------------------------------------------------------------------=
=2D-
Rainer Krienke, Universitaet Koblenz, Rechenzentrum, Raum A022
Universitaetsstrasse 1, 56070 Koblenz, Tel: +49 261287 -1312, Fax: -1001312
Mail: krienke@uni-koblenz.de, Web: http://www.uni-koblenz.de/~krienke
Get my public PGP key: http://www.uni-koblenz.de/~krienke/mypgp.html
=2D------------------------------------------------------------------------=
=2D-

--nextPart1350766.i67HbQU8ME
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDWJOoaldtjc/KDEoRAlWwAKCTdCsaRi4GKXULBpDvWuxuEp/vxgCePa92
SCf9s9++lDfm5bxF2Jugzgw=
=f/S5
-----END PGP SIGNATURE-----

--nextPart1350766.i67HbQU8ME--


--===============2105259747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2105259747==--

