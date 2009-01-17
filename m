From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [RFC PATCH 2/3] Easy alloca() replacements
Date: Fri, 16 Jan 2009 19:58:49 -0800
Message-ID: <1232164730-9397-3-git-send-email-vaurora@redhat.com>
References: <1232164730-9397-1-git-send-email-vaurora@redhat.com>
	<1232164730-9397-2-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232164730-9397-2-git-send-email-vaurora@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org
Cc: Paul Wankadia <junyer@google.com>

alloca() is compiler-dependent, non-standard, and has undefined
behavior when it fails (IOW, the program crashes).  Replace with
normal C stack variables where possible and malloc() where not.

Extremely lightly tested.
---
 daemon/automount.c       |   26 ++++++------
 daemon/direct.c          |   12 ++----
 daemon/flag.c            |   12 +++---
 daemon/indirect.c        |   12 ++----
 daemon/module.c          |   42 ++++++--------------
 lib/cache.c              |   30 +++++----------
 lib/cat_path.c           |    1 -
 modules/lookup_file.c    |   43 +++-----------------
 modules/lookup_ldap.c    |   95 ++++++++++++++++++++++++++++-----------------
 modules/lookup_nisplus.c |   32 +++++++++++-----
 modules/mount_autofs.c   |    1 -
 modules/mount_bind.c     |    7 +--
 modules/mount_changer.c  |    5 +--
 modules/mount_ext2.c     |    5 +--
 modules/mount_generic.c  |    5 +--
 15 files changed, 142 insertions(+), 186 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index e120f50..40f8e0d 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -125,8 +125,8 @@ static int do_mkdir(const char *parent, const char *path, mode_t mode)
 
 int mkdir_path(const char *path, mode_t mode)
 {
-	char *buf = alloca(strlen(path) + 1);
-	char *parent = alloca(strlen(path) + 1);
+	char buf[PATH_MAX];
+	char parent[PATH_MAX];
 	const char *cp = path, *lcp = path;
 	char *bp = buf, *pp = parent;
 
@@ -161,7 +161,7 @@ int mkdir_path(const char *path, mode_t mode)
 int rmdir_path(struct autofs_point *ap, const char *path, dev_t dev)
 {
 	int len = strlen(path);
-	char *buf = alloca(len + 1);
+	char buf[PATH_MAX];
 	char *cp;
 	int first = 1;
 	struct stat st;
@@ -466,20 +466,20 @@ static int umount_subtree_mounts(struct autofs_point *ap, const char *path, unsi
 	pthread_cleanup_push(cache_lock_cleanup, mc);
 
 	if (me->multi) {
-		char *root, *base;
+		char root[PATH_MAX];
+		char *base;
 		size_t ap_len;
 		int cur_state;
 
 		ap_len = strlen(ap->path);
 
-		if (!strchr(me->multi->key, '/')) {
+		if (!strchr(me->multi->key, '/'))
 			/* Indirect multi-mount root */
-			root = alloca(ap_len + strlen(me->multi->key) + 2);
-			strcpy(root, ap->path);
-			strcat(root, "/");
-			strcat(root, me->multi->key);
-		} else
-			root = me->multi->key;
+			/* sprintf okay - if it's mounted, it's
+			 * PATH_MAX or less bytes */
+			sprintf(root, "%s/%s", ap->path, me->multi->key);
+		else
+			strcpy(root, me->multi->key);
 
 		if (is_mm_root)
 			base = NULL;
@@ -927,14 +927,14 @@ static int get_pkt(struct autofs_point *ap, union autofs_v5_packet_union *pkt)
 
 int do_expire(struct autofs_point *ap, const char *name, int namelen)
 {
-	char buf[PATH_MAX + 1];
+	char buf[PATH_MAX];
 	int len, ret;
 
 	if (*name != '/') {
 		len = ncat_path(buf, sizeof(buf), ap->path, name, namelen);
 	} else {
 		len = snprintf(buf, PATH_MAX, "%s", name);
-		if (len > PATH_MAX)
+		if (len >= PATH_MAX)
 			len = 0;
 	}
 
diff --git a/daemon/direct.c b/daemon/direct.c
index c0243c4..8ab6c15 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -636,7 +636,9 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me, const char *
 	time_t timeout = ap->exp_timeout;
 	struct stat st;
 	int ioctlfd, status, ret;
-	const char *type, *map_name = NULL;
+	const char *default_map_name = "-hosts";
+	const char *map_name = default_map_name;
+	const char *type;
 	char mountpoint[PATH_MAX];
 
 	if (ops->version && ap->flags & MOUNT_FLAG_REMOUNT) {
@@ -739,13 +741,7 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me, const char *
 	      mp->options, mountpoint);
 
 	type = ap->entry->maps->type;
-	if (type && !strcmp(ap->entry->maps->type, "hosts")) {
-		char *tmp = alloca(7);
-		if (tmp) {
-			strcpy(tmp, "-hosts");
-			map_name = (const char *) tmp;
-		}
-	} else
+	if (!type || strcmp(ap->entry->maps->type, "hosts"))
 		map_name = me->mc->map->argv[0];
 
 	ret = mount(map_name, mountpoint, "autofs", MS_MGC_VAL, mp->options);
diff --git a/daemon/flag.c b/daemon/flag.c
index e43cece..26dda95 100644
--- a/daemon/flag.c
+++ b/daemon/flag.c
@@ -23,10 +23,10 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <string.h>
-#include <alloca.h>
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
+#include <limits.h>
 
 #include "automount.h"
 
@@ -113,12 +113,12 @@ void release_flag_file(void)
 /* * Try to create flag file */
 int aquire_flag_file(void)
 {
-	char *linkf;
-	int len;
+	char linkf[PATH_MAX];
 
-	len = strlen(FLAG_FILE) + MAX_PIDSIZE;
-	linkf = alloca(len + 1);
-	snprintf(linkf, len, "%s.%d", FLAG_FILE, getpid());
+	if (snprintf(linkf, sizeof(linkf), "%s.%d", FLAG_FILE, getpid()) >=
+	    sizeof(linkf))
+		/* Didn't acquire it */
+		return 0;
 
 	/*
 	 * Repeat until it was us who made the link or we find the
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 9d3745c..f4170cc 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -89,7 +89,9 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 	struct ioctl_ops *ops = get_ioctl_ops();
 	time_t timeout = ap->exp_timeout;
 	char *options = NULL;
-	const char *type, *map_name = NULL;
+	const char *default_map_name = "-hosts";
+	const char *map_name = default_map_name;
+	const char *type;
 	struct stat st;
 	struct mnt_list *mnts;
 	int ret;
@@ -141,13 +143,7 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 	}
 
 	type = ap->entry->maps->type;
-	if (type && !strcmp(ap->entry->maps->type, "hosts")) {
-		char *tmp = alloca(7);
-		if (tmp) {
-			strcpy(tmp, "-hosts");
-			map_name = (const char *) tmp;
-		}
-	} else
+	if (!type || strcmp(ap->entry->maps->type, "hosts"))
 		map_name = ap->entry->maps->argv[0];
 
 	ret = mount(map_name, root, "autofs", MS_MGC_VAL, options);
diff --git a/daemon/module.c b/daemon/module.c
index e593d75..013b561 100644
--- a/daemon/module.c
+++ b/daemon/module.c
@@ -58,15 +58,10 @@ struct lookup_mod *open_lookup(const char *name, const char *err_prefix,
 {
 	struct lookup_mod *mod;
 	char buf[MAX_ERR_BUF];
-	char *fnbuf;
-	size_t size_name;
-	size_t size_fnbuf;
+	char fnbuf[PATH_MAX];
 	void *dh;
 	int *ver;
 
-	size_name = _strlen(name, PATH_MAX + 1);
-	if (!size_name)
-		return NULL;
 
 	mod = malloc(sizeof(struct lookup_mod));
 	if (!mod) {
@@ -77,9 +72,9 @@ struct lookup_mod *open_lookup(const char *name, const char *err_prefix,
 		return NULL;
 	}
 
-	size_fnbuf = size_name + strlen(AUTOFS_LIB_DIR) + 13;
-	fnbuf = alloca(size_fnbuf);
-	if (!fnbuf) {
+	if (snprintf(fnbuf,
+		     sizeof(fnbuf), "%s/lookup_%s.so", AUTOFS_LIB_DIR, name) >=
+	    sizeof(fnbuf)) {
 		free(mod);
 		if (err_prefix) {
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
@@ -87,7 +82,6 @@ struct lookup_mod *open_lookup(const char *name, const char *err_prefix,
 		}
 		return NULL;
 	}
-	snprintf(fnbuf, size_fnbuf, "%s/lookup_%s.so", AUTOFS_LIB_DIR, name);
 
 	if (!(dh = dlopen(fnbuf, RTLD_NOW))) {
 		if (err_prefix)
@@ -141,15 +135,10 @@ struct parse_mod *open_parse(const char *name, const char *err_prefix,
 {
 	struct parse_mod *mod;
 	char buf[MAX_ERR_BUF];
-	char *fnbuf;
-	size_t size_name;
-	size_t size_fnbuf;
+	char fnbuf[PATH_MAX];
 	void *dh;
 	int *ver;
 
-	size_name = _strlen(name, PATH_MAX + 1);
-	if (!size_name)
-		return NULL;
 
 	mod = malloc(sizeof(struct parse_mod));
 	if (!mod) {
@@ -160,9 +149,9 @@ struct parse_mod *open_parse(const char *name, const char *err_prefix,
 		return NULL;
 	}
 
-	size_fnbuf = size_name + strlen(AUTOFS_LIB_DIR) + 13;
-	fnbuf = alloca(size_fnbuf);
-	if (!fnbuf) {
+	if (snprintf(fnbuf,
+		     sizeof(fnbuf), "%s/parse_%s.so", AUTOFS_LIB_DIR, name) >=
+	    sizeof(fnbuf)) {
 		free(mod);
 		if (err_prefix) {
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
@@ -170,7 +159,6 @@ struct parse_mod *open_parse(const char *name, const char *err_prefix,
 		}
 		return NULL;
 	}
-	snprintf(fnbuf, size_fnbuf, "%s/parse_%s.so", AUTOFS_LIB_DIR, name);
 
 	if (!(dh = dlopen(fnbuf, RTLD_NOW))) {
 		if (err_prefix)
@@ -222,15 +210,10 @@ struct mount_mod *open_mount(const char *name, const char *err_prefix)
 {
 	struct mount_mod *mod;
 	char buf[MAX_ERR_BUF];
-	char *fnbuf;
-	size_t size_name;
-	size_t size_fnbuf;
+	char fnbuf[PATH_MAX];
 	void *dh;
 	int *ver;
 
-	size_name = _strlen(name, PATH_MAX + 1);
-	if (!size_name)
-		return NULL;
 
 	mod = malloc(sizeof(struct mount_mod));
 	if (!mod) {
@@ -241,9 +224,9 @@ struct mount_mod *open_mount(const char *name, const char *err_prefix)
 		return NULL;
 	}
 
-	size_fnbuf = size_name + strlen(AUTOFS_LIB_DIR) + 13;
-	fnbuf = alloca(size_fnbuf);
-	if (!fnbuf) {
+	if (snprintf(fnbuf,
+		     sizeof(fnbuf), "%s/mount_%s.so", AUTOFS_LIB_DIR, name) >=
+	    sizeof(fnbuf)) {
 		free(mod);
 		if (err_prefix) {
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
@@ -251,7 +234,6 @@ struct mount_mod *open_mount(const char *name, const char *err_prefix)
 		}
 		return NULL;
 	}
-	snprintf(fnbuf, size_fnbuf, "%s/mount_%s.so", AUTOFS_LIB_DIR, name);
 
 	if (!(dh = dlopen(fnbuf, RTLD_NOW))) {
 		if (err_prefix)
diff --git a/lib/cache.c b/lib/cache.c
index edb3192..efd5a98 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -482,27 +482,22 @@ struct mapent *cache_lookup_offset(const char *prefix, const char *offset, int s
 {
 	struct list_head *p;
 	struct mapent *this;
-	int plen = strlen(prefix);
-	char *o_key;
+	/* Keys for direct maps may be as long as a path name */
+	char o_key[PATH_MAX];
+	/* Avoid "//" at the beginning of paths */
+	const char *print_prefix = strlen(prefix) > 1 ? prefix : "";
 
 	/* root offset duplicates "/" */
-	if (plen > 1) {
-		o_key = alloca(plen + strlen(offset) + 1);
-		strcpy(o_key, prefix);
-		strcat(o_key, offset);
-	} else {
-		o_key = alloca(strlen(offset) + 1);
-		strcpy(o_key, offset);
-	}
+	if (snprintf(o_key, sizeof(o_key), "%s%s", print_prefix, offset) >=
+	    sizeof(o_key))
+		return NULL;
 
 	list_for_each(p, head) {
 		this = list_entry(p, struct mapent, multi_list);
 		if (!strcmp(&this->key[start], o_key))
-			goto done;
+			return this;
 	}
-	this = NULL;
-done:
-	return this;
+	return NULL;
 }
 
 /* cache must be read locked by caller */
@@ -759,13 +754,8 @@ int cache_delete(struct mapent_cache *mc, const char *key)
 	struct mapent *me = NULL, *pred;
 	u_int32_t hashval = hash(key, mc->size);
 	int status, ret = CHE_OK;
-	char *this;
+	char this[PATH_MAX];
 
-	this = alloca(strlen(key) + 1);
-	if (!this) {
-		ret = CHE_FAIL;
-		goto done;
-	}
 	strcpy(this, key);
 
 	me = mc->hash[hashval];
diff --git a/lib/cat_path.c b/lib/cat_path.c
index 576b424..60669db 100644
--- a/lib/cat_path.c
+++ b/lib/cat_path.c
@@ -12,7 +12,6 @@
  *
  * ----------------------------------------------------------------------- */
 
-#include <alloca.h>
 #include <string.h>
 #include <limits.h>
 #include <ctype.h>
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 95b9f6f..e489586 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -389,8 +389,8 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	unsigned int logopt = master->logopt;
 	char *buffer;
 	int blen;
-	char *path;
-	char *ent;
+	char path[KEY_MAX_LEN + 1];
+	char ent[MAPENT_MAX_LEN + 1];
 	struct stat st;
 	FILE *f;
 	int fd;
@@ -406,20 +406,6 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		return NSS_STATUS_UNAVAIL;
 	}
 
-	path = alloca(KEY_MAX_LEN + 1);
-	if (!path) {
-		error(logopt,
-		      MODPREFIX "could not malloc storage for path");
-		return NSS_STATUS_UNAVAIL;
-	}
-
-	ent = alloca(MAPENT_MAX_LEN + 1);
-	if (!ent) {
-		error(logopt,
-		      MODPREFIX "could not malloc storage for mapent");
-		return NSS_STATUS_UNAVAIL;
-	}
-
 	f = open_fopen_r(ctxt->mapname);
 	if (!f) {
 		error(logopt,
@@ -640,8 +626,8 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct map_source *source;
 	struct mapent_cache *mc;
-	char *key;
-	char *mapent;
+	char key[KEY_MAX_LEN + 1];
+	char mapent[MAPENT_MAX_LEN + 1];
 	struct stat st;
 	FILE *f;
 	int fd;
@@ -663,20 +649,6 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		return NSS_STATUS_UNAVAIL;
 	}
 
-	key = alloca(KEY_MAX_LEN + 1);
-	if (!key) {
-		error(ap->logopt,
-		      MODPREFIX "could not malloc storage for key");
-		return NSS_STATUS_UNAVAIL;
-	}
-
-	mapent = alloca(MAPENT_MAX_LEN + 1);
-	if (!mapent) {
-		error(ap->logopt,
-		      MODPREFIX "could not malloc storage for mapent");
-		return NSS_STATUS_UNAVAIL;
-	}
-
 	f = open_fopen_r(ctxt->mapname);
 	if (!f) {
 		error(ap->logopt,
@@ -1015,7 +987,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char *mapent = NULL;
-	int mapent_len;
+	char mapent_buf[MAPENT_MAX_LEN + 1];
 	int status = 0;
 	int ret = 1;
 
@@ -1099,9 +1071,8 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && (me->source == source || *me->key == '/')) {
 		pthread_cleanup_push(cache_lock_cleanup, mc);
-		mapent_len = strlen(me->mapent);
-		mapent = alloca(mapent_len + 1);
-		strcpy(mapent, me->mapent);
+		strcpy(mapent_buf, me->mapent);
+		mapent = mapent_buf;
 		pthread_cleanup_pop(0);
 	}
 	cache_unlock(mc);
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 83e11a9..da575bd 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -296,10 +296,10 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 	if (ctxt->mapname)
 		l += strlen(key) + strlen(ctxt->mapname) + strlen("(&(=))");
 
-	query = alloca(l);
+	query = malloc(l);
 	if (query == NULL) {
 		char *estr = strerror_r(errno, buf, sizeof(buf));
-		crit(logopt, MODPREFIX "alloca: %s", estr);
+		crit(logopt, MODPREFIX "malloc: %s", estr);
 		return NSS_STATUS_UNAVAIL;
 	}
 
@@ -312,6 +312,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 		     key, (int) strlen(ctxt->mapname), ctxt->mapname) >= l) {
 			debug(logopt,
 			      MODPREFIX "error forming query string");
+			free(query);
 			return 0;
 		}
 		scope = LDAP_SCOPE_SUBTREE;
@@ -319,6 +320,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 		if (sprintf(query, "(objectclass=%s)", class) >= l) {
 			debug(logopt,
 			      MODPREFIX "error forming query string");
+			free(query);
 			return 0;
 		}
 		scope = LDAP_SCOPE_SUBTREE;
@@ -342,6 +344,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 			error(logopt,
 			      MODPREFIX "query failed for %s: %s",
 			      query, ldap_err2string(rv));
+			free(query);
 			return 0;
 		}
 
@@ -355,6 +358,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 			      MODPREFIX "query succeeded, no matches for %s",
 			      query);
 			ldap_msgfree(result);
+			free(query);
 			return 0;
 		}
 	} else {
@@ -397,10 +401,12 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 			ldap_msgfree(result);
 			error(logopt,
 			      MODPREFIX "failed to find query dn under search base dns");
+			free(query);
 			return 0;
 		}
 	}
 
