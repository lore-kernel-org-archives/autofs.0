From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: [Fwd: linking issues with ldap]
Date: Wed, 23 Jan 2008 18:37:31 +0100
Message-ID: <47977B5B.300@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060700040709030203050002"
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
--------------060700040709030203050002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Sending again, first attempt failed.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------060700040709030203050002
Content-Type: message/rfc822;
 name="linking issues with ldap.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linking issues with ldap.eml"

Message-ID: <478F78DA.6090401@inria.fr>
Date: Thu, 17 Jan 2008 16:48:42 +0100
From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
User-Agent: Thunderbird 2.0.0.9 (X11/20080114)
MIME-Version: 1.0
To: autofs@linux.kernel.org
Subject: linking issues with ldap
X-Enigmail-Version: 0.95.3
Content-Type: multipart/mixed; boundary="------------060107030305090105040908"

This is a multi-part message in MIME format.
--------------060107030305090105040908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello list.

Latest release (5.0.3) attempt to link against libldap_r, and fails on
mandriva because of unresolved pthread symbols. However, according to
ldap maintainer, libldap_r is supposed to be a private library. Hence
autofs should use -lldap, not -lldap_r. Attached patch fix this.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------060107030305090105040908
Content-Type: text/x-patch;
 name="autofs-5.0.3-ldap-linking.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-5.0.3-ldap-linking.patch"

diff -p -up autofs-5.0.3/aclocal.m4.pthread autofs-5.0.3/aclocal.m4
--- autofs-5.0.3/aclocal.m4.pthread	2008-01-15 14:30:04.000000000 +0000
+++ autofs-5.0.3/aclocal.m4	2008-01-15 14:30:30.000000000 +0000
@@ -250,7 +250,7 @@ AC_DEFUN([AF_CHECK_FUNC_LDAP_CREATE_PAGE
 
 # save current ldflags
 af_check_ldap_create_page_control_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lldap_r"
+LDFLAGS="$LDFLAGS -lldap"
 
 AC_TRY_LINK(
   [ #include <ldap.h> ],
@@ -283,7 +283,7 @@ AC_DEFUN([AF_CHECK_FUNC_LDAP_PARSE_PAGE_
 
 # save current ldflags
 af_check_ldap_parse_page_control_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lldap_r"
+LDFLAGS="$LDFLAGS -lldap"
 
 AC_TRY_LINK(
   [ #include <ldap.h> ],

--------------060107030305090105040908--


--------------060700040709030203050002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------060700040709030203050002--

