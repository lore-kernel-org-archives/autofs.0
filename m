From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/4] autofs-5.0.4 - always read file maps
Date: Mon, 19 Jan 2009 21:24:38 +0900
Message-ID: <20090119122438.31454.99701.stgit@zeus.themaw.net>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090119121918.31454.61737.stgit@zeus.themaw.net>
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
To: Valerie Aurora Henson <vaurora@redhat.com>, Paul Wankadia <junyer@google.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

autofs tries to not load an entire map into the internal cache unless it
has to. For maps that do get loaded into the cache it relies on checks to
work out if a map is up to date in order to trigger a map read. This is
fine for maps that can do direct key lookups but file maps need to do a
linear search through the file when locating an entry for a key. For large
maps this can be a huge overhead. This patch make autofs always load file
based maps at start and makes use of the map file mtime to discover if the
cache needs to be refreshed.
---

 daemon/lookup.c       |    9 +++++--
 modules/lookup_file.c |   59 +++++++++++++++++--------------------------------
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/daemon/lookup.c b/daemon/lookup.c
index 741d846..e034348 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -283,10 +283,13 @@ static int do_read_map(struct autofs_point *ap, struct map_source *map, time_t a
 	 * for the fail cases to function correctly and to cache the
 	 * lookup handle.
 	 *
-	 * We always need to whole map for direct mounts in order to
-	 * mount the triggers.
+	 * We always need to read the whole map for direct mounts in
+	 * order to mount the triggers. We also want to read the whole
+	 * map if it's a file map to avoid potentially lengthy linear
+	 * file scanning.
 	 */
-	if (!(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT)
+	if (strcmp(map->type, "file") &&
+	    !(ap->flags & MOUNT_FLAG_GHOST) && ap->type != LKP_DIRECT)
 		return NSS_STATUS_SUCCESS;
 
 	if (!map->stale)
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 95b9f6f..7672725 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -44,7 +44,6 @@ typedef enum { esc_none, esc_char, esc_val, esc_all } ESCAPES;
 
 struct lookup_context {
 	const char *mapname;
-	time_t mtime;
 	struct parse_mod *parse;
 };
 
@@ -54,7 +53,6 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 {
 	struct lookup_context *ctxt;
 	char buf[MAX_ERR_BUF];
-	struct stat st;
 
 	*context = NULL;
 
@@ -87,15 +85,6 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 		return 1;
 	}
 
-	if (stat(ctxt->mapname, &st)) {
-		free(ctxt);
-		logmsg(MODPREFIX "file map %s, could not stat",
-		     argv[0]);
-		return 1;
-	}
-		
-	ctxt->mtime = st.st_mtime;
-
 	if (!mapfmt)
 		mapfmt = MAPFMT_DEFAULT;
 
@@ -391,7 +380,6 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	int blen;
 	char *path;
 	char *ent;
-	struct stat st;
 	FILE *f;
 	int fd;
 	unsigned int path_len, ent_len;
@@ -504,13 +492,6 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 			break;
 	}
 
-	if (fstat(fd, &st)) {
-		crit(logopt, MODPREFIX "file map %s, could not stat",
-		       ctxt->mapname);
-		return NSS_STATUS_UNAVAIL;
-	}
-	ctxt->mtime = st.st_mtime;
-
 	fclose(f);
 
 	return NSS_STATUS_SUCCESS;
@@ -642,7 +623,6 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 	struct mapent_cache *mc;
 	char *key;
 	char *mapent;
-	struct stat st;
 	FILE *f;
 	int fd;
 	unsigned int k_len, m_len;
@@ -748,13 +728,6 @@ int lookup_read_map(struct autofs_point *ap, time_t age, void *context)
 			break;
 	}
 
-	if (fstat(fd, &st)) {
-		crit(ap->logopt,
-		     MODPREFIX "file map %s, could not stat",
-		     ctxt->mapname);
-		return NSS_STATUS_UNAVAIL;
-	}
-	ctxt->mtime = st.st_mtime;
 	source->age = age;
 
 	fclose(f);
@@ -951,9 +924,6 @@ static int check_map_indirect(struct autofs_point *ap,
 	if (ret == CHE_FAIL)
 		return NSS_STATUS_NOTFOUND;
 
-	if (ret & CHE_UPDATED)
-		source->stale = 1;
-
 	pthread_cleanup_push(cache_lock_cleanup, mc);
 	cache_writelock(mc);
 	exists = cache_lookup_distinct(mc, key);
@@ -963,7 +933,6 @@ static int check_map_indirect(struct autofs_point *ap,
 			free(exists->mapent);
 			exists->mapent = NULL;
 			exists->status = 0;
-			source->stale = 1;
 		}
 	}
 	pthread_cleanup_pop(1);
@@ -985,14 +954,8 @@ static int check_map_indirect(struct autofs_point *ap,
 		we = cache_lookup_distinct(mc, "*");
 		if (we) {
 			/* Wildcard entry existed and is now gone */
-			if (we->source == source && (wild & CHE_MISSING)) {
+			if (we->source == source && (wild & CHE_MISSING))
 				cache_delete(mc, "*");
-				source->stale = 1;
-			}
-		} else {
-			/* Wildcard not in map but now is */
-			if (wild & (CHE_OK | CHE_UPDATED))
-				source->stale = 1;
 		}
 		pthread_cleanup_pop(1);
 
@@ -1062,9 +1025,28 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	 * we never know about it.
 	 */
 	if (ap->type == LKP_INDIRECT && *key != '/') {
+		struct stat st;
 		char *lkp_key;
 
+		/*
+		 * We can skip the map lookup and cache update altogether
+		 * if we know the map hasn't been modified since it was
+		 * last read. If it has then we can mark the map stale
+		 * so a re-read is triggered following the lookup.
+		 */
+		if (stat(ctxt->mapname, &st)) {
+			error(ap->logopt, MODPREFIX
+			      "file map %s, could not stat", ctxt->mapname);
+			return NSS_STATUS_UNAVAIL;
+		}
+
 		cache_readlock(mc);
+		me = cache_lookup_first(mc);
+		if (me && st.st_mtime <= me->age)
+			goto do_cache_lookup;
+		else
+			source->stale = 1;
+
 		me = cache_lookup_distinct(mc, key);
 		if (me && me->multi)
 			lkp_key = strdup(me->multi->key);
@@ -1088,6 +1070,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 
 	cache_readlock(mc);
+do_cache_lookup:
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
