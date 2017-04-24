From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/34] autofs-5.1.2 - add function conf_amd_get_mount_paths()
Date: Mon, 24 Apr 2017 09:01:25 +0800
Message-ID: <149299568527.23475.16910248249518608436.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=+7buL4bcwDxt/jWeGX
        sNYgwCEBQs6NJoD1p8GR/agp8=; b=Mb5SGt+lpY++IDHR2RwYGxce7UM/BVK8AW
        kWUcmT3fhK0fttSlGtdr4c5ibs1NjY+3mB+AxorjR+8yYn0KD6D5HZHXdT7dAK4n
        IeygC7HsRyqB729Rg+e7MSU/n+gHo6ODQZhWWYWSlbm4sClgmZi0qi7nZLN4aAvZ
        veNdLzp2jwOl8P+h9K5pGqvMW8/Q53KqURqe+Oeoog8TuYt5tmD9jAvGCdTnLuLF
        hJriR6uEX/4lg2NvR4t3C5MO+usSU+tXIpUsykQiyEbcfwzZ3IqrhBxIfrHz5Jgn
        KB51XNq9L8GL1fZFOubSOdOzkqpMkV/fVGRp5ibYb/iRkDQdtLJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=+7buL4bcwDxt/jWeGXsNYgwCEBQs6NJoD1p8GR/agp8=; b=g++3NPUw
        VuqpPCK70eUEgnOlhVUliYH/Q+JFUeqLXgdCBsf6e4WBokR1iMxr4hChN5XlSbJP
        QJmFhplSoAKmUed0p0YD0P3Zr0mk9ANCvMVGS7LejqAyvmPnV+JzM1l1669OHYNw
        wp9r7xxsvK3MamdS8AQJYLkJYqijanIJCGpP5MDaEiI42uW1hgPynYeXI+GqWLTz
        gcFcNW/6JiK7t7SGhKBfmmUZo6t33w/bY6FWwbCgGh+rNseZi7JhMNbIT0AnDwox
        RermCyb2Isr5QJYy298CCSBik9ArE4nRU7YkRyMK1Crm6PJp317K8pvqfrg86nfR
        VsFc5O1w3mUyBg==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add configuration function to get an array of amd mount section
paths.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 include/defaults.h |    1 +
 lib/defaults.c     |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index ac195ed..750b803 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -40,6 +40,7 @@ xx/xx/2016 autofs-5.1.3
 - add ref counting to struct map_source.
 - add support for amd browsable option.
 - add function conf_amd_get_map_name().
+- add function conf_amd_get_mount_paths().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index 650f3e6..7766196 100644
--- a/include/defaults.h
+++ b/include/defaults.h
@@ -174,6 +174,7 @@ unsigned int defaults_disable_not_found_message(void);
 unsigned int defaults_get_sss_master_map_wait(void);
 
 unsigned int conf_amd_mount_section_exists(const char *);
+char **conf_amd_get_mount_paths(void);
 char *conf_amd_get_arch(void);
 char *conf_amd_get_karch(void);
 char *conf_amd_get_os(void);
diff --git a/lib/defaults.c b/lib/defaults.c
index fba5d78..102eda5 100644
--- a/lib/defaults.c
+++ b/lib/defaults.c
@@ -771,6 +771,81 @@ static struct conf_option *conf_lookup(const char *section, const char *key)
 	return co;
 }
 
+static char **conf_enumerate_amd_mount_sections(void)
+{
+	struct conf_option *this;
+	unsigned int count;
+	char **paths;
+	char *last;
+	int i, j;
+
+	last = NULL;
+	count = 0;
+	for (i = 0; i < CFG_TABLE_SIZE; i++) {
+		if (!config->hash[i])
+			continue;
+
+		this = config->hash[i];
+		while (this) {
+			/* Only amd mount section names begin with '/' */
+			if (*this->section != '/') {
+				this = this->next;
+				continue;
+			}
+
+			if (!last ||
+			   strcmp(this->section, last))
+				count ++;
+			last = this->section;
+			this = this->next;
+		}
+	}
+
+	if (!count)
+		return NULL;
+
+	paths = (char **) malloc(((count + 1) * sizeof(char *)));
+	if (!paths)
+		return NULL;
+	memset(paths, 0, ((count + 1) * sizeof(char *)));
+
+	last = NULL;
+	j = 0;
+
+	for (i = 0; i < CFG_TABLE_SIZE; i++) {
+		if (!config->hash[i])
+			continue;
+
+		this = config->hash[i];
+		while (this) {
+			/* Only amd mount section names begin with '/' */
+			if (*this->section != '/') {
+				this = this->next;
+				continue;
+			}
+
+			if (!last ||
+			    strcmp(this->section, last)) {
+				char *path = strdup(this->section);
+				if (!path)
+					goto fail;
+				paths[j++] = path;
+			}
+			last = this->section;
+			this = this->next;
+		}
+	}
+
+	return paths;
+
+fail:
+	i = 0;
+	while (paths[i])
+		free(paths[i++]);
+	free(paths);
+	return NULL;
+}
+
 static unsigned int conf_section_exists(const char *section)
 {
 	struct conf_option *co;
@@ -1777,6 +1852,11 @@ unsigned int conf_amd_mount_section_exists(const char *section)
 	return conf_section_exists(section);
 }
 
+char **conf_amd_get_mount_paths(void)
+{
+	return conf_enumerate_amd_mount_sections();
+}
+
 char *conf_amd_get_arch(void)
 {
 	return conf_get_string(amd_gbl_sec, NAME_AMD_ARCH);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
