From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: [patch] more robust test for ldap library
Date: Fri, 05 Dec 2008 19:05:15 +0100
Message-ID: <49396D5B.7040405@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060209050004050102040602"
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--------------060209050004050102040602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

The test for LDAP library wrongly use LDFLAGS to add -lldap to the gcc 
call. However, when strict linker ordering is in effect, it doesn't work 
correctly. As described in autoconf documentation, additional libs 
should be added through LIBS variable instead. The following patch fixes it.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------060209050004050102040602
Content-Type: text/plain;
 name="autofs-5.0.3-fix-ldap-detection.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-5.0.3-fix-ldap-detection.patch"

diff -Naur --exclude '*~' autofs-5.0.3/aclocal.m4 autofs-5.0.3-fix-ldap-detection/aclocal.m4
--- autofs-5.0.3/aclocal.m4	2008-07-02 13:26:00.000000000 +0200
+++ autofs-5.0.3-fix-ldap-detection/aclocal.m4	2008-07-02 13:28:04.000000000 +0200
@@ -230,9 +230,9 @@
 AC_DEFUN([AF_CHECK_FUNC_LDAP_CREATE_PAGE_CONTROL],
 [AC_MSG_CHECKING(for ldap_create_page_control in -lldap)
 
-# save current ldflags
-af_check_ldap_create_page_control_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lldap"
+# save current libs
+af_check_ldap_create_page_control_save_libs="$LIBS"
+LIBS="$LIBS -lldap"
 
 AC_TRY_LINK(
   [ #include <ldap.h> ],
@@ -251,8 +251,8 @@
         [Define to 1 if you have the `ldap_create_page_control' function.])
 fi
 
-# restore ldflags
-LDFLAGS="$af_check_ldap_create_page_control_save_ldflags"
+# restore libs
+LIBS="$af_check_ldap_create_page_control_save_libs"
 ])
 
 dnl --------------------------------------------------------------------------
@@ -263,9 +263,9 @@
 AC_DEFUN([AF_CHECK_FUNC_LDAP_PARSE_PAGE_CONTROL],
 [AC_MSG_CHECKING(for ldap_parse_page_control in -lldap)
 
-# save current ldflags
-af_check_ldap_parse_page_control_save_ldflags="$LDFLAGS"
-LDFLAGS="$LDFLAGS -lldap"
+# save current libs
+af_check_ldap_parse_page_control_save_libs="$LIBS"
+LIBS="$LIBS -lldap"
 
 AC_TRY_LINK(
   [ #include <ldap.h> ],
@@ -284,7 +284,7 @@
         [Define to 1 if you have the `ldap_parse_page_control' function.])
 fi
 
-# restore ldflags
-LDFLAGS="$af_check_ldap_parse_page_control_save_ldflags"
+# restore libs
+LIBS="$af_check_ldap_parse_page_control_save_libs"
 ])
 

--------------060209050004050102040602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------060209050004050102040602--

