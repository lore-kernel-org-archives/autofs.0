From: Ian Kent <raven@themaw.net>
Subject: [PATCH 28/37] autofs-5.1.2 - add ref counting to struct map_source
Date: Tue, 25 Oct 2016 09:19:54 +0800
Message-ID: <20161025011954.7778.82851.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=gM5IsqNKEf4S+L9fZjbd8JMP8oc=; b=Oi2vpnirpsYpqrGSQH
        UAcxvh3JG+RtOdDJ6uTxMIj5S9NEgEKTCt9DVCCUsIH4rVfi5QyLvzmXZg46cQw9
        ARbwVpmFA+AntUJm8nSLSNQBaj95VY3LzyYCzAkXMWQrzryKdPx3XEzAEE13+xsM
        Qih9LEjaWpbOGMkmyLJ9Rjg0s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=gM5IsqNKEf4S+L9fZjbd8J
        MP8oc=; b=accnT+wxPgMwwmY0bakPUbh2aqxvqzjGCl46P3+glUlj2nLpp10DBR
        3f8uADO+rcFB7/7MvnSru3nbdRxL9uo8wTRYgazdkScphTUP5p0gFxmlrFDFSJbn
        HCkhUCs3ewf6OQdIZHAV6nDGVpNUJntCq1ZJPhi+9R05oL8uwcyvU=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

amd map format maps that are type "auto" frequently refer to the
current map in their map entries.

While this isn't a problem for relatively small maps it can be very
wasteful for large maps and even more so for maps that have multi-
component keys that trigger type "auto" mounts as they progress down
the directory tree.

So add a reference count in order for amd type "auto" mounts to use
the parent map if it matches.

sun format maps are much less likley to use the same map and if they
do they are usually trivial, one line maps, so it isn't a problem.

But, more importantly, sun format maps need to track recursive inclusion
and inclusion depth for a given map source when plus map inclusion is
used which prevents the map soucre from being shared.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 daemon/indirect.c      |    7 +++++-
 include/master.h       |    3 ++
 lib/master.c           |   22 +++++++++++++++++
 modules/mount_autofs.c |   61 ++++++++++++++++++++++++++++++++----------------
 5 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6b097ff..5b3d0d1 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -25,6 +25,7 @@ xx/xx/2016 autofs-5.1.3
 - work around sss startup delay.
 - add sss master map wait config option.
 - fix typos in README.amd-maps.
+- add ref counting to struct map_source.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 4c32bdb..5d84b89 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -97,7 +97,12 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 	int ret;
 	int err;
 
