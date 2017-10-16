From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/35] autofs-5.1.3 - fix possible map instance memory leak
Date: Mon, 16 Oct 2017 13:08:01 +0800
Message-ID: <150813048131.25695.8698015440611658720.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When using a temporary map unconditionally updating the original map
instance pointer will lead to a memory leak when the instance pointer
is already set (among other problems).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 daemon/lookup.c |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1b5c69ee..fab5ed49 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -18,6 +18,7 @@ xx/xx/2017 autofs-5.1.4
 - add some more debug logging to get_supported_ver_and_cost().
 - fix ipv6 proto option handling.
 - also check flag file exe name.
+- fix possible map instance memory leak.
 
 24/05/2017 autofs-5.1.3
 =======================
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
