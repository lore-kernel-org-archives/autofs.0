From: Ian Kent <raven@themaw.net>
Subject: [PATCH 21/25] autofs-5.0.7 - fix fix wildcard multi map regression
Date: Mon, 19 Aug 2013 09:14:16 +0800
Message-ID: <20130819011415.6472.48682.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=1lChZqViUinHyLr1xG0XiEipou8=; b=KmroUqeGZ3jBoFEv7TPmlcgCMpj0
	EaMdL+83f1BgeDIBy7k7T5G1oQlwQWgdgeqQizbQoPRFbFfS+8l99/MIhi4vChY0
	pdyJL3G2xcrYHcBPm7vcll5pi1bqfso/Ni5GrPNrlwSLBKoU2cCK45GCaIcKJTB5
	EBOvVv8IFVcv77w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=1lChZqViUinHyLr1xG0XiE
	ipou8=; b=THaoj1eyO5cInIpbGEMgTc3iuZCmij7tGAoiVrc7fhjnXneDFn1YSl
	Czu7L2kK7MBMk1EhiJ4WNL0YROteFih7e2D49tDGW8BG6l0kQfx2msyoYqHQUhSg
	2LgosyIt8jzSb07RusY2IIKxteaT5nT5+9ctwwNARG/c95pti17C0=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

A recent patch to fix a wildcard multi map mount regression has a
side effect of causing a deadlock at startup when trying to re-connect
to existing mounts.

The patch required the map entry cache write lock be taken so the cache
could be updated. But when starting and trying to re-connect to existing
mounts there's no need to update the cache.
---
 CHANGELOG                |    1 +
 modules/lookup_file.c    |   25 ++++++++++++++++++++-----
 modules/lookup_ldap.c    |   23 +++++++++++++++++++----
 modules/lookup_nisplus.c |   26 +++++++++++++++++++++-----
 modules/lookup_sss.c     |   22 ++++++++++++++++++----
 modules/lookup_yp.c      |   23 +++++++++++++++++++----
 6 files changed, 98 insertions(+), 22 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 618ac20..c3f12e5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -72,6 +72,7 @@
 - try and cleanup after dumpmaps.
 - teach dumpmaps to output simple key value pairs.
 - fix syncronize handle_mounts() shutdown.
+- fix fix wildcard multi map regression.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index 4b4ee89..83ef048 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -1042,7 +1042,7 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			return NSS_STATUS_UNAVAIL;
 		}
 
