From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] cleanup white-space in the autofs ldap
	helper
Date: Fri, 03 Nov 2006 18:21:10 -0500
Message-ID: <x49k62c15i1.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

tssia.

-Jeff

diff --git a/samples/autofs-ldap-auto-master.c b/samples/autofs-ldap-auto-master.c
index 387b4be..14ed9f1 100644
--- a/samples/autofs-ldap-auto-master.c
+++ b/samples/autofs-ldap-auto-master.c
@@ -1,5 +1,5 @@
 /*
- * ident $id$
+ * ident $Id:$
  *
  * Dump out the automount map given as an argument on the command line.
  */
@@ -12,10 +12,6 @@ #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
-#ifndef TRUE
-#define TRUE 1
-#endif
-
 #ifndef FALSE
 #define FALSE 0
 #endif
@@ -61,19 +57,19 @@ dump_map(LDAP *ld,
 				   NULL,
 				   LDAP_NO_LIMIT,
 				   &messages);
-	if(result != LDAP_SUCCESS) {
+	if (result != LDAP_SUCCESS) {
 		return 0;
 	}
 
 	/* We expected only one match.  Pull it from the results list. */
 	entry = ldap_first_entry(ld, messages);
-	if(entry == NULL) {
+	if (entry == NULL) {
 		return 0;
 	}
 
 	/* Get the DN of the map. */
 	dn = ldap_get_dn(ld, entry);
-	if((dn == NULL) || (strlen(dn) == 0)) {
+	if ((dn == NULL) || (strlen(dn) == 0)) {
 		return 0;
 	}
 
@@ -83,15 +79,15 @@ dump_map(LDAP *ld,
 	/* Free memory used by our first query. */
 	free(attrs[0]);
 	free(attrs[1]);
-	if(server) {
+	if (server) {
 		ldap_control_free(server);
 		server = NULL;
 	}
-	if(client) {
+	if (client) {
 		ldap_control_free(client);
 		client = NULL;
 	}
-	if(messages) {
+	if (messages) {
 		ldap_msgfree(messages);
 		messages = NULL;
 	}
@@ -110,43 +106,43 @@ dump_map(LDAP *ld,
 				   NULL,
 				   LDAP_NO_LIMIT,
 				   &messages);
-	if(result != LDAP_SUCCESS) {
+	if (result != LDAP_SUCCESS) {
 		return 0;
 	}
 
 	/* Iterate through the results, dumping them out. */
-	for(entry = ldap_first_entry(ld, messages);
-	    entry != NULL;
-	    entry = ldap_next_entry(ld, entry)) {
+	for (entry = ldap_first_entry(ld, messages);
+	     entry != NULL;
+	     entry = ldap_next_entry(ld, entry)) {
 		keys = ldap_get_values(ld, entry, entry_key_attribute);
 		values = ldap_get_values(ld, entry, value_attribute);
-		if(keys && keys[0] && values && values[0]) {
+		if (keys && keys[0] && values && values[0]) {
 			found = 1;
 			printf("%s %s\n", keys[0], values[0]);
 		}
-		if(keys != NULL) {
+		if (keys != NULL) {
 			ldap_value_free(keys);
 		}
-		if(values != NULL) {
+		if (values != NULL) {
 			ldap_value_free(values);
 		}
 	}
 
 	/* Clean up and return. */
-	if(dn) {
+	if (dn) {
 		ldap_memfree(dn);
 	}
 	free(attrs[0]);
 	free(attrs[1]);
-	if(server) {
+	if (server) {
 		ldap_control_free(server);
 		server = NULL;
 	}
-	if(client) {
+	if (client) {
 		ldap_control_free(client);
 		client = NULL;
 	}
-	if(messages) {
+	if (messages) {
 		ldap_msgfree(messages);
 		messages = NULL;
 	}
@@ -167,8 +163,8 @@ main(int argc, char **argv)
 	setlocale(LC_ALL, "");
 
 	/* Scan through the argument list. */
-	while((c = getopt(argc, argv, "m:e:n:k:v:")) != -1) {
-		switch(c) {
+	while ((c = getopt(argc, argv, "m:e:n:k:v:")) != -1) {
+		switch (c) {
 			case 'm':
 				/* This is the object class we expect maps to
 				 * have.  The default is MAPOC. */
@@ -221,21 +217,21 @@ main(int argc, char **argv)
 	}
 	/* An argument without a flag is the name of the map to look up
 	 * information in. */
-	if((argv[optind] != NULL) && (strlen(argv[optind]) > 0)) {
+	if ((argv[optind] != NULL) && (strlen(argv[optind]) > 0)) {
 		map = argv[optind];
 		mapset = 1;
 	}
 
 	/* Initialize the LDAP library, pointing it at the default server. */
 	ld = ldap_init(NULL, LDAP_PORT);
-	if(ld == NULL) {
+	if (ld == NULL) {
 		fprintf(stderr, "error initializing LDAP\n");
 		return 1;
 	}
 
 	/* Try to switch to protocol 3. */
 	c = 3;
-	if(ldap_set_option(ld, LDAP_OPT_PROTOCOL_VERSION, &c) != LDAP_SUCCESS) {
+	if (ldap_set_option(ld, LDAP_OPT_PROTOCOL_VERSION, &c) != LDAP_SUCCESS) {
 		/* Just retry with the default protocol version. */
 		ldap_unbind(ld);
 		ld = ldap_init(NULL, LDAP_PORT);
@@ -243,7 +239,7 @@ main(int argc, char **argv)
 
 	/* Connect to the server anonymously. */
 	result = ldap_simple_bind_s(ld, NULL, NULL);
-	if(result != LDAP_SUCCESS) {
+	if (result != LDAP_SUCCESS) {
 		fprintf(stderr, "%s: error binding to server: %s\n",
 			argv[0], ldap_err2string(result));
 		ldap_unbind(ld);
