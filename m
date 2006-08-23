From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: Lost patch
Date: Wed, 23 Aug 2006 16:26:57 +0200
Message-ID: <44EC65B1.2060109@inria.fr>
References: <44D21274.9040405@inria.fr>
	<1154699891.25506.0.camel@raven.themaw.net>
	<44D3536A.6060502@inria.fr>
	<1154934063.11586.3.camel@raven.themaw.net>
	<44E9C785.5000104@inria.fr>
	<Pine.LNX.4.64.0608231113200.2954@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608231113200.2954@raven.themaw.net>
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

Ian Kent wrote:
> On Mon, 21 Aug 2006, Guillaume Rousse wrote:
> 
>> Ian Kent wrote:
>>> Please don't send patches as attachments put them in-line with the mail.
>>> It's a pain reply with comments.
>> OK. It's a bit more difficult to ensure patch integrity, but here is it
>> again:
> 
> OK. I'll merge it during the next round of cleanups.
> 
> Have you tested this?
Actually not, otherwise I would have noticed I've been confused between
redhat/ and samples/ directories :/. Is this really useful to keep
redhat-specific stuff there ?

Here is a corrected version that just change the DEFAULT_ prefixes
without altering default values, as it needs further discussion:
diff -Naur autofs-5.0.1/lib/defaults.c
autofs-5.0.1-drop-default-profix-from-config/lib/defaults.c
--- autofs-5.0.1/lib/defaults.c	2006-07-13 10:11:38.000000000 +0200
+++ autofs-5.0.1-drop-default-profix-from-config/lib/defaults.c
2006-08-23 14:21:55.000000000 +0200
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

diff -Naur autofs-5.0.1/samples/autofs.conf.default.in
autofs-5.0.1-drop-default-profix-from-config/samples/autofs.conf.default.in
--- autofs-5.0.1/samples/autofs.conf.default.in	2006-07-13
10:11:39.000000000 +0200
+++
autofs-5.0.1-drop-default-profix-from-config/samples/autofs.conf.default.in
2006-08-23 14:22:24.000000000 +0200
@@ -1,50 +1,50 @@
 #
 # Define default options for autofs.
 #
-# DEFAULT_MASTER_MAP_NAME - default map name for the master map.
+# MASTER_MAP_NAME - default map name for the master map.
 #
-#DEFAULT_MASTER_MAP_NAME="auto.master"
+#MASTER_MAP_NAME="auto.master"
 #
-# DEFAULT_TIMEOUT - set the default mount timeout (default 600).
+# TIMEOUT - set the default mount timeout (default 600).
 #
-DEFAULT_TIMEOUT=300
+TIMEOUT=300
 #
-# DEFAULT_BROWSE_MODE - maps are browsable by default.
+# BROWSE_MODE - maps are browsable by default.
 #
-DEFAULT_BROWSE_MODE="no"
+BROWSE_MODE="no"
 #
-# DEFAULT_LOGGING - set default log level "none", "verbose" or "debug"
+# LOGGING - set default log level "none", "verbose" or "debug"
 #
-#DEFAULT_LOGGING="none"
+#LOGGING="none"
 #
 # Define the default LDAP schema to use for lookups
 #
 # System default
 #
-#DEFAULT_MAP_OBJECT_CLASS="nisMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="nisObject"
-#DEFAULT_MAP_ATTRIBUTE="nisMapName"
-#DEFAULT_ENTRY_ATTRIBUTE="cn"
-#DEFAULT_VALUE_ATTRIBUTE="nisMapEntry"
+#MAP_OBJECT_CLASS="nisMap"
+#ENTRY_OBJECT_CLASS="nisObject"
+#MAP_ATTRIBUTE="nisMapName"
+#ENTRY_ATTRIBUTE="cn"
+#VALUE_ATTRIBUTE="nisMapEntry"
 #
 # Other common LDAP nameing
 #
-#DEFAULT_MAP_OBJECT_CLASS="automountMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="automount"
-#DEFAULT_MAP_ATTRIBUTE="ou"
-#DEFAULT_ENTRY_ATTRIBUTE="cn"
-#DEFAULT_VALUE_ATTRIBUTE="automountInformation"
-#
-#DEFAULT_MAP_OBJECT_CLASS="automountMap"
-#DEFAULT_ENTRY_OBJECT_CLASS="automount"
-#DEFAULT_MAP_ATTRIBUTE="automountMapName"
-#DEFAULT_ENTRY_ATTRIBUTE="automountKey"
-#DEFAULT_VALUE_ATTRIBUTE="automountInformation"
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
 #
-# DEFAULT_AUTH_CONF_FILE - set the default location for the SASL
+# AUTH_CONF_FILE - set the default location for the SASL
 #			   authentication configuration file.
 #
-#DEFAULT_AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"
+#AUTH_CONF_FILE="@@autofsmapdir@@/autofs_ldap_auth.conf"
 #
 # General global options
 #

[..]
>> -# System default
>> +# autofs server configuration
> 
> I always thought of autofs is a client not a server.
I just wanted to express the difference between daemon and service
script configuration. Feel free to express it differently.

> The config needs to reflect the setup of previous versions of autofs.
It depend what you want to achieve. If you want to make the transition
easier, you're right, but not if you want to provide quick references
about default values in the configuration file. I'd rather document the
changes in release notes, or eventually change the defaults values in
defaults.h.

[..]
>> -# Other common LDAP nameing
>> +#TIMEOUT=600
> 
> Should be 300 not 600.
600 is the default.

[..]
>> +#BROWSE_MODE="yes"
> 
> Should be set to "no".
yes is the default.

[..]
>> +# Define the LDAP schema to use for lookups
>>  #
>> -# DEFAULT_AUTH_CONF_FILE - set the default location for the SASL
>> +#MAP_OBJECT_CLASS="nisMap"
>> +#ENTRY_OBJECT_CLASS="nisObject"
>> +#MAP_ATTRIBUTE="nisMapName"
>> +#ENTRY_ATTRIBUTE="cn"
>> +#VALUE_ATTRIBUTE="nisMapEntry"
> 
> The two other common LDAP schema should be present in the config file 
> somewhere for a quick reference for people needing that information.
OK, but then I'd rather use a different formating, to have a better
visual identification of available configuration directives, such as:

# Name used for object class. Other common value may be "automountMap"
#MAP_OBJECT_CLASS="nisMap"

-- 
Guillaume Rousse
Projet Estime, INRIA
Domaine de Voluceau
Rocquencourt - B.P. 105
78153 Le Chesnay Cedex - France