-	ap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
+	/* If the map is being shared the exp_timeout can't be inherited
+	 * from the map source since it may be different so the autofs
+	 * point exp_runfreq must have already been set.
+	 */
+	if (ap->entry->maps->ref <= 1)
+		ap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
 
 	if (ops->version && !do_force_unlink) {
 		ap->flags |= MOUNT_FLAG_REMOUNT;
diff --git a/include/master.h b/include/master.h
index 3f97acd..3947cd5 100644
--- a/include/master.h
+++ b/include/master.h
@@ -23,6 +23,7 @@
 #define MAP_FLAG_FORMAT_AMD	0x0001
 
 struct map_source {
+	unsigned int ref;
 	unsigned int flags;
 	char *type;
 	char *format;
@@ -89,6 +90,8 @@ struct map_source *
 master_add_map_source(struct master_mapent *, char *, char *, time_t, int, const char **);
 struct map_source *
 master_find_map_source(struct master_mapent *, const char *, const char *, int, const char **);
+struct map_source *
+master_get_map_source(struct master_mapent *, const char *, const char *, int, const char **);
 void master_free_map_source(struct map_source *, unsigned int);
 struct map_source *
 master_find_source_instance(struct map_source *, const char *, const char *, int, const char **);
diff --git a/lib/master.c b/lib/master.c
index 4c6e79b..fceb5dd 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -181,6 +181,7 @@ master_add_map_source(struct master_mapent *entry,
 	if (!source)
 		return NULL;
 	memset(source, 0, sizeof(struct map_source));
+	source->ref = 1;
 
 	if (type) {
 		ntype = strdup(type);
@@ -232,6 +233,8 @@ master_add_map_source(struct master_mapent *entry,
 
 		this = __master_find_map_source(entry, type, format, argc, tmpargv);
 		if (this) {
+			error(entry->ap->logopt,
+			      "map source used without taking reference");
 			this->age = age;
 			master_free_map_source(source, 0);
 			master_source_unlock(entry);
@@ -330,8 +333,27 @@ struct map_source *master_find_map_source(struct master_mapent *entry,
 	return source;
 }
 
+struct map_source *
+master_get_map_source(struct master_mapent *entry,
+		      const char *type, const char *format,
+		      int argc, const char **argv)
+{
+	struct map_source *source = NULL;
+
+	master_source_readlock(entry);
+	source = __master_find_map_source(entry, type, format, argc, argv);
+	if (source)
+		source->ref++;
+	master_source_unlock(entry);
+
+	return source;
+}
+
 static void __master_free_map_source(struct map_source *source, unsigned int free_cache)
 {
+	/* instance map sources are not ref counted */
+	if (source->ref && --source->ref)
+		return;
 	if (source->type)
 		free(source->type);
 	if (source->format)
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 0476a09..3ba5271 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -208,18 +208,37 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	}
 	if (info->map)
 		argv[0] = info->map;
+
+	if (options) {
+		p = options;
+		while ((p = strchr(p, ',')) != NULL) {
+			if (*p == ',') {
+				*p = '\0';
+				p++;
+			}
+			argv[argc++] = p;
+		}
+	}
+	argv[argc] = NULL;
+
 	/*
-	 * If the parent map format is amd and the format isn't
-	 * specified in the map entry set it from the parent map
-	 * source.
+	 * For amd type "auto" the map is often re-used so check
+	 * if the the parent map can be used and use it if it
+	 * matches.
+	 *
+	 * Also if the parent map format is amd and the format
+	 * isn't specified in the map entry set it from the parent
+	 * map source.
 	 */
-	if (!info->format && ap->entry->maps) {
+	source = NULL;
+	if (ap->entry->maps && ap->entry->maps->flags & MAP_FLAG_FORMAT_AMD) {
 		struct map_source *s = ap->entry->maps;
+
 		/*
 		 * For amd maps, if the format and source type aren't
 		 * specified try and set them from the parent.
 		 */
-		if (s->flags & MAP_FLAG_FORMAT_AMD) {
+		if (!info->format) {
 			info->format = strdup("amd");
 			if (!info->format)
 				warn(ap->logopt, MODPREFIX
@@ -231,23 +250,19 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 					     "failed to set amd map type");
 			}
 		}
-	}
 
-	if (options) {
-		p = options;
-		while ((p = strchr(p, ',')) != NULL) {
-			if (*p == ',') {
-				*p = '\0';
-				p++;
-			}
-			argv[argc++] = p;
-		}
+		source = master_get_map_source(ap->entry,
+					       info->type, info->format,
+					       argc, argv);
+		if (source)
+			entry->maps = source;
 	}
-	argv[argc] = NULL;
 
-	source = master_add_map_source(entry,
-				       info->type, info->format,
-				       monotonic_time(NULL), argc, argv);
+	if (!source)
+		source = master_add_map_source(entry,
+					       info->type, info->format,
+					       monotonic_time(NULL),
+					       argc, argv);
 	if (!source) {
 		error(ap->logopt,
 		      MODPREFIX "failed to add map source to entry");
@@ -256,7 +271,13 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 		return 1;
 	}
 	free_map_type_info(info);
-	source->exp_timeout = timeout;
+	/* The exp_timeout can't be inherited if the map is shared, so
+	 * the autofs point exp_runfreq must be set here.
+	 */
+	if (source->ref <= 1)
+		source->exp_timeout = timeout;
+	else
+		nap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
 
 	mounts_mutex_lock(ap);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
