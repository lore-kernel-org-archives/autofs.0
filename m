From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Wed, 23 Aug 2006 16:55:18 +0200
Message-ID: <44EC6C56.9070304@inria.fr>
References: <44A25311.2040501@inria.fr>		<1151554184.2929.45.camel@raven.themaw.net>	<44A3B6CD.5030403@inria.fr>		<1151585997.3915.36.camel@raven.themaw.net>	<44A4E38D.7020004@inria.fr>		<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>		<44A9216F.1030102@inria.fr>	<1151943337.9183.44.camel@raven.themaw.net>
	<44C72411.8070401@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44C72411.8070401@inria.fr>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

Guillaume Rousse wrote:
>> I think the main issue being discussed here is the location of the
>> program configuration only. Hopefully the rest is ok.
Here is a first patch that just separate daemon configuration from
service configuration.

To minimize behaviour changes, service configuration location is found
as service script location, just by looking for potential targets
(/etc/sysconfig, /etc/defaults) and keeping the first found. I didn't
changed map and config location directories search.

However, as this kind of stuff is highly distribution-dependant, I'd
rather suggest to not bother installing in the default installation
procedure, and let each packager finish the job directly.

diff -Naur autofs-5.0.1-drop-default-profix-from-config/Makefile.conf.in
autofs-5.0.1-separate-config-files/Makefile.conf.in
--- autofs-5.0.1-drop-default-profix-from-config/Makefile.conf.in
2006-08-23 14:21:40.000000000 +0200
+++ autofs-5.0.1-separate-config-files/Makefile.conf.in	2006-08-23
14:36:23.000000000 +0200
@@ -80,3 +80,6 @@
 # Location for init.d files
 initdir = @initdir@

+# Location for init.d files configuration
+initconfdir = @initconfdir@
+
diff -Naur autofs-5.0.1-drop-default-profix-from-config/aclocal.m4
autofs-5.0.1-separate-config-files/aclocal.m4
--- autofs-5.0.1-drop-default-profix-from-config/aclocal.m4	2006-08-23
14:21:40.000000000 +0200
+++ autofs-5.0.1-separate-config-files/aclocal.m4	2006-08-23
14:53:15.000000000 +0200
@@ -75,7 +75,7 @@
 dnl
--------------------------------------------------------------------------
 dnl AF_INIT_D
 dnl
-dnl Check the location of the init.d directory
+dnl Check the location of the service script directory
 dnl
--------------------------------------------------------------------------
 AC_DEFUN(AF_INIT_D,
 [if test -z "$initdir"; then
@@ -91,6 +91,24 @@
 fi])

 dnl
--------------------------------------------------------------------------
+dnl AF_INITCONF_D
+dnl
+dnl Check the location of the service configuration directory
+dnl
--------------------------------------------------------------------------
+AC_DEFUN(AF_INITCONF_D,
+[if test -z "$initconfdir"; then
+  AC_MSG_CHECKING([location of the init.d configuration directory])
+  for initconf_d in /etc/sysconfig /etc/default; do
+    if test -z "$initconfdir"; then
+      if test -d "$initconf_d"; then
+	initconfdir="$initconf_d"
+	AC_MSG_RESULT($initconfdir)
+      fi
+    fi
+  done
+fi])
+
+dnl
--------------------------------------------------------------------------
 dnl AF_CONF_D
 dnl
 dnl Check the location of the configuration defaults directory
diff -Naur autofs-5.0.1-drop-default-profix-from-config/configure.in
autofs-5.0.1-separate-config-files/configure.in
--- autofs-5.0.1-drop-default-profix-from-config/configure.in	2006-08-23
14:21:40.000000000 +0200
+++ autofs-5.0.1-separate-config-files/configure.in	2006-08-23
14:53:14.000000000 +0200
@@ -41,12 +41,18 @@
 AF_LINUX_PROCFS()

 #
-# Location of init.d directory?
+# Location of service script directory?
 #
 AF_INIT_D()
 AC_SUBST(initdir)

 #
+# Location of service configuration directory?
+#
+AF_INITCONF_D()
+AC_SUBST(initconfdir)
+
+#
 # Location of system config script directory?
 #
 AF_CONF_D()
