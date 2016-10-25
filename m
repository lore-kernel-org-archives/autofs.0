From: Ian Kent <raven@themaw.net>
Subject: [PATCH 26/37] autofs-5.1.2 - add sss master map wait config option
Date: Tue, 25 Oct 2016 09:19:43 +0800
Message-ID: <20161025011943.7778.46286.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=+pXUjqLRPvcfEXUJvreShFj1498=; b=ZPGS7qQmi4PrDzXGm/
        UHca3LzurT7RzjRLIfJAFU91gC41y1pBceJrbcjnmUEuZqOURK/RtAAifVQ2d/cN
        YFDrvJth+//JLilCURf1cF+W2iuuuDHwHqq3YdmsUOJR9HczxrkNoUdoO4+l/Pfa
        RLCTcLHmS1rViLRCNEm9WYKno=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=+pXUjqLRPvcfEXUJvreShF
        j1498=; b=k0QTFep6LHkJwAP+H+zzD6u5R05UVWpSpWy1rWSpN8RfDsuE+ccgbQ
        MGwpjfyA6CRyu4imLFaPWU0m8P0EKYlAQpEsG+1j/5fIvy0uJjuWu0WxJHJ0JlZ8
        g8LASJGnJ86L1D/BHIMeKiK+UtaHRobvNf5tbO0jgC6EB+WuaL6KU=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When sssd is starting up it can sometimes return "no such entry" for a
short time until it has read in the LDAP map information. This affects
reading the master map at autofs startup and results in no automount
mounts if sssd is the primary map source.

This problem should be resolved in sssd but it's a problem for the
moment so a configuration option, sss_master_map_wait, has been added
to work around it.

The internal program default is 0, don't wait but the installed
configuration sets this to 10 seconds to work around the problem.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 include/defaults.h             |    3 +++
 lib/defaults.c                 |   18 ++++++++++++++++++
 man/autofs.conf.5.in           |    7 +++++++
 modules/lookup_sss.c           |    7 ++++---
 redhat/autofs.conf.default.in  |   10 ++++++++++
 samples/autofs.conf.default.in |   10 ++++++++++
 7 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 90688e6..e89086b 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -23,6 +23,7 @@ xx/xx/2016 autofs-5.1.3
 - wait for master map available at start.
 - add master read wait option.
 - work around sss startup delay.
+- add sss master map wait config option.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index 80db18d..1dea48c 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -51,6 +51,8 @@
 #define DEFAULT_USE_HOSTNAME_FOR_MOUNTS  "0"
 #define DEFAULT_DISABLE_NOT_FOUND_MESSAGE "0"
 
+#define DEFAULT_SSS_MASTER_MAP_WAIT	"0"
+
 /* Config entry flags */
 #define CONF_NONE			0x00000000
 #define CONF_ENV			0x00000001
@@ -169,6 +171,7 @@ const char *defaults_get_auth_conf_file(void);
 unsigned int defaults_get_map_hash_table_size(void);
 unsigned int defaults_use_hostname_for_mounts(void);
 unsigned int defaults_disable_not_found_message(void);
+unsigned int defaults_get_sss_master_map_wait(void);
 
 unsigned int conf_amd_mount_section_exists(const char *);
 char *conf_amd_get_arch(void);
diff --git a/lib/defaults.c b/lib/defaults.c
index 5fa4a2b..3ac231b 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -77,6 +77,8 @@
 #define NAME_USE_HOSTNAME_FOR_MOUNTS	"use_hostname_for_mounts"
 #define NAME_DISABLE_NOT_FOUND_MESSAGE	"disable_not_found_message"
 
+#define NAME_SSS_MASTER_MAP_WAIT	"sss_master_map_wait"
+
 #define NAME_AMD_ARCH				"arch"
 #define NAME_AMD_AUTO_ATTRCACHE			"auto_attrcache"
 #define NAME_AMD_AUTO_DIR			"auto_dir"
