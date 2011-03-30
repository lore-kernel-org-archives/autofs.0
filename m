From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs-5.0.5 - fix stale map read
Date: Wed, 30 Mar 2011 13:49:38 +0800
Message-ID: <20110330054938.22333.37733.stgit@localhost6.localdomain6>
References: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20110330054620.22333.45008.stgit@localhost6.localdomain6>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, "Philip Ong Jr." <pongjr@gmail.com>

A previous patch to fix direct maps not updating on re-read has
a side effect of causing maps to always be re-read on lookup.
This is because, following the application of the previous patch,
the map stale status is no longer being updated on a successful
map read.
---

 CHANGELOG        |    1 +
 daemon/lookup.c  |    1 +
 daemon/state.c   |    1 -
 include/master.h |    1 +
 lib/master.c     |   37 +++++++++++++++++++++++++------------
 5 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a9687b7..fcf9145 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -63,6 +63,7 @@
 - fix expire race.
 - replace GPLv3 code.
 - fix next task list update.
+- fix stale map read.
 
 03/09/2009 autofs-5.0.5
 -----------------------
diff --git a/daemon/lookup.c b/daemon/lookup.c
index 36e60c9..0f7051b 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -1139,6 +1139,7 @@ int lookup_prune_cache(struct autofs_point *ap, time_t age)
 		cache_readlock(map->mc);
 		lookup_prune_one_cache(ap, map->mc, age);
 		pthread_cleanup_pop(1);
+		clear_stale_instances(map);
 		map->stale = 0;
 		map = map->next;
 	}
diff --git a/daemon/state.c b/daemon/state.c
index 85587bd..3645440 100644
--- a/daemon/state.c
+++ b/daemon/state.c
@@ -501,7 +501,6 @@ static void *do_readmap(void *arg)
 		pthread_cleanup_pop(1);
 		pthread_cleanup_pop(1);
 		pthread_cleanup_pop(1);
-		lookup_prune_cache(ap, now);
 	}
 
 	pthread_cleanup_pop(1);
diff --git a/include/master.h b/include/master.h
index bef59d3..1c1a7d5 100644
--- a/include/master.h
+++ b/include/master.h
@@ -89,6 +89,7 @@ struct map_source *
 master_find_source_instance(struct map_source *, const char *, const char *, int, const char **);
 struct map_source *
 master_add_source_instance(struct map_source *, const char *, const char *, time_t, int, const char **);
+void clear_stale_instances(struct map_source *);
 void send_map_update_request(struct autofs_point *);
 void master_source_writelock(struct master_mapent *);
 void master_source_readlock(struct master_mapent *);
diff --git a/lib/master.c b/lib/master.c
index 95bd3fb..4b48883 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -465,7 +465,26 @@ master_add_source_instance(struct map_source *source, const char *type, const ch
 	return new;
 }
 
-static void check_stale_instances(struct map_source *source)
+static int check_stale_instances(struct map_source *source)
+{
+	struct map_source *map;
+
+	if (!source)
+		return 0;
+
+	map = source->instance;
+	while (map) {
+		if (map->stale)
+			return 1;
+		if (check_stale_instances(map))
+			return 1;
+		map = map->next;
+	}
+
+	return 0;
+}
+
+void clear_stale_instances(struct map_source *source)
 {
 	struct map_source *map;
 
@@ -474,11 +493,9 @@ static void check_stale_instances(struct map_source *source)
 
 	map = source->instance;
 	while (map) {
-		if (map->stale) {
-			source->stale = 1;
-			break;
-		}
-		check_stale_instances(map->instance);
+		clear_stale_instances(map);
+		if (map->stale)
+			map->stale = 0;
 		map = map->next;
 	}
 
@@ -496,12 +513,8 @@ void send_map_update_request(struct autofs_point *ap)
 
 	map = ap->entry->maps;
 	while (map) {
-		check_stale_instances(map);
-		map = map->next;
-	}
-
-	map = ap->entry->maps;
-	while (map) {
+		if (check_stale_instances(map))
+			map->stale = 1;
 		if (map->stale) {
 			need_update = 1;
 			break;
