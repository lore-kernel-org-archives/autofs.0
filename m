From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: autofs5: unable to locate ldap master map
Date: Thu, 24 Aug 2006 16:49:33 +0200
Message-ID: <44EDBC7D.9090702@inria.fr>
References: <44A25311.2040501@inria.fr>		<1151554184.2929.45.camel@raven.themaw.net>	<44A3B6CD.5030403@inria.fr>		<1151585997.3915.36.camel@raven.themaw.net>	<44A4E38D.7020004@inria.fr>		<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>		<44A9216F.1030102@inria.fr>	<1151943337.9183.44.camel@raven.themaw.net>	<44C72411.8070401@inria.fr>
	<44EC6C56.9070304@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EC6C56.9070304@inria.fr>
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
To: autofs mailing list <autofs@linux.kernel.org>

Guillaume Rousse wrote:
> Guillaume Rousse wrote:
>>> I think the main issue being discussed here is the location of the
>>> program configuration only. Hopefully the rest is ok.
> Here is a first patch that just separate daemon configuration from
> service configuration.
And here another one that enhance consistency between main configuration
file and ldap autentification file:
1) both are installed as .conf file
2) both are named .conf in the archive (not .conf.default)
3) ldap autentification file is searched under same directory as main
configuration file, removing the need to give its full path in
configuration, hence removing the need for a subsitution before installation

BTW, I'm not even sure being able to define ldap autentification file
name is really useful. I'd just hardcode its location, as the main one.

I did test (ldap setup only, however) all my 3 configuration patches,
and I'm going to release a 5.0.1 rpm in imminent Mandriva 2007 beta 3.

diff -Naur autofs-5.0.1-separate-config-files/lib/defaults.c
autofs-5.0.1-rc1-cleanup-config-file-names/lib/defaults.c
--- autofs-5.0.1-separate-config-files/lib/defaults.c	2006-08-23
14:24:42.000000000 +0200
+++ autofs-5.0.1-rc1-cleanup-config-file-names/lib/defaults.c	2006-08-24
15:43:59.000000000 +0200
@@ -21,7 +21,7 @@
 #include "defaults.h"
 #include "log.h"

-#define DEFAULTS_CONFIG_FILE		AUTOFS_CONF_DIR "/autofs"
+#define DEFAULTS_CONFIG_FILE		AUTOFS_CONF_DIR "/autofs.conf"
 #define MAX_LINE_LEN			256

 #define ENV_NAME_MASTER_MAP		"MASTER_MAP_NAME"
diff -Naur autofs-5.0.1-separate-config-files/modules/lookup_ldap.c
autofs-5.0.1-rc1-cleanup-config-file-names/modules/lookup_ldap.c
--- autofs-5.0.1-separate-config-files/modules/lookup_ldap.c	2006-08-23
14:24:42.000000000 +0200
+++ autofs-5.0.1-rc1-cleanup-config-file-names/modules/lookup_ldap.c
2006-08-24 15:43:58.000000000 +0200
@@ -278,6 +278,10 @@
 		return 0;
 	}

