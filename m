From: Ian Kent <raven@themaw.net>
Subject: [PATCH 21/35] autofs-5.1.3 - check map instances for staleness on
 map update
Date: Mon, 16 Oct 2017 13:08:07 +0800
Message-ID: <150813048720.25695.5008486650914175326.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When there are multiple map source instances bypassing the cache update
when any one of the map sources returns NSS_STATUS_UNAVAIL is too strong.

When the map is marked not stale also check the instances before skipping
the cache update.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 +
 daemon/lookup.c  |    5 +++--
 daemon/state.c   |    2 +-
 include/master.h |    1 +
 lib/master.c     |    2 +-
 5 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index fab5ed49..9815da29 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -19,6 +19,7 @@ xx/xx/2017 autofs-5.1.4
 - fix ipv6 proto option handling.
 - also check flag file exe name.
 - fix possible map instance memory leak.
+- check map instances for staleness on map update.
 
 24/05/2017 autofs-5.1.3
 =======================
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