-		cache_writelock(mc);
+		cache_readlock(mc);
 		me = cache_lookup_first(mc);
 		if (me && st.st_mtime <= me->age) {
 			/*
@@ -1084,7 +1084,18 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		}
 	}
 
-	cache_writelock(mc);
+	/*
+	 * We can't take the writelock for direct mounts. If we're
+	 * starting up or trying to re-connect to an existing direct
+	 * mount we could be iterating through the map entries with
+	 * the readlock held. But we don't need to update the cache
+	 * when we're starting up so just take the readlock in that
+	 * case.
+	 */
+	if (ap->flags & MOUNT_FLAG_REMOUNT)
+		cache_readlock(mc);
+	else
+		cache_writelock(mc);
 do_cache_lookup:
 	me = cache_lookup(mc, key);
 	/*
@@ -1102,10 +1113,11 @@ do_cache_lookup:
 	}
 	if (me && me->mapent) {
 		/*
-		 * Add wildcard match for later validation checks and
-		 * negative cache lookups.
+		 * If this is a lookup add wildcard match for later validation
+		 * checks and negative cache lookups.
 		 */
-		if (ap->type == LKP_INDIRECT && *me->key == '*') {
+		if (!(ap->flags & MOUNT_FLAG_REMOUNT) &&
+		    ap->type == LKP_INDIRECT && *me->key == '*') {
 			ret = cache_update(mc, source, key, me->mapent, me->age);
 			if (!(ret & (CHE_OK | CHE_UPDATED)))
 				me = NULL;
@@ -1130,6 +1142,9 @@ do_cache_lookup:
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
+		/* Don't update negative cache when re-connecting */
+		if (ap->flags & MOUNT_FLAG_REMOUNT)
+			return NSS_STATUS_TRYAGAIN;
 		cache_writelock(mc);
 		cache_update_negative(mc, source, key, ap->negative_timeout);
 		cache_unlock(mc);
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index d05098f..2ab1e8c 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -3016,7 +3016,18 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			return status;
 	}
 
-	cache_writelock(mc);
+	/*
+	 * We can't take the writelock for direct mounts. If we're
+	 * starting up or trying to re-connect to an existing direct
+	 * mount we could be iterating through the map entries with
+	 * the readlock held. But we don't need to update the cache
+	 * when we're starting up so just take the readlock in that
+	 * case.
+	 */
+	if (ap->flags & MOUNT_FLAG_REMOUNT)
+		cache_readlock(mc);
+	else
+		cache_writelock(mc);
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
@@ -3028,10 +3039,11 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && me->mapent) {
 		/*
-		 * Add wildcard match for later validation checks and
-		 * negative cache lookups.
+		 * If this is a lookup add wildcard match for later validation
+		 * checks and negative cache lookups.
 		 */
-		if (ap->type == LKP_INDIRECT && *me->key == '*') {
+		if (!(ap->flags & MOUNT_FLAG_REMOUNT) &&
+		    ap->type == LKP_INDIRECT && *me->key == '*') {
 			ret = cache_update(mc, source, key, me->mapent, me->age);
 			if (!(ret & (CHE_OK | CHE_UPDATED)))
 				me = NULL;
@@ -3053,6 +3065,9 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
+		/* Don't update negative cache when re-connecting */
+		if (ap->flags & MOUNT_FLAG_REMOUNT)
+			return NSS_STATUS_TRYAGAIN;
 		cache_writelock(mc);
 		cache_update_negative(mc, source, key, ap->negative_timeout);
 		cache_unlock(mc);
diff --git a/modules/lookup_nisplus.c b/modules/lookup_nisplus.c
index ef942a7..08878bb 100644
--- a/modules/lookup_nisplus.c
+++ b/modules/lookup_nisplus.c
@@ -561,7 +561,18 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			return status;
 	}
 
-	cache_writelock(mc);
+	/*
+	 * We can't take the writelock for direct mounts. If we're
+	 * starting up or trying to re-connect to an existing direct
+	 * mount we could be iterating through the map entries with
+	 * the readlock held. But we don't need to update the cache
+	 * when we're starting up so just take the readlock in that
+	 * case.
+	 */
+	if (ap->flags & MOUNT_FLAG_REMOUNT)
+		cache_readlock(mc);
+	else
+		cache_writelock(mc);
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
@@ -573,10 +584,11 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && me->mapent) {
 		/*
-		 * Add wildcard match for later validation checks and
-		 * negative cache lookups.
+		 * If this is a lookup add wildcard match for later validation
+		 * checks and negative cache lookups.
 		 */
-		if (ap->type == LKP_INDIRECT && *me->key == '*') {
+		if (!(ap->flags & MOUNT_FLAG_REMOUNT) &&
+		    ap->type == LKP_INDIRECT && *me->key == '*') {
 			ret = cache_update(mc, source, key, me->mapent, me->age);
 			if (!(ret & (CHE_OK | CHE_UPDATED)))
 				me = NULL;
@@ -603,6 +615,11 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		time_t now = time(NULL);
 		int rv = CHE_OK;
 
+		free(mapent);
+
+		/* Don't update negative cache when re-connecting */
+		if (ap->flags & MOUNT_FLAG_REMOUNT)
+			return NSS_STATUS_TRYAGAIN;
 		cache_writelock(mc);
 		me = cache_lookup_distinct(mc, key);
 		if (!me)
@@ -612,7 +629,6 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			me->status = time(NULL) + ap->negative_timeout;
 		}
 		cache_unlock(mc);
-		free(mapent);
 		return NSS_STATUS_TRYAGAIN;
 	}
 	free(mapent);
diff --git a/modules/lookup_sss.c b/modules/lookup_sss.c
index 1fe740b..4a9cfd2 100644
--- a/modules/lookup_sss.c
+++ b/modules/lookup_sss.c
@@ -635,7 +635,17 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			return status;
 	}
 
-	cache_readlock(mc);
+	/*
+	 * We can't take the writelock for direct mounts. If we're
+	 * starting up or trying to re-connect to an existing direct
+	 * mount we could be iterating through the map entries with
+	 * the readlock held. But we don't need to update the cache
+	 * when we're starting up so just take the readlock in that
+	 */
+	if (ap->flags & MOUNT_FLAG_REMOUNT)
+		cache_writelock(mc);
+	else
+		cache_readlock(mc);
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
@@ -647,10 +657,11 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && me->mapent) {
 		/*
-		 * Add wildcard match for later validation checks and
-		 * negative cache lookups.
+		 * If this is a lookup add wildcard match for later validation
+		 * checks and negative cache lookups.
 		 */
-		if (ap->type == LKP_INDIRECT && *me->key == '*') {
+		if (ap->type == LKP_INDIRECT && *me->key == '*' &&
+		   !(ap->flags & MOUNT_FLAG_REMOUNT)) {
 			ret = cache_update(mc, source, key, me->mapent, me->age);
 			if (!(ret & (CHE_OK | CHE_UPDATED)))
 				me = NULL;
@@ -672,6 +683,9 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	ret = ctxt->parse->parse_mount(ap, key, key_len,
 				       mapent, ctxt->parse->context);
 	if (ret) {
+		/* Don't update negative cache when re-connecting */
+		if (ap->flags & MOUNT_FLAG_REMOUNT)
+			return NSS_STATUS_TRYAGAIN;
 		cache_writelock(mc);
 		cache_update_negative(mc, source, key, ap->negative_timeout);
 		cache_unlock(mc);
diff --git a/modules/lookup_yp.c b/modules/lookup_yp.c
index e99e3c0..4d1848e 100644
--- a/modules/lookup_yp.c
+++ b/modules/lookup_yp.c
@@ -662,7 +662,18 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 			return status;
 	}
 
-	cache_writelock(mc);
+	/*
+	 * We can't take the writelock for direct mounts. If we're
+	 * starting up or trying to re-connect to an existing direct
+	 * mount we could be iterating through the map entries with
+	 * the readlock held. But we don't need to update the cache
+	 * when we're starting up so just take the readlock in that
+	 * case.
+	 */
+	if (ap->flags & MOUNT_FLAG_REMOUNT)
+		cache_readlock(mc);
+	else
+		cache_writelock(mc);
 	me = cache_lookup(mc, key);
 	/* Stale mapent => check for entry in alternate source or wildcard */
 	if (me && !me->mapent) {
@@ -674,10 +685,11 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	}
 	if (me && me->mapent) {
 		/*
-		 * Add wildcard match for later validation checks and
-		 * negative cache lookups.
+		 * If this is a lookup add wildcard match for later validation
+		 * checks and negative cache lookups.
 		 */
-		if (ap->type == LKP_INDIRECT && *me->key == '*') {
+		if (ap->type == LKP_INDIRECT && *me->key == '*' &&
+		   !(ap->flags & MOUNT_FLAG_REMOUNT)) {
 			ret = cache_update(mc, source, key, me->mapent, me->age);
 			if (!(ret & (CHE_OK | CHE_UPDATED)))
 				me = NULL;
@@ -698,6 +710,9 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 		ret = ctxt->parse->parse_mount(ap, key, key_len,
 					       mapent, ctxt->parse->context);
 		if (ret) {
+			/* Don't update negative cache when re-connecting */
+			if (ap->flags & MOUNT_FLAG_REMOUNT)
+				return NSS_STATUS_TRYAGAIN;
 			cache_writelock(mc);
 			cache_update_negative(mc, source, key, ap->negative_timeout);
 			cache_unlock(mc);

