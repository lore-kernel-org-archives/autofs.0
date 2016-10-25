From: Ian Kent <raven@themaw.net>
Subject: [PATCH 34/37] autofs-5.1.2 - add function conf_get_map_options()
Date: Tue, 25 Oct 2016 09:20:27 +0800
Message-ID: <20161025012026.7778.68710.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=3IX7D9z6sJHcFwiFGgE+PJ8WTh4=; b=Kx1pyhyh7ib126h5Hf
        zF71ntR63u6+19oCqFDIKVjCqTEy7HcsgI1LGkJ3Yr1MzNe9PSywCyV7FI9Z38Ys
        ucv4bRTfEM+sFI7wgWjL8SBCdqJhe0VoE5eem51S1Mu8hffmVtK/hw7gol6xo5+E
        3PSpiKIM9QTSPinf/js3r4Wqw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=3IX7D9z6sJHcFwiFGgE+PJ
        8WTh4=; b=ErSNbXz73GxMdXd66deL1QSQaLKKGGIpjh9Vncj2JrBnfq9pWOG5t7
        nLjEomNQU69jN4/NAzZ8/x0ysxFrHbQNWlzd7ooqgi6X0gewqPZ7GOTYd7vmLdgp
        OTjJSszIa8ASueGN4STzehhoeZUSvNKoXZCsFklbwkHPOIwSYY6b0=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add configuration function to get the map_options option from
an amd mount configuration section.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 include/defaults.h |    1 +
 lib/defaults.c     |   10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 6553a40..32452de 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -31,6 +31,7 @@ xx/xx/2016 autofs-5.1.3
 - add function conf_amd_get_mount_paths().
 - include amd mount sections mounts in master mounts list.
 - check for conflicting amd section mounts.
+- add function conf_get_map_options().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index c0d0aef..d3f2c2d 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -196,6 +196,7 @@ char *conf_amd_get_nis_domain(void);
 unsigned int conf_amd_set_nis_domain(const char *);
 char *conf_amd_get_map_defaults(const char *);
 char *conf_amd_get_map_name(const char *);
+char *conf_get_map_options(const char *);
 char *conf_amd_get_map_type(const char *);
 char *conf_amd_get_search_path(const char *);
 unsigned int conf_amd_get_dismount_interval(const char *);
diff --git a/lib/defaults.c b/lib/defaults.c
index 102eda5..a1e041d 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -109,6 +109,7 @@
 #define NAME_AMD_MAP_OPTIONS			"map_options"
 #define NAME_AMD_MAP_RELOAD_INTERVAL		"map_reload_interval"
 #define NAME_AMD_MAP_NAME			"map_name"
+#define NAME_AMD_MAP_OPTIONS			"map_options"
 #define NAME_AMD_MAP_TYPE			"map_type"
 #define NAME_AMD_MOUNT_TYPE			"mount_type"
 #define NAME_AMD_PID_FILE			"pid_file"
@@ -2024,6 +2025,15 @@ char *conf_amd_get_map_name(const char *section)
 	return tmp;
 }
 
+char *conf_get_map_options(const char *section)
+{
+	char *tmp = NULL;
+	if (section)
+		tmp = conf_get_string(section, NAME_AMD_MAP_OPTIONS);
+
+	return tmp;
+}
+
 char *conf_amd_get_map_type(const char *section)
 {
 	char *tmp = NULL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
