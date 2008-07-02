From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: [patch] fix ldap capacities detection
Date: Wed, 02 Jul 2008 13:35:38 +0200
Message-ID: <486B680A.8050005@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030908040401010504030108"
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
--------------030908040401010504030108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When using -Wl,-a-s-needed linker flags (which is becoming the standard 
in most linux distributions), compilation will fail if -lldap is passed 
before the test file in gcc command:
[guillomovitch@n2 autofs]$ gcc -o conftest -O2 -g -pipe 
-Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector 
--param=ssp-buffer-size=4 -fstack-protector-all -fomit-frame-pointer 
-march=i586 -mtune=generic -fasynchronous-unwind-tables
-Wl,--as-needed -Wl,--no-undefined -lldap conftest.c
/home/guillomovitch/tmp/ccsbs3BH.o: In function `main':
/home/guillomovitch/cooker/autofs/BUILD/autofs-5.0.3/conftest.c:45: 
undefined reference to `ldap_create_page_control'

The proper solution is to pass -lldap trough $LIBS variable instead of 
$LDFLAGS.
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------030908040401010504030108
Content-Type: text/x-patch;
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
 

--------------030908040401010504030108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------030908040401010504030108--

