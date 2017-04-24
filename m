From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/34] autofs-5.1.2 - add support for amd browsable option
Date: Mon, 24 Apr 2017 09:01:15 +0800
Message-ID: <149299567495.23475.4753139944325347128.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=XIjeUKKRyzDVFs7HCZ
        /K/x/aOKOlA2R7mE+yGEm7NYY=; b=dIMQy2a/tGACv0Khbpu75NieT39bsYA8qA
        0hrOgsKLHp6BV6k+HPEjDu0uq4TZ8BxFSqx1BceRTUXFjdyRNfzY7BYHrNkIAVKQ
        ZA/7VAZCpcAgs09M+3HZ8ymzVGGSJggpeXj1jXXg5zzr5n0Nx8VWyXz6H1GsvFmf
        izeGoFe7NKE5+nDAgElz2MK22DuGsKyRQ4ZeOhFR/S7F/2JEjQR9aQJ7JYHPjA6q
        sepD5rSnZG/M88AyDrW2/WqVhGGEZI2lk8oKSQuuLN3JTnTvGl7rbc4D8NHVoSfN
        RxJORgsXPhW2I8bYoxdDqdYm3bmaKuzlX+VAucmE+Z4Ju9I8NhgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=XIjeUKKRyzDVFs7HCZ/K/x/aOKOlA2R7mE+yGEm7NYY=; b=qm1Hs4yJ
        otAMJHhqlE5Ovzux3vRba6dW8JHN25V5Kw6nsn+gJ4+5lrpnBJABHrohe0LZPYXR
        K6HlM3T1aMmE1LpphEwpjGxSr+a0f/7pKeFa4zY1e7s9J9nzxKulF9nGZbioyCut
        X3rQ0JBYeM+q3OG2s0HpTeXb1gA0ZUbyMHbtipug0qaVGrzSKRI+eWHs/QaLjPd4
        dCniYWbIHk5UpNna1mUmPcQqxU9jmuQFVUOU2CCKg45aa9XaUakBxQpDnxh9MBVu
        J4blZrhxVYX8fGJDphN23lusrSp96Zeoo1WoOhIQlTR5J4dseluiBvqRWGlr8As5
        AvJL//V4o18FxQ==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

From: Ian Kent <ikent@redhat.com>

Add support for the "browsable_dirs" configuration option and the
pseudo mount option "browsable" of amd format maps.

Note that support for the configuration option "browsable_dirs = full"
and the pseudo mount option "fullybrowsable" of type auto map entries
cannot be implemented using  the existing kernel to user space autofs
implementation.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                      |    1 
 README.amd-maps                |    2 -
 daemon/lookup.c                |  106 ++++++++++++++++++++++++++++++++--------
 lib/master_parse.y             |   14 ++++-
 man/autofs.conf.5.in           |    7 ++-
 modules/amd_parse.y            |    3 -
 modules/mount_autofs.c         |    8 ++-
 modules/parse_amd.c            |    2 -
 redhat/autofs.conf.default.in  |    7 ++-
 samples/autofs.conf.default.in |    7 ++-
 10 files changed, 120 insertions(+), 37 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index fb6243b..b67fd56 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -38,6 +38,7 @@ xx/xx/2016 autofs-5.1.3
 - honor last rw in mount options when doing a bind mount.
 - fix typos in README.amd-maps.
 - add ref counting to struct map_source.
+- add support for amd browsable option.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/README.amd-maps b/README.amd-maps
index e79f521..4f1d58d 100644
--- a/README.amd-maps
+++ b/README.amd-maps
@@ -101,7 +101,7 @@ What hasn't been implemented
 ----------------------------
 
 The configuration options fully_qualified_hosts, unmount_on_exit and
-browsable_dirs (and a couple of others) aren't implemented.
+browsable_dirs = full (and a couple of others) aren't implemented.
 
 Map types (sources) ndbm, passwd are not implemented.
 The map source "sss" can't be used for amd format maps.
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 5ff837d..583d3d3 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -663,6 +663,56 @@ int lookup_nss_read_map(struct autofs_point *ap, struct map_source *source, time
 	return 0;
 }
 
