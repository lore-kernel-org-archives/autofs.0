From: "Arthur Korn" <arthur@korn.ch>
Subject: Bug#279561: smbfs multimount broken
Date: Wed, 3 Nov 2004 20:16:03 +0100
Message-ID: <20041103191603.GA6640@turing>
Reply-To: Arthur Korn <arthur@korn.ch>, 279561@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33243147794080041=="
Return-path: <autofs-bounces@linux.kernel.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.279561.B.109950937612674@bugs.debian.org>
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
To: submit@bugs.debian.org


--===============33243147794080041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Package: autofs
Version: 4.1.3-4
Severity: minor
Tags: patch

You should file all bugs to the BTS, since else I have to ... or
I'll most probably forget about it.

Maybe it could be changed to detect double slashes "//"? This
would be compatible with the old behaviour (which is as SUN does
I suppose), but admittedly limited to SMBfs.

ciao, 2ri

----- Forwarded message from Elmar Pruesse <elmar@pruesse.net> -----

Date: Wed, 03 Nov 2004 16:51:08 +0100
To: arthur@debian.org
=46rom: Elmar Pruesse <elmar@pruesse.net>
Subject: debian, autofs 4.1.3-4, smbfs multimount broken, patch

hi Arthur,

I hope you don't mind me mailing you directly instead of fileing a bug=20
report, etc.

The the code in parse_sun.c that "tokenizes" multimount lines got broken=20
when the possibilty to use server names containing whitespace was added.=20
It assumes that whitespace followed by a "/" indicates a new mountpoint.=20
Since smbfs mounts also start with a "/", this makes it impossible to=20
use smbfs in multimounts. (Escaping doesn't work either, tried that).

I propose (patch attached) changing the syntax of multimount smbfs=20
mountpoints to match those of ordinary smbfs mounts.

Ordninary smbfsmount:
/mysmbmount -fstype=3Dsmbfs ://smbserver/dir

Multimount in version three:
/multimount -fstype=3Dsmbfs /one //smbserver/one /two //smbserver/two

Proposed syntax:
/multimount -fstype=3Dsmbfs /one ://smbserver/one /two ://smbserver/two


It's the shortest patch I could come up with. The syntax change is=20
minimal, resolves an inconsistency and the way it used to work is broken=20
anyway.

In case anyone is interested I also attached a modified version of the=20
auto.net example which uses smblclient instead of showmount and can be=20
used to dynamically access public smb shares.

By the way: Is there any reason, apart from noone having written it, why=20
 there is no support for ghosting from program maps?

regards,
Elmar

diff -rNu autofs-4.1.3.orig/modules/parse_sun.c autofs-4.1.3/modules/parse_=
sun.c
--- autofs-4.1.3.orig/modules/parse_sun.c	2004-10-03 17:43:57.000000000 +02=
00
+++ autofs-4.1.3/modules/parse_sun.c	2004-10-03 17:38:50.000000000 +0200
@@ -618,7 +618,7 @@
 {
 	struct parse_context *ctxt =3D (struct parse_context *) context;
 	char *pmapent, *options;
-	const char *p, *q;
+	const char *p, *q, *r;
 	int mapent_len, rv;
 	int optlen;
=20
@@ -716,9 +716,12 @@
 			while (*q && *q !=3D '/') {
 				l =3D chunklen(q, 1);
 				q +=3D l;
+				r =3D q;
 				q =3D skipspace(q);
 			}
-			l =3D q - p;
+			if (*p =3D=3D ':')=20
+			  	p++;	/* Sun escape for entries starting with / */
+			l =3D r - p;
=20
 			loc =3D dequote(p, l);
 			loclen =3D strlen(loc);

#!/bin/sh

key=3D"$1"
opts=3D"-fstype=3Dsmbfs"

for SMBCLIENT in /{,usr/}{,s}bin/smbclient; do [ -x $SMBCLIENT ] && break; =
done
[ -x $SMBCLIENT ] || exit 1

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key=3D"$key" -v opts=3D"$opts" -F'=
|' -- '
	BEGIN	{ ORS=3D""; first=3D1 }
	/Disk/	{ if (first) { print opts; first=3D0 }; print " \\\n\t /" $2, "://"=
 key "/" $2 }
	END 	{ if (!first) print "\n"; else exit 1 }
	'


----- End forwarded message -----

--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
I didn't know it was impossible when I did it.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiS5zNgpsykSg/LgRAik7AJ9o96kGVNPsjbPFqSPyhG2Nimx0FQCfekDk
4QpLvoIClFf1wv4NKQimz4E=
=4QOX
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--


--===============33243147794080041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============33243147794080041==--

