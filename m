From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs-5.1.3 - fix possible map instance memory leak
Date: Mon, 21 Aug 2017 13:37:48 +0800
Message-ID: <150329386896.7451.1723445167211797570.stgit@pluto.themaw.net>
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

When using a temporary map unconditionally updating the original map
instance pointer will lead to a memory leak when the instance pointer
is already set (among other problems).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 daemon/lookup.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/daemon/lookup.c b/daemon/lookup.c
index 583d3d37..569fffaf 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -536,7 +536,8 @@ static enum nsswitch_status read_map_source(struct nss_source *this,
 	result = read_file_source_instance(ap, &tmap, age);
 	pthread_cleanup_pop(1);
 
-	map->instance = tmap.instance;
+	if (!map->instance)
+		map->instance = tmap.instance;
 
 	return result;
 }
@@ -1089,7 +1090,8 @@ static enum nsswitch_status lookup_map_name(struct nss_source *this,
 
 	result = lookup_name_file_source_instance(ap, &tmap, name, name_len);
 
-	map->instance = tmap.instance;
+	if (!map->instance)
+		map->instance = tmap.instance;
 
 	/* path is freed in free_argv */
 	free_argv(tmap.argc, tmap.argv);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