+static char *make_browse_path(unsigned int logopt,
+			      const char *root, const char *key,
+			      const char *prefix)
+{
+	unsigned int l_prefix;
+	unsigned int k_len, r_len;
+	char *k_start;
+	char *path;
+
+	k_start = (char *) key;
+	k_len = strlen(key);
+	l_prefix = 0;
+
+	if (prefix) {
+		l_prefix = strlen(prefix);
+
+		if (l_prefix > k_len)
+			return NULL;
+
+		/* If the prefix doesn't match the beginning
+		 * of the key this entry isn't a sub directory
+		 * at this level.
+		 */
+		if (strncmp(key, prefix, l_prefix))
+			return NULL;
+
+		/* Directory entry starts following the prefix */
+		k_start += l_prefix;
+	}
+
+	/* No remaining "/" allowed here */
+	if (strchr(k_start, '/'))
+		return NULL;
+
+	r_len = strlen(root);
+
+	if ((r_len + strlen(k_start)) > KEY_MAX_LEN)
+		return NULL;
+
+	path = malloc(r_len + k_len + 2);
+	if (!path) {
+		warn(logopt, "failed to allocate full path");
+		return NULL;
+	}
+
+	sprintf(path, "%s/%s", root, k_start);
+
+	return path;
+}
+
 int lookup_ghost(struct autofs_point *ap, const char *root)
 {
 	struct master_mapent *entry = ap->entry;
@@ -706,10 +756,19 @@ int lookup_ghost(struct autofs_point *ap, const char *root)
 			if (!me->mapent)
 				goto next;
 
-			if (!strcmp(me->key, "*"))
+			/* Wildcard cannot be a browse directory and amd map
+			 * keys may end with the wildcard.
+			 */
+			if (strchr(me->key, '*'))
 				goto next;
 
+			/* This will also take care of amd "/defaults" entry as
+			 * amd map keys are not allowd to start with "/"
+			 */
 			if (*me->key == '/') {
+				if (map->flags & MAP_FLAG_FORMAT_AMD)
+					goto next;
+
 				/* It's a busy multi-mount - leave till next time */
 				if (list_empty(&me->multi_list))
 					error(ap->logopt,
@@ -717,12 +776,10 @@ int lookup_ghost(struct autofs_point *ap, const char *root)
 				goto next;
 			}
 
-			fullpath = malloc(strlen(me->key) + strlen(root) + 3);
-			if (!fullpath) {
-				warn(ap->logopt, "failed to allocate full path");
+			fullpath = make_browse_path(ap->logopt,
+						    root, me->key, ap->pref);
+			if (!fullpath)
 				goto next;
-			}
-			sprintf(fullpath, "%s/%s", root, me->key);
 
 			ret = stat(fullpath, &st);
 			if (ret == -1 && errno != ENOENT) {
@@ -732,6 +789,17 @@ int lookup_ghost(struct autofs_point *ap, const char *root)
 				goto next;
 			}
 
+			/* Directory already exists? */
+			if (!ret) {
+				/* Shouldn't need this
+				me->dev = st.st_dev;
+				me->ino = st.st_ino;
+				*/
+				debug(ap->logopt, "me->dev %d me->ino %d", me->dev, me->ino);
+				free(fullpath);
+				goto next;
+			}
+
 			ret = mkdir_path(fullpath, 0555);
 			if (ret < 0 && errno != EEXIST) {
 				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
@@ -1241,28 +1309,23 @@ void lookup_close_lookup(struct autofs_point *ap)
 	return;
 }
 
-static char *make_fullpath(const char *root, const char *key)
+static char *make_fullpath(struct autofs_point *ap, const char *key)
 {
+	char *path = NULL;
 	int l;
-	char *path;
 
-	if (*key == '/') {
+	if (*key != '/')
+		path = make_browse_path(ap->logopt, ap->path, key, ap->pref);
+	else {
 		l = strlen(key) + 1;
 		if (l > KEY_MAX_LEN)
-			return NULL;
+			goto out;
 		path = malloc(l);
 		if (!path)
-			return NULL;
+			goto out;
 		strcpy(path, key);
-	} else {
-		l = strlen(key) + 1 + strlen(root) + 1;
-		if (l > KEY_MAX_LEN)
-			return NULL;
-		path = malloc(l);
-		if (!path)
-			return NULL;
-		sprintf(path, "%s/%s", root, key);
 	}
+out:
 	return path;
 }
 
@@ -1293,13 +1356,14 @@ void lookup_prune_one_cache(struct autofs_point *ap, struct mapent_cache *mc, ti
 
 		key = strdup(me->key);
 		me = cache_enumerate(mc, me);
-		if (!key || !strcmp(key, "*")) {
+		/* Don't consider any entries with a wildcard */
+		if (!key || strchr(key, '*')) {
 			if (key)
 				free(key);
 			continue;
 		}
 
-		path = make_fullpath(ap->path, key);
+		path = make_fullpath(ap, key);
 		if (!path) {
 			warn(ap->logopt, "can't malloc storage for path");
 			free(key);
diff --git a/lib/master_parse.y b/lib/master_parse.y
index 0011429..7536324 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -811,14 +811,22 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 
 	if (format && !strcmp(format, "amd")) {
 		unsigned int loglevel = conf_amd_get_log_options();
+		unsigned int flags = conf_amd_get_flags(path);
+
 		if (loglevel <= LOG_DEBUG && loglevel > LOG_INFO)
 			logopt = LOGOPT_DEBUG;
 		else if (loglevel <= LOG_INFO && loglevel > LOG_ERR)
 			logopt = LOGOPT_VERBOSE;
-		/* amd mounts don't support browse mode */
-		ghost = 0;
-	}
 
+		/* It isn't possible to provide the fullybrowsable amd
+		 * browsing functionality within the autofs framework.
+		 * This flag will not be set if browsable_dirs = full
+		 * in the configuration or fullybrowsable is present as
+		 * an option.
+		 */
+		if (flags & CONF_BROWSABLE_DIRS)
+			ghost = 1;
+	}
 
 	if (timeout < 0) {
 		/*
diff --git a/man/autofs.conf.5.in b/man/autofs.conf.5.in
index a9a08f9..a9ed1c3 100644
--- a/man/autofs.conf.5.in
+++ b/man/autofs.conf.5.in
@@ -355,7 +355,12 @@ and that will be done.
 .TP
 .B browsable_dirs
 .br
-Not yet implemented.
+Allow map keys to be shown in directory listings. This option
+can have values of "yes" or "no". The default is "no". A variation
+of this option, "browsable", can be used as a pseudo mount option
+in type "auto" map entries to provide provide browsing funtionality
+in sub-mounts. The amd "browsable_dirs = full" option cannot be
+implemented within the current autofs framework and is not supported.
 .TP
 .B exec_map_timeout
 .br
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index bfa1d51..b33250a 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -433,8 +433,7 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 
 options: OPTION
 	{
-		if (!strcmp($1, "browsable") ||
-		    !strcmp($1, "fullybrowsable") ||
+		if (!strcmp($1, "fullybrowsable") ||
 		    !strcmp($1, "nounmount") ||
 		    !strcmp($1, "unmount")) {
 			sprintf(msg_buf, "option %s is not currently "
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 3ba5271..e404c83 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -121,11 +121,13 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			while (*comma != '\0' && *comma != ',')
 				comma++;
 
-			if (_strncmp("nobrowse", cp, 8) == 0)
+			if (_strncmp("nobrowse", cp, 8) == 0 ||
+			    _strncmp("nobrowsable", cp, 11) == 0)
 				ghost = 0;
 			else if (_strncmp("nobind", cp, 6) == 0)
 				nobind = 1;
-			else if (_strncmp("browse", cp, 6) == 0)
+			else if (_strncmp("browse", cp, 6) == 0 ||
+				 _strncmp("browsable", cp, 9) == 0)
 				ghost = 1;
 			else if (_strncmp("symlink", cp, 7) == 0)
 				symlnk = 1;
@@ -287,8 +289,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			nap->pref = am_entry->pref;
 			am_entry->pref = NULL;
 		}
-		/* amd mounts don't support browse mode */
-		nap->flags &= ~MOUNT_FLAG_GHOST;
 	}
 
 	if (handle_mounts_startup_cond_init(&suc)) {
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 38d76b8..2ff43fa 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -930,7 +930,7 @@ static int do_auto_mount(struct autofs_point *ap, const char *name,
 	}
 
 	return do_mount(ap, ap->path,
-			name, strlen(name), target, "autofs", NULL);
+			name, strlen(name), target, "autofs", entry->opts);
 }
 
 static int do_link_mount(struct autofs_point *ap, const char *name,
diff --git a/redhat/autofs.conf.default.in b/redhat/autofs.conf.default.in
index c7e4d97..4a4b582 100644
--- a/redhat/autofs.conf.default.in
+++ b/redhat/autofs.conf.default.in
@@ -274,8 +274,6 @@ mount_nfs_default_protocol = 4
 #	is a sensible option to implement and that will be
 #	done.
 #
-# browsable_dirs - not yet implemented.
-#
 # exec_map_timeout - a timeout is not currently used for
 #	for program maps, might be implemented.
 #
@@ -318,6 +316,11 @@ mount_nfs_default_protocol = 4
 #	takes its default value from the autofs internal default
 #	of 600 seconds.
 #
+# browsable_dirs - make map keys visible in directory listings.
+#	Note that support for the "fullybrowsable" option cannot
+#	be added using the existing kernel to user space autofs
+#	implementation.
+#
 # autofs_use_lofs - if set to "yes" autofs will attempt to use bind
 #	mounts for type "auto" when possible.
 #
diff --git a/samples/autofs.conf.default.in b/samples/autofs.conf.default.in
index d52ad85..4af05aa 100644
--- a/samples/autofs.conf.default.in
+++ b/samples/autofs.conf.default.in
@@ -273,8 +273,6 @@ browse_mode = no
 #	is a sensible option to implement and that will be
 #	done.
 #
-# browsable_dirs - not yet implemented.
-#
 # exec_map_timeout - a timeout is not currently used for
 #	for program maps, might be implemented.
 #
@@ -317,6 +315,11 @@ browse_mode = no
 #	takes its default value from the autofs internal default
 #	of 600 seconds.
 #
+# browsable_dirs - make map keys visible in directory listings.
+#	Note that support for the "fullybrowsable" option cannot
+#	be added using the existing kernel to user space autofs
+#	implementation.
+#
 # autofs_use_lofs - if set to "yes" autofs will attempt to use bind
 #	mounts for type "auto" when possible.
 #

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
