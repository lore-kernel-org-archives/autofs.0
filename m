From: "Arthur Korn" <arthur@korn.ch>
Subject: Fixes to init script errors introduced in Debian patches
Date: Thu, 21 Oct 2004 23:19:01 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041021211901.GA11243@turing>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44311295086105429=="
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--===============44311295086105429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

Two small bugs with causing quite some problems have been fixed.

These have been introduced with the changes made by me to the
init script for Debian. Since I posted those changes here
previously, I supply the fixes as well.

diff -ruN autofs-4.1.3.orig/samples/rc.autofs.in autofs-4.1.3/samples/rc.au=
tofs.in
--- autofs-4.1.3.orig/samples/rc.autofs.in	2004-10-21 21:55:10.000000000 +0=
200
+++ autofs-4.1.3/samples/rc.autofs.in	2004-10-21 21:55:03.000000000 +0200
@@ -91,7 +91,7 @@
 #
 function getschemes()
 {
-    if grep -q '^automount: ' /etc/nsswitch.conf; then
+    if grep -q ^automount: /etc/nsswitch.conf; then
         grep ^automount: /etc/nsswitch.conf | \
                 sed -e 's/^.*://' -e 's/\[.*\]/ /g'
     else


diff -ruN autofs-4.1.3.orig/samples/rc.autofs.in autofs-4.1.3/samples/rc.au=
tofs.in
--- autofs-4.1.3.orig/samples/rc.autofs.in	2004-10-21 21:48:49.000000000 +0=
200
+++ autofs-4.1.3/samples/rc.autofs.in	2004-10-21 21:48:41.000000000 +0200
@@ -188,10 +188,10 @@
 		: echo DAEMONOPTIONS OPTIONS $daemonoptions $options
 		startupoptions=3D
 		if echo "$options $daemonoptions" | grep -q -- '-t' ; then
-		    # the first timout value in "$options $daemonoptions" is
+		    # the last timout value in "$daemonoptions $options" is
 		    # the one that is taken.
-		    startupoptions=3D"--timeout=3D$(echo $options $daemonoptions | \
-		      sed 's/^.?*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$/\2/')"
+		    startupoptions=3D"--timeout=3D$(echo $daemonoptions $options| \
+		      sed 's/^.*--*t\(imeout\)*[ \t=3D]*\([0-9][0-9]*\).*$/\2/')"
 		fi
 		if echo "$daemonoptions $options" | grep -q -- '-g' ; then
 		    startupoptions=3D"$startupoptions --ghost"

ciao, 2ri
--=20
Secure email, spread GPG, clearsign all mail. http://www.gnupg.org
=2E
Nearly all men can stand adversity, but if you want to test a man's=20
character, give him power.
 -- Abraham Lincoln

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBeCfFNgpsykSg/LgRAjSlAKCA5ri+s4X8MIv/eFIWTAq0Y8mlHQCgvCkk
ZFaQD8zIxy0lHkPSg0HXpFA=
=OiWv
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--


--===============44311295086105429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============44311295086105429==--

