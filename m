From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 3/8] Added function names to
	some debug/crit messages, changed some crits to debug
Date: Mon, 20 Dec 2010 14:10:12 +1300
Message-ID: <bd89570b033488aef952fcaf4c46fea290da49c6.1294888163.git.bill.ryder.nz@gmail.com>
References: <cover.1294888163.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1294888163.git.bill.ryder.nz@gmail.com>
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
To: 

---
 CHANGELOG             |   10 +++++++-
 modules/lookup_ldap.c |   64 +++++++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9dd8185..c40a670 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,5 +1,13 @@
+
+18/6/2010 autofs-4.1.4 - bryder p39
+-----------------------------------
+Added the function name to the lookup_ldap debug and critical messages. 
+Also made a couple of the 'crit' messages 'debug' messages because they are not actually critical. 
+They just show a failed search.
+
+
 17/6/2010 autofs-4.1.4 - bryder p38
----------------------------
+--------------------------
 Added LDAP patch to stop the autofs-ldap-auto-master and lookup_ldap.so from crashing on modern ldap libraries. 
 It sets the LDAP_DEPRECATED macro to 1. Obviously the ldap stuff needs some updating.
 
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index b269f75..f8ed7fc 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -80,7 +80,7 @@ static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 	rv = ldap_set_option(ldap, LDAP_OPT_NETWORK_TIMEOUT, &timeout);
 	if (rv != LDAP_SUCCESS) {
 		warn(MODPREFIX
-		     "failed to set connection timeout to %d", timeout);
+		     "%s: failed to set connection timeout to %d", __func__, timeout);
 	}
 
 	/* Connect to the server as an anonymous user. */
@@ -172,7 +172,7 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	memset(ctxt->base, 0, l + 1);
 	memcpy(ctxt->base, ptr, l);
 
