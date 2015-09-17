From: Yu Ning <ning.yu@canonical.com>
Subject: [PATCH v3 3/3] autofs-5.1.1 - use monotonic clock instead of time().
Date: Thu, 17 Sep 2015 11:48:53 +0800
Message-ID: <1442461733-22907-3-git-send-email-ning.yu@ubuntu.com>
References: <1442402500.2977.80.camel@themaw.net>
 <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1442461733-22907-1-git-send-email-ning.yu@ubuntu.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Yu Ning <ning.yu@ubuntu.com>

A new function monotonic_time() is introduced in automount.h as a
monotonic version of time(), all the calls to time() have been switched
to use this new function.

Signed-off-by: Yu Ning <ning.yu@ubuntu.com>
---
 daemon/automount.c        |  4 ++--
 daemon/direct.c           |  4 ++--
 daemon/indirect.c         |  4 ++--
 daemon/lookup.c           |  6 +++---
 daemon/state.c            |  2 +-
 include/automount.h       |  9 +++++++++
 lib/alarm.c               |  4 ++--
 lib/cache.c               |  2 +-
 lib/master.c              |  4 ++--
 modules/dclist.c          |  2 +-
 modules/lookup_file.c     |  8 ++++----
 modules/lookup_hesiod.c   |  6 +++---
 modules/lookup_hosts.c    |  4 ++--
 modules/lookup_ldap.c     | 10 +++++-----
 modules/lookup_nisplus.c  | 10 +++++-----
 modules/lookup_program.c  | 10 +++++-----
 modules/lookup_sss.c      |  6 +++---
 modules/lookup_userhome.c |  2 +-
 modules/lookup_yp.c       |  8 ++++----
 modules/mount_autofs.c    |  2 +-
 modules/parse_amd.c       |  2 +-
 modules/replicated.c      |  4 ++--
 22 files changed, 61 insertions(+), 52 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 229cb1a..a49ceee 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1454,7 +1454,7 @@ static void *statemachine(void *arg)
 			break;
 
 		case SIGHUP:
-			do_hup_signal(master_list, time(NULL));
+			do_hup_signal(master_list, monotonic_time(NULL));
 			break;
 
 		default:
