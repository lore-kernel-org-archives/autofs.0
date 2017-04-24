From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/34] autofs-5.1.2 - add function conf_amd_get_map_name()
Date: Mon, 24 Apr 2017 09:01:20 +0800
Message-ID: <149299568007.23475.8196146262828292356.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=E/6y3AZZatwSeKeVmd
        1jG3NMzJohZX8HdAN6XPE370U=; b=WuLt37P9OE/GwEAblblmqHIDqdCyiGXGzm
        Josk4PCqL3mgEfyx1Azi0yKVPSVZwuT5oQWfj8nxwOwNfMnkJeS8Th78HzLqtfyC
        v7sYniKfJC1oqyhz6q4M8jzqFZsNVQvIKOOcRHcF4dUk2hg5TRI1IHBeij4tyUQC
        0x+4IjHS/BTaQ9T1XTY7X/61Yj/XmwmigYaojBCyN8fzGpm5qLMTDIcPDXZsxx+l
        kDAGz9Hl+5VvOfzgoYDd029x4G8q5GdeAD7lV3dQcgEwn4Xtxqfw87oRHHf8+e5v
        YyryES7+qcRD4sHjsyJNDWDF+9yZ/ybiOEw5L2ECoZ0DuighIYhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=E/6y3AZZatwSeKeVmd1jG3NMzJohZX8HdAN6XPE370U=; b=oteBM946
        lQ0HihVgN+cw5k/gIOVfKsoXA7DzU5HfBNiFQNjfZNH/dXwSjxq32UWzMpdy1ndR
        hvfSZmJ96g4Jq3NgyP/nPClzUdwPQ5RZeg2lQu8QK3kp6h3Ziv+YTPkH9XqR+bbo
        PbBD/ZjbbjkujXJSK81k05HKOzelw68pUK/MlVjIWPM/BoM5RqpFniMgYZjsBVn5
        g4zswZWvMWuC50lS/PZu8+LLqlJOHxVDWS05d4Y8PS+6JmrYb4kHeOtXFoKguvWG
        gkeolok9/aL4LYZZns83YTXN3KSOYE8a4YJ9rFNxl/6yOSDEczmqNqh6ugmDLXrX
        bxZKwetBVWKqmQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
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
index b67fd56..ac195ed 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -39,6 +39,7 @@ xx/xx/2016 autofs-5.1.3
 - fix typos in README.amd-maps.
 - add ref counting to struct map_source.
 - add support for amd browsable option.
+- add function conf_amd_get_map_name().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index b93fda3..650f3e6 100644
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
