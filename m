From: Ian Kent <raven@themaw.net>
Subject: [PATCH 30/37] autofs-5.1.2 - add function conf_amd_get_map_name()
Date: Tue, 25 Oct 2016 09:20:05 +0800
Message-ID: <20161025012004.7778.88776.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=KWYiRkZwjNtSl0CxJ9S+DlFyvi4=; b=MMPRD67FVgfHBThmpH
        IyjzXWOHOEqqodhXIaosnLNPfe/iQz+B0AxWvoeM/31JeOiKKfmVuB/Rs/WdqTT1
        hcMZ5pwpRFMCx4vphDQP1gOUg93X9vg2WwjeA1MVQdmfpA31pEqtiKOLiFuOMdXB
        NLxTzFz3kPka1zBb91G5eVImM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=KWYiRkZwjNtSl0CxJ9S+Dl
        Fyvi4=; b=g79TBkYr1Doi9+RQ4S5OrHGypcmyLxAfVJBlQjTHhdhQ5vXGnP5jUt
        CfFD6RPhVLEKntFTue9XweXzbM5/sD633d4Re5gs4WCdAWlhVkBIQ6D/9d7KpE6d
        4cnQ4nU39xK31C0JkD4YT7+DrDkXHpd7RYzlzH3ZcJhAm/KaWKnr0=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add configuration function to get the map_name option from
an amd mount configuration section.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 include/defaults.h |    1 +
 lib/defaults.c     |   10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index da3b54e..38c565f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -27,6 +27,7 @@ xx/xx/2016 autofs-5.1.3
 - fix typos in README.amd-maps.
 - add ref counting to struct map_source.
 - add support for amd browsable option.
+- add function conf_amd_get_map_name().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index 1dea48c..fd29f22 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -194,6 +194,7 @@ char *conf_amd_get_nfs_proto(void);
 char *conf_amd_get_nis_domain(void);
 unsigned int conf_amd_set_nis_domain(const char *);
 char *conf_amd_get_map_defaults(const char *);
+char *conf_amd_get_map_name(const char *);
 char *conf_amd_get_map_type(const char *);
 char *conf_amd_get_search_path(const char *);
 unsigned int conf_amd_get_dismount_interval(const char *);
diff --git a/lib/defaults.c b/lib/defaults.c
index 3ac231b..fba5d78 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -108,6 +108,7 @@
 #define NAME_AMD_MAP_DEFAULTS			"map_defaults"
 #define NAME_AMD_MAP_OPTIONS			"map_options"
 #define NAME_AMD_MAP_RELOAD_INTERVAL		"map_reload_interval"
+#define NAME_AMD_MAP_NAME			"map_name"
 #define NAME_AMD_MAP_TYPE			"map_type"
 #define NAME_AMD_MOUNT_TYPE			"mount_type"
 #define NAME_AMD_PID_FILE			"pid_file"
@@ -1934,6 +1935,15 @@ char *conf_amd_get_map_defaults(const char *section)
 	return tmp;
 }
 
+char *conf_amd_get_map_name(const char *section)
+{
+	char *tmp = NULL;
+	if (section)
+		tmp = conf_get_string(section, NAME_AMD_MAP_NAME);
+
+	return tmp;
+}
+
 char *conf_amd_get_map_type(const char *section)
 {
 	char *tmp = NULL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
