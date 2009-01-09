From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [PATCH 3/4] Easy alloca() replacements
Date: Fri,  9 Jan 2009 13:47:02 -0500
Message-ID: <1231526823-18595-4-git-send-email-vaurora@redhat.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231526823-18595-3-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231526823-18595-3-git-send-email-vaurora@redhat.com>
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


Signed-off-by: Valerie Aurora Henson <vaurora@redhat.com>
---
 daemon/automount.c       |    6 +++---
 daemon/direct.c          |    8 +++-----
 daemon/flag.c            |   12 ++++++------
 daemon/indirect.c        |    8 +++-----
 daemon/module.c          |   42 ++++++++++++------------------------------
 lib/cache.c              |   20 ++++++--------------
 lib/cat_path.c           |    1 -
 modules/lookup_nisplus.c |   22 +++++++++++++++++-----
 modules/mount_autofs.c   |    1 -
 modules/mount_bind.c     |    7 ++-----
 modules/mount_changer.c  |    5 +----
 modules/mount_ext2.c     |    5 +----
 modules/mount_generic.c  |    5 +----
 13 files changed, 55 insertions(+), 87 deletions(-)

diff --git a/daemon/automount.c b/daemon/automount.c
index 6f078c1..61bbc80 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -124,8 +124,8 @@ static int do_mkdir(const char *parent, const char *path, mode_t mode)
 
 int mkdir_path(const char *path, mode_t mode)
 {
-	char *buf = alloca(strlen(path) + 1);
-	char *parent = alloca(strlen(path) + 1);
+	char buf[PATH_MAX];
+	char parent[PATH_MAX];
 	const char *cp = path, *lcp = path;
 	char *bp = buf, *pp = parent;
 
@@ -160,7 +160,7 @@ int mkdir_path(const char *path, mode_t mode)
 int rmdir_path(struct autofs_point *ap, const char *path, dev_t dev)
 {
 	int len = strlen(path);
-	char *buf = alloca(len + 1);
+	char buf[PATH_MAX];
 	char *cp;
 	int first = 1;
 	struct stat st;
diff --git a/daemon/direct.c b/daemon/direct.c
index 98fcc07..94216ba 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -742,11 +742,9 @@ int mount_autofs_offset(struct autofs_point *ap, struct mapent *me, const char *
 
 	type = ap->entry->maps->type;
 	if (type && !strcmp(ap->entry->maps->type, "hosts")) {
-		char *tmp = alloca(7);
-		if (tmp) {
-			strcpy(tmp, "-hosts");
-			map_name = (const char *) tmp;
-		}
+		char tmp[7];
+		strcpy(tmp, "-hosts");
+		map_name = (const char *) tmp;
 	} else
 		map_name = me->mc->map->argv[0];
 
diff --git a/daemon/flag.c b/daemon/flag.c
index d8ca61b..5c4f0c2 100644
--- a/daemon/flag.c
+++ b/daemon/flag.c
@@ -25,10 +25,10 @@
 #include <time.h>
 #include <unistd.h>
 #include <string.h>
-#include <alloca.h>
 #include <stdio.h>
 #include <signal.h>
 #include <errno.h>
+#include <limits.h>
 
 #define MAX_PIDSIZE	20
 #define FLAG_FILE	AUTOFS_FLAG_DIR "/autofs-running"
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
+	if (snprintf(linkf, sizeof(linkf), "%s.%d", FLAG_FILE, getpid()) >
+	    sizeof(linkf))
+		/* Didn't acquire it */
+		return 0;
 
 	/*
 	 * Repeat until it was us who made the link or we find the
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 1232810..31713fd 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -144,11 +144,9 @@ static int do_mount_autofs_indirect(struct autofs_point *ap, const char *root)
 
 	type = ap->entry->maps->type;
 	if (type && !strcmp(ap->entry->maps->type, "hosts")) {
-		char *tmp = alloca(7);
-		if (tmp) {
-			strcpy(tmp, "-hosts");
-			map_name = (const char *) tmp;
-		}
+		char tmp[7];
+		strcpy(tmp, "-hosts");
+		map_name = (const char *) tmp;
 	} else
 		map_name = ap->entry->maps->argv[0];
 
diff --git a/daemon/module.c b/daemon/module.c
index 36eca00..06b39c9 100644
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
+		     sizeof(fnbuf), "%s/lookup_%s.so", AUTOFS_LIB_DIR, name) >
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
+		     sizeof(fnbuf), "%s/parse_%s.so", AUTOFS_LIB_DIR, name) >
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
+		    sizeof(fnbuf), "%s/mount_%s.so", AUTOFS_LIB_DIR, name) >
+	   sizeof(fnbuf)) {
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
index 36b8294..bc2c722 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -484,27 +484,19 @@ struct mapent *cache_lookup_offset(const char *prefix, const char *offset, int s
 {
 	struct list_head *p;
 	struct mapent *this;
-	int plen = strlen(prefix);
-	char *o_key;
+	char o_key[KEY_MAX_LEN];
 
 	/* root offset duplicates "/" */
-	if (plen > 1) {
-		o_key = alloca(plen + strlen(offset) + 1);
-		strcpy(o_key, prefix);
-		strcat(o_key, offset);
-	} else {
-		o_key = alloca(strlen(offset) + 1);
-		strcpy(o_key, offset);
-	}
+	if (snprintf(o_key, sizeof(o_key), "%s%s", prefix, offset) >
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
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index f15465f..279a8d6 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -93,7 +93,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	int cur_state, len;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 		logerr(MODPREFIX "alloca: %s", estr);
@@ -108,6 +108,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		nis_freeresult(result);
 		crit(logopt,
 		     MODPREFIX "couldn't locate nis+ table %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_NOTFOUND;
 	}
@@ -119,6 +120,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 		nis_freeresult(result);
 		crit(logopt,
 		     MODPREFIX "couldn't enumrate nis+ map %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -156,6 +158,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	}
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return NSS_STATUS_SUCCESS;
@@ -181,7 +184,8 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) +
+			   20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 		logerr(MODPREFIX "alloca: %s", estr);
@@ -196,6 +200,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		nis_freeresult(result);
 		crit(ap->logopt,
 		     MODPREFIX "couldn't locate nis+ table %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_NOTFOUND;
 	}
@@ -207,6 +212,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 		nis_freeresult(result);
 		crit(ap->logopt,
 		     MODPREFIX "couldn't enumrate nis+ map %s", ctxt->mapname);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -246,6 +252,7 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 
 	source->age = age;
 
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return NSS_STATUS_SUCCESS;
@@ -272,8 +279,8 @@ static int lookup_one(struct autofs_point *ap,
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(key) +
-			strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(key) + strlen(ctxt->mapname) +
+			   strlen(ctxt->domainname) + 20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 		logerr(MODPREFIX "alloca: %s", estr);
@@ -287,6 +294,7 @@ static int lookup_one(struct autofs_point *ap,
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
 		nis_error rs = result->status;
 		nis_freeresult(result);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		if (rs == NIS_NOTFOUND ||
 		    rs == NIS_S_NOTFOUND ||
@@ -304,6 +312,7 @@ static int lookup_one(struct autofs_point *ap,
 	cache_unlock(mc);
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return ret;
@@ -328,7 +337,8 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	mc = source->mc;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	tablename = alloca(strlen(ctxt->mapname) + strlen(ctxt->domainname) + 20);
+	tablename = malloc(strlen(ctxt->mapname) + strlen(ctxt->domainname) +
+			   20);
 	if (!tablename) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 		logerr(MODPREFIX "alloca: %s", estr);
@@ -342,6 +352,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	if (result->status != NIS_SUCCESS && result->status != NIS_S_SUCCESS) {
 		nis_error rs = result->status;
 		nis_freeresult(result);
+		free(tablename);
 		pthread_setcancelstate(cur_state, NULL);
 		if (rs == NIS_NOTFOUND ||
 		    rs == NIS_S_NOTFOUND ||
@@ -358,6 +369,7 @@ static int lookup_wild(struct autofs_point *ap, struct lookup_context *ctxt)
 	cache_unlock(mc);
 
 	nis_freeresult(result);
+	free(tablename);
 	pthread_setcancelstate(cur_state, NULL);
 
 	return ret;
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index eb63d8e..effa4fc 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -20,7 +20,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <signal.h>
-#include <alloca.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 022d183..3ec467d 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -71,7 +71,7 @@ out:
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int i, len;
@@ -82,14 +82,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
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
@@ -143,7 +140,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		}
 	} else {
 		char *cp;
-		char *basepath = alloca(strlen(fullpath) + 1);
+		char basepath[PATH_MAX];
 		int status;
 		struct stat st;
 
diff --git a/modules/mount_changer.c b/modules/mount_changer.c
index 43b8355..bf77a98 100644
--- a/modules/mount_changer.c
+++ b/modules/mount_changer.c
@@ -46,7 +46,7 @@ int mount_init(void **context)
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int len, status, existed = 1;
@@ -59,14 +59,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
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
index 4c5b271..a80ccba 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -38,7 +38,7 @@ int mount_init(void **context)
 int mount_mount(struct autofs_point *ap, const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options, void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	const char *p, *p1;
 	int err, ro = 0;
@@ -51,14 +51,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
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
index f094d07..17ebfd4 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -39,7 +39,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		const char *what, const char *fstype, const char *options,
 		void *context)
 {
-	char *fullpath;
+	char fullpath[PATH_MAX];
 	char buf[MAX_ERR_BUF];
 	int err;
 	int len, status, existed = 1;
@@ -50,14 +50,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
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
1.6.0.4
