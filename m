From: Ian Kent <raven@themaw.net>
Subject: [PATCH 31/37] autofs-5.1.2 - add function conf_amd_get_mount_paths()
Date: Tue, 25 Oct 2016 09:20:10 +0800
Message-ID: <20161025012010.7778.51537.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=vrE7l0SXmvOkafQYOm27vxlIuNY=; b=EsifJSFYf8iIspxXOJ
        hdwOfEfT/WTKsipJwirat1NEk0uECBe3nIWUpM0parI4+jrSEXsnOAtg6n9the5I
        mUdevFvMv0JxN1E1GBmkCIvg7zH4puc4ExXSgwhMom23JKbgD73FaTBJi510AOpk
        XYW9TXjHfPY3OWtFRPiCNZ9XQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=vrE7l0SXmvOkafQYOm27vx
        lIuNY=; b=Cih80yL8spXDNODQUytCx999dYweR/As3bPWBoND0cgJU2Zk+6iMzv
        1z9QL/03agRgDWY7yramhVtKeN5ocH2Y4ONbLF/OJRBw+tvy+rjqSCbUtqpEDUIS
        hLa8MP4GrzwrtykrQ+iruNnEfY1jDutuXt3HKdpWyd5xV8TJDfet4=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
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
index 38c565f..0853484 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -28,6 +28,7 @@ xx/xx/2016 autofs-5.1.3
 - add ref counting to struct map_source.
 - add support for amd browsable option.
 - add function conf_amd_get_map_name().
+- add function conf_amd_get_mount_paths().
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/defaults.h b/include/defaults.h
index fd29f22..c0d0aef 100644
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
