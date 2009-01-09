From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: [PATCH 2/4] Make MAX_ERR_BUF and PARSE_MAX_BUF use easier
	to audit
Date: Fri,  9 Jan 2009 13:47:01 -0500
Message-ID: <1231526823-18595-3-git-send-email-vaurora@redhat.com>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231526823-18595-2-git-send-email-vaurora@redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


Signed-off-by: Valerie Aurora Henson <vaurora@redhat.com>
---
 modules/lookup_ldap.c |   49 ++++++++++++++++++++++---------------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 42c3235..0ef7bcf 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -275,7 +275,7 @@ LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct lookup_conte
 
 static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt, const char *class, const char *key)
 {
-	char buf[PARSE_MAX_BUF];
+	char buf[MAX_ERR_BUF];
 	char *query, *dn, *qdn;
 	LDAPMessage *result, *e;
 	struct ldap_searchdn *sdns = NULL;
@@ -299,7 +299,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 
 	query = alloca(l);
 	if (query == NULL) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		char *estr = strerror_r(errno, buf, sizeof(buf));
 		crit(logopt, MODPREFIX "alloca: %s", estr);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -1074,7 +1074,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 			}
 			if (!tmp) {
 				char *estr;
-				estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				estr = strerror_r(errno, buf, sizeof(buf));
 				logerr(MODPREFIX "malloc: %s", estr);
 				return 0;
 			}
@@ -1096,7 +1096,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 			tmp = malloc(l + 1);
 			if (!tmp) {
 				char *estr;
-				estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				estr = strerror_r(errno, buf, sizeof(buf));
 				crit(logopt, MODPREFIX "malloc: %s", estr);
 				return 0;
 			}
@@ -1131,7 +1131,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 		/* Isolate the server's name. */
 		if (!tmp) {
 			char *estr;
-			estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			estr = strerror_r(errno, buf, sizeof(buf));
 			logerr(MODPREFIX "malloc: %s", estr);
 			return 0;
 		}
@@ -1172,7 +1172,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 				ctxt->mapname = map;
 			else {
 				char *estr;
-				estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				estr = strerror_r(errno, buf, sizeof(buf));
 				logerr(MODPREFIX "malloc: %s", estr);
 				if (ctxt->server)
 					free(ctxt->server);
@@ -1183,7 +1183,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 			base = malloc(l + 1);
 			if (!base) {
 				char *estr;
-				estr = strerror_r(errno, buf, MAX_ERR_BUF);
+				estr = strerror_r(errno, buf, sizeof(buf));
 				logerr(MODPREFIX "malloc: %s", estr);
 				if (ctxt->server)
 					free(ctxt->server);
@@ -1197,7 +1197,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
 		char *map = malloc(l + 1);
 		if (!map) {
 			char *estr;
-			estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			estr = strerror_r(errno, buf, sizeof(buf));
 			logerr(MODPREFIX "malloc: %s", estr);
 			if (ctxt->server)
 				free(ctxt->server);
@@ -1310,7 +1310,7 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	/* If we can't build a context, bail. */
 	ctxt = malloc(sizeof(struct lookup_context));
 	if (!ctxt) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		char *estr = strerror_r(errno, buf, sizeof(buf));
 		logerr(MODPREFIX "malloc: %s", estr);
 		return 1;
 	}
@@ -1411,8 +1411,9 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 	unsigned int timeout = master->default_timeout;
 	unsigned int logging = master->default_logging;
 	unsigned int logopt = master->logopt;
-	int rv, l, count, blen;
-	char buf[PARSE_MAX_BUF];
+	int rv, l, count;
+	char buf[MAX_ERR_BUF];
+	char parse_buf[PARSE_MAX_BUF];
 	char *query;
 	LDAPMessage *result, *e;
 	char *class, *info, *entry;
@@ -1434,7 +1435,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 
 	query = alloca(l);
 	if (query == NULL) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		char *estr = strerror_r(errno, buf, sizeof(buf));
 		logerr(MODPREFIX "alloca: %s", estr);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -1524,18 +1525,12 @@ int lookup_read_master(struct master *master, time_t age, void *context)
 			goto next;
 		}
 
-		blen = strlen(*keyValue) + 1 + strlen(*values) + 2;
-		if (blen > PARSE_MAX_BUF) {
+		if (snprintf(parse_buf, sizeof(parse_buf), "%s %s",
+			     *keyValue, *values) > sizeof(parse_buf)) {
 			error(logopt, MODPREFIX "map entry too long");
 			ldap_value_free(values);
 			goto next;
 		}
-		memset(buf, 0, PARSE_MAX_BUF);
-
-		strcpy(buf, *keyValue);
-		strcat(buf, " ");
-		strcat(buf, *values);
-
 		master_parse_entry(buf, timeout, logging, age);
 next:
 		ldap_value_free(keyValue);
@@ -1553,7 +1548,7 @@ static int get_percent_decoded_len(const char *name)
 {
 	int escapes = 0;
 	int escaped = 0;
-	char *tmp = name;
+	const char *tmp = name;
 	int look_for_close = 0;
 
 	while (*tmp) {
@@ -2052,7 +2047,7 @@ static int do_get_entries(struct ldap_search_params *sp, struct map_source *sour
 				mapent = malloc(v_len + 1);
 				if (!mapent) {
 					char *estr;
-					estr = strerror_r(errno, buf, MAX_ERR_BUF);
+					estr = strerror_r(errno, buf, sizeof(buf));
 					logerr(MODPREFIX "malloc: %s", estr);
 					ldap_value_free_len(bvValues);
 					goto next;
@@ -2072,7 +2067,7 @@ static int do_get_entries(struct ldap_search_params *sp, struct map_source *sour
 					mapent_len = new_size;
 				} else {
 					char *estr;
-					estr = strerror_r(errno, buf, MAX_ERR_BUF);
+					estr = strerror_r(errno, buf, sizeof(buf));
 					logerr(MODPREFIX "realloc: %s", estr);
 				}
 			}
@@ -2173,7 +2168,7 @@ static int read_one_map(struct autofs_point *ap,
 
 	sp.query = alloca(l);
 	if (sp.query == NULL) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		char *estr = strerror_r(errno, buf, sizeof(buf));
 		logerr(MODPREFIX "malloc: %s", estr);
 		return NSS_STATUS_UNAVAIL;
 	}
@@ -2327,7 +2322,7 @@ static int lookup_one(struct autofs_point *ap,
 
 	query = alloca(l);
 	if (query == NULL) {
-		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
+		char *estr = strerror_r(errno, buf, sizeof(buf));
 		crit(ap->logopt, MODPREFIX "malloc: %s", estr);
 		if (enc_len1) {
 			free(enc_key1);
@@ -2499,7 +2494,7 @@ static int lookup_one(struct autofs_point *ap,
 				mapent = malloc(v_len + 1);
 				if (!mapent) {
 					char *estr;
-					estr = strerror_r(errno, buf, MAX_ERR_BUF);
+					estr = strerror_r(errno, buf, sizeof(buf));
 					logerr(MODPREFIX "malloc: %s", estr);
 					ldap_value_free_len(bvValues);
 					goto next;
@@ -2519,7 +2514,7 @@ static int lookup_one(struct autofs_point *ap,
 					mapent_len = new_size;
 				} else {
 					char *estr;
-					estr = strerror_r(errno, buf, MAX_ERR_BUF);
+					estr = strerror_r(errno, buf, sizeof(buf));
 					logerr(MODPREFIX "realloc: %s", estr);
 				}
 			}
-- 
1.6.0.4
