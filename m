From: Ian Kent <raven@themaw.net>
Subject: [PATCH 27/34] autofs-5.1.2 - add config option to use mount request
 log id
Date: Mon, 24 Apr 2017 09:02:31 +0800
Message-ID: <149299575188.23475.12428066715204363242.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=POpiHJNbl4GX6ZFQeB
        esCEbS/yqhbuXVNvrTwfsTZEY=; b=N27gLauu0maDB+bBU707Al1L0L1XsNCa8W
        odUxLDWRlZQodm5sN8L0dqBk8v6+CQ/MfEGQmF5eIeb2DVVvpJ5hBvQgxkmSl0TU
        wdr35RuUUSPeerLJOZ+RxiUtEA9SnV/3zweiyC+KJCE+sSMG+ido0bxhcGcXQY7+
        a+yU9ij/7hySsUUH38UmO4Z1Ch5z9CD5rzJAxNdXK1OgWgwX1XuDn/L7PuwJSR3c
        o3/UDIF7dFc10H/SK9VWV1AVFOOJSn/PDizopMu6M1HATEXfRCm8zPYrcLbk1/Pa
        5znal+tPrkBfgywrPKLVwd0pgHLmtv1URMGsLhIc2+aNoW6NYrPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=POpiHJNbl4GX6ZFQeBesCEbS/yqhbuXVNvrTwfsTZEY=; b=sU2udSmr
        VVBP6BR+w51lKvj0pysa63vi58AXOaYHgvfP++6LY1QMb96Emqz9L6Ayvv+Tj313
        VHZYW5Oy1vwodXCioCSqjjniBWOm2X0ZJnJkmmjmV/COXI1eD3M9TePzz+RdlkHQ
        eszQbq0CGgdQe4hrGPOdN/DtPePE6VfaxV5lLMFZpkHrtV1QAJ8Igh/f6nEdYBWG
        rT+m15GjQUJEVRm7j2JCadX28QH6r7993rVZA/Qn8WAczpDaV9VPg9ILu4/em38j
        FthICWWONx3cPGccorOAukfAyoXVlGgbLU1vhHjsEtxMye4H+DXltGnCcUASdtNU
        1zp9Sf1V6y4AHQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add a configuration option to control whether request ids are added to
mount request log entries. It's default value is to not include the
additional id.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 +
 daemon/automount.c             |    3 +++
 include/defaults.h             |    2 ++
 lib/defaults.c                 |   17 +++++++++++++++++
 man/autofs.conf.5.in           |    6 ++++++
 redhat/autofs.conf.default.in  |    7 +++++++
 samples/autofs.conf.default.in |    7 +++++++
 7 files changed, 43 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 7add032..5e3ca0d 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -53,6 +53,7 @@ xx/xx/2016 autofs-5.1.3
 - create thread-local ID for mount attempts.
 - log functions to prefix messages with attempt_id if available.
 - factor out set_thread_mount_request_log_id().
+- add config option to use mount request log id.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 203d21f..d27804d 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -116,6 +116,9 @@ void set_thread_mount_request_log_id(struct pending_args *mt)
 	unsigned long *attempt_id;
 	int status;
 
+	if (!defaults_get_use_mount_request_log_id())
+		return;
+
 	attempt_id = pthread_getspecific(key_thread_attempt_id);
 	if (attempt_id == NULL) {
 		attempt_id = (unsigned long *) calloc(1, sizeof(unsigned long));
diff --git a/include/defaults.h b/include/defaults.h
index 7f0129b..b28fde3 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -52,6 +52,7 @@
 #define DEFAULT_DISABLE_NOT_FOUND_MESSAGE "0"
 
 #define DEFAULT_SSS_MASTER_MAP_WAIT	"0"
+#define DEFAULT_USE_MOUNT_REQUEST_LOG_ID "0"
 
 /* Config entry flags */
 #define CONF_NONE			0x00000000
@@ -172,6 +173,7 @@ unsigned int defaults_get_map_hash_table_size(void);
 unsigned int defaults_use_hostname_for_mounts(void);
 unsigned int defaults_disable_not_found_message(void);
 unsigned int defaults_get_sss_master_map_wait(void);
+unsigned int defaults_get_use_mount_request_log_id(void);
 
 unsigned int conf_amd_mount_section_exists(const char *);
 char **conf_amd_get_mount_paths(void);
diff --git a/lib/defaults.c b/lib/defaults.c
index 4a14367..d20c190 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -78,6 +78,7 @@
 #define NAME_DISABLE_NOT_FOUND_MESSAGE	"disable_not_found_message"
 
 #define NAME_SSS_MASTER_MAP_WAIT	"sss_master_map_wait"
+#define NAME_USE_MOUNT_REQUEST_LOG_ID	"use_mount_request_log_id"
 
 #define NAME_AMD_ARCH				"arch"
 #define NAME_AMD_AUTO_ATTRCACHE			"auto_attrcache"
@@ -362,6 +363,11 @@ static int conf_load_autofs_defaults(void)
 	if (ret == CFG_FAIL)
 		goto error;
 
+	ret = conf_update(sec, NAME_USE_MOUNT_REQUEST_LOG_ID,
+			  DEFAULT_USE_MOUNT_REQUEST_LOG_ID, CONF_ENV);
+	if (ret == CFG_FAIL)
+		goto error;
+
 	/* LDAP_URI and SEARCH_BASE can occur multiple times */
 	while ((co = conf_lookup(sec, NAME_LDAP_URI)))
 		conf_delete(co->section, co->name);
@@ -1852,6 +1858,17 @@ unsigned int defaults_get_sss_master_map_wait(void)
 	return res;
 }
 
+unsigned int defaults_get_use_mount_request_log_id(void)
+{
+	int res;
+
+	res = conf_get_yesno(autofs_gbl_sec, NAME_USE_MOUNT_REQUEST_LOG_ID);
+	if (res < 0)
+		res = atoi(DEFAULT_USE_MOUNT_REQUEST_LOG_ID);
+
+	return res;
+}
+
 unsigned int conf_amd_mount_section_exists(const char *section)
 {
 	return conf_section_exists(section);
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index 360570d..a777c58 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -148,6 +148,12 @@ Set the time to wait and retry if sssd returns "no such entry" when starting
 up. When sssd is starting up it can sometimes return "no such entry" for a
 short time until it has read in the LDAP map information. Default is 0 seconds,
 don't wait.
+.TP
+.B use_mount_request_log_id
+.br
+Set whether to use a mount request log id so that log entries for specific
+mount requests can be easily identified in logs that have multiple conncurrent
+requests. Default is don't use mount request log ids.
 .SS LDAP Configuration
 .P
 Configuration settings available are:
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index 4a4b582..3c6a316 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -71,6 +71,13 @@ mount_nfs_default_protocol = 4
 #
 # force_standard_program_map_env = no
 #
+# use_mount_request_log_id - Set whether to use a mount request log
+#			id so that log entries for specific mount
+#			requests can be easily identified in logs
+#			that have multiple conncurrent requests.
+#
+#use_mount_request_log_id = no
+#
 # Define base dn for map dn lookup.
 #
 # Define server URIs
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index 4af05aa..3ea3dd1 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -70,6 +70,13 @@ browse_mode = no
 #
 # force_standard_program_map_env = no
 #
+# use_mount_request_log_id - Set whether to use a mount request log
+#			id so that log entries for specific mount
+#			requests can be easily identified in logs
+#			that have multiple conncurrent requests.
+#
+#use_mount_request_log_id = no
+#
 # Define base dn for map dn lookup.
 #
 # Define server URIs

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
