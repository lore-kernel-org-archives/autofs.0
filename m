From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] make automount daemon a PIE
Date: Wed, 24 Mar 2004 17:56:23 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16482.4631.363999.697432@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hello,

Uli Drepper suggested making automount a position independent executable.
Here is a patch which does so on systems with compilers that support it.

Ian, I didn't include generated files (ala configure and Makefile.conf) for
obvious reasons.

Cheers,

Jeff


diff --exclude configure --exclude Makefile.conf -urp autofs-4.1.1.orig/Makefile.conf.in autofs-4.1.1/Makefile.conf.in
--- autofs-4.1.1.orig/Makefile.conf.in	2003-09-29 04:22:35.000000000 -0400
+++ autofs-4.1.1/Makefile.conf.in	2004-03-24 17:37:46.000000000 -0500
@@ -7,6 +7,10 @@
 # build autofs.
 #
 
+# Do we build with -fpie?
+DAEMON_CFLAGS  = @DAEMON_CFLAGS@
+DAEMON_LDFLAGS = @DAEMON_LDFLAGS@
+
 # Special parameters for glibc (libc 6)
 LIBNSL    = @LIBNSL@
 LIBRESOLV = @LIBRESOLV@
diff --exclude configure --exclude Makefile.conf -urp autofs-4.1.1.orig/configure.in autofs-4.1.1/configure.in
--- autofs-4.1.1.orig/configure.in	2004-03-07 07:17:54.000000000 -0500
+++ autofs-4.1.1/configure.in	2004-03-24 17:44:26.000000000 -0500
@@ -126,6 +126,27 @@ AC_SUBST(LIBLDAP)
 LDFLAGS="${AF_tmp_ldflags}"
 
 #
+# Does gcc support building position independent executables?
+#
+AC_PROG_CC
+cat > pietest.c <<EOF
+int main(void) { return 0; }
+EOF
+CFLAGS=-fpie
+DAEMON_CFLAGS=
+DAEMON_LDFLAGS=
+AC_MSG_CHECKING([whether gcc accepts -fpie])
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[int main(void) {return 0;}]])],
+		  [gcc_supports_pie=yes], [gcc_supports_pie=no])
+AC_MSG_RESULT([$gcc_supports_pie])
+if test $gcc_supports_pie = yes ; then
+	DAEMON_CFLAGS="-fpie"
+	DAEMON_LDFLAGS="-pie"
+fi
+AC_SUBST(DAEMON_CFLAGS)
+AC_SUBST(DAEMON_LDFLAGS)
+
+#
 # Location of init.d directory?
 #
 AF_INIT_D()
diff --exclude configure --exclude Makefile.conf -urp autofs-4.1.1.orig/daemon/Makefile autofs-4.1.1/daemon/Makefile
--- autofs-4.1.1.orig/daemon/Makefile	2004-01-29 11:01:22.000000000 -0500
+++ autofs-4.1.1/daemon/Makefile	2004-03-24 17:40:28.000000000 -0500
@@ -11,14 +11,14 @@ OBJS = automount.o spawn.o module.o moun
 
 version := $(shell cat ../.version)
 
-CFLAGS += -rdynamic -DAUTOFS_LIB_DIR=\"$(autofslibdir)\" -DVERSION_STRING=\"$(version)\" -I../include
+CFLAGS += -rdynamic $(DAEMON_CFLAGS) -DAUTOFS_LIB_DIR=\"$(autofslibdir)\" -DVERSION_STRING=\"$(version)\" -I../include
 LDFLAGS += -rdynamic
 LIBS = -ldl
 
 all: automount
 
 automount: $(OBJS) $(AUTOFS_LIB)
-	$(CC) $(LDFLAGS) -o automount $(OBJS) $(AUTOFS_LIB) $(LIBS)
+	$(CC) $(LDFLAGS) $(DAEMON_LDFLAGS) -o automount $(OBJS) $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) automount
 
 clean:
