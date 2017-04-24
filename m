From: Ian Kent <raven@themaw.net>
Subject: [PATCH 32/34] autofs-5.1.2 - use malloc for expanded map location
Date: Mon, 24 Apr 2017 09:02:57 +0800
Message-ID: <149299577758.23475.7881230953938585078.stgit@pluto.themaw.net>
References: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=jO9ULi12arFIqM6Fmb
        oVZmaeDclqdWQQ6gVpiyqfkb8=; b=NzqyMulhuAhrx3/OVw2u2Kz1hdrsJhj5Z9
        Pupo56qenO6xLMk6c7dhu9aCZ+vdNowtbUG83Jyqtsdgp8WBkfqmt1517FEZ5nfu
        dvLXrpteQHYauvBEFlbwpvRWUpE3mRd1Akk9r6Fw8QplJM03m9Xp+o7trnyg8gwv
        rzCfu6zHPeHz9UFRuY1hcMmVkdaAf/VJWb2xtqTnbqF0wRpFNnkZPWTvlVdXz2x4
        fanM0E1nUe5LCik6lo8K9UOljAbt8G2jiwYh7GRzswb4tIqCQl1J3Zp5NktB30WG
        0xvb/klTYJ9xgJ/y5T+X8rWZnA9d7mbIUWpk+39R+yXwTkHUIlwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=jO9ULi12arFIqM6FmboVZmaeDclqdWQQ6gVpiyqfkb8=; b=HxMK6+zN
        mtAWjvbsryuRw6z4tjbYehwnGuJUAGBpLAccmYL9jHIY/0XdfYUequgbZ0YeKuwe
        USMRtx3MeuigbGoVt22E0NMb4CIF+EzuS/6LDCAytprOeiN/SYmoZGT7CukzJssU
        SG/X8a0fYSxgnJL60gaePH+EsdxOx+UWboOJFi/TCE7n+YuXpJe2bl5ahCwX3eeD
        l0tAPsWnrcacGGXb4jDKBhp4r2FkMg7gNdlXtryrWqDw+kxaC/lCC4BGyP/Gqf8G
        8oo6ls0ms3FiO584dF7mHIcPClNLprjlNHFOY4x1wecJtav7nWyydv+ECeIIG9wW
        It2ghJ6Ymme5Ew==
In-Reply-To: <149299547753.23475.9924538846721477415.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Change the allocation of temporary mount location storage in the sun
parser to use malloc(3) instead of alloca(3) and refactor a little.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_sun.c |   65 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index b7c5a62..1ea69d5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -58,6 +58,7 @@ xx/xx/2016 autofs-5.1.3
 - fix possible NULL derefernce.
 - fix work around sss startup delay.
 - fix invalid reference in remount_active_mount().
+- use malloc for expanded map location.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index a9689f0..8955c84 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -1234,6 +1234,29 @@ static int mount_subtree(struct autofs_point *ap, struct mapent *me,
 	return rv;
 }
 
