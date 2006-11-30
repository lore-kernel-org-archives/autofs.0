From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] Clean up the ldap code
Date: Thu, 30 Nov 2006 12:45:16 -0500
Message-ID: <x497ixcvnf7.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

Hi, Ian, list,

Here's a patch that significantly cleans up the lookup_ldap module.
In the beginning of time (for this module), there was only one
supported LDAP schema.  And for a time, it was good.  After a while,
however, standards emerged -- standards which conflicted with our
original LDAP schema vision.  With each new standard, our LDAP module
gained ugly if clauses and added return values.  The parsing of such
things made the module less and less pleasing to the eye.  And, users
began to complain of many queries to their poor little LDAP servers.

In a heroic effort to bring peace back to the world of autofs and
LDAP, I present this patch.  Among its merits, I submit the following:

o It will perform less binds to the LDAP server
o It will remember which LDAP schema worked, and continue to query
  only that schema (instead of trying all three every time)
o It will make the code much more read-able

Any and all comments are appreciated.

Thanks,

Jeff

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 08a1c56..51edd6f 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -39,14 +39,50 @@ #define MAPFMT_DEFAULT "sun"
 
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
+struct autofs_schema supported_schemas[3] = {
+	{ "nisMap", "nisMapName", "nisObject", "cn", "nisMapEntry" },
+	{ "automountMap", "ou", "automount", "cn", "automountInformation" },
+	{ "automountMap", "automountMapName",
+	  "automount", "automountKey", "automountInformation" },
+};
+#define NR_SCHEMAS	3
+
 struct lookup_context {
 	char *server, *base;
 	int port;
+	/* once we find a schema that works, save it for future lookups */
+	struct autofs_schema *schema;
 	struct parse_mod *parse;
 };
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
+void set_schema(struct lookup_context *ctxt, struct autofs_schema *schema)
+{
+	ctxt->schema = schema;
+}
+
 static LDAP *do_connect(struct lookup_context *ctxt, int *result_ldap)
 {
 	LDAP *ldap;
@@ -159,8 +195,8 @@ struct lookup_context *context_init(cons
 	memcpy(ctxt->base, ptr, l);
 
 	debug(MODPREFIX "server = \"%s\", port = %d, base dn = \"%s\"",
-		  ctxt->server ? ctxt->server : "(default)",
-		  ctxt->port, ctxt->base);
+	      ctxt->server ? ctxt->server : "(default)",
+	      ctxt->port, ctxt->base);
 
 	return ctxt;
 }
@@ -196,9 +232,8 @@ int lookup_init(const char *mapfmt, int 
 	return !(ctxt->parse = open_parse(mapfmt, MODPREFIX, argc-1, argv+1));
 }
 
