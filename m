From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] ldap search limit fix
Date: Fri, 29 Oct 2004 14:44:43 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1099079083.3396.133.camel@gold.msp.redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-y2qR9guis+36EEVqhA/U"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: raven@themaw.net, autofs@linux.kernel.org


--=-y2qR9guis+36EEVqhA/U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Currently if a site is using ldap for its automount maps and the number
of maps they have is greater than the search limit for their ldap
server, automount will give an error and quit at that mount point.

This is because the ldap search returns LDAP_SIZELIMIT_EXCEEDED, which
automount assumes is an error.  So the patch modifies automount so it
knows that if it recieves an LDAP_SIZELIMIT_EXCEEDED that it got the
map, it was just too large.  And automount knows that it can't ghost the
map, but it still can look up individual entries.


Thanks,
Chris



--=-y2qR9guis+36EEVqhA/U
Content-Description: 
Content-Disposition: attachment; filename=autofs-4.1.3-ldap-search-limit.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/modules/lookup_ldap.c.ldap-search-limit.patch	2004-04-03 01:14:33.000000000 -0600
+++ autofs-4.1.3/modules/lookup_ldap.c	2004-10-29 14:03:02.163260495 -0500
@@ -150,8 +150,10 @@ int lookup_init(const char *mapfmt, int 
 }
 
 static int read_one_map(const char *root,
-			const char *class, char *key, char *type,
-			struct lookup_context *context)
+			const char *class, char *key,
+			const char *keyval, int keyvallen, char *type,
+			struct lookup_context *context,
+			int *result_ldap)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv, i, l, count;
@@ -170,7 +172,10 @@ static int read_one_map(const char *root
 	}
 
 	/* Build a query string. */
-	l = strlen("(&(objectclass=))") + strlen(class) + 1;
+	l = strlen("(objectclass=)") + strlen(class) + 1;
+	if (keyvallen > 0) {
+		l += strlen(key) + keyvallen + strlen("(&(=))");
+	}
 
 	query = alloca(l);
 	if (query == NULL) {
@@ -179,8 +184,15 @@ static int read_one_map(const char *root
 	}
 
 	memset(query, '\0', l);
-	if (sprintf(query, "(&(objectclass=%s))", class) >= l) {
-		debug(MODPREFIX "error forming query string");
+	if (keyvallen > 0) {
+		if (sprintf(query, "(&(objectclass=%s)(%s=%.*s))", class,
+			    key, keyvallen, keyval) >= l) {
+			debug(MODPREFIX "error forming query string");
+		}
+	} else {
+		if (sprintf(query, "(objectclass=%s)", class) >= l) {
+			debug(MODPREFIX "error forming query string");
+		}
 	}
 	query[l - 1] = '\0';
 
@@ -212,6 +224,7 @@ static int read_one_map(const char *root
 	if (rv != LDAP_SUCCESS) {
 		crit(MODPREFIX "couldn't bind to %s",
 		     ctxt->server ? ctxt->server : "default server");
+		*result_ldap = rv;
 		return 0;
 	}
 
@@ -223,6 +236,7 @@ static int read_one_map(const char *root
 
 	if ((rv != LDAP_SUCCESS) || (result == NULL)) {
 		crit(MODPREFIX "query failed for %s", query);
+		*result_ldap = rv;
 		return 0;
 	}
 
@@ -268,15 +282,23 @@ static int read_one_map(const char *root
 	return 1;
 }
 
-static int read_map(const char *root, struct lookup_context *context)
+static int read_map(const char *root, struct lookup_context *context,
+		    const char *key, int keyvallen, int *result_ldap)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	time_t age = time(NULL);
+	int rv = LDAP_SUCCESS;
 
 	/* all else fails read entire map */
-	if (!read_one_map(root, "nisObject", "cn", "nisMapEntry", ctxt)) {
-		if (!read_one_map(root, "automount", "cn", "automountInformation", ctxt))
+	if (!read_one_map(root, "nisObject", "cn", key, keyvallen,
+				"nisMapEntry", ctxt, &rv)) {
+		if ((rv != LDAP_SUCCESS) ||
+		    !read_one_map(root, "automount", "cn", key, keyvallen,
+				  "automountInformation", ctxt, &rv)) {
+			if (result_ldap != NULL) 
+				*result_ldap = rv;
 			return 0;
+		}
 	}
 
 	/* Clean stale entries from the cache */
@@ -289,13 +311,22 @@ int lookup_ghost(const char *root, int g
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	struct mapent_cache *me;
-	int status = 1;
+	int status = 1, rv = LDAP_SUCCESS;
 	char *mapname;
 
 	chdir("/");
 
-	if (!read_map(root, ctxt))
-		return LKP_FAIL;
+	if (!read_map(root, ctxt, NULL, 0, &rv))
+		switch (rv) {
+		case LDAP_SIZELIMIT_EXCEEDED:
+			if (ghost)
+				crit("lookup_ghost: Unable to download "
+				    "the entire LDAP map for :%s ",mapname);
+		case LDAP_UNWILLING_TO_PERFORM:
+			return LKP_NOTSUP;
+		default:
+			return LKP_FAIL;
+		}
 
 	if (ctxt->server) {
 		mapname = alloca(strlen(ctxt->server) + strlen(ctxt->base) + 2 + 1 + 1);
@@ -382,8 +413,8 @@ int lookup_mount(const char *root, const
 
 	status = lookup(root, name, name_len, ctxt);
 	if (status == -1) {
-		/* all else fails read entire map */
-		if (!read_map(root, ctxt))
+		/* all else fails read just this entry */
+		if (!read_map(root, ctxt, name, name_len, NULL))
 			return 1;
 
 		status = lookup(root, name, name_len, ctxt);

--=-y2qR9guis+36EEVqhA/U
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-y2qR9guis+36EEVqhA/U--

