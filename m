From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: patch: explicitely link against kerberos libs for sasl
	support
Date: Sat, 17 Nov 2007 13:23:47 +0100
Message-ID: <473EDD53.3060303@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030905020705060302060508"
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

This is a multi-part message in MIME format.
--------------030905020705060302060508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

sasl support breaks ldap module for unresolved kerberos symbols.
Attached patch fix this issue by explicitely linking against kerberos libs.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------030905020705060302060508
Content-Type: text/x-patch;
 name="autofs-5.0.2-link-with-kerberos-lib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="autofs-5.0.2-link-with-kerberos-lib.patch"

diff -Naur --exclude '*~' autofs-5.0.2/configure.in autofs-5.0.2-link-with-kerberos-lib/configure.in
--- autofs-5.0.2/configure.in	2007-11-17 12:18:07.000000000 +0100
+++ autofs-5.0.2-link-with-kerberos-lib/configure.in	2007-11-17 12:17:26.000000000 +0100
@@ -243,7 +243,7 @@
 if test -z "$HAVE_SASL" -a "$HAVE_LIBXML" == "1"
 then
 	HAVE_SASL=0
-	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1 LIBSASL="$LIBSASL -lsasl2", , -lsasl2 $LIBS)
+	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1 LIBSASL="$LIBSASL -lsasl2 -lkrb5", , -lsasl2 $LIBS)
 	if test "$HAVE_SASL" == "1"; then
 		AC_DEFINE(WITH_SASL,1,
 			[Define if using SASL authentication with the LDAP module])

--------------030905020705060302060508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------030905020705060302060508--

