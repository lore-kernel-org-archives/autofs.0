From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] auto-detect the base DN for map entries
Date: Thu, 30 Nov 2006 13:52:32 -0500
Message-ID: <x49vekwu5qn.fsf@segfault.boston.devel.redhat.com>
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

Currently, the Linux automounter requires the specification of the
search base as a part of the map name.  Thus, entries like the
following are not uncommon:

/home ldap:foo.example.com:nisMapName=auto.mnt,dc=example,dc=com

when what is really desirable is the following:

/home ldap:auto.mnt

The patch below allows for this more desirable syntax.  Comments, as
always, are welcome.

-Jeff

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 51edd6f..6c77b27 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -135,6 +135,95 @@ static LDAP *do_connect(struct lookup_co
 	return ldap;
 }
 
+/*
+ *  Returns 1 on success, 0 on failure.
+ */
+int autofs_get_basedn_schema(LDAP *ldap, struct lookup_context *ctxt,
+			     const char *mapname, struct autofs_schema *schema)
+{
+	int l, rv;
+	char *query, *basedn;
+	char *attrs[] = { LDAP_NO_ATTRS, NULL };
+	LDAPMessage *result, *e;
+	const char *class = schema->map_object_class,
+		   *key = schema->map_name_attr;
+
+	/* Build a query string. */
+	l = strlen("(&(objectclass=)(=))") + strlen(class) + strlen(key) +
+		strlen(mapname) + 1;
+	query = alloca(l);
+	if (query == NULL) {
+		crit(MODPREFIX "malloc: %m");
+		return 0;
+	}
+
+	memset(query, '\0', l);
+	if (sprintf(query, "(&(objectclass=%s)(%s=%s))",
+		    class, key, mapname) >= l) {
+		debug(MODPREFIX "error forming query string");
+		return 0;
+	}
+	query[l - 1] = '\0';
+
+	/* Look around. */
+	debug(MODPREFIX "searching for \"%s\"", query);
+
+	rv = ldap_search_s(ldap, NULL, LDAP_SCOPE_SUBTREE,
+			   query, attrs, 0, &result);
+	if ((rv != LDAP_SUCCESS) || !result) {
+		crit(MODPREFIX "query failed for %s", query);
+		return 0;
+	}
+	e = ldap_first_entry(ldap, result);
+	if (!e) {
+		debug(MODPREFIX "query succeeded, no matches for %s", query);
+		ldap_msgfree(result);
+		return 0;
+	}
+
+	basedn = ldap_get_dn(ldap, result);
+	ldap_msgfree(result);
+	if (!basedn)
+		return 0;
+
+	ctxt->base = strdup(basedn);
+	ldap_memfree(basedn);
+	if (!ctxt->base)
+		return 0;
+
+	debug("got base dn of %s\n", ctxt->base);
+	return 1;
+}
+
+int autofs_get_basedn(struct lookup_context *ctxt, const char *mapname)
+{
+	LDAP *ldap;
+	int i, ret;
+
+	ldap = do_connect(ctxt, NULL);
+	if (!ldap) {
+		error("Unable to bind to the ldap server!\n");
+		return -1;
+	}
+
+	if (ctxt->schema)
+		ret = autofs_get_basedn_schema(ldap, ctxt, mapname,
+					       ctxt->schema);
+	else {
+		for (i = 0; i < NR_SCHEMAS; i++) {
+			ret = autofs_get_basedn_schema(ldap, ctxt, mapname,
+						       &supported_schemas[i]);
+			if (ret == 1) {
+				set_schema(ctxt, &supported_schemas[i]);
+				break;
+			}
+		}
+	}
+
+	ldap_unbind(ldap);
+	return ret;
+}
+
 struct lookup_context *context_init(const char *mapname)
 {
 	struct lookup_context *ctxt = NULL;
@@ -189,10 +278,26 @@ struct lookup_context *context_init(cons
 	}
 
 	/* Isolate the base DN. */
-	l = strlen(ptr);
-	ctxt->base = malloc(l + 1);
-	memset(ctxt->base, 0, l + 1);
-	memcpy(ctxt->base, ptr, l);
+	if (strchr(ptr, '=') == NULL) {
+		if (!autofs_get_basedn(ctxt, mapname)) {
+			warn(MODPREFIX "Unable to determine base dn\n");
+			ctxt->base = NULL;
+		}
+	}
+
+	if (!ctxt->base) {
+		/*
+		 *  Previous versions of autofs would simply use
+		 *  whatever value was left in 'ptr' as the base dn.  So,
+		 *  in order to hopefully not cause regressions, that
+		 *  behaviour was preserved in the case where nothing
+		 *  more clever could be done.
+		 */
+		l = strlen(ptr);
+		ctxt->base = malloc(l + 1);
+		memset(ctxt->base, 0, l + 1);
+		memcpy(ctxt->base, ptr, l);
+	}
 
 	debug(MODPREFIX "server = \"%s\", port = %d, base dn = \"%s\"",
 	      ctxt->server ? ctxt->server : "(default)",