-static int read_one_map(const char *root,
-			const char *class, char *key,
-			const char *keyval, int keyvallen, char *type,
+static int read_one_map(LDAP *ldap, const char *root,
+			struct autofs_schema *schema,
 			struct lookup_context *ctxt,
 			time_t age, int *result_ldap)
 {
@@ -207,8 +242,12 @@ static int read_one_map(const char *root
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
 	int found_entry = 0;
 
 	if (ctxt == NULL) {
@@ -218,10 +257,6 @@ static int read_one_map(const char *root
 
 	/* Build a query string. */
 	l = strlen("(objectclass=)") + strlen(class) + 1;
-	if (keyvallen > 0) {
-		l += strlen(key) +keyvallen + strlen("(&(=))");
-	}
-
 	query = alloca(l);
 	if (query == NULL) {
 		crit(MODPREFIX "malloc: %m");
@@ -229,22 +264,11 @@ static int read_one_map(const char *root
 	}
 
 	memset(query, '\0', l);
-	if (keyvallen > 0) {
-		if (sprintf(query, "(&(objectclass=%s)(%s=%.*s))", class,
-			    key, keyvallen, keyval) >= l) {
-			debug(MODPREFIX "error forming query string");
-		}
-	} else {
-		if (sprintf(query, "(objectclass=%s)", class) >= l) {
-			debug(MODPREFIX "error forming query string");
-		}
+	if (sprintf(query, "(objectclass=%s)", class) >= l) {
+		debug(MODPREFIX "error forming query string");
 	}
-	query[l - 1] = '\0';
 
-	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, result_ldap);
-	if (!ldap)
-		return 0;
+	query[l - 1] = '\0';
 
 	/* Look around. */
 	debug(MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->base);
@@ -254,7 +278,6 @@ static int read_one_map(const char *root
 
 	if ((rv != LDAP_SUCCESS) || !result) {
 		crit(MODPREFIX "query failed for %s: %s", query, ldap_err2string(rv));
-		ldap_unbind(ldap);
 		*result_ldap = rv;
 		return 0;
 	}
@@ -263,7 +286,6 @@ static int read_one_map(const char *root
 	if (!e) {
 		debug(MODPREFIX "query succeeded, no matches for %s", query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return 0;
 	} else
 		debug(MODPREFIX "examining entries");
@@ -306,7 +328,6 @@ static int read_one_map(const char *root
 
 	/* Clean up. */
 	ldap_msgfree(result);
-	ldap_unbind(ldap);
 
 	if (found_entry) 
 		return 1;
@@ -315,42 +336,46 @@ static int read_one_map(const char *root
 }
 
 static int read_map(const char *root, struct lookup_context *ctxt,
-		    const char *key, int keyvallen, time_t age, int *result_ldap)
+		    time_t age, int *result_ldap)
 {
+	LDAP *ldap;
 	int rv = LDAP_SUCCESS;
-	int ret;
+	int ret, i;
 
-	/* all else fails read entire map */
-	ret = read_one_map(root, "nisObject", "cn", 
-			  key, keyvallen, "nisMapEntry", ctxt, age, &rv);
-	if (ret) {
-		if (rv == LDAP_SUCCESS)
-			goto ret_ok;
-	}
-
-	ret = read_one_map(root, "automount", "cn", key, keyvallen, 
-			  "automountInformation", ctxt, age, &rv);
-	if (ret) {
-		if (rv == LDAP_SUCCESS)
-			goto ret_ok;
+	/* Initialize the LDAP context */
+	ldap = do_connect(ctxt, &rv);
+	if (!ldap) {
+		if (rv != LDAP_SUCCESS)
+			*result_ldap = rv;
+		return 0;
 	}
 
-	ret = read_one_map(root, "automount", "automountKey", key, keyvallen, 
-			  "automountInformation", ctxt, age, &rv);
-	if (ret) {
-		if (rv == LDAP_SUCCESS)
-			goto ret_ok;
+	if (ctxt->schema) {
+		ret = read_one_map(ldap, root, ctxt->schema, ctxt, age, &rv);
+		if (ret == 1 && rv == LDAP_SUCCESS)
+			goto done;
+	} else {
+		for (i = 0; i < NR_SCHEMAS; i++) {
+			ret = read_one_map(ldap, root,
+					   &supported_schemas[i],
+					   ctxt, age, &rv);
+			if (ret == 1 && rv == LDAP_SUCCESS) {
+				set_schema(ctxt, &supported_schemas[i]);
+				goto done;
+			}
+		}
 	}
 
-	if (result_ldap)
+	ldap_unbind(ldap);
+	if (result_ldap != NULL)
 		*result_ldap = rv;
 
 	return 0;
 
-ret_ok:
+done:
 	/* Clean stale entries from the cache */
 	cache_clean(root, age);
-
+	ldap_unbind(ldap);
 	return 1;
 }
 
@@ -364,7 +389,7 @@ int lookup_ghost(const char *root, int g
 
 	chdir("/");
 
-	if (!read_map(root, ctxt, NULL, 0, age, &rv))
+	if (!read_map(root, ctxt, age, &rv))
 		switch (rv) {
 		case LDAP_SIZELIMIT_EXCEEDED:
 		case LDAP_UNWILLING_TO_PERFORM:
@@ -403,17 +428,21 @@ int lookup_ghost(const char *root, int g
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
 
@@ -464,7 +493,6 @@ static int lookup_one(const char *root, 
 	if (!e) {
 		debug(MODPREFIX "got answer, but no first entry for %s", query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -507,17 +535,47 @@ static int lookup_one(const char *root, 
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
@@ -552,17 +610,11 @@ static int lookup_wild(const char *root,
 
 	debug(MODPREFIX "searching for \"%s\" under \"%s\"", query, ctxt->base);
 
-	/* Initialize the LDAP context. */
-	ldap = do_connect(ctxt, &rv);
-	if (!ldap)
-		return 0;
-
 	rv = ldap_search_s(ldap, ctxt->base, LDAP_SCOPE_SUBTREE,
 			   query, attrs, 0, &result);
 
 	if ((rv != LDAP_SUCCESS) || !result) {
 		crit(MODPREFIX "query failed for %s", query);
-		ldap_unbind(ldap);
 		return 0;
 	}
 
@@ -572,7 +624,6 @@ static int lookup_wild(const char *root,
 	if (!e) {
 		debug(MODPREFIX "got answer, but no first entry for %s", query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -582,7 +633,6 @@ static int lookup_wild(const char *root,
 	if (!values) {
 		debug(MODPREFIX "no %s defined for %s", type, query);
 		ldap_msgfree(result);
-		ldap_unbind(ldap);
 		return CHE_MISSING;
 	}
 
@@ -610,7 +660,27 @@ static int lookup_wild(const char *root,
 	/* Clean up. */
 	ldap_value_free(values);
 	ldap_msgfree(result);
-	ldap_unbind(ldap);
+
+	return ret;
+}
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
 
 	return ret;
 }
@@ -618,7 +688,8 @@ static int lookup_wild(const char *root,
 int lookup_mount(const char *root, const char *name, int name_len, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	int ret, ret2, ret3;
+	LDAP *ldap;
+	int ret;
 	char key[KEY_MAX_LEN + 1];
 	int key_len;
 	char mapent[MAPENT_MAX_LEN + 1];
@@ -636,47 +707,40 @@ int lookup_mount(const char *root, const
 	if (key_len > KEY_MAX_LEN)
 		return 1;
 
-	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
-	ret2 = lookup_one(root, key,
-			    "automount", "cn", "automountInformation", ctxt);
-	ret3 = lookup_one(root, key,
-			"automount", "automountKey", "automountInformation", ctxt);
-	
-   	debug("ret = %d, ret2 = %d ret3 = %d", ret, ret2, ret3);
+	/* Initialize the LDAP context. */
+	ldap = do_connect(ctxt, NULL);
+	if (!ldap)
+		return 0;
 
-	if (!ret && !ret2 && ret3)
+	ret = lookup_one(ldap, root, key, ctxt);
+	if (ret == CHE_FAIL) {
+		ldap_unbind(ldap);
 		return 1;
-
+	}
+	
 	me = cache_lookup_first();
 	t_last_read = me ? now - me->age : ap.exp_runfreq + 1;
 
 	if (t_last_read > ap.exp_runfreq) 
-		if ((ret & (CHE_MISSING | CHE_UPDATED)) && 
-		    (ret2 & (CHE_MISSING | CHE_UPDATED)) &&
-		    (ret3 & (CHE_MISSING | CHE_UPDATED)))
+		if (ret & (CHE_MISSING | CHE_UPDATED))
 			need_hup = 1;
 
-	if (ret == CHE_MISSING && ret2 == CHE_MISSING && ret3 == CHE_MISSING) {
+	if (ret == CHE_MISSING) {
 		int wild = CHE_MISSING;
 
 		/* Maybe update wild card map entry */
 		if (ap.type == LKP_INDIRECT) {
-			ret = lookup_wild(root, "nisObject",
-					  "cn", "nisMapEntry", ctxt);
-			ret2 = lookup_wild(root, "automount",
-					   "cn", "automountInformation", ctxt);
-			ret3 = lookup_wild(root, "automount", "automountKey",
-					   "automountInformation", ctxt);
-			wild = (ret & (CHE_MISSING | CHE_FAIL)) &&
-					(ret2 & (CHE_MISSING | CHE_FAIL));
-
-			if (ret & CHE_MISSING && ret2 & CHE_MISSING && ret3 & CHE_MISSING)
+			ret = lookup_wild(ldap, root, ctxt);
+			wild = ret & (CHE_MISSING | CHE_FAIL);
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
@@ -750,24 +814,20 @@ int lookup_one_included(char *map, char 
 {
 	struct lookup_context *ctxt;
 	int ret = 0;
+	LDAP *ldap;
 
 	ctxt = context_init(map);
 	if (!ctxt)
 		return CHE_FAIL;
 	ctxt->base = NULL;
 
-	ret = lookup_one(root, key, "nisObject", "cn", "nisMapEntry", ctxt);
-	if (ret & (CHE_UPDATED | CHE_OK))
-		goto done;
-
-	ret = lookup_one(root, key, "automount",
-			 "cn", "automountInformation", ctxt);
-	if (ret & (CHE_UPDATED | CHE_OK))
-		goto done;
+	/* Initialize the LDAP context. */
+	ldap = do_connect(ctxt, NULL);
+	if (!ldap)
+		return 0;
+	ret = lookup_one(ldap, root, key, ctxt);
+	ldap_unbind(ldap);
 
-	ret = lookup_one(root, key, "automount", "automountKey",
-			 "automountInformation", ctxt);
-done:
 	free(ctxt->server);
 	free(ctxt->base);
 	free(ctxt);
@@ -794,7 +854,7 @@ int lookup_readmap_included(char *map, c
 	ctxt->base = NULL;
 
 	/* read_map returns 0 for failure, 1 for success */
-	rv = read_map(root, ctxt, NULL, 0, age, &rv);
+	rv = read_map(root, ctxt, age, &rv);
 
 	free(ctxt->server);
 	free(ctxt->base);