+static char *do_expandsunent(const char *src, const char *key,
+			     const struct substvar *svc, int slashify_colons)
+{
+	char *mapent;
+	int len;
+
+	len = expandsunent(src, NULL, key, svc, slashify_colons);
+	if (len == 0) {
+		errno = EINVAL;
+		return NULL;
+	}
+	len++;
+
+	mapent = malloc(len);
+	if (!mapent)
+		return NULL;
+	memset(mapent, 0, len);
+
+	expandsunent(src, mapent, key, svc, slashify_colons);
+
+	return mapent;
+}
+
 /*
  * syntax is:
  *	[-options] location [location] ...
@@ -1273,34 +1296,23 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	}
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &cur_state);
-	macro_lock();
 
+	macro_lock();
 	ctxt->subst = addstdenv(ctxt->subst, NULL);
 
-	mapent_len = expandsunent(mapent, NULL, name, ctxt->subst, slashify);
-	if (mapent_len == 0) {
+	pmapent = do_expandsunent(mapent, name, ctxt->subst, slashify);
+	if (!pmapent) {
 		error(ap->logopt, MODPREFIX "failed to expand map entry");
 		ctxt->subst = removestdenv(ctxt->subst, NULL);
 		macro_unlock();
 		pthread_setcancelstate(cur_state, NULL);
 		return 1;
 	}
+	mapent_len = strlen(pmapent) + 1;
 
-	pmapent = alloca(mapent_len + 1);
-	if (!pmapent) {	
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
-		logerr(MODPREFIX "alloca: %s", estr);
-		ctxt->subst = removestdenv(ctxt->subst, NULL);
-		macro_unlock();
-		pthread_setcancelstate(cur_state, NULL);
-		return 1;
-	}
-	pmapent[mapent_len] = '\0';
-
-	expandsunent(mapent, pmapent, name, ctxt->subst, slashify);
 	ctxt->subst = removestdenv(ctxt->subst, NULL);
-
 	macro_unlock();
+
 	pthread_setcancelstate(cur_state, NULL);
 
 	debug(ap->logopt, MODPREFIX "expanded entry: %s", pmapent);
@@ -1309,6 +1321,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	options = strdup(ctxt->optstr ? ctxt->optstr : "");
 	if (!options) {
 		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		free(pmapent);
 		logerr(MODPREFIX "strdup: %s", estr);
 		return 1;
 	}
@@ -1337,6 +1350,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 					if (mnt_options)
 						free(mnt_options);
 					free(options);
+					free(pmapent);
 					return 1;
 				}
 				mnt_options = tmp;
@@ -1363,6 +1377,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 						free(options);
 					if (mnt_options)
 						free(mnt_options);
+					free(pmapent);
 					return 1;
 				}
 				options = tmp;
@@ -1386,6 +1401,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			if (!m_root) {
 				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 				free(options);
+				free(pmapent);
 				logerr(MODPREFIX "alloca: %s", estr);
 				return 1;
 			}
@@ -1396,6 +1412,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			if (!m_root) {
 				char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
 				free(options);
+				free(pmapent);
 				logerr(MODPREFIX "alloca: %s", estr);
 				return 1;
 			}
@@ -1409,6 +1426,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		me = cache_lookup_distinct(mc, name);
 		if (!me) {
 			free(options);
+			free(pmapent);
 			cache_unlock(mc);
 			pthread_setcancelstate(cur_state, NULL);
 			error(ap->logopt,
@@ -1440,6 +1458,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			 */
 			if (source->flags & MAP_FLAG_FORMAT_AMD) {
 				free(options);
+				free(pmapent);
 				cache_multi_unlock(me);
 				cache_unlock(mc);
 				pthread_setcancelstate(cur_state, NULL);
@@ -1472,6 +1491,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 				cache_multi_unlock(me);
 				cache_unlock(mc);
 				free(options);
+				free(pmapent);
 				pthread_setcancelstate(cur_state, NULL);
 				return 1;
 			}
@@ -1486,6 +1506,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 				cache_unlock(mc);
 				free(path);
 				free(options);
+				free(pmapent);
 				pthread_setcancelstate(cur_state, NULL);
 				return 1;
 			}
@@ -1507,6 +1528,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 				cache_unlock(mc);
 				free(path);
 				free(options);
+				free(pmapent);
 				free(myoptions);
 				if (loc)
 					free(loc);
@@ -1535,6 +1557,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		cache_unlock(mc);
 
 		free(options);
+		free(pmapent);
 		pthread_setcancelstate(cur_state, NULL);
 
 		return rv;
@@ -1555,6 +1578,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			loc = strdup(p);
 			if (!loc) {
 				free(options);
+				free(pmapent);
 				cache_unlock(mc);
 				warn(ap->logopt, MODPREFIX "out of memory");
 				return 1;
@@ -1565,6 +1589,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			cache_unlock(mc);
 			free(loc);
 			free(options);
+			free(pmapent);
 			return rv;
 		}
 		cache_unlock(mc);
@@ -1573,6 +1598,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		loc = dequote(p, l, ap->logopt);
 		if (!loc) {
 			free(options);
+			free(pmapent);
 			warn(ap->logopt, MODPREFIX "null location or out of memory");
 			return 1;
 		}
@@ -1580,6 +1606,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		/* Location can't begin with a '/' */
 		if (*p == '/') {
 			free(options);
+			free(pmapent);
 			free(loc);
 			warn(ap->logopt,
 			      MODPREFIX "error location begins with \"/\"");
@@ -1589,6 +1616,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		if (!validate_location(ap->logopt, loc)) {
 			free(loc);
 			free(options);
+			free(pmapent);
 			return 1;
 		}
 
@@ -1606,6 +1634,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			if (!ent) {
 				free(loc);
 				free(options);
+				free(pmapent);
 				warn(ap->logopt,
 				     MODPREFIX "null location or out of memory");
 				return 1;
@@ -1615,6 +1644,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 				free(ent);
 				free(loc);
 				free(options);
+				free(pmapent);
 				return 1;
 			}
 
@@ -1626,6 +1656,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 				free(ent);
 				free(loc);
 				free(options);
+				free(pmapent);
 				error(ap->logopt, MODPREFIX "out of memory");
 				return 1;
 			}
@@ -1656,6 +1687,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 			if (loclen == 0) {
 				free(loc);
 				free(options);
+				free(pmapent);
 				error(ap->logopt,
 				      MODPREFIX "entry %s is empty!", name);
 				return 1;
@@ -1676,6 +1708,7 @@ int parse_mount(struct autofs_point *ap, const char *name,
 		if (loc)
 			free(loc);
 		free(options);
+		free(pmapent);
 		pthread_setcancelstate(cur_state, NULL);
 	}
 	return rv;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
