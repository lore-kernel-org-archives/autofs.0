From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/27] autofs-5.1.3 - remove expand_selectors() call on amd
 parser entry
Date: Mon, 11 Dec 2017 16:58:55 +0800
Message-ID: <151298273578.19722.8674279908901688160.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Macro expansion within the amd parser has to be done during the mount
attempt loop, after any defaults are setup and also after any defaults
overrides from the map entry itself.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |   22 ++++++----------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index df87df49..9721f74e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -46,6 +46,7 @@ xx/xx/2017 autofs-5.1.4
 - fix typo in amd_parse.c.
 - add missing MODPREFIX to logging in amd parser.
 - fix symlink false negative in umount_multi().
+- remove expand_selectors() on amd parser entry.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index f2332b15..8741dd53 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1844,7 +1844,6 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	struct amd_entry *defaults_entry;
 	struct amd_entry *cur_defaults;
 	char *defaults;
-	char *pmapent;
 	int len, rv = 1;
 	int cur_state;
 	int ret;
@@ -1869,17 +1868,8 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		return 1;
 	}
 
-	len = expand_selectors(ap, mapent, &pmapent, sv);
-	if (!len) {
-		macro_free_table(sv);
-		pthread_setcancelstate(cur_state, NULL);
-		return 1;
-	}
-
 	pthread_setcancelstate(cur_state, NULL);
 
-	debug(ap->logopt, MODPREFIX "expanded mapent: %s", pmapent);
-
 	defaults = conf_amd_get_map_defaults(ap->path);
 	if (defaults) {
 		debug(ap->logopt, MODPREFIX
@@ -1901,7 +1891,6 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		error(ap->logopt, MODPREFIX "failed to get a defaults entry");
 		if (defaults)
 			free(defaults);
-		free(pmapent);
 		macro_free_table(sv);
 		return 1;
 	}
@@ -1910,16 +1899,13 @@ int parse_mount(struct autofs_point *ap, const char *name,
 
 	INIT_LIST_HEAD(&entries);
 
-	ret = amd_parse_list(ap, pmapent, &entries, &sv);
+	ret = amd_parse_list(ap, mapent, &entries, &sv);
 	if (ret) {
 		error(ap->logopt,
-		      MODPREFIX "failed to parse entry: %s", pmapent);
-		free(pmapent);
+		      MODPREFIX "failed to parse entry: %s", mapent);
 		goto done;
 	}
 
-	free(pmapent);
-
 	if (list_empty(&entries)) {
 		error(ap->logopt, MODPREFIX "no location found after parse");
 		goto done;
@@ -1956,6 +1942,9 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			continue;
 		}
 
+		debug(ap->logopt, "expand defaults entry");
+		sv = expand_entry(ap, cur_defaults, flags, sv);
+
 		if (this->flags & AMD_ENTRY_CUT && at_least_one) {
 			info(ap->logopt, MODPREFIX
 			     "at least one entry tried before cut selector, "
@@ -1968,6 +1957,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 
 		at_least_one = 1;
 
+		debug(ap->logopt, "expand mount entry");
 		update_with_defaults(cur_defaults, this, sv);
 		sv = expand_entry(ap, this, flags, sv);
 		sv = merge_entry_options(ap, this, sv);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