diff -Naur autofs-5.0.1-drop-default-profix-from-config/samples/Makefile
autofs-5.0.1-separate-config-files/samples/Makefile
--- autofs-5.0.1-drop-default-profix-from-config/samples/Makefile
2006-08-23 14:21:40.000000000 +0200
+++ autofs-5.0.1-separate-config-files/samples/Makefile	2006-08-23
15:04:37.000000000 +0200
@@ -10,9 +10,7 @@

 rc.autofs: rc.autofs.in
 	sed -e "s|@@sbindir@@|$(sbindir)|g" \
-	    -e "s|@@autofslibdir@@|$(autofslibdir)|g" \
-	    -e "s|@@autofsconfdir@@|$(autofsconfdir)|g" \
-	    -e "s|@@initdir@@|$(initdir)|g" < rc.autofs.in > rc.autofs
+	    -e "s|@@initconfdir@@|$(initconfdir)|g" < rc.autofs.in > rc.autofs

 autofs.conf.default: autofs.conf.default.in
 	sed -e "s|@@autofsmapdir@@|$(autofsmapdir)|g" \
@@ -25,16 +23,19 @@
 	install -d -m 755 $(INSTALLROOT)$(autofslibdir)
 	install -d -m 755 $(INSTALLROOT)/var/run/autofs

-.PHONY: autofs.init
+.PHONY: autofs.init autofs.initconf
 autofs.init:
 	@echo
 ifneq ($(initdir),)
 	install -d -m 755 $(INSTALLROOT)$(initdir)
 	install rc.autofs -m 755 $(INSTALLROOT)$(initdir)/autofs
-else
-	if test -d $(INSTALLROOT)/etc/rc.d ; then \
-		install -c rc.autofs -m 755 $(INSTALLROOT)/etc/rc.d ; \
-	fi
+endif
+
+autofs.initconf:
+	@echo
+ifneq ($(initconfdir),)
+	install -d -m 755 $(INSTALLROOT)$(initconfdir)
+	install sysconfig.autofs -m 644 $(INSTALLROOT)$(initconfdir)/autofs
 endif

 CONFIG = $(shell test -e $(INSTALLROOT)$(autofsconfdir)/autofs.orig ||
echo "-b --suffix=.orig")
@@ -175,7 +176,7 @@
 		fi ; \
 	fi

-install: rc.autofs autofs.conf.default dirs autofs.init autofs.conf \
+install: rc.autofs autofs.conf.default dirs autofs.init autofs.initconf
autofs.conf \
 		autofs_ldap_auth.conf $(SAMPLES)
 	@echo

diff -Naur
autofs-5.0.1-drop-default-profix-from-config/samples/autofs.conf.default.in
autofs-5.0.1-separate-config-files/samples/autofs.conf.default.in
---
autofs-5.0.1-drop-default-profix-from-config/samples/autofs.conf.default.in
2006-08-23 14:22:24.000000000 +0200
+++ autofs-5.0.1-separate-config-files/samples/autofs.conf.default.in
2006-08-23 14:26:19.000000000 +0200
@@ -45,12 +45,3 @@
 #			   authentication configuration file.
 #
 #AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"
-#
-# General global options
-#
-#OPTIONS=""
-#
-#
-#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to auto.mnt
-UNDERSCORETODOT=1
-
diff -Naur
autofs-5.0.1-drop-default-profix-from-config/samples/rc.autofs.in
autofs-5.0.1-separate-config-files/samples/rc.autofs.in
--- autofs-5.0.1-drop-default-profix-from-config/samples/rc.autofs.in
2006-08-23 14:21:40.000000000 +0200
+++ autofs-5.0.1-separate-config-files/samples/rc.autofs.in	2006-08-23
14:32:00.000000000 +0200
@@ -14,7 +14,7 @@
 DAEMON=@@sbindir@@/automount
 prog=`basename $DAEMON`
 MODULE="autofs4"
-confdir=@@autofsconfdir@@
+confdir=@@initconfdir@@

 test -e $DAEMON || exit 0

diff -Naur
autofs-5.0.1-drop-default-profix-from-config/samples/sysconfig.autofs
autofs-5.0.1-separate-config-files/samples/sysconfig.autofs
---
autofs-5.0.1-drop-default-profix-from-config/samples/sysconfig.autofs
1970-01-01 01:00:00.000000000 +0100
+++ autofs-5.0.1-separate-config-files/samples/sysconfig.autofs
2006-08-23 14:25:40.000000000 +0200
@@ -0,0 +1,9 @@
+#
+# General global options
+#
+#OPTIONS=""
+#
+#
+#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to auto.mnt
+UNDERSCORETODOT=1
+
-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
