From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/4] Make hash table scale
	to	thousands	of	entries
Date: Fri, 16 Jan 2009 14:23:11 +0900
Message-ID: <1232083391.3166.76.camel@zeus.themaw.net>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231922825.3168.37.camel@zeus.themaw.net>
	<408431290901140252o2c8908d7h985a2682e161957c@mail.gmail.com>
	<1231939076.3168.53.camel@zeus.themaw.net>
	<408431290901140620k11a8cf7evb667895a59c7e204@mail.gmail.com>
	<1231983710.3100.38.camel@zeus.themaw.net>
	<x49vdsgvcdk.fsf@segfault.boston.devel.redhat.com>
	<1232032573.3100.53.camel@zeus.themaw.net>
	<408431290901151233q33699529r6119788c998866ed@mail.gmail.com>
	<x49d4eouwt6.fsf@segfault.boston.devel.redhat.com>
	<408431290901151257i70400351yc3ab9360136c8e9c@mail.gmail.com>
	<1232065653.3166.19.camel@zeus.themaw.net>
	<1232066406.3166.28.camel@zeus.themaw.net>
	<1232070195.3166.36.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232070195.3166.36.camel@zeus.themaw.net>
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
To: Paul Wankadia <junyer@google.com>
Cc: autofs@linux.kernel.org

On Fri, 2009-01-16 at 10:43 +0900, Ian Kent wrote:
> > > 
> > > I'm tending toward reading the map during the lookup so the map is up to
> > > date when we look for the key in the cache.
> 
> Or maybe not.
> 
> If we take advantage of the existing code to mark the map as stale and
> handle the re-read and we accept the overhead of scanning the file map
> while waiting for the update something like this could be all that's
> needed.

So here is a slightly updated patch.

autofs-5.0.4 - always read file maps

From: Ian Kent <raven@themaw.net>


---

 daemon/lookup.c       |    9 ++++++---
 modules/lookup_file.c |   26 ++++++++++++++------------
 2 files changed, 20 insertions(+), 15 deletions(-)


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
index 95b9f6f..6f426a5 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -93,7 +93,6 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 		     argv[0]);
 		return 1;
 	}
-		
 	ctxt->mtime = st.st_mtime;
 
 	if (!mapfmt)
@@ -951,9 +950,6 @@ static int check_map_indirect(struct autofs_point *ap,
 	if (ret == CHE_FAIL)
 		return NSS_STATUS_NOTFOUND;
 
-	if (ret & CHE_UPDATED)
-		source->stale = 1;
-
 	pthread_cleanup_push(cache_lock_cleanup, mc);
 	cache_writelock(mc);
 	exists = cache_lookup_distinct(mc, key);
@@ -963,7 +959,6 @@ static int check_map_indirect(struct autofs_point *ap,
 			free(exists->mapent);
 			exists->mapent = NULL;
 			exists->status = 0;
-			source->stale = 1;
 		}
 	}
 	pthread_cleanup_pop(1);
@@ -985,14 +980,8 @@ static int check_map_indirect(struct autofs_point *ap,
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
 
@@ -1064,7 +1053,19 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	if (ap->type == LKP_INDIRECT && *key != '/') {
 		char *lkp_key;
 
+		/*
+		 * We can skip the map lookup and cache update altogether
+		 * if we know the map hasn't been modified since it was
+		 * last read. If it has then we can mark the map stale
+		 * so a re-read is triggered following the lookup.
+		 */
 		cache_readlock(mc);
+		me = cache_lookup_first(mc);
+		if (me && ctxt->mtime <= me->age)
+			goto do_cache_lookup;
+		else
+			source->stale = 1;
+
 		me = cache_lookup_distinct(mc, key);
 		if (me && me->multi)
 			lkp_key = strdup(me->multi->key);
@@ -1088,6 +1089,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 
 	cache_readlock(mc);
+do_cache_lookup:
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
