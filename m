From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 4/8] reinstated the jmoyer
	ldap-cleanup patch and included man etc updates
Date: Tue, 21 Dec 2010 08:30:46 +1300
Message-ID: <1ef0b60fff5b2d33bf9430769d2ce0ad55a618c2.1294888163.git.bill.ryder.nz@gmail.com>
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
 CHANGELOG             |    9 ++
 daemon/automount.c    |    8 +-
 include/automount.h   |    1 +
 man/automount.8       |    8 ++
 modules/lookup_ldap.c |  275 ++++++++++++++++++++++++++++++++-----------------
 5 files changed, 206 insertions(+), 95 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c40a670..04043c5 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,10 @@
+29/06/2010 autofs-4.1.4-p40
+---------------------------
+  Reinstates the jmoyer ldap-cleanup.patch from 4.1.3 which does cleaner LDAP schema handling. 
+  It only looks up the schema once and then remembers it for every requested path under a mount point.
+  It  includes the --use_old_ldap_lookup or -u option to make the code search every schema every time the way it used to.
+  bryder changed the original patch is to invert the search order so the most modern schema (rfc2307bis) is checked first
+  bryder added the option to the man page and help output from automount.c
 
 18/6/2010 autofs-4.1.4 - bryder p39
 -----------------------------------
@@ -19,6 +26,8 @@ Also help to the automount.c command for this option and updated the man page.
 Only tested with LDAP.
 
 
+
+
 11/4/2005 autofs-4.1.4
 ----------------------
 - add /proc/modules check to Debian init script.
diff --git a/daemon/automount.c b/daemon/automount.c
index 93e3ff7..0ef9cbb 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1382,7 +1382,7 @@ static void usage(void)
 {
 	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
 	fprintf(stderr, "   -D|--dumpmap dumps out the maps read and exits\n");
-
+	fprintf(stderr, "   -u|--use-old-ldap-lookup instead of figuring out the schema once do it every single time a mount is requested. This is the old behaviour\n");
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1675,6 +1675,7 @@ int main(int argc, char *argv[])
 		{"ghost", 0, 0, 'g'},
 		{"submount", 0, &submount, 1},
 		{"dumpmap", 0, 0, 'D'},
+		{"use-old-ldap-lookup", 0, 0, 'u'},
 		{0, 0, 0, 0}
 	};
 
@@ -1687,7 +1688,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgD", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgDu", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1720,6 +1721,9 @@ int main(int argc, char *argv[])
 		case 'D':
 			dumpmap = 1;
 			break;
+		case 'u':
+			ap.use_old_ldap_lookup = 1;
+			break;
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
diff --git a/include/automount.h b/include/automount.h
index 64ff83d..fa97764 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -113,6 +113,7 @@ struct autofs_point {
 	int state_pipe[2];
 	unsigned dir_created;		/* Was a directory created for this
 					   mount? */
+	unsigned use_old_ldap_lookup;   /* query all schemas every time instead of sticking with the first one found */
 };
 
 extern struct autofs_point ap; 
diff --git a/man/automount.8 b/man/automount.8
index e640656..5dc597b 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -46,6 +46,14 @@ Display the version number, then exit.
 .TP
 .I "\-D, \-\-dumpmap"
 Dumps the maps read and exits.
+.TP
+.I "\-u, \-\-use\-old\-ldap\-lookup"
+By default automount will use new code for finding the correct ldap
+schema. It starts with rfc2307bis, then does the netscape one, then
+the original rfc2307 schema. It only checks once for each mount point
+and remembers the schema for the rest of the automount invocation.
+If you set this flag it will do it the old way which involves looking
+for the schema every time a mount is requested.
 .SH ARGUMENTS
 \fBautomount\fP takes at least three arguments.  Mandatory arguments 
 include \fImount-point\fP, \fImap-type\fP, and \fImap\fP.  Both mandatory
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index f8ed7fc..1c5c62a 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -39,14 +39,57 @@
 
 #define MODPREFIX "lookup(ldap): "
 