-	debug(MODPREFIX "server = \"%s\", port = %d, base dn = \"%s\"",
+	debug(MODPREFIX "%s: server = \"%s\", port = %d, base dn = \"%s\"", __func__,
 		  ctxt->server ? ctxt->server : "(default)",
 		  ctxt->port, ctxt->base);
 
@@ -203,7 +203,7 @@ static int read_one_map(const char *root,
 	LDAP *ldap;
 
 	if (ctxt == NULL) {
-		crit(MODPREFIX "context was NULL");
+		crit(MODPREFIX "%s: context was NULL", __func__);
 		return 0;
 	}
 
@@ -223,11 +223,11 @@ static int read_one_map(const char *root,
 	if (keyvallen > 0) {
 		if (sprintf(query, "(&(objectclass=%s)(%s=%.*s))", class,
 			    key, keyvallen, keyval) >= l) {
-			debug(MODPREFIX "error forming query string");
+			debug(MODPREFIX "%s: error forming query string", __func__);
 		}
 	} else {
 		if (sprintf(query, "(objectclass=%s)", class) >= l) {
-			debug(MODPREFIX "error forming query string");
+			debug(MODPREFIX "%s: error forming query string", __func__);
 		}
 	}
 	query[l - 1] = '\0';
@@ -238,13 +238,13 @@ static int read_one_map(const char *root,
 		return 0;
 
 	/* Look around. */
-	debug(MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->base);
+	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
 
 	rv = ldap_search_s(ldap, ctxt->base, LDAP_SCOPE_SUBTREE,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
-		crit(MODPREFIX "query failed for %s: %s", query, ldap_err2string(rv));
+	        crit(MODPREFIX "%s: query failed for %s: %s", __func__, query, ldap_err2string(rv));
 		ldap_unbind(ldap);
 		*result_ldap = rv;
 		return 0;
@@ -252,12 +252,12 @@ static int read_one_map(const char *root,
 
 	e = ldap_first_entry(ldap, result);
 	if (!e) {
-		debug(MODPREFIX "query succeeded, no matches for %s", query);
+		debug(MODPREFIX "%s: query succeeded, no matches for %s", __func__, query);
 		ldap_msgfree(result);
 		ldap_unbind(ldap);
 		return 0;
 	} else
-		debug(MODPREFIX "examining entries");
+		debug(MODPREFIX "%s: examining entries", __func__ );
 
 	while (e) {
 		keyValue = ldap_get_values(ldap, e, key);
@@ -269,7 +269,7 @@ static int read_one_map(const char *root,
 
 		values = ldap_get_values(ldap, e, type);
 		if (!values) {
-			info(MODPREFIX "no %s defined for %s", type, query);
+			info(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
 			ldap_value_free(keyValue);
 			e = ldap_next_entry(ldap, e);
 			continue;
@@ -291,7 +291,7 @@ static int read_one_map(const char *root,
 		e = ldap_next_entry(ldap, e);
 	}
 
-	debug(MODPREFIX "done updating map");
+	debug(MODPREFIX "%s: done updating map", __func__ );
 
 	/* Clean up. */
 	ldap_msgfree(result);
@@ -393,7 +393,7 @@ static int lookup_one(const char *root, const char *qKey,
 	int ret = CHE_OK;
 
 	if (ctxt == NULL) {
-		crit(MODPREFIX "context was NULL");
+		crit(MODPREFIX "%s: context was NULL", __func__ );
 		return 0;
 	}
 
@@ -404,7 +404,7 @@ static int lookup_one(const char *root, const char *qKey,
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "%s: alloca returned NULL", __func__ );
 		return 0;
 	}
 
@@ -412,12 +412,12 @@ static int lookup_one(const char *root, const char *qKey,
 	memset(query, '\0', l);
 	ql = sprintf(query, "(&(objectclass=%s)(%s=%s))", class, key, qKey);
 	if (ql >= l) {
-		debug(MODPREFIX "error forming query string");
+		debug(MODPREFIX "%s: error forming query string", __func__);
 		return 0;
 	}
 	query[l - 1] = '\0';
 
-	debug(MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->base);
+	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
 
 	/* Initialize the LDAP context. */
 	ldap = do_connect(ctxt, &rv);
@@ -428,26 +428,27 @@ static int lookup_one(const char *root, const char *qKey,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
-		crit(MODPREFIX "query failed for %s", query);
+		crit(MODPREFIX "%s: query failed for %s", __func__, query);
 		ldap_unbind(ldap);
 		return 0;
 	}
 
-	debug(MODPREFIX "getting first entry for %s=\"%s\"", key, qKey);
 
+	debug(MODPREFIX "%s: getting first entry for %s=\"%s\"", __func__, key, qKey);
 	e = ldap_first_entry(ldap, result);
 	if (!e) {
-		crit(MODPREFIX "got answer, but no first entry for %s", query);
+		debug(MODPREFIX "%s: got answer, but no first entry for %s", __func__, query);
 		ldap_msgfree(result);
 		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
-	debug(MODPREFIX "examining first entry");
+
+	debug(MODPREFIX "%s: examining first entry", __func__);
 
 	values = ldap_get_values(ldap, e, type);
 	if (!values) {
-		debug(MODPREFIX "no %s defined for %s", type, query);
+		debug(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
 		ldap_msgfree(result);
 		ldap_unbind(ldap);
 		return CHE_MISSING;
@@ -499,7 +500,7 @@ static int lookup_wild(const char *root,
 	int qKey_len;
 
 	if (ctxt == NULL) {
-		crit(MODPREFIX "context was NULL");
+		crit(MODPREFIX "%s: context was NULL", __func__);
 		return 0;
 	}
 
@@ -512,7 +513,7 @@ static int lookup_wild(const char *root,
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "%s: malloc failed",__func__);
 		return 0;
 	}
 
@@ -520,12 +521,12 @@ static int lookup_wild(const char *root,
 	memset(query, '\0', l);
 	ql = sprintf(query, "(&(objectclass=%s)(%s=%s))", class, key, qKey);
 	if (ql >= l) {
-		debug(MODPREFIX "error forming query string");
+		debug(MODPREFIX "%s: error forming query string", __func__);
 		return 0;
 	}
 	query[l - 1] = '\0';
 
-	debug(MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->base);
+	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
 
 	/* Initialize the LDAP context. */
 	ldap = do_connect(ctxt, &rv);
@@ -536,26 +537,27 @@ static int lookup_wild(const char *root,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
-		crit(MODPREFIX "query failed for %s", query);
+		crit(MODPREFIX "%s: query failed for %s", __func__, query);
 		ldap_unbind(ldap);
 		return 0;
 	}
 
-	debug(MODPREFIX "getting first entry for %s=\"%s\"", key, qKey);
+
+	debug(MODPREFIX "%s: getting first entry for %s=\"%s\"", __func__, key, qKey);
 
 	e = ldap_first_entry(ldap, result);
 	if (!e) {
-		crit(MODPREFIX "got answer, but no first entry for %s", query);
+		debug(MODPREFIX "%s: got answer, but no first entry for %s", __func__, query);
 		ldap_msgfree(result);
 		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
-	debug(MODPREFIX "examining first entry");
+	debug(MODPREFIX "%s: examining first entry", __func__);
 
 	values = ldap_get_values(ldap, e, type);
 	if (!values) {
-		debug(MODPREFIX "no %s defined for %s", type, query);
+		debug(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
 		ldap_msgfree(result);
 		ldap_unbind(ldap);
 		return CHE_MISSING;
@@ -654,7 +656,7 @@ int lookup_mount(const char *root, const char *name, int name_len, void *context
 		while (me) {
 			sprintf(mapent, me->mapent);
 
-			debug(MODPREFIX "%s -> %s", key, mapent);
+			debug(MODPREFIX "%s: %s -> %s", __func__, key, mapent);
 			ret = ctxt->parse->parse_mount(root, name, name_len,
 						  mapent, ctxt->parse->context);
 			me = cache_lookup_next(me);
@@ -674,7 +676,7 @@ int lookup_mount(const char *root, const char *name, int name_len, void *context
 			}
 			sprintf(mapent, "-fstype=autofs ldap:%s", mapname);
 
-			debug(MODPREFIX "%s -> %s", key, mapent);
+			debug(MODPREFIX "%s: %s -> %s", __func__, key, mapent);
 			ret = ctxt->parse->parse_mount(root, name, name_len,
 						  mapent, ctxt->parse->context);
 		}
-- 
1.7.3.3
