From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: broken hesiod check
Date: Wed, 23 Aug 2006 16:30:15 +0200
Message-ID: <44EC6677.1070609@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

The hesiod check macros breaks configure script by changing LIBS value
inconditionally, wich is evil.

This patch correct this, by saving and restoring original value as needed.

diff -Naur autofs-5.0.1/aclocal.m4 autofs-5.0.1-fix-hesiod-check/aclocal.m4
--- autofs-5.0.1/aclocal.m4	2006-07-13 10:11:38.000000000 +0200
+++ autofs-5.0.1-fix-hesiod-check/aclocal.m4	2006-08-23
15:29:28.000000000 +0200
@@ -178,7 +178,11 @@
 dnl
--------------------------------------------------------------------------
 AC_DEFUN([AF_CHECK_LIBHESIOD],
 [AC_MSG_CHECKING(for libhesiod)
-LIBS="$LIBHESIOD -lhesiod -lresolv"
+
+# save current ldflags
+af_check_hesiod_save_ldflags="$LDFLAGS"
+LDFLAGS="$LDFLAGS -lhesiod -lresolv"
+
 AC_TRY_LINK(
   [ #include <hesiod.h> ],
   [ char *c; hesiod_init(&c); ],
@@ -186,5 +190,8 @@
     LIBHESIOD="$LIBHESIOD -lhesiod -lresolv"
     AC_MSG_RESULT(yes) ],
   [ AC_MSG_RESULT(no) ])
+
+# restore ldflags
+LDFLAGS="$af_check_hesiod_save_ldflags"
 ])
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