+/*
+ *  Automount entries are stored hierarchically, with the map name as the base
+ *  dn for searches on entries for that map.  Thus, to obtain the base dn for
+ *  the master map, one would use the following filter:
+ *    (&(objectclass=<map_object_class>)(<map_name_attr>="auto.master"))
+ *  Once the base dn is obtained (using ldap_get_first_entry, followed by
+ *  ldap_get_dn), the following filter will return all entries for the given
+ *  map:
+ *    (objectclass=<entry_object_class>)
+ *  The attributes of interest are <entry_key_attr>, or the key, and
+ *  <entry_value_attr> or the value portion of the automount map entry.
+ */
+struct autofs_schema {
+	char *map_object_class;
+	char *map_name_attr;
+
+	char *entry_object_class;
+	char *entry_key_attr;
+	char *entry_value_attr;
+};
+
+
+#define NR_SCHEMAS	3
+struct autofs_schema supported_schemas[NR_SCHEMAS] = {
+	{ "automountMap", "automountMapName",
+	  "automount", "automountKey", "automountInformation" },
+	{ "automountMap", "ou", "automount", "cn", "automountInformation" },
+	{ "nisMap", "nisMapName", "nisObject", "cn", "nisMapEntry" },
+};
+
 struct lookup_context {
 	char *server, *base;
 	int port;
+
+	/* once we find a schema that works, save it for future lookups  -
+	 * unless the use_old_ldap_lookup optoin is in effect in which case every schema is search every time.
+	 */
+	struct autofs_schema *schema;
+
 	struct parse_mod *parse;
 };
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
+void set_schema(struct lookup_context *ctxt, struct autofs_schema *schema)
+{
+	if (!ap.use_old_ldap_lookup) 
+		ctxt->schema = schema;
+}
+
+
 static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 {
 	LDAP *ldap;
@@ -57,8 +100,8 @@ static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 	/* Initialize the LDAP context. */
 	ldap = ldap_init(ctxt->server, ctxt->port);
 	if (!ldap) {
-		crit(MODPREFIX "couldn't initialize LDAP connection"
-		     " to %s", ctxt->server ? ctxt->server : "default server");
+		crit(MODPREFIX "%s: couldn't initialize LDAP connection"
+		     " to %s", __func__, ctxt->server ? ctxt->server : "default server");
 		return NULL;
 	}
 
@@ -69,7 +112,7 @@ static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 		ldap_unbind(ldap);
 		ldap = ldap_init(ctxt->server, ctxt->port);
 		if (!ldap) {
-			crit(MODPREFIX "couldn't initialize LDAP");
+			crit(MODPREFIX "%s: couldn't initialize LDAP for v2", __func__ );
 			return NULL;
 		} else {
 			version = 2;
@@ -79,7 +122,7 @@ static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 	/* Sane network connection timeout */
 	rv = ldap_set_option(ldap, LDAP_OPT_NETWORK_TIMEOUT, &timeout);
 	if (rv != LDAP_SUCCESS) {
-		warn(MODPREFIX
+		warn(MODPREFIX 
 		     "%s: failed to set connection timeout to %d", __func__, timeout);
 	}
 
@@ -188,9 +231,8 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc - 1, argv + 1));
 }
 
