From: Ian Kent <raven@themaw.net>
Subject: [PATCH 36/37] autofs-5.1.2 - handle map_option cache for top level
 mounts
Date: Tue, 25 Oct 2016 09:20:37 +0800
Message-ID: <20161025012037.7778.47908.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=E2tB5QWRc9vw4aaGqy0qW4xLrnc=; b=pvRH8vKrU5AfriFkDE
        8Ooh68kOv+WG1TFMO4fXBBeWZ2EAdTQrJVcqgX9YbbYMLhJ2StJB3kkXOo+3WZZj
        d8Q1tCTnoB05D9MFlC78xTqafMK0F/cQlJlGSCiXGLoNXFD1xoxHUgS6KIKkjynb
        KG7aXVZj1qQdsCRbtdbWnmMV0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=E2tB5QWRc9vw4aaGqy0qW4
        xLrnc=; b=KGB36bWse91NXKiOULWc1SU13g/rIC6apQDb/I34dDWV9j67NGUO63
        aQGkXXpVogmQpnovrjSu7ch6wtuWmbSGpzufmyeHRXZkPh1h111pC7G7YGQCtBjn
        PDasjM66wYKpl6866t9zSFVSpElLWne2r6Gh4r94tlX9rAE4LwXYw=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
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
index ec184b4..8f47520 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -33,6 +33,7 @@ xx/xx/2016 autofs-5.1.3
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
index 6beae87..6bb67ce 100644
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
 
+		opts = conf_get_map_options(path);
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
index 7536324..8ee0bdd 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -863,6 +863,22 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 	if (mode && mode < LONG_MAX)
 		entry->ap->mode = mode;
 
+	if (format && !strcmp(format, "amd")) {
+		char *opts = conf_get_map_options(path);
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
index 2bb262e..4ebcd27 100644
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
