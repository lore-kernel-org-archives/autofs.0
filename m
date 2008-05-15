From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: sasl with heimdal kerberos
Date: Thu, 15 May 2008 16:02:08 +0200
Message-ID: <482C4260.3090308@gmx.net>
Reply-To: autofs@linux.kernel.org, Martin von Gagern <Martin.vGagern@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3741358419745250022=="
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
--===============3741358419745250022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig73B7467E013888297C53A21A"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig73B7467E013888297C53A21A
Content-Type: multipart/mixed; boundary="------------020809070505000003080602"

This is a multi-part message in MIME format.
--------------020809070505000003080602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

I'm using Gentoo Linux with autofs-5.0.3, cyrus-sasl-2.1.22 and heimdal
0.7.2. I got compile time error messages when trying to compile autofs
with sasl support. I reported them as https://bugs.gentoo.org/210762

Today I was made aware that the same issues were already mentioned on
this mailing list here, in a thread titled "sasl compilation error"
http://www.mail-archive.com/autofs@linux.kernel.org/msg06165.html

I just had a closer look at this, and found two useful macros defined in
the heimdal headers, called krb5_realm_length and krb5_realm_data. MIT
kerberos doesn't seem to define them, but a simple preprocessor siwtch
is enough to introduce them in a MIT-compatible fashion.

With this I created a patch that causes autofs to compile on my system,
and which I would expect to compile for all sane Heimdal and MIT setups,
and to work correctly as well. Be warned, though, that I haven't got any
real Kerberos set up here, so I didn't actually test that things work.

Greetings,
   Martin von Gagern

P.S.: This is a repost of my original message from 2008-04-28.
       Looks like that got lost as I wasn't subscribed at the time.


--------------020809070505000003080602
Content-Type: text/plain;
 name="autofs-heimdal-support.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="autofs-heimdal-support.patch"

--- autofs-5.0.3.orig/modules/cyrus-sasl.c	2008-04-28 16:17:03.000000000 =
+0200
+++ autofs-5.0.3/modules/cyrus-sasl.c	2008-04-28 16:41:58.000000000 +0200=

@@ -66,6 +66,15 @@
 #endif
 #endif
=20
+/**
+ * The type of a principal is different for MIT Krb5 and Heimdal.
+ * These macros are provided by Heimdal, and introduced here for MIT.
+ */
+#ifndef krb5_realm_length
+#define krb5_realm_length(r) ((r).length)
+#define krb5_realm_data(r) ((r).data)
+#endif
+
 /*
  *  Once a krb5 credentials cache is setup, we need to set the KRB5CCNAM=
E
  *  environment variable so that the library knows where to find it.
@@ -452,11 +461,11 @@
=20
 	/* setup a principal for the ticket granting service */
 	ret =3D krb5_build_principal_ext(ctxt->krb5ctxt, &tgs_princ,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
+		krb5_realm_length(*krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)=
),
+		krb5_realm_data(*krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)),=

 		strlen(KRB5_TGS_NAME), KRB5_TGS_NAME,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
+		krb5_realm_length(*krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)=
),
+		krb5_realm_data(*krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)),=

 		0);
 	if (ret) {
 		error(logopt,


--------------020809070505000003080602--

--------------enig73B7467E013888297C53A21A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFILEJmRhp6o4m9dFsRAvVCAJoCtnpDijaYMWh7dKTeG+1aybwllACgmftL
aEboKQtSoM638erDJn5h8wk=
=RHYD
-----END PGP SIGNATURE-----

--------------enig73B7467E013888297C53A21A--


--===============3741358419745250022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3741358419745250022==--