+	free(query);
 	qdn = strdup(dn);
 	ldap_memfree(dn);
 	ldap_msgfree(result);
@@ -1172,7 +1178,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 			else {
 				char *estr;
 				estr = strerror_r(errno, buf, sizeof(buf));
-				logerr(MODPREFIX "malloc: %s", estr);
+				logerr(MODPREFIX "strdup: %s", estr);
 				if (ctxt->server)
 					free(ctxt->server);
 				return 0;
@@ -1432,23 +1438,26 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 
 	l = strlen("(objectclass=)") + strlen(class) + 1;
 
-	query = alloca(l);
+	query = malloc(l);
 	if (query == NULL) {
 		char *estr = strerror_r(errno, buf, sizeof(buf));
-		logerr(MODPREFIX "alloca: %s", estr);
+		logerr(MODPREFIX "malloc: %s", estr);
 		return NSS_STATUS_UNAVAIL;
 	}
 
 	if (sprintf(query, "(objectclass=%s)", class) >= l) {
 		error(logopt, MODPREFIX "error forming query string");
+		free(query);
 		return NSS_STATUS_UNAVAIL;
 	}
 	query[l] = '\0';
 
 	/* Initialize the LDAP context. */
 	ldap = do_reconnect(logopt, ctxt);
-	if (!ldap)
+	if (!ldap) {
+		free(query);
 		return NSS_STATUS_UNAVAIL;
+	}
 
 	/* Look around. */
 	debug(logopt,
@@ -1460,6 +1469,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		error(logopt, MODPREFIX "query failed for %s: %s",
 		      query, ldap_err2string(rv));
 		unbind_ldap_connection(logging, ldap, ctxt);
+		free(query);
 		return NSS_STATUS_NOTFOUND;
 	}
 
@@ -1470,6 +1480,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		      query);
 		ldap_msgfree(result);
 		unbind_ldap_connection(logging, ldap, ctxt);