+    /* prepend with configuration directory */
+    realloc(auth_conf, strlen(auth_conf) + strlen(AUTOFS_CONF_DIR) + 2);
+    sprintf(auth_conf, "%s/%s", AUTOFS_CONF_DIR, auth_conf);
+
 	/*
 	 *  Here we check that the config file exists, and that we have
 	 *  permission to read it.  The XML library does not specify why a
diff -Naur autofs-5.0.1-separate-config-files/samples/Makefile
autofs-5.0.1-rc1-cleanup-config-file-names/samples/Makefile
--- autofs-5.0.1-separate-config-files/samples/Makefile	2006-08-23
15:04:37.000000000 +0200
+++ autofs-5.0.1-rc1-cleanup-config-file-names/samples/Makefile
2006-08-24 16:13:31.000000000 +0200
@@ -6,16 +6,12 @@

 SAMPLES = auto.master auto.misc auto.net auto.smb

-all: rc.autofs autofs.conf.default
+all: rc.autofs

 rc.autofs: rc.autofs.in
 	sed -e "s|@@sbindir@@|$(sbindir)|g" \
 	    -e "s|@@initconfdir@@|$(initconfdir)|g" < rc.autofs.in > rc.autofs

-autofs.conf.default: autofs.conf.default.in
-	sed -e "s|@@autofsmapdir@@|$(autofsmapdir)|g" \
-		< autofs.conf.default.in > autofs.conf.default
-
 .PHONY: dirs
 dirs:
 	install -d -m 755 $(INSTALLROOT)$(autofsmapdir)
@@ -38,26 +34,26 @@
 	install sysconfig.autofs -m 644 $(INSTALLROOT)$(initconfdir)/autofs
 endif

-CONFIG = $(shell test -e $(INSTALLROOT)$(autofsconfdir)/autofs.orig ||
echo "-b --suffix=.orig")
-CEXISTS = $(shell test -e $(INSTALLROOT)$(autofsconfdir)/autofs || echo
"no")
+CONFIG = $(shell test -e
$(INSTALLROOT)$(autofsconfdir)/autofs.conf.orig || echo "-b --suffix=.orig")
+CEXISTS = $(shell test -e $(INSTALLROOT)$(autofsconfdir)/autofs.conf ||
echo "no")

 .PHONY: autofs.conf
-autofs.conf: autofs.conf.default
+autofs.conf:
 	@echo
 	@echo "Installing autofs default configuation in $(autofsconfdir)"
 	@if test -z "$(CONFIG)" ; \
 	then \
-		install -v autofs.conf.default -m 644 \
+		install -v autofs.conf -m 644 \
 			$(INSTALLROOT)$(autofsconfdir)/autofs.conf.new ; \
 		echo "Found existing backup of configuration file." ; \
 		echo "Installed package default configuration file as
\"autofs.conf.new\"." ; \
 	else \
-		install -v autofs.conf.default -m 644 $(CONFIG) \
-				$(INSTALLROOT)$(autofsconfdir)/autofs ; \
-		echo "Installed package configuration configuration as \"autofs\"." ; \
+		install -v autofs.conf -m 644 $(CONFIG) \
+				$(INSTALLROOT)$(autofsconfdir)/autofs.conf ; \
+		echo "Installed package configuration configuration as
\"autofs.conf\"." ; \
 		if test -z "$(CEXISTS)" ; \
 		then \
-			echo "Backup of existing configuration made to \"autofs.orig\"." ; \
+			echo "Backup of existing configuration made to
\"autofs.conf.orig\"." ; \
 		fi ; \
 	fi

@@ -80,7 +76,7 @@
 		echo "Installed package auth config as \"autofs_ldap_auth.conf\"." ; \
 		if test -z "$(SEXISTS)" ; \
 		then \
-			echo "Backup of existing auth config made to
\".utofs_ldap_auth.conf.orig\"." ; \
+			echo "Backup of existing auth config made to
\"autofs_ldap_auth.conf.orig\"." ; \
 		fi ; \
 	fi

@@ -176,7 +172,7 @@
 		fi ; \
 	fi

-install: rc.autofs autofs.conf.default dirs autofs.init autofs.initconf
autofs.conf \
+install: rc.autofs dirs autofs.init autofs.initconf autofs.conf \
 		autofs_ldap_auth.conf $(SAMPLES)
 	@echo

diff -Naur autofs-5.0.1-separate-config-files/samples/autofs.conf
autofs-5.0.1-rc1-cleanup-config-file-names/samples/autofs.conf
--- autofs-5.0.1-separate-config-files/samples/autofs.conf	1970-01-01
01:00:00.000000000 +0100
+++ autofs-5.0.1-rc1-cleanup-config-file-names/samples/autofs.conf
2006-08-24 15:11:03.000000000 +0200
@@ -0,0 +1,47 @@
+#
+# Define default options for autofs.
+#
+# MASTER_MAP_NAME - default map name for the master map.
+#
+#MASTER_MAP_NAME="auto.master"
+#
+# TIMEOUT - set the default mount timeout (default 600).
+#
+TIMEOUT=300
+#
+# BROWSE_MODE - maps are browsable by default.
+#
+BROWSE_MODE="no"
+#
+# LOGGING - set default log level "none", "verbose" or "debug"
+#
+#LOGGING="none"
+#
+# Define the default LDAP schema to use for lookups
+#
+# System default
+#
+#MAP_OBJECT_CLASS="nisMap"
+#ENTRY_OBJECT_CLASS="nisObject"
+#MAP_ATTRIBUTE="nisMapName"
+#ENTRY_ATTRIBUTE="cn"
+#VALUE_ATTRIBUTE="nisMapEntry"
+#
+# Other common LDAP nameing
+#
+#MAP_OBJECT_CLASS="automountMap"
+#ENTRY_OBJECT_CLASS="automount"
+#MAP_ATTRIBUTE="ou"
+#ENTRY_ATTRIBUTE="cn"
+#VALUE_ATTRIBUTE="automountInformation"
+#
+#MAP_OBJECT_CLASS="automountMap"
+#ENTRY_OBJECT_CLASS="automount"
+#MAP_ATTRIBUTE="automountMapName"
+#ENTRY_ATTRIBUTE="automountKey"
+#VALUE_ATTRIBUTE="automountInformation"
+#
+# AUTH_CONF_FILE - set the default location for the SASL
+#			   authentication configuration file.
+#
+#AUTH_CONF_FILE="autofs_ldap_auth.conf"
diff -Naur
autofs-5.0.1-separate-config-files/samples/autofs.conf.default.in
autofs-5.0.1-rc1-cleanup-config-file-names/samples/autofs.conf.default.in
--- autofs-5.0.1-separate-config-files/samples/autofs.conf.default.in
2006-08-23 14:26:19.000000000 +0200
+++
autofs-5.0.1-rc1-cleanup-config-file-names/samples/autofs.conf.default.in
1970-01-01 01:00:00.000000000 +0100
@@ -1,47 +0,0 @@
-#
-# Define default options for autofs.
-#
-# MASTER_MAP_NAME - default map name for the master map.
-#
-#MASTER_MAP_NAME="auto.master"
-#
-# TIMEOUT - set the default mount timeout (default 600).
-#
-TIMEOUT=300
-#
-# BROWSE_MODE - maps are browsable by default.
-#
-BROWSE_MODE="no"
-#
-# LOGGING - set default log level "none", "verbose" or "debug"
-#
-#LOGGING="none"
-#
-# Define the default LDAP schema to use for lookups
-#
-# System default
-#
-#MAP_OBJECT_CLASS="nisMap"
-#ENTRY_OBJECT_CLASS="nisObject"
-#MAP_ATTRIBUTE="nisMapName"
-#ENTRY_ATTRIBUTE="cn"
-#VALUE_ATTRIBUTE="nisMapEntry"
-#
-# Other common LDAP nameing
-#
-#MAP_OBJECT_CLASS="automountMap"
-#ENTRY_OBJECT_CLASS="automount"
-#MAP_ATTRIBUTE="ou"
-#ENTRY_ATTRIBUTE="cn"
-#VALUE_ATTRIBUTE="automountInformation"
-#
-#MAP_OBJECT_CLASS="automountMap"
-#ENTRY_OBJECT_CLASS="automount"
-#MAP_ATTRIBUTE="automountMapName"
-#ENTRY_ATTRIBUTE="automountKey"
-#VALUE_ATTRIBUTE="automountInformation"
-#
-# AUTH_CONF_FILE - set the default location for the SASL
-#			   authentication configuration file.
-#
-#AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
