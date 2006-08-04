From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: Lost patch
Date: Fri, 04 Aug 2006 16:02:18 +0200
Message-ID: <44D3536A.6060502@inria.fr>
References: <44D21274.9040405@inria.fr>
	<1154699891.25506.0.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070107070000090405010109"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1154699891.25506.0.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------070107070000090405010109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ian Kent wrote:
> On Thu, 2006-08-03 at 17:12 +0200, Guillaume Rousse wrote:
>> I tried two times already to send a patch to the list without success,
>> despite they were quite small (5Kb). What is the problem ?
> 
> Don't know.
> It looks like they never reached the list server.
> I can't see anything waiting in the moderator queue.
Strange.
Here it is, keeping you in CC this time.

Current autofs code prefixes all its configuration directive with
DEFAULT, which is misleading: what you configure is actual value,
whereas default is what is used when no actual value is provided.

The attached patche remove the DEFAULT_ prefix for all these variables,
and rework the sample configuration file to have all its directives
commented with their default values, as openssh does, to make it clearer.

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France

--------------070107070000090405010109
Content-Type: text/x-patch;
 name="autofs-5.0.1.config.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-5.0.1.config.patch"

diff -Naur autofs-5.0.1/lib/defaults.c autofs-5.0.1.config/lib/defaults.c
--- autofs-5.0.1/lib/defaults.c	2006-07-13 10:11:38.000000000 +0200
+++ autofs-5.0.1.config/lib/defaults.c	2006-07-26 09:15:30.000000000 +0200
@@ -24,21 +24,21 @@
 #define DEFAULTS_CONFIG_FILE		AUTOFS_CONF_DIR "/autofs"
 #define MAX_LINE_LEN			256
 
-#define ENV_NAME_MASTER_MAP		"DEFAULT_MASTER_MAP_NAME"
+#define ENV_NAME_MASTER_MAP		"MASTER_MAP_NAME"
 
-#define ENV_NAME_TIMEOUT		"DEFAULT_TIMEOUT"
-#define ENV_NAME_BROWSE_MODE		"DEFAULT_BROWSE_MODE"
-#define ENV_NAME_LOGGING		"DEFAULT_LOGGING"
+#define ENV_NAME_TIMEOUT		"TIMEOUT"
+#define ENV_NAME_BROWSE_MODE		"BROWSE_MODE"
+#define ENV_NAME_LOGGING		"LOGGING"
 
-#define ENV_LDAP_SERVER			"DEFAULT_LDAP_SERVER"
+#define ENV_LDAP_SERVER			"LDAP_SERVER"
 
-#define ENV_NAME_MAP_OBJ_CLASS		"DEFAULT_MAP_OBJECT_CLASS"
-#define ENV_NAME_ENTRY_OBJ_CLASS	"DEFAULT_ENTRY_OBJECT_CLASS"
-#define ENV_NAME_MAP_ATTR		"DEFAULT_MAP_ATTRIBUTE"
-#define ENV_NAME_ENTRY_ATTR		"DEFAULT_ENTRY_ATTRIBUTE"
-#define ENV_NAME_VALUE_ATTR		"DEFAULT_VALUE_ATTRIBUTE"
+#define ENV_NAME_MAP_OBJ_CLASS		"MAP_OBJECT_CLASS"
+#define ENV_NAME_ENTRY_OBJ_CLASS	"ENTRY_OBJECT_CLASS"
+#define ENV_NAME_MAP_ATTR		"MAP_ATTRIBUTE"
+#define ENV_NAME_ENTRY_ATTR		"ENTRY_ATTRIBUTE"
+#define ENV_NAME_VALUE_ATTR		"VALUE_ATTRIBUTE"
 
-#define ENV_AUTH_CONF_FILE		"DEFAULT_AUTH_CONF_FILE"
+#define ENV_AUTH_CONF_FILE		"AUTH_CONF_FILE"
 
 static const char *default_master_map_name = DEFAULT_MASTER_MAP_NAME;
 
diff -Naur autofs-5.0.1/redhat/autofs.sysconfig.in autofs-5.0.1.config/redhat/autofs.sysconfig.in
--- autofs-5.0.1/redhat/autofs.sysconfig.in	2006-07-13 10:11:39.000000000 +0200
+++ autofs-5.0.1.config/redhat/autofs.sysconfig.in	2006-07-26 09:21:22.000000000 +0200
@@ -1,56 +1,43 @@
 #
-# Define default options for autofs.
-#
-# DEFAULT_MASTER_MAP_NAME - default map name for the master map.
-#
-#DEFAULT_MASTER_MAP_NAME="auto.master"
-#
-# DEFAULT_TIMEOUT - set the default mount timeout (default 600).
-#
-DEFAULT_TIMEOUT=300
-#
-# DEFAULT_BROWSE_MODE - maps are browsable by default.
-#
-DEFAULT_BROWSE_MODE="no"
-#
-# DEFAULT_LOGGING - set default log level "none", "verbose" or "debug"
-#
-#DEFAULT_LOGGING="none"
-#
-# Define the default LDAP schema to use for lookups
-#
-# System default
+# autofs server configuration
+# 
+
+# MASTER_MAP_NAME - map name for the master map.
 #
-#DEFAULT_MAP_OBJECT_CLASS="nisMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="nisObject"
-#DEFAULT_MAP_ATTRIBUTE="nisMapName"
-#DEFAULT_ENTRY_ATTRIBUTE="cn"
-#DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"
+#MASTER_MAP_NAME="auto.master"
+
+# TIMEOUT - set the mount timeout
 #
-# Other common LDAP nameing
+#TIMEOUT=600
+
+# BROWSE_MODE - maps are browsable by default.
 #
-#DEFAULT_MAP_OBJECT_CLASS="automountMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="automount"
-#DEFAULT_MAP_ATTRIBUTE="ou"
-#DEFAULT_ENTRY_ATTRIBUTE="cn"
-#DEFAULT_VALUE_ATTRIBUTE="automountInformation"
+#BROWSE_MODE="yes"
+
+# LOGGING - set log level "none", "verbose" or "debug"
 #
-#DEFAULT_MAP_OBJECT_CLASS="automountMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="automount"
-#DEFAULT_MAP_ATTRIBUTE="automountMapName"
-#DEFAULT_ENTRY_ATTRIBUTE="automountKey"
-#DEFAULT_VALUE_ATTRIBUTE="automountInformation"
+#LOGGING="none"
+
+# Define the LDAP schema to use for lookups
 #
-# DEFAULT_AUTH_CONF_FILE - set the default location for the SASL
+#MAP_OBJECT_CLASS="nisMap"
+#ENTRY_OBJECT_CLASS="nisObject"
+#MAP_ATTRIBUTE="nisMapName"
+#ENTRY_ATTRIBUTE="cn"
+#VALUE_ATTRIBUTE="nisMapEntry"
+
+# AUTH_CONF_FILE - set the location for the SASL
 #			   authentication configuration file.
 #
-#DEFAULT_AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"
+#AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"
+
 #
+# autofs service configuration
+# 
+
 # General global options
 #
 #OPTIONS=""
-#
-#
-#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to auto.mnt
-UNDERSCORETODOT=1
 
+#  UNDERSCORETODOT changes auto_home to auto.home and auto_mnt to auto.mnt
+#UNDERSCORETODOT=1

--------------070107070000090405010109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070107070000090405010109--

