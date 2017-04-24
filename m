From: Ian Kent <raven@themaw.net>
Subject: [PATCH 28/34] autofs-5.1.2 - use autofs_point to store expire
 timeout where possibe
Date: Mon, 24 Apr 2017 09:02:37 +0800
Message-ID: <149299575699.23475.10807438005215007122.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=T7F3VmHJWBL2GiUDE6
        np5kbhih5msox7YAKXw9bpdns=; b=dTTuupkpMzU1rsFtj4ZRtta/DUxqEkZGg4
        x637V0vtPypXriKcipR1bOGfDcnJZBNiAL83N3rk3Y3U0W1ioFnAGJQCOnrOkEog
        Pk1ctkgusoVdbKEZ4rl7bggN4spA5D1iJpuJpj+EVhFRTcO1gHY+Dt0Rv6cEDsjv
        eJtvCzMQK46xkuqvkmPFBXdJ6yuQRidA53x6UlQbvZIvUhmFO0mMTiJn+kjpSKgl
        PXUjB2FRAVTlHv1kPfzdq6bYomHhEnuSCOL2D9f69WyOuzpJJZ0O1N1SF5Hj3PQr
        z12eaNF6Y0q9mTCep1yR4jUUu9W/3gXCkQcSLCjbxGypu7hMoTNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=T7F3VmHJWBL2GiUDE6np5kbhih5msox7YAKXw9bpdns=; b=A8VreSRd
        dpzIA5+yedkGABBEM17PwbP8sY4UwrImm6Z1x0fPzXrec+I98Sau3vyXd3dChrxj
        Nhmd0x5EhgDUjclXesFbtXA35ZIwBVAZca6+6IntSx0pgwkGtPfZ9n9kI7dYdge+
        1KOq7hB56yWaOhG51+I99UKz6ZOwSbPCd0I+m9OXgbOiThBP2DvBmzQoO6o+GUpd
        QwiEUnLKJYQcUr304c3IlExPDW2I25kdafw8VQxQRWZo2EpgPnlMvmvlfsIQQc0r
        hYBtvUMDPg3eYzvsx52X3GkK7z09IQm4m7s+tW/AFFxxjru6XNgKmfdw9Yxmb7ky
        kw4rZMZdmymNZw==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

For technical reasons the expire timeout is stored in the map entry source
rather than the struct autofs_point and must be stored in the map source for
direct (and offset) mounts.

But with the map source re-use needed by amd format type "auto" mounts the
timeout can't be stored in the map source since the it may be different for
mounts that share the map source.

So use the struct autofs_point where possible.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 daemon/direct.c        |    6 +++---
 daemon/indirect.c      |    2 +-
 daemon/state.c         |   12 +++++++-----
 include/automount.h    |    1 +
 include/mounts.h       |    2 ++
 lib/master.c           |    5 ++++-
 lib/master_parse.y     |   27 +++++++++++++--------------
 lib/mounts.c           |   27 +++++++++++++++++++++------
 modules/mount_autofs.c |   12 ++++--------
 10 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5e3ca0d..1a4a8d9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -54,6 +54,7 @@ xx/xx/2016 autofs-5.1.3
 - log functions to prefix messages with attempt_id if available.
 - factor out set_thread_mount_request_log_id().
 - add config option to use mount request log id.
