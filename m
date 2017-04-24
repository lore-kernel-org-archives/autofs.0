From: Ian Kent <raven@themaw.net>
Subject: [PATCH 19/34] autofs-5.1.2 - handle map_option cache for top level
 mounts
Date: Mon, 24 Apr 2017 09:01:50 +0800
Message-ID: <149299571086.23475.13661903634141135673.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=rZHagqPQ9fHO4Hzf8l
        kphNyO/AsBGq/yYgsgSycQFmA=; b=bp7TK3kX2vThKZSHQRexulFIqZIDsmxYMD
        eEDl9ZfDzJjf590GNn7CS8AtGFycRJDsdihC2s3ReWSBdMBizSHh9teW9YBG6cEs
        COiBrHJ+Yeh6qpJSmcnDG5jUVfJelzn8WdkgtIEXfSQSCeqychfFnqLlXhrkaYmV
        thPYA3FSaWHXNyrXQQ+nYcPAKZoNEhq7tzO8D3UWZtpPK2R/Z4twHEeOZbJbJ7Jf
        62kTfdJOwXWBLFC1CZlWTPftvV+CpAdqmxDb8KI5OfwszDOz8KAwok/Cnh8C61eK
        5QDK6mGDJKIk6Nf5xplX34dp/ivVyA0JkYJreEaHGMrlmEPavUNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=rZHagqPQ9fHO4Hzf8lkphNyO/AsBGq/yYgsgSycQFmA=; b=aSSrAu7b
        N4+CH4PDQaEzyjvMI7sEMPWEGjvxHgaJuKXD9b7zOAkJrw8VhRjWp5adyUgsnEeO
        +aYyQwwsttH0o6dv4stmvM0mK/uwNKwT1kK+Bj0tB7Lhj8wRMbgo28+/czjMFZUr
        aNqa/AMMVVD8hqNEORZWN/4YZ/GzZv6Fr+aDG3zVWfsZJZUDEaB1IGclsskneZmc
        x5nfRoNxaxcPKt/IjkbXGwT5vBgL/NoXqH8i61DWk2rwXlsefOoP1ZeJTH+EASw3
        TFGjrS9GThNhs4J/ONFQqDZ9lsv8zF8zDUHHoBuLz3bd55VRFJwCMcaeGYlWrVK4
        1i9U2y4JIrGk+w==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

In order to read in the map at mount time autofs top level mounts
must be set as browsasble but amd top level mounts that have the
map_option cache:=all set need to read in the map without the browse
option being set.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 include/automount.h  |    3 +++
 lib/master.c         |   15 +++++++++++++++
 lib/master_parse.y   |   16 ++++++++++++++++
 man/autofs.conf.5.in |    8 ++++++--
 5 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3999298..3415b18 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -45,6 +45,7 @@ xx/xx/2016 autofs-5.1.3
 - check for conflicting amd section mounts.
 - add function conf_get_map_options().
 - capture cache option and its settings during parsing.
+- handle map_option cache for top level mounts.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/include/automount.h b/include/automount.h
index f643f84..1d378c2 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -528,6 +528,9 @@ struct kernel_mod_version {
 /* Use symlinks instead of bind mounting local mounts */
 #define MOUNT_FLAG_SYMLINK		0x0040
 
+/* Read amd map even if it's not to be ghosted (browsable) */
+#define MOUNT_FLAG_AMD_CACHE_ALL	0x0080
+
 struct autofs_point {
 	pthread_t thid;
 	char *path;			/* Mount point name */
diff --git a/lib/master.c b/lib/master.c
index 6beae87..3f91808 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -983,6 +983,7 @@ static void master_add_amd_mount_section_mounts(struct master *master, time_t ag
 		unsigned int ghost = 0;
 		char *type = NULL;
 		char *map = NULL;
+		char *opts;
 
 		ret = master_partial_match_mapent(master, path);
 		if (ret) {
@@ -1037,6 +1038,20 @@ static void master_add_amd_mount_section_mounts(struct master *master, time_t ag
 			goto next;
 		}
 
+		opts = conf_amd_get_map_options(path);
+		if (opts) {
+			/* autofs uses the equivalent of cache:=inc,sync
+			 * (except for file maps which use cache:=all,sync)
+			 * but if the map is large then it may be necessary
+			 * to read the whole map at startup even if browsing
+			 * is is not enabled, so look for cache:=all in the
+			 * map_options configuration entry.
+			 */
+			if (strstr(opts, "cache:=all"))
+				entry->ap->flags |= MOUNT_FLAG_AMD_CACHE_ALL;
+			free(opts);
+		}
+
 		type = conf_amd_get_map_type(path);
 		argv[0] = map;
 		argv[1] = NULL;
diff --git a/lib/master_parse.y b/lib/master_parse.y
index 7536324..29bc3fc 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -863,6 +863,22 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 	if (mode && mode < LONG_MAX)
 		entry->ap->mode = mode;
 
+	if (format && !strcmp(format, "amd")) {
+		char *opts = conf_amd_get_map_options(path);
+		if (opts) {
+			/* autofs uses the equivalent of cache:=inc,sync
+			 * (except for file maps which use cache:=all,sync)
+			 * but if the map is large then it may be necessary
+			 * to read the whole map at startup even if browsing
+			 * is is not enabled, so look for cache:=all in the
+			 * map_options configuration entry.
+			 */
+			if (strstr(opts, "cache:=all"))
+				entry->ap->flags |= MOUNT_FLAG_AMD_CACHE_ALL;
+			free(opts);
+		}
+	}
+
 /*
 	source = master_find_map_source(entry, type, format,
 					local_argc, (const char **) local_argv); 
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index a9ed1c3..360570d 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -291,8 +291,12 @@ protocol version.
 .BR cache_duration ", " map_reload_interval ", " map_options
 .br
 The map	entry cache is continually updated and stale entries
-cleaned on re-load, which is done when map changes aredetected
-so these configuration entries are not used by autofs.
+cleaned on re-load, which is done when map changes are detected
+so these configuration entries are not used by autofs. An
+exception to this is the case where the map is large. In this
+case it may be necessary to read the whole map at startup even if
+browsing is is not enabled. Adding the cache:=all option to
+map_options can be used to for this.
 .TP
 .B localhost_address
 This is not used within autofs. This configuration option was

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
