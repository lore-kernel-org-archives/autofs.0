From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs-5.1.3 - check map instances for staleness on map
 update
Date: Mon, 21 Aug 2017 13:37:55 +0800
Message-ID: <150329387529.7451.9189302319085848477.stgit@pluto.themaw.net>
References: <150329377379.7451.10096062127149809722.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150329377379.7451.10096062127149809722.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Omar Sandoval <osandov@osandov.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Jeff Mahoney <jeffm@suse.com>

When there are multiple map source instances bypassing the cache update
when any one of the map sources returns NSS_STATUS_UNAVAIL is too strong.

When the map is marked not stale also check the instances before skipping
the cache update.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 daemon/lookup.c  |    5 +++--
 daemon/state.c   |    2 +-
 include/master.h |    1 +
 lib/master.c     |    2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/daemon/lookup.c b/daemon/lookup.c
index 569fffaf..cb67e7d9 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -633,7 +633,8 @@ int lookup_nss_read_map(struct autofs_point *ap, struct map_source *source, time
 			if (result == NSS_STATUS_UNKNOWN)
 				continue;
 
-			/* Don't try to update the map cache if it's unavailable */
+			/* Try to avoid updating the map cache if an instance
+			 * is unavailable */
 			if (result == NSS_STATUS_UNAVAIL)
 				map->stale = 0;
 
@@ -1453,7 +1454,7 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 	map = entry->maps;
 	while (map) {
 		/* Is the map stale */
-		if (!map->stale) {
+		if (!map->stale && !check_stale_instances(map)) {
 			map = map->next;
 			continue;
 		}
diff --git a/daemon/state.c b/daemon/state.c
index cd0dd939..72bba6af 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -512,7 +512,7 @@ static void *do_readmap(void *arg)
 		map = ap->entry->maps;
 		while (map) {
 			/* Is map source up to date or no longer valid */
-			if (!map->stale) {
+			if (!map->stale && !check_stale_instances(map)) {
 				map = map->next;
 				continue;
 			}
diff --git a/include/master.h b/include/master.h
index 087ddbe6..e1d272fb 100644
--- a/include/master.h
+++ b/include/master.h
@@ -97,6 +97,7 @@ struct map_source *
 master_find_source_instance(struct map_source *, const char *, const char *, int, const char **);
 struct map_source *
 master_add_source_instance(struct map_source *, const char *, const char *, time_t, int, const char **);
+int check_stale_instances(struct map_source *);
 void clear_stale_instances(struct map_source *);
 void send_map_update_request(struct autofs_point *);
 void master_source_writelock(struct master_mapent *);
diff --git a/lib/master.c b/lib/master.c
index 142f97ed..22b1522a 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -521,7 +521,7 @@ master_add_source_instance(struct map_source *source, const char *type, const ch
 	return new;
 }
 
-static int check_stale_instances(struct map_source *source)
+int check_stale_instances(struct map_source *source)
 {
 	struct map_source *map;
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