+- use autofs_point to store expire timeout where possibe.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/daemon/direct.c b/daemon/direct.c
index b682346..9a13435 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -312,7 +312,7 @@ static int unlink_active_mounts(struct autofs_point *ap, struct mnt_list *mnts,
 
 	if (tree_get_mnt_list(mnts, &list, me->key, 1)) {
 		if (ap->state == ST_READMAP) {
-			time_t tout = me->source->exp_timeout;
+			time_t tout = get_exp_timeout(ap, me->source);
 			int save_ioctlfd, ioctlfd;
 
 			save_ioctlfd = ioctlfd = me->ioctlfd;
@@ -522,7 +522,7 @@ int mount_autofs_direct(struct autofs_point *ap)
 		}
 
 		mc = map->mc;
-		timeout = map->exp_timeout;
+		timeout = get_exp_timeout(ap, map);
 		cache_readlock(mc);
 		pthread_cleanup_push(cache_lock_cleanup, mc);
 		me = cache_enumerate(mc, NULL);
@@ -678,7 +678,7 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me, const char *
 	struct ioctl_ops *ops = get_ioctl_ops();
 	char buf[MAX_ERR_BUF];
 	struct mnt_params *mp;
-	time_t timeout = me->source->exp_timeout;
+	time_t timeout = get_exp_timeout(ap, me->source);
 	struct stat st;
 	int ioctlfd, status, ret;
 	const char *hosts_map_name = "-hosts";
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 00b2622..ffb11b8 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -87,7 +87,7 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 {
 	const char *str_indirect = mount_type_str(t_indirect);
 	struct ioctl_ops *ops = get_ioctl_ops();
-	time_t timeout = ap->entry->maps->exp_timeout;
+	time_t timeout = get_exp_timeout(ap, ap->entry->maps);
 	char *options = NULL;
 	const char *hosts_map_name = "-hosts";
 	const char *map_name = hosts_map_name;
diff --git a/daemon/state.c b/daemon/state.c
index be5a834..cd0dd93 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -407,6 +407,7 @@ static void do_readmap_mount(struct autofs_point *ap, struct mnt_list *mnts,
 		if (valid) {
 			struct mapent_cache *vmc = valid->mc;
 			struct ioctl_ops *ops = get_ioctl_ops();
+			time_t timeout;
 			time_t runfreq;
 
 			cache_unlock(vmc);
@@ -428,9 +429,10 @@ static void do_readmap_mount(struct autofs_point *ap, struct mnt_list *mnts,
 			cache_set_ino_index(vmc, me->key, me->dev, me->ino);
 			cache_unlock(vmc);
 			/* Set timeout and calculate the expire run frequency */
-			ops->timeout(ap->logopt, valid->ioctlfd, map->exp_timeout);
-			if (map->exp_timeout) {
-				runfreq = (map->exp_timeout + CHECK_RATIO - 1) / CHECK_RATIO;
+			timeout = get_exp_timeout(ap, map);
+			ops->timeout(ap->logopt, valid->ioctlfd, timeout);
+			if (timeout) {
+				runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
 				if (ap->exp_runfreq)
 					ap->exp_runfreq = min(ap->exp_runfreq, runfreq);
 				else
@@ -442,7 +444,7 @@ static void do_readmap_mount(struct autofs_point *ap, struct mnt_list *mnts,
 			debug(ap->logopt,
 			      "%s is mounted", me->key);
 	} else
-		do_mount_autofs_direct(ap, mnts, me, map->exp_timeout);
+		do_mount_autofs_direct(ap, mnts, me, get_exp_timeout(ap, map));
 
 	return;
 }
@@ -491,7 +493,7 @@ static void *do_readmap(void *arg)
 
 	if (ap->type == LKP_INDIRECT) {
 		struct ioctl_ops *ops = get_ioctl_ops();
-		time_t timeout = ap->entry->maps->exp_timeout;
+		time_t timeout = get_exp_timeout(ap, ap->entry->maps);
 		ap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
 		ops->timeout(ap->logopt, ap->ioctlfd, timeout);
 		lookup_prune_cache(ap, now);
diff --git a/include/automount.h b/include/automount.h
index eb4fcc4..39e685d 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -551,6 +551,7 @@ struct autofs_point {
 	dev_t dev;			/* "Device" number assigned by kernel */
 	struct master_mapent *entry;	/* Master map entry for this mount */
 	unsigned int type;		/* Type of map direct or indirect */
+	time_t exp_timeout;		/* Indirect mount expire timeout */
 	time_t exp_runfreq;		/* Frequency for polling for timeouts */
 	time_t negative_timeout;	/* timeout in secs for failed mounts */
 	unsigned int flags;		/* autofs mount flags */
diff --git a/include/mounts.h b/include/mounts.h
index 8425818..031e2a3 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -111,6 +111,8 @@ int tree_find_mnt_ents(struct mnt_list *mnts, struct list_head *list, const char
 int tree_is_mounted(struct mnt_list *mnts, const char *path, unsigned int type);
 void set_tsd_user_vars(unsigned int, uid_t, gid_t);
 const char *mount_type_str(unsigned int);
+void set_exp_timeout(struct autofs_point *ap, struct map_source *source, time_t timeout);
+time_t get_exp_timeout(struct autofs_point *ap, struct map_source *source);
 void notify_mount_result(struct autofs_point *, const char *, time_t, const char *);
 int try_remount(struct autofs_point *, struct mapent *, unsigned int);
 void set_indirect_mount_tree_catatonic(struct autofs_point *);
diff --git a/lib/master.c b/lib/master.c
index 3f91808..142f97e 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -99,6 +99,7 @@ int master_add_autofs_point(struct master_mapent *entry, unsigned logopt,
 		ap->negative_timeout = defaults_get_negative_timeout();
 	else
 		ap->negative_timeout = global_negative_timeout;
+	ap->exp_timeout = defaults_get_timeout();
 	ap->exp_runfreq = 0;
 	ap->flags = 0;
 	if (ghost)
@@ -981,6 +982,7 @@ static void master_add_amd_mount_section_mounts(struct master *master, time_t ag
 	while (paths[i]) {
 		const char *path = paths[i];
 		unsigned int ghost = 0;
+		time_t timeout;
 		char *type = NULL;
 		char *map = NULL;
 		char *opts;
@@ -1066,7 +1068,8 @@ static void master_add_amd_mount_section_mounts(struct master *master, time_t ag
 			goto next;
 		}
 
-		source->exp_timeout = conf_amd_get_dismount_interval(path);
+		timeout = conf_amd_get_dismount_interval(path);
+		set_exp_timeout(entry->ap, source, timeout);
 		source->master_line = 0;
 
 		entry->age = age;
diff --git a/lib/master_parse.y b/lib/master_parse.y
index 29bc3fc..42e03c2 100644
--- a/lib/master_parse.y
+++ b/lib/master_parse.y
@@ -828,19 +828,6 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 			ghost = 1;
 	}
 
-	if (timeout < 0) {
-		/*
-		 * If no timeout is given get the timout from the
-		 * first map (if it exists) or the config for amd
-		 * maps.
-		 */
-		if (format && !strcmp(format, "amd"))
-			timeout = conf_amd_get_dismount_interval(path);
-		else if (entry->maps)
-			timeout = entry->maps->exp_timeout;
-		else
-			timeout = default_timeout;
-	}
 
 	if (!entry->ap) {
 		ret = master_add_autofs_point(entry, logopt, nobind, ghost, 0);
@@ -863,6 +850,18 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 	if (mode && mode < LONG_MAX)
 		entry->ap->mode = mode;
 
+	if (timeout < 0) {
+		/*
+		 * If no timeout is given get the timout from the
+		 * autofs point, or the first map, or the config
+		 * for amd maps.
+		 */
+		if (format && !strcmp(format, "amd"))
+			timeout = conf_amd_get_dismount_interval(path);
+		else
+			timeout = get_exp_timeout(entry->ap, entry->maps);
+	}
+
 	if (format && !strcmp(format, "amd")) {
 		char *opts = conf_amd_get_map_options(path);
 		if (opts) {
@@ -897,7 +896,7 @@ int master_parse_entry(const char *buffer, unsigned int default_timeout, unsigne
 		local_free_vars();
 		return 0;
 	}
-	source->exp_timeout = timeout;
+	set_exp_timeout(entry->ap, source, timeout);
 	source->master_line = lineno;
 
 	entry->age = age;
diff --git a/lib/mounts.c b/lib/mounts.c
index a9be906..22d653e 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1578,6 +1578,24 @@ const char *mount_type_str(const unsigned int type)
 	return (pos == type_count ? NULL : str_type[pos]);
 }
 
+void set_exp_timeout(struct autofs_point *ap,
+		     struct map_source *source, time_t timeout)
+{
+	ap->exp_timeout = timeout;
+	if (source)
+		source->exp_timeout = timeout;
+}
+
+time_t get_exp_timeout(struct autofs_point *ap, struct map_source *source)
+{
+	time_t timeout = ap->exp_timeout;
+
+	if (source && ap->type == LKP_DIRECT)
+		timeout = source->exp_timeout;
+
+	return timeout;
+}
+
 void notify_mount_result(struct autofs_point *ap,
 			 const char *path, time_t timeout, const char *type)
 {
@@ -1709,12 +1727,9 @@ static int remount_active_mount(struct autofs_point *ap,
 	ops->open(ap->logopt, &fd, devid, path);
 	if (fd == -1)
 		return REMOUNT_OPEN_FAIL;
-	else {
-		if (type == t_indirect || type == t_offset)
-			timeout = ap->entry->maps->exp_timeout;
-		else
-			timeout = me->source->exp_timeout;
-	}
+
+	error(ap->logopt, "ap->type %d type %u", ap->type, type);
+	timeout = get_exp_timeout(ap, me->source);
 
 	/* Re-reading the map, set timeout and return */
 	if (ap->state == ST_READMAP) {
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 20bcd11..be9d51d 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -57,7 +57,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 	int nobind = ap->flags & MOUNT_FLAG_NOBIND;
 	int ghost = ap->flags & MOUNT_FLAG_GHOST;
 	int symlnk = ap->flags & MOUNT_FLAG_SYMLINK;
-	time_t timeout = ap->entry->maps->exp_timeout;
+	time_t timeout = get_exp_timeout(ap, ap->entry->maps);
 	unsigned logopt = ap->logopt;
 	struct map_type_info *info;
 	struct master *master;
@@ -273,13 +273,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 		return 1;
 	}
 	free_map_type_info(info);
-	/* The exp_timeout can't be inherited if the map is shared, so
-	 * the autofs point exp_runfreq must be set here.
-	 */
-	if (source->ref <= 1)
-		source->exp_timeout = timeout;
-	else
-		nap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
+
+	set_exp_timeout(nap, NULL, timeout);
+	nap->exp_runfreq = (timeout + CHECK_RATIO - 1) / CHECK_RATIO;
 
 	mounts_mutex_lock(ap);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