@@ -2004,7 +2004,7 @@ int main(int argc, char *argv[])
 	unsigned ghost, logging, daemon_check;
 	unsigned dumpmaps, foreground, have_global_options;
 	time_t timeout;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	struct rlimit rlim;
 	const char *options = "+hp:t:vmdD:fVrO:l:n:CF";
 	static const struct option long_options[] = {
diff --git a/daemon/direct.c b/daemon/direct.c
index cdd7f49..470a719 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -464,7 +464,7 @@ int mount_autofs_direct(struct autofs_point *ap)
 	struct mapent_cache *nc, *mc;
 	struct mapent *me, *ne, *nested;
 	struct mnt_list *mnts;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 
 	if (strcmp(ap->path, "/-")) {
 		error(ap->logopt, "expected direct map, exiting");
@@ -1388,7 +1388,7 @@ int handle_packet_missing_direct(struct autofs_point *ap, autofs_packet_missing_
 	}
 
 	/* Check if we recorded a mount fail for this key */
-	if (me->status >= time(NULL)) {
+	if (me->status >= monotonic_time(NULL)) {
 		ops->send_fail(ap->logopt,
 			       ioctlfd, pkt->wait_queue_token, -ENOENT);
 		ops->close(ap->logopt, ioctlfd);
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 0ea9b19..b2015f9 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -197,7 +197,7 @@ out_err:
 
 int mount_autofs_indirect(struct autofs_point *ap, const char *root)
 {
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	int status;
 	int map;
 
@@ -818,7 +818,7 @@ int handle_packet_missing_indirect(struct autofs_point *ap, autofs_packet_missin
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, pkt->name, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			ops->send_fail(ap->logopt, ap->ioctlfd,
 				       pkt->wait_queue_token, -ENOENT);
 			cache_unlock(me->mc);
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 62071df..9a8fa7e 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -875,7 +875,7 @@ static int lookup_name_file_source_instance(struct autofs_point *ap, struct map_
 	struct map_source *instance;
 	char src_file[] = "file";
 	char src_prog[] = "program";
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	struct stat st;
 	char *type, *format;
 
@@ -915,7 +915,7 @@ static int lookup_name_source_instance(struct autofs_point *ap, struct map_sourc
 {
 	struct map_source *instance;
 	const char *format;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 
 	if (*name == '/' && map->flags & MAP_FLAG_FORMAT_AMD)
 		return lookup_amd_instance(ap, map, name, name_len);
@@ -1079,7 +1079,7 @@ static void update_negative_cache(struct autofs_point *ap, struct map_source *so
 		else
 			map = entry->maps;
 		if (map) {
-			time_t now = time(NULL);
+			time_t now = monotonic_time(NULL);
 			int rv = CHE_FAIL;
 
 			cache_writelock(map->mc);
diff --git a/daemon/state.c b/daemon/state.c
index 3174a9c..08828b1 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -553,7 +553,7 @@ static unsigned int st_readmap(struct autofs_point *ap)
 	pthread_t thid;
 	struct readmap_args *ra;
 	int status;
-	int now = time(NULL);
+	int now = monotonic_time(NULL);
 
 	debug(ap->logopt, "state %d path %s", ap->state, ap->path);
 
diff --git a/include/automount.h b/include/automount.h
index 447aba1..7bbf859 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -565,6 +565,15 @@ do { \
 		fatal(_m_unlock); \
 } while(0)
 
+static inline time_t monotonic_time(time_t *t)
+{
+	struct timespec ts;
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	if (t)
+		*t = (time_t) ts.tv_sec;
+	return (time_t) ts.tv_sec;
+}
+
 /* Expire alarm handling routines */
 int alarm_start_handler(void);
 int alarm_add(struct autofs_point *ap, time_t seconds);
diff --git a/lib/alarm.c b/lib/alarm.c
index 5b98b2d..7563c9b 100755
--- a/lib/alarm.c
+++ b/lib/alarm.c
@@ -46,7 +46,7 @@ int alarm_add(struct autofs_point *ap, time_t seconds)
 	struct list_head *head;
 	struct list_head *p;
 	struct alarm *new;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	time_t next_alarm = 0;
 	unsigned int empty = 1;
 	int status;
@@ -175,7 +175,7 @@ static void *alarm_handler(void *arg)
 
 		first = list_entry(head->next, struct alarm, list);
 
-		now = time(NULL);
+		now = monotonic_time(NULL);
 
 		if (first->time > now) {
 			struct timespec nsecs;
diff --git a/lib/cache.c b/lib/cache.c
index 631d275..44e323d 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -775,7 +775,7 @@ void cache_update_negative(struct mapent_cache *mc,
 			   struct map_source *ms, const char *key,
 			   time_t timeout)
 {
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	struct mapent *me;
 	int rv = CHE_OK;
 
diff --git a/lib/master.c b/lib/master.c
index 6c38b1c..cca8371 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1483,7 +1483,7 @@ int dump_map(struct master *master, const char *type, const char *name)
 		struct map_source *source;
 		struct master_mapent *this;
 		struct autofs_point *ap;
-		time_t now = time(NULL);
+		time_t now = monotonic_time(NULL);
 
 		this = list_entry(p, struct master_mapent, list);
 		p = p->next;
@@ -1601,7 +1601,7 @@ int master_show_mounts(struct master *master)
 		struct map_source *source;
 		struct master_mapent *this;
 		struct autofs_point *ap;
-		time_t now = time(NULL);
+		time_t now = monotonic_time(NULL);
 		unsigned int count = 0;
 
 		this = list_entry(p, struct master_mapent, list);
diff --git a/modules/dclist.c b/modules/dclist.c
index af21ce0..4daa199 100644
--- a/modules/dclist.c
+++ b/modules/dclist.c
@@ -568,7 +568,7 @@ struct dclist *get_dc_list(unsigned int logopt, const char *uri)
 	if (!list)
 		goto out_error;
 
-	dclist->expire = time(NULL) + min_ttl;
+	dclist->expire = monotonic_time(NULL) + min_ttl;
 	dclist->uri = list;
 
 	return dclist;
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 7c982c6..4e52fce 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -743,7 +743,7 @@ static int match_key(struct autofs_point *ap,
 {
 	char buf[MAX_ERR_BUF];
 	struct mapent_cache *mc;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	char *lkp_key;
 	char *prefix;
 	size_t map_key_len;
@@ -808,7 +808,7 @@ static int lookup_one(struct autofs_point *ap,
 	struct mapent_cache *mc = source->mc;
 	char mkey[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	FILE *f;
 	unsigned int k_len, m_len;
 	int entry, ret;
@@ -914,7 +914,7 @@ static int lookup_wild(struct autofs_point *ap,
 	struct mapent_cache *mc;
 	char mkey[KEY_MAX_LEN + 1];
 	char mapent[MAPENT_MAX_LEN + 1];
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	FILE *f;
 	unsigned int k_len, m_len;
 	int entry, ret;
@@ -1118,7 +1118,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, key, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 526f294..9da4f8e 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -163,7 +163,7 @@ static int lookup_one(struct autofs_point *ap,
 	}
 
 	cache_writelock(mc);
-	ret = cache_update(mc, source, key, best_record, time(NULL));
+	ret = cache_update(mc, source, key, best_record, monotonic_time(NULL));
 	cache_unlock(mc);
 	if (ret == CHE_FAIL) {
 		hesiod_free_list(ctxt->hesiod_context, hes_result);
@@ -228,7 +228,7 @@ static int lookup_one_amd(struct autofs_point *ap,
 	}
 
 	cache_writelock(mc);
-	ret = cache_update(mc, source, lkp_key, *hes_result, time(NULL));
+	ret = cache_update(mc, source, lkp_key, *hes_result, monotonic_time(NULL));
 	cache_unlock(mc);
 
 	if (hes_result)
@@ -339,7 +339,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, name, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_hosts.c b/modules/lookup_hosts.c
index 0d48356..8c4bbd9 100644
--- a/modules/lookup_hosts.c
+++ b/modules/lookup_hosts.c
@@ -284,7 +284,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	struct mapent *me;
 	char *mapent = NULL;
 	int mapent_len;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	int ret;
 
 	source = ap->entry->current;
@@ -296,7 +296,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, name, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 5da613e..d45e7d1 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -944,7 +944,7 @@ static LDAP *do_reconnect(unsigned logopt, struct lookup_context *ctxt)
 
 	uris_mutex_lock(ctxt);
 	if (ctxt->dclist) {
-		if (!ldap || ctxt->dclist->expire < time(NULL)) {
+		if (!ldap || ctxt->dclist->expire < monotonic_time(NULL)) {
 			free_dclist(ctxt->dclist);
 			ctxt->dclist = NULL;
 		}
@@ -2851,7 +2851,7 @@ static int lookup_one(struct autofs_point *ap, struct map_source *source,
 	struct mapent_cache *mc;
 	int rv, i, l, ql, count;
 	char buf[MAX_ERR_BUF];
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	char *query;
 	LDAPMessage *result = NULL, *e;
 	char *class, *info, *entry;
@@ -3214,7 +3214,7 @@ static int lookup_one_amd(struct autofs_point *ap,
 	struct berval **bvKey;
 	struct berval **bvValues;
 	char buf[MAX_ERR_BUF];
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	int rv, l, ql, count;
 	int ret = CHE_MISSING;
 
@@ -3417,7 +3417,7 @@ static int check_map_indirect(struct autofs_point *ap,
 	unsigned int is_amd_format = source->flags & MAP_FLAG_FORMAT_AMD;
 	struct mapent_cache *mc;
 	struct mapent *me;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	time_t t_last_read;
 	int ret, cur_state;
 	int status;
@@ -3555,7 +3555,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, key, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index d5eba47..17d3dde 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -288,7 +288,7 @@ static int lookup_one(struct autofs_point *ap,
 	nis_result *result;
 	nis_object *this;
 	char *mapent;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	int ret, cur_state;
 	char buf[MAX_ERR_BUF];
 
@@ -400,7 +400,7 @@ static int lookup_wild(struct autofs_point *ap,
 	nis_result *result;
 	nis_object *this;
 	char *mapent;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	int ret, cur_state;
 	char buf[MAX_ERR_BUF];
 
@@ -487,7 +487,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
 	mapent = ENTRY_VAL(this, 1);
 
 	cache_writelock(mc);
-	ret = cache_update(mc, source, "/defaults", mapent, time(NULL));
+	ret = cache_update(mc, source, "/defaults", mapent, monotonic_time(NULL));
 	cache_unlock(mc);
 
 	nis_freeresult(result);
@@ -505,7 +505,7 @@ static int check_map_indirect(struct autofs_point *ap,
 	unsigned int is_amd_format = source->flags & MAP_FLAG_FORMAT_AMD;
 	struct mapent_cache *mc;
 	struct mapent *me, *exists;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	time_t t_last_read;
 	int ret = 0;
 
@@ -650,7 +650,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, key, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_program.c b/modules/lookup_program.c
index a3a7e98..eff774b 100644
--- a/modules/lookup_program.c
+++ b/modules/lookup_program.c
@@ -369,7 +369,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
 		while (isblank(*start))
 			start++;
 		cache_writelock(mc);
-		ret = cache_update(mc, source, "/defaults", start, time(NULL));
+		ret = cache_update(mc, source, "/defaults", start, monotonic_time(NULL));
 		cache_unlock(mc);
 		if (ret == CHE_FAIL) {
 			free(ment);
@@ -438,7 +438,7 @@ static int match_key(struct autofs_point *ap,
 				start++;
 		}
 		cache_writelock(mc);
-		ret = cache_update(mc, source, lkp_key, start, time(NULL));
+		ret = cache_update(mc, source, lkp_key, start, monotonic_time(NULL));
 		cache_unlock(mc);
 		if (ret == CHE_FAIL) {
 			free(ment);
@@ -491,7 +491,7 @@ static int match_key(struct autofs_point *ap,
 			while (isblank(*start))
 				start++;
 			cache_writelock(mc);
-			ret = cache_update(mc, source, match, start, time(NULL));
+			ret = cache_update(mc, source, match, start, monotonic_time(NULL));
 			cache_unlock(mc);
 			if (ret == CHE_FAIL) {
 				free(match);
@@ -537,7 +537,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, name, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
@@ -586,7 +586,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		 * proceed with the program map lookup.
 		 */
 		if (strchr(name, '/') ||
-		    me->age + ap->negative_timeout > time(NULL)) {
+		    me->age + ap->negative_timeout > monotonic_time(NULL)) {
 			char *ent = NULL;
 
 			if (me->mapent) {
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 528ab41..d685ccf 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -374,7 +374,7 @@ static int lookup_one(struct autofs_point *ap,
 	struct mapent_cache *mc;
 	struct mapent *we;
 	void *sss_ctxt = NULL;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	char buf[MAX_ERR_BUF];
 	char *value = NULL;
 	char *s_key;
@@ -491,7 +491,7 @@ static int check_map_indirect(struct autofs_point *ap,
 	struct map_source *source;
 	struct mapent_cache *mc;
 	struct mapent *me;
-	time_t now = time(NULL);
+	time_t now = monotonic_time(NULL);
 	time_t t_last_read;
 	int ret, cur_state;
 
@@ -585,7 +585,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, key, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/lookup_userhome.c b/modules/lookup_userhome.c
index fb3caaa..d0c3e80 100644
--- a/modules/lookup_userhome.c
+++ b/modules/lookup_userhome.c
@@ -77,7 +77,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 
 	cache_writelock(mc);
-	ret = cache_update(mc, source, name, NULL, time(NULL));
+	ret = cache_update(mc, source, name, NULL, monotonic_time(NULL));
 	cache_unlock(mc);
 
 	if (ret == CHE_FAIL) {
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index fcf470a..3ffa4b6 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -405,7 +405,7 @@ static int lookup_one(struct autofs_point *ap,
 	char *mapname;
 	char *mapent;
 	int mapent_len;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	int ret;
 
 	mc = source->mc;
@@ -517,7 +517,7 @@ static int lookup_wild(struct autofs_point *ap,
 	char *mapname;
 	char *mapent;
 	int mapent_len;
-	time_t age = time(NULL);
+	time_t age = monotonic_time(NULL);
 	int ret;
 
 	mc = source->mc;
@@ -598,7 +598,7 @@ static int lookup_amd_defaults(struct autofs_point *ap,
 		return CHE_FAIL;
 
 	cache_writelock(mc);
-	ret = cache_update(mc, source, "/defaults", mapent, time(NULL));
+	ret = cache_update(mc, source, "/defaults", mapent, monotonic_time(NULL));
 	cache_unlock(mc);
 
 	return ret;
@@ -753,7 +753,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	/* Check if we recorded a mount fail for this key anywhere */
 	me = lookup_source_mapent(ap, key, LKP_DISTINCT);
 	if (me) {
-		if (me->status >= time(NULL)) {
+		if (me->status >= monotonic_time(NULL)) {
 			cache_unlock(me->mc);
 			return NSS_STATUS_NOTFOUND;
 		} else {
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 4846e7f..05ea1c1 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -242,7 +242,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	source = master_add_map_source(entry,
 				       info->type, info->format,
-				       time(NULL), argc, argv);
+				       monotonic_time(NULL), argc, argv);
 	if (!source) {
 		error(ap->logopt,
 		      MODPREFIX "failed to add map source to entry");
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 899be40..6e29c6c 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1181,7 +1181,7 @@ static int do_host_mount(struct autofs_point *ap, const char *name,
 					 "hosts", "sun", argc, pargv);
 	if (!instance) {
 		instance = master_add_source_instance(source,
-				 "hosts", "sun", time(NULL), argc, pargv);
+				 "hosts", "sun", monotonic_time(NULL), argc, pargv);
 		if (!instance) {
 			error(ap->logopt, MODPREFIX
 			     "failed to create source instance for hosts map");
diff --git a/modules/replicated.c b/modules/replicated.c
index 0f0cc51..8da1148 100644
--- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -69,14 +69,14 @@ void seed_random(void)
 
 	fd = open_fd("/dev/urandom", O_RDONLY);
 	if (fd < 0) {
-		srandom(time(NULL));
+		srandom(monotonic_time(NULL));
 		return;
 	}
 
 	if (read(fd, &seed, sizeof(seed)) != -1)
 		srandom(seed);
 	else
-		srandom(time(NULL));
+		srandom(monotonic_time(NULL));
 
 	close(fd);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