-static int read_one_map(const char *root,
-			const char *class, char *key,
-			const char *keyval, int keyvallen, char *type,
+static int read_one_map(LDAP *ldap, const char *root,
+			struct autofs_schema *schema,			
 			struct lookup_context *ctxt,
 			time_t age, int *result_ldap)
 {
@@ -199,8 +241,13 @@ static int read_one_map(const char *root,
 	LDAPMessage *result, *e;
 	char **keyValue = NULL;
 	char **values = NULL;
-	char *attrs[] = { key, type, NULL };
-	LDAP *ldap;
+	char *attrs[] = { schema->entry_key_attr,
+			  schema->entry_value_attr,
+			  NULL };
+	const char *class = schema->entry_object_class,
+		   *key = schema->entry_key_attr,
+		   *type = schema->entry_value_attr;
+	int found_entry = 0;
 
 	if (ctxt == NULL) {
 		crit(MODPREFIX "%s: context was NULL", __func__);
@@ -209,9 +256,6 @@ static int read_one_map(const char *root,
 
 	/* Build a query string. */
 	l = strlen("(objectclass=)") + strlen(class) + 1;
-	if (keyvallen > 0) {
-		l += strlen(key) +keyvallen + strlen("(&(=))");
-	}
 
 	query = alloca(l);
 	if (query == NULL) {
@@ -220,22 +264,11 @@ static int read_one_map(const char *root,
 	}
 
 	memset(query, '\0', l);
-	if (keyvallen > 0) {
-		if (sprintf(query, "(&(objectclass=%s)(%s=%.*s))", class,
-			    key, keyvallen, keyval) >= l) {
-			debug(MODPREFIX "%s: error forming query string", __func__);
-		}
-	} else {
-		if (sprintf(query, "(objectclass=%s)", class) >= l) {
-			debug(MODPREFIX "%s: error forming query string", __func__);
-		}
+	if (sprintf(query, "(objectclass=%s)", class) >= l) {
+		debug(MODPREFIX "error forming query string");
 	}
 	query[l - 1] = '\0';
 
-	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, result_ldap);
-	if (!ldap)
-		return 0;
 
 	/* Look around. */
 	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
@@ -245,7 +278,6 @@ static int read_one_map(const char *root,
 
 	if ((rv != LDAP_SUCCESS) || !result) {
 	        crit(MODPREFIX "%s: query failed for %s: %s", __func__, query, ldap_err2string(rv));
-		ldap_unbind(ldap);
 		*result_ldap = rv;
 		return 0;
 	}
@@ -254,7 +286,6 @@ static int read_one_map(const char *root,
 	if (!e) {
 		debug(MODPREFIX "%s: query succeeded, no matches for %s", __func__, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return 0;
 	} else
 		debug(MODPREFIX "%s: examining entries", __func__ );
@@ -267,6 +298,8 @@ static int read_one_map(const char *root,
 			continue;
 		}
 
+		found_entry = 1;
+
 		values = ldap_get_values(ldap, e, type);
 		if (!values) {
 			info(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
@@ -295,37 +328,55 @@ static int read_one_map(const char *root,
 
 	/* Clean up. */
 	ldap_msgfree(result);
-	ldap_unbind(ldap);
 
-	return 1;
+	if (found_entry) 
+		return 1;
+	else
+		return 0;
 }
 
 static int read_map(const char *root, struct lookup_context *ctxt,
-		    const char *key, int keyvallen, time_t age, int *result_ldap)
+		    time_t age, int *result_ldap)
 {
-	int rv1 = LDAP_SUCCESS, rv2 = LDAP_SUCCESS;
-	int ret;
-
-	/* all else fails read entire map */
-	ret = read_one_map(root, "nisObject", "cn", 
-			  key, keyvallen, "nisMapEntry", ctxt, age, &rv1);
-	if (ret)
-		goto ret_ok;
+	LDAP *ldap;
+	int rv = LDAP_SUCCESS;
+	int ret, i;
 
-	ret = read_one_map(root, "automount", "cn", key, keyvallen, 
-			  "automountInformation", ctxt, age, &rv2);
-	if (ret)
-		goto ret_ok;
+	/* Initialize the LDAP context. */
+	ldap = do_connect(ctxt, &rv);
+	if (!ldap) {
+		if (rv != LDAP_SUCCESS)
+			*result_ldap = rv;
+		return 0;
+	}
 
+	/* all else fails read entire map */
+	if (ctxt->schema) {
+		ret = read_one_map(ldap, root, ctxt->schema, ctxt, age, &rv);
+		if (ret == 1 && rv == LDAP_SUCCESS)
+			goto ret_ok;
+	} else {
+		for (i = 0; i < NR_SCHEMAS; i++) {
+			ret = read_one_map(ldap, root,
+					   &supported_schemas[i],
+					   ctxt, age, &rv);
+			if (ret == 1 && rv == LDAP_SUCCESS) {
+				set_schema(ctxt, &supported_schemas[i]);
+				goto ret_ok;
+			}
+		}
+	}
+ 
+	ldap_unbind(ldap);
 	if (result_ldap)
-		*result_ldap = (rv1 == LDAP_SUCCESS ? rv2 : rv1);
+		*result_ldap = rv;
 
 	return 0;
 
 ret_ok:
 	/* Clean stale entries from the cache */
 	cache_clean(root, age);
-
+	ldap_unbind(ldap);
 	return 1;
 }
 
@@ -339,7 +390,7 @@ int lookup_ghost(const char *root, int ghost, time_t now, void *context)
 
 	chdir("/");
 
-	if (!read_map(root, ctxt, NULL, 0, age, &rv))
+	if (!read_map(root, ctxt, age, &rv))
 		switch (rv) {
 		case LDAP_SIZELIMIT_EXCEEDED:
 		case LDAP_UNWILLING_TO_PERFORM:
@@ -378,17 +429,21 @@ int lookup_ghost(const char *root, int ghost, time_t now, void *context)
 	return status;
 }
 
-static int lookup_one(const char *root, const char *qKey,
-		      const char *class, char *key, char *type,
-		      struct lookup_context *ctxt)
+static int lookup_one_schema(LDAP *ldap, const char *root, const char *qKey,
+			     struct autofs_schema *schema,
+			     struct lookup_context *ctxt)
 {
 	int rv, i, l, ql;
 	time_t age = time(NULL);
 	char *query;
 	LDAPMessage *result, *e;
 	char **values = NULL;
-	char *attrs[] = { key, type, NULL };
-	LDAP *ldap;
+	char *attrs[] = { schema->entry_key_attr,
+			  schema->entry_value_attr,
+			  NULL };
+	const char *class = schema->entry_object_class,
+		   *key = schema->entry_key_attr,
+		   *type = schema->entry_value_attr;
 	struct mapent_cache *me = NULL;
 	int ret = CHE_OK;
 
@@ -419,38 +474,29 @@ static int lookup_one(const char *root, const char *qKey,
 
 	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
 
-	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, &rv);
-	if (!ldap)
-		return 0;
-
 	rv = ldap_search_s(ldap, ctxt->base, LDAP_SCOPE_SUBTREE,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
 		crit(MODPREFIX "%s: query failed for %s", __func__, query);
-		ldap_unbind(ldap);
 		return 0;
 	}
 
-
 	debug(MODPREFIX "%s: getting first entry for %s=\"%s\"", __func__, key, qKey);
+
 	e = ldap_first_entry(ldap, result);
 	if (!e) {
 		debug(MODPREFIX "%s: got answer, but no first entry for %s", __func__, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
-
 	debug(MODPREFIX "%s: examining first entry", __func__);
 
 	values = ldap_get_values(ldap, e, type);
 	if (!values) {
 		debug(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -478,22 +524,51 @@ static int lookup_one(const char *root, const char *qKey,
 	/* Clean up. */
 	ldap_value_free(values);
 	ldap_msgfree(result);
-	ldap_unbind(ldap);
 
 	return ret;
 }
 
-static int lookup_wild(const char *root,
-		      const char *class, char *key, char *type,
+static int lookup_one(LDAP *ldap, const char *root, const char *qKey,
 		      struct lookup_context *ctxt)
 {
+	int ret, i;
+
+	if (ctxt->schema) {
+		ret = lookup_one_schema(ldap, root, qKey, ctxt->schema, ctxt);
+		debug("lookup_one with schema %s,%s,%s returns %d\n",
+		      ctxt->schema->entry_key_attr,
+		      ctxt->schema->entry_object_class,
+		      ctxt->schema->entry_value_attr, ret);
+	} else {
+		for (i = 0; i < NR_SCHEMAS; i++) {
+			ret = lookup_one_schema(ldap, root, qKey,
+					 &supported_schemas[i], ctxt);
+			debug("lookup_one with schema %d returns %d\n",i, ret);
+			if (ret != CHE_FAIL) {
+				set_schema(ctxt, &supported_schemas[i]);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int lookup_wild_schema(LDAP *ldap, const char *root,
+			      struct autofs_schema *schema,
+			      struct lookup_context *ctxt)
+{
 	int rv, i, l, ql;
 	time_t age = time(NULL);
 	char *query;
 	LDAPMessage *result, *e;
 	char **values = NULL;
-	char *attrs[] = { key, type, NULL };
-	LDAP *ldap;
+	char *attrs[] = { schema->entry_key_attr,
+			  schema->entry_value_attr,
+			  NULL };
+	const char *class = schema->entry_object_class,
+		   *key = schema->entry_key_attr,
+		   *type = schema->entry_value_attr;
 	struct mapent_cache *me = NULL;
 	int ret = CHE_OK;
 	char qKey[KEY_MAX_LEN + 1];
@@ -528,28 +603,20 @@ static int lookup_wild(const char *root,
 
 	debug(MODPREFIX "%s: searching for \"%s\" under \"%s\"", __func__, query, ctxt->base);
 
-	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, &rv);
-	if (!ldap)
-		return 0;
-
 	rv = ldap_search_s(ldap, ctxt->base, LDAP_SCOPE_SUBTREE,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
 		crit(MODPREFIX "%s: query failed for %s", __func__, query);
-		ldap_unbind(ldap);
 		return 0;
 	}
 
-
 	debug(MODPREFIX "%s: getting first entry for %s=\"%s\"", __func__, key, qKey);
 
 	e = ldap_first_entry(ldap, result);
 	if (!e) {
 		debug(MODPREFIX "%s: got answer, but no first entry for %s", __func__, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -559,7 +626,6 @@ static int lookup_wild(const char *root,
 	if (!values) {
 		debug(MODPREFIX "%s: no %s defined for %s", __func__, type, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -587,15 +653,38 @@ static int lookup_wild(const char *root,
 	/* Clean up. */
 	ldap_value_free(values);
 	ldap_msgfree(result);
-	ldap_unbind(ldap);
 
 	return ret;
 }
 
+
+static int lookup_wild(LDAP *ldap, const char *root,
+		       struct lookup_context *ctxt)
+{
+	int ret, i;
+
+	if (ctxt->schema)
+		return lookup_wild_schema(ldap, root, ctxt->schema, ctxt);
+
+
+	for (i = 0; i < NR_SCHEMAS; i++) {
+		ret = lookup_wild_schema(ldap, root,
+					 &supported_schemas[i], ctxt);
+		if (ret != CHE_FAIL) {
+			set_schema(ctxt, &supported_schemas[i]);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/* lookup_mount returns 1 if there was some kind of error */
 int lookup_mount(const char *root, const char *name, int name_len, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	int ret, ret2;
+	LDAP *ldap;
+	int ret;
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
@@ -613,42 +702,42 @@ int lookup_mount(const char *root, const char *name, int name_len, void *context
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
-	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
-	ret2 = lookup_one(root, key,
-			    "automount", "cn", "automountInformation", ctxt);
-	
-   	debug("ret = %d, ret2 = %d", ret, ret2);
 
-	if (!ret && !ret2)
+	/* Initialize the LDAP context. */
+	ldap = do_connect(ctxt, NULL);
+	if (!ldap)
+		return 0;
+	
+	ret = lookup_one(ldap, root, key, ctxt);
+	if (ret == CHE_FAIL) {
+		ldap_unbind(ldap);
 		return 1;
+	}
 
 	me = cache_lookup_first();
 	t_last_read = me ? now - me->age : ap.exp_runfreq + 1;
 
 	if (t_last_read > ap.exp_runfreq) 
-		if ((ret & (CHE_MISSING | CHE_UPDATED)) && 
-		    (ret2 & (CHE_MISSING | CHE_UPDATED)))
+		if (ret & (CHE_MISSING | CHE_UPDATED))
 			need_hup = 1;
 
-	if (ret == CHE_MISSING && ret2 == CHE_MISSING) {
+
+	if (ret == CHE_MISSING) {
 		int wild = CHE_MISSING;
 
 		/* Maybe update wild card map entry */
 		if (ap.type == LKP_INDIRECT) {
-			ret = lookup_wild(root, "nisObject",
-					  "cn", "nisMapEntry", ctxt);
-			ret2 = lookup_wild(root, "automount",
-					   "cn", "automountInformation", ctxt);
-			wild = (ret & (CHE_MISSING | CHE_FAIL)) &&
-					(ret2 & (CHE_MISSING | CHE_FAIL));
-
-			if (ret & CHE_MISSING && ret2 & CHE_MISSING)
+			ret = lookup_wild(ldap, root, ctxt);
+			wild = (ret & (CHE_MISSING | CHE_FAIL));
+
+			if (ret & CHE_MISSING)
 				cache_delete(root, "*", 0);
 		}
 
 		if (cache_delete(root, key, 0) && wild)
 			rmdir_path(key);
 	}
+	ldap_unbind(ldap);
 
 	me = cache_lookup(key);
 	if (me) {
-- 
1.7.3.3