+		free(query);
 		return NSS_STATUS_NOTFOUND;
 	} else
 		debug(logopt, MODPREFIX "examining entries");
@@ -1525,7 +1536,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		}
 
 		if (snprintf(parse_buf, sizeof(parse_buf), "%s %s",
-			     *keyValue, *values) > sizeof(parse_buf)) {
+			     *keyValue, *values) >= sizeof(parse_buf)) {
 			error(logopt, MODPREFIX "map entry too long");
 			ldap_value_free(values);
 			goto next;
@@ -1539,6 +1550,7 @@ next:
 	/* Clean up. */
 	ldap_msgfree(result);
 	unbind_ldap_connection(logopt, ldap, ctxt);
+	free(query);
 
 	return NSS_STATUS_SUCCESS;
 }
@@ -2165,7 +2177,7 @@ static int read_one_map(struct autofs_point *ap,
 	/* Build a query string. */
 	l = strlen("(objectclass=)") + strlen(class) + 1;
 
-	sp.query = alloca(l);
+	sp.query = malloc(l);
 	if (sp.query == NULL) {
 		char *estr = strerror_r(errno, buf, sizeof(buf));
 		logerr(MODPREFIX "malloc: %s", estr);
@@ -2174,14 +2186,17 @@ static int read_one_map(struct autofs_point *ap,
 
 	if (sprintf(sp.query, "(objectclass=%s)", class) >= l) {
 		error(ap->logopt, MODPREFIX "error forming query string");
+		free(sp.query);
 		return NSS_STATUS_UNAVAIL;
 	}
 	sp.query[l] = '\0';
 
 	/* Initialize the LDAP context. */
 	sp.ldap = do_reconnect(ap->logopt, ctxt);
-	if (!sp.ldap)
+	if (!sp.ldap) {
+		free(sp.query);
 		return NSS_STATUS_UNAVAIL;
+	}
 
 	/* Look around. */
 	debug(ap->logopt,
@@ -2206,6 +2221,7 @@ static int read_one_map(struct autofs_point *ap,
 		if (rv != LDAP_SUCCESS || !sp.result) {
 			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 			*result_ldap = rv;
+			free(sp.query);
 			return NSS_STATUS_UNAVAIL;
 		}
 
@@ -2214,6 +2230,7 @@ static int read_one_map(struct autofs_point *ap,
 			ldap_msgfree(sp.result);
 			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 			*result_ldap = rv;
+			free(sp.query);
 			return NSS_STATUS_NOTFOUND;
 		}
 		ldap_msgfree(sp.result);
@@ -2224,6 +2241,7 @@ static int read_one_map(struct autofs_point *ap,
 	unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 
 	source->age = age;
+	free(sp.query);
 
 	return NSS_STATUS_SUCCESS;
 }
@@ -2319,7 +2337,7 @@ static int lookup_one(struct autofs_point *ap,
 	if (enc_len1)
 		l += 2*strlen(entry) + enc_len1 + enc_len2 + 6;
 
-	query = alloca(l);
+	query = malloc(l);
 	if (query == NULL) {
 		char *estr = strerror_r(errno, buf, sizeof(buf));
 		crit(ap->logopt, MODPREFIX "malloc: %s", estr);
@@ -2327,6 +2345,7 @@ static int lookup_one(struct autofs_point *ap,
 			free(enc_key1);
 			free(enc_key2);
 		}
+		free(query);
 		return CHE_FAIL;
 	}
 
@@ -2358,14 +2377,17 @@ static int lookup_one(struct autofs_point *ap,
 	if (ql >= l) {
 		error(ap->logopt,
 		      MODPREFIX "error forming query string");
+		free(query);
 		return CHE_FAIL;
 	}
 	query[ql] = '\0';
 
 	/* Initialize the LDAP context. */
 	ldap = do_reconnect(ap->logopt, ctxt);
-	if (!ldap)
+	if (!ldap) {
+		free(query);
 		return CHE_UNAVAIL;
+	}
 
 	debug(ap->logopt,
 	      MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->qdn);
@@ -2375,6 +2397,7 @@ static int lookup_one(struct autofs_point *ap,
 	if ((rv != LDAP_SUCCESS) || !result) {
 		crit(ap->logopt, MODPREFIX "query failed for %s", query);
 		unbind_ldap_connection(ap->logopt, ldap, ctxt);
+		free(query);
 		return CHE_FAIL;
 	}
 
@@ -2387,6 +2410,7 @@ static int lookup_one(struct autofs_point *ap,
 		     MODPREFIX "got answer, but no entry for %s", query);
 		ldap_msgfree(result);
 		unbind_ldap_connection(ap->logopt, ldap, ctxt);
+		free(query);
 		return CHE_MISSING;
 	}
 
@@ -2601,6 +2625,7 @@ next:
 		}
 	}
 	pthread_cleanup_pop(1);
+	free(query);
 
 	return ret;
 }
@@ -2687,7 +2712,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char *mapent = NULL;
-	int mapent_len;
+	char mapent_buf[MAPENT_MAX_LEN + 1];
 	int status = 0;
 	int ret = 1;
 
@@ -2757,38 +2782,36 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			me = cache_lookup_distinct(mc, "*");
 	}
 	if (me && (me->source == source || *me->key == '/')) {
-		mapent_len = strlen(me->mapent);
-		mapent = alloca(mapent_len + 1);
-		strcpy(mapent, me->mapent);
+		strcpy(mapent_buf, me->mapent);
+		mapent = mapent_buf;
 	}
 	cache_unlock(mc);
 
-	if (mapent) {
-		master_source_current_wait(ap->entry);
-		ap->entry->current = source;
+	if (!mapent)
+		return NSS_STATUS_TRYAGAIN;
 
-		debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
-		ret = ctxt->parse->parse_mount(ap, key, key_len,
-					 mapent, ctxt->parse->context);
-		if (ret) {
-			time_t now = time(NULL);
-			int rv = CHE_OK;
+	master_source_current_wait(ap->entry);
+	ap->entry->current = source;
 
-			/* Record the the mount fail in the cache */
-			cache_writelock(mc);
+	debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
+	ret = ctxt->parse->parse_mount(ap, key, key_len,
+				       mapent, ctxt->parse->context);
+	if (ret) {
+		time_t now = time(NULL);
+		int rv = CHE_OK;
+
+		/* Record the the mount fail in the cache */
+		cache_writelock(mc);
+		me = cache_lookup_distinct(mc, key);
+		if (!me)
+			rv = cache_update(mc, source, key, NULL, now);
+		if (rv != CHE_FAIL) {
 			me = cache_lookup_distinct(mc, key);
-			if (!me)
-				rv = cache_update(mc, source, key, NULL, now);
-			if (rv != CHE_FAIL) {
-				me = cache_lookup_distinct(mc, key);
-				me->status = now + ap->negative_timeout;
-			}
-			cache_unlock(mc);
+			me->status = now + ap->negative_timeout;
 		}
-	}
-
-	if (ret)
+		cache_unlock(mc);
 		return NSS_STATUS_TRYAGAIN;
+	}
 
 	return NSS_STATUS_SUCCESS;
 }
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index 4c3ce60..7b03f49 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -92,10 +92,10 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	int cur_state, len;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
+		logerr(MODPREFIX "malloc: %s", estr);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -107,6 +107,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		nis_freeresult(result);
 		crit(logopt,
 		     MODPREFIX "couldn't locate nis+ table %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_NOTFOUND;
 	}
@@ -118,6 +119,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		nis_freeresult(result);
 		crit(logopt,
 		     MODPREFIX "couldn't enumrate nis+ map %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -155,6 +157,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	}
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return NSS_STATUS_SUCCESS;
@@ -180,10 +183,10 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
+		logerr(MODPREFIX "malloc: %s", estr);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -195,6 +198,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		nis_freeresult(result);
 		crit(ap->logopt,
 		     MODPREFIX "couldn't locate nis+ table %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_NOTFOUND;
 	}
@@ -206,6 +210,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		nis_freeresult(result);
 		crit(ap->logopt,
 		     MODPREFIX "couldn't enumrate nis+ map %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -245,6 +250,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 
 	source->age = age;
 
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return NSS_STATUS_SUCCESS;
@@ -271,11 +277,11 @@ static int lookup_one(struct autofs_point *ap,
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(key) +
-			strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(key) + strlen(ctxt->mapname) +
+			   strlen(ctxt->domainname) + 20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
+		logerr(MODPREFIX "malloc: %s", estr);
 		pthread_setcancelstate(cur_state, NULL);
 		return -1;
 	}
@@ -286,6 +292,7 @@ static int lookup_one(struct autofs_point *ap,
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
 		nis_error rs = result->status;
 		nis_freeresult(result);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		if (rs == NIS_NOTFOUND ||
 		    rs == NIS_S_NOTFOUND ||
@@ -303,6 +310,7 @@ static int lookup_one(struct autofs_point *ap,
 	cache_unlock(mc);
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return ret;
@@ -327,10 +335,11 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(ctxt->mapname) + strlen(ctxt->domainname) +
+			   20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
+		logerr(MODPREFIX "malloc: %s", estr);
 		pthread_setcancelstate(cur_state, NULL);
 		return -1;
 	}
@@ -341,6 +350,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
 		nis_error rs = result->status;
 		nis_freeresult(result);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		if (rs == NIS_NOTFOUND ||
 		    rs == NIS_S_NOTFOUND ||
@@ -357,6 +367,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	cache_unlock(mc);
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return ret;
@@ -546,7 +557,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && (me->source == source || *me->key == '/')) {
 		mapent_len = strlen(me->mapent);
-		mapent = alloca(mapent_len + 1);
+		mapent = malloc(mapent_len + 1);
 		strcpy(mapent, me->mapent);
 	}
 	cache_unlock(mc);
@@ -572,6 +583,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			}
 			cache_unlock(mc);
 		}
+		free(mapent);
 	}
 
 	if (ret)
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 82a5ef3..182da4e 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -18,7 +18,6 @@
 #include <malloc.h>
 #include <string.h>
 #include <signal.h>
-#include <alloca.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 361f0c2..b8ef581 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -69,7 +69,7 @@ out:
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int i, len;
@@ -80,14 +80,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	/* Root offset of multi-mount */
 	len = strlen(root);
 	if (root[len - 1] == '/') {
-		fullpath = alloca(len);
 		len = snprintf(fullpath, len, "%s", root);
 	/* Direct mount name is absolute path so don't use root */
 	} else if (*name == '/') {
-		fullpath = alloca(len + 1);
 		len = sprintf(fullpath, "%s", root);
 	} else {
-		fullpath = alloca(len + name_len + 2);
 		len = sprintf(fullpath, "%s/%s", root, name);
 	}
 	fullpath[len] = '\0';
@@ -141,7 +138,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		}
 	} else {
 		char *cp;
-		char *basepath = alloca(strlen(fullpath) + 1);
+		char basepath[PATH_MAX];
 		int status;
 		struct stat st;
 
diff --git a/modules/mount_changer.c b/modules/mount_changer.c
index 92bb72b..024d244 100644
--- a/modules/mount_changer.c
+++ b/modules/mount_changer.c
@@ -44,7 +44,7 @@ int mount_init(void **context)
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int len, status, existed = 1;
@@ -57,14 +57,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	/* Root offset of multi-mount */
 	len = strlen(root);
 	if (root[len - 1] == '/') {
-		fullpath = alloca(len);
 		len = snprintf(fullpath, len, "%s", root);
 	/* Direct mount name is absolute path so don't use root */
 	} else if (*name == '/') {
-		fullpath = alloca(len + 1);
 		len = sprintf(fullpath, "%s", root);
 	} else {
-		fullpath = alloca(len + name_len + 2);
 		len = sprintf(fullpath, "%s/%s", root, name);
 	}
 	fullpath[len] = '\0';
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index 192ec04..85329ab 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -36,7 +36,7 @@ int mount_init(void **context)
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	const char *p, *p1;
 	int err, ro = 0;
@@ -49,14 +49,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	/* Root offset of multi-mount */
 	len = strlen(root);
 	if (root[len - 1] == '/') {
-		fullpath = alloca(len);
 		len = snprintf(fullpath, len, "%s", root);
 	/* Direct mount name is absolute path so don't use root */
 	} else if (*name == '/') {
-		fullpath = alloca(len + 1);
 		len = sprintf(fullpath, "%s", root);
 	} else {
-		fullpath = alloca(len + name_len + 2);
 		len = sprintf(fullpath, "%s/%s", root, name);
 	}
 	fullpath[len] = '\0';
diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index 6d7b4b3..1dc1bfd 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -37,7 +37,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		const char *what, const char *fstype, const char *options,
 		void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int len, status, existed = 1;
@@ -48,14 +48,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	/* Root offset of multi-mount */
 	len = strlen(root);
 	if (root[len - 1] == '/') {
-		fullpath = alloca(len);
 		len = snprintf(fullpath, len, "%s", root);
 	/* Direct mount name is absolute path so don't use root */
 	} else if (*name == '/') {
-		fullpath = alloca(len + 1);
 		len = sprintf(fullpath, "%s", root);
 	} else {
-		fullpath = alloca(len + name_len + 2);
 		len = sprintf(fullpath, "%s/%s", root, name);
 	}
 	fullpath[len] = '\0';
-- 
1.6.0.3
