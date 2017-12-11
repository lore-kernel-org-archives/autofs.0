From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/27] autofs-5.1.3 - improve debug logging of lookup key
Date: Mon, 11 Dec 2017 16:58:32 +0800
Message-ID: <151298271269.19722.9241549135816843990.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

When looking up an amd format map key, if there is a prefix it
will be used in matching the map key.

So print the actual matched key string in debug log output.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG                |    1 +
 modules/lookup_file.c    |   14 ++++++++++----
 modules/lookup_hesiod.c  |   20 +++++++++++++++++---
 modules/lookup_ldap.c    |   15 ++++++++++++---
 modules/lookup_nisplus.c |   15 ++++++++++++---
 modules/lookup_yp.c      |   43 +++++++++++++++++++++++++------------------
 6 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 65dd850e..bbeaa406 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -42,6 +42,7 @@ xx/xx/2017 autofs-5.1.4
 - fix open calls not using open_xxxx() calls.
 - move open_xxxx() functions to spawn.c.
 - serialize calls to open_xxxx() functions.
+- improve debug logging of lookup key.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index e2d248e0..ed5caa47 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -1285,18 +1285,24 @@ do_cache_lookup:
 		}
 	}
 	cache_unlock(mc);
-	free(lkp_key);
 
-	if (!me)
+	if (!me) {
+		free(lkp_key);
 		return NSS_STATUS_NOTFOUND;
+	}
 
-	if (!mapent)
+	if (!mapent) {
+		free(lkp_key);
 		return NSS_STATUS_TRYAGAIN;
+	}
+
+	debug(ap->logopt, MODPREFIX "%s -> %s", lkp_key, mapent);
+
+	free(lkp_key);
 
 	master_source_current_wait(ap->entry);
 	ap->entry->current = source;
 
-	debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 298ebc75..b3278d20 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -463,14 +463,28 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 
 	me = match_cached_key(ap, MODPREFIX, source, lkp_key);
-	free(lkp_key);
-	if (!me)
+
+	if (!me) {
+		free(lkp_key);
 		return NSS_STATUS_NOTFOUND;
+	}
 
-	if (!me->mapent)
+	if (!me->mapent) {
+		free(lkp_key);
 		return NSS_STATUS_UNAVAIL;
+	}
 
 	mapent = strdup(me->mapent);
+	if (!mapent) {
+		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		error(ap->logopt, "malloc: %s", estr);
+		free(lkp_key);
+		return NSS_STATUS_UNKNOWN;
+	}
+
+	debug(ap->logopt, MODPREFIX "%s -> %s", lkp_key, mapent);
+
+	free(lkp_key);
 
 	rv = ctxt->parser->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parser->context);
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 98701e5b..37810e1c 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -3785,15 +3785,24 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		}
 	}
 	cache_unlock(mc);
-	free(lkp_key);
 
-	if (!mapent)
+	if (!me) {
+		free(lkp_key);
+		return NSS_STATUS_NOTFOUND;
+	}
+
+	if (!mapent) {
+		free(lkp_key);
 		return NSS_STATUS_TRYAGAIN;
+	}
+
+	debug(ap->logopt, MODPREFIX "%s -> %s", lkp_key, mapent);
+
+	free(lkp_key);
 
 	master_source_current_wait(ap->entry);
 	ap->entry->current = source;
 
-	debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index 398e8931..8dee4630 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -824,15 +824,24 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		}
 	}
 	cache_unlock(mc);
-	free(lkp_key);
 
-	if (!mapent)
+	if (!me) {
+		free(lkp_key);
+		return NSS_STATUS_NOTFOUND;
+	}
+
+	if (!mapent) {
+		free(lkp_key);
 		return NSS_STATUS_TRYAGAIN;
+	}
+
+	debug(ap->logopt, MODPREFIX "%s -> %s", lkp_key, mapent);
+
+	free(lkp_key);
 
 	master_source_current_wait(ap->entry);
 	ap->entry->current = source;
 
-	debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index 9f186ac6..d1ffcae4 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -927,28 +927,35 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		}
 	}
 	cache_unlock(mc);
+
+	if (!me) {
+		free(lkp_key);
+		return NSS_STATUS_NOTFOUND;
+	}
+
+	if (!mapent) {
+		free(lkp_key);
+		return NSS_STATUS_TRYAGAIN;
+	}
+
+	debug(ap->logopt, MODPREFIX "%s -> %s", lkp_key, mapent);
+
 	free(lkp_key);
 
-	if (mapent) {
-		master_source_current_wait(ap->entry);
-		ap->entry->current = source;
-
-		debug(ap->logopt, MODPREFIX "%s -> %s", key, mapent);
-		ret = ctxt->parse->parse_mount(ap, key, key_len,
-					       mapent, ctxt->parse->context);
-		if (ret) {
-			/* Don't update negative cache when re-connecting */
-			if (ap->flags & MOUNT_FLAG_REMOUNT)
-				return NSS_STATUS_TRYAGAIN;
-			cache_writelock(mc);
-			cache_update_negative(mc, source, key, ap->negative_timeout);
-			cache_unlock(mc);
-			return NSS_STATUS_TRYAGAIN;
-		}
-	 }
+	master_source_current_wait(ap->entry);
+	ap->entry->current = source;
 
-	if (ret)
+	ret = ctxt->parse->parse_mount(ap, key, key_len,
+				       mapent, ctxt->parse->context);
+	if (ret) {
+		/* Don't update negative cache when re-connecting */
+		if (ap->flags & MOUNT_FLAG_REMOUNT)
+			return NSS_STATUS_TRYAGAIN;
+		cache_writelock(mc);
+		cache_update_negative(mc, source, key, ap->negative_timeout);
+		cache_unlock(mc);
 		return NSS_STATUS_TRYAGAIN;
+	}
 
 	return NSS_STATUS_SUCCESS;
 }

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