@@ -354,6 +356,11 @@ static int conf_load_autofs_defaults(void)
 	if (ret == CFG_FAIL)
 		goto error;
 
+	ret = conf_update(sec, NAME_SSS_MASTER_MAP_WAIT,
+			  DEFAULT_SSS_MASTER_MAP_WAIT, CONF_ENV);
+	if (ret == CFG_FAIL)
+		goto error;
+
 	/* LDAP_URI and SEARCH_BASE can occur multiple times */
 	while ((co = conf_lookup(sec, NAME_LDAP_URI)))
 		conf_delete(co->section, co->name);
@@ -1753,6 +1760,17 @@ unsigned int defaults_disable_not_found_message(void)
 	return res;
 }
 
+unsigned int defaults_get_sss_master_map_wait(void)
+{
+	int res;
+
+	res = conf_get_yesno(autofs_gbl_sec, NAME_SSS_MASTER_MAP_WAIT);
+	if (res < 0)
+		res = atoi(DEFAULT_SSS_MASTER_MAP_WAIT);
+
+	return res;
+}
+
 unsigned int conf_amd_mount_section_exists(const char *section)
 {
 	return conf_section_exists(section);
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 466db10..93ff7af 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -141,6 +141,13 @@ The original request to add this log message needed it to be unconditional.
 That produces, IMHO, unnecessary noise in the log so a configuration option
 has been added to provide the ability to turn it off. The default is "no"
 to maintain the current behaviour.
+.TP
+.B sss_master_map_wait
+.br
+Set the time to wait and retry if sssd returns "no such entry" when starting
+up. When sssd is starting up it can sometimes return "no such entry" for a
+short time until it has read in the LDAP map information. Default is 0 seconds,
+don't wait.
 .SS LDAP Configuration
 .P
 Configuration settings available are:
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 702e7b5..ce4d0ed 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -32,8 +32,6 @@
 
 /* Half a second between retries */
 #define SETAUTOMOUNTENT_MASTER_INTERVAL	500000000
-/* Try for 10 seconds */
-#define SETAUTOMOUNTENT_MASTER_RETRIES	10 * 2
 
 #define MODPREFIX "lookup(sss): "
 
@@ -304,7 +302,10 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		if (ret != ENOENT)
 			return NSS_STATUS_UNAVAIL;
 
-		retries = SETAUTOMOUNTENT_MASTER_RETRIES;
+		retries = defaults_get_sss_master_map_wait() * 2;
+		if (retries <= 0)
+			return NSS_STATUS_NOTFOUND;
+
 		ret = setautomntent_wait(logopt,
 					 ctxt, ctxt->mapname, &sss_ctxt,
 					 retries);
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 2fa8a4c..9bceab3 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -166,6 +166,16 @@ mount_nfs_default_protocol = 4
 #
 #disable_not_found_message = "no"
 #
+# sss_master_map_wait - When sssd is starting up it can sometimes return
+# 			"no such entry" for a short time until it has read
+# 			in the LDAP map information. Internal default is 0
+# 			seconds, don't wait but if there is a problem with
+# 			autofs not finding the master map at startup (when
+# 			it should) then try setting this to 10 to work
+# 			around it.
+#
+#sss_master_map_wait = 0
+#
 # Otions for the amd parser within autofs.
 #
 # amd configuration options that are aren't used, haven't been
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index 77c5999..a275e08 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -165,6 +165,16 @@ browse_mode = no
 #
 #disable_not_found_message = "no"
 #
+# sss_master_map_wait - When sssd is starting up it can sometimes return
+#			"no such entry" for a short time until it has read
+# 			in the LDAP map information. Internal default is 0
+# 			seconds, don't wait but if there is a problem with
+# 			autofs not finding the master map at startup (when
+# 			it should) then try setting this to 10 to work
+# 			around it.
+#
+#sss_master_map_wait = 0
+#
 # Otions for the amd parser within autofs.
 #
 # amd configuration options that are aren't used, haven't been

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
