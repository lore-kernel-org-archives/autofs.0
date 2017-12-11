From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/27] autofs-5.1.3 - fix amd defaults map entry handling
Date: Mon, 11 Dec 2017 16:59:01 +0800
Message-ID: <151298274152.19722.12674128615379093740.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When parsing an amd map entry the map entry defaults were not being
handled properly.

A "-" in the map entry requires a reset to defaults, which wasn't being
done.

A "-<map options>" in the map entry requires merging the <map options>
with the current defaults map entry, which was also not being done
properly.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 
 modules/parse_amd.c |  109 +++++++++++++++++++++++++++++++++------------------
 2 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9721f74e..c856f9cb 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -47,6 +47,7 @@ xx/xx/2017 autofs-5.1.4
 - add missing MODPREFIX to logging in amd parser.
 - fix symlink false negative in umount_multi().
 - remove expand_selectors() on amd parser entry.
+- fix amd defaults map entry handling.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 8741dd53..8030b271 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -1830,45 +1830,24 @@ out:
 	return make_default_entry(ap, sv);
 }
 
-int parse_mount(struct autofs_point *ap, const char *name,
-		int name_len, const char *mapent, void *context)
+static struct amd_entry *setup_defaults(struct autofs_point *ap,
+					const char *name, int name_len,
+					struct map_source *source,
+					struct substvar **sv)
 {
-	struct parse_context *ctxt = (struct parse_context *) context;
-	unsigned int flags = conf_amd_get_flags(ap->path);
-	struct substvar *sv = NULL;
-	struct map_source *source;
+	struct amd_entry *defaults_entry;
 	struct mapent_cache *mc;
 	struct mapent *me;
-	unsigned int at_least_one;
-	struct list_head entries, *p, *head;
-	struct amd_entry *defaults_entry;
-	struct amd_entry *cur_defaults;
+	struct substvar *nsv;
 	char *defaults;
-	int len, rv = 1;
-	int cur_state;
-	int ret;
-
-	source = ap->entry->current;
-	ap->entry->current = NULL;
-	master_source_current_signal(ap->entry);
 
 	mc = source->mc;
+	defaults = NULL;
+	defaults_entry = NULL;
 
-	if (!mapent) {
-		warn(ap->logopt, MODPREFIX "error: empty map entry");
-		return 1;
-	}
-
-	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-
-	sv = add_lookup_vars(ap, name, name_len, source, sv);
-	if (!sv) {
-		macro_free_table(sv);
-		pthread_setcancelstate(cur_state, NULL);
-		return 1;
-	}
-
-	pthread_setcancelstate(cur_state, NULL);
+	nsv = add_lookup_vars(ap, name, name_len, source, NULL);
+	if (!nsv)
+		goto done;
 
 	defaults = conf_amd_get_map_defaults(ap->path);
 	if (defaults) {
@@ -1883,22 +1862,63 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			char buf[MAX_ERR_BUF];
 			char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 			error(ap->logopt, MODPREFIX "malloc: %s", estr);
+			macro_free_table(nsv);
+			nsv = NULL;
+			goto done;
 		}
 	}
 
-	defaults_entry = get_defaults_entry(ap, defaults, sv);
+	defaults_entry = get_defaults_entry(ap, defaults, nsv);
 	if (!defaults_entry) {
 		error(ap->logopt, MODPREFIX "failed to get a defaults entry");
-		if (defaults)
-			free(defaults);
-		macro_free_table(sv);
-		return 1;
+		macro_free_table(nsv);
+		nsv = NULL;
 	}
+done:
 	if (defaults)
 		free(defaults);
+	if (*sv)
+		macro_free_table(*sv);
+	*sv = nsv;
+
+	return defaults_entry;
+}
+
+int parse_mount(struct autofs_point *ap, const char *name,
+		int name_len, const char *mapent, void *context)
+{
+	struct parse_context *ctxt = (struct parse_context *) context;
+	unsigned int flags = conf_amd_get_flags(ap->path);
+	struct substvar *sv = NULL;
+	struct map_source *source;
+	unsigned int at_least_one;
+	struct list_head entries, *p, *head;
+	struct amd_entry *defaults_entry;
+	struct amd_entry *cur_defaults;
+	int rv = 1;
+	int cur_state;
+	int ret;
+
+	source = ap->entry->current;
+	ap->entry->current = NULL;
+	master_source_current_signal(ap->entry);
+
+	if (!mapent) {
+		warn(ap->logopt, MODPREFIX "error: empty map entry");
+		return 1;
+	}
 
 	INIT_LIST_HEAD(&entries);
 
+	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
+
+	defaults_entry = setup_defaults(ap, name, name_len, source, &sv);
+	if (!defaults_entry) {
+		error(ap->logopt, MODPREFIX
+		      "failed to setup defaults entry");
+		goto done;
+	}
+
 	ret = amd_parse_list(ap, mapent, &entries, &sv);
 	if (ret) {
 		error(ap->logopt,
@@ -1929,9 +1949,20 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			free_amd_entry(cur_defaults);
 			list_del_init(&this->list);
 			cur_defaults = this;
+			update_with_defaults(defaults_entry, cur_defaults, sv);
 			continue;
 		} else if (this->flags & AMD_DEFAULTS_RESET) {
-			struct amd_entry *new;
+			struct amd_entry *nd, *new;
+			struct substvar *nsv = NULL;
+
+			nd = setup_defaults(ap, name, name_len, source, &nsv);
+			if (nd) {
+				free_amd_entry(defaults_entry);
+				defaults_entry = nd;
+				macro_free_table(sv);
+				sv = nsv;
+			}
+
 			new = dup_defaults_entry(defaults_entry);
 			if (new) {
 				free_amd_entry(cur_defaults);
@@ -1997,6 +2028,8 @@ done:
 	free_amd_entry(defaults_entry);
 	macro_free_table(sv);
 
+	pthread_setcancelstate(cur_state, NULL);
+
 	return rv;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
