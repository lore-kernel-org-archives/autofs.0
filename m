From: Andre Wood <andre@stonemarche.org>
Subject: Enhancement request: executable program maps called after
	umount.
Date: Fri, 16 Nov 2007 03:50:52 -0500
Message-ID: <473D59EC.6070400@stonemarche.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8064751267577907862=="
Return-path: <autofs-bounces@linux.kernel.org>
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============8064751267577907862==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5145918082CF8E01213B2D1E"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5145918082CF8E01213B2D1E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Enhancement request:

Program maps need to called prior to mounting AND called again after
unmounting.
The reason for this is that if the script (program map) arranges for the
"device" to be available for mounting,
it also needs a chance to cleanup after the "device" is unmounted.  Can
you include this enhancement into autofs?
I would suggest calling the script with an additional parameter during
the unmount phase, so that it is easy to determine the state.

    Andre'


--------------enig5145918082CF8E01213B2D1E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)

iD8DBQFHPVnzFBtQPwPMVKYRAuLZAJ4txUUioS9Ul+QscvAGmlDSiaDecACeIazN
FXJPRWdbImPnReI6pwnJirQ=
=g64U
-----END PGP SIGNATURE-----

--------------enig5145918082CF8E01213B2D1E--


--===============8064751267577907862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8064751267577907862==--

