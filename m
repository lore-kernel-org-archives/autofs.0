From: mzozd <mzozd@ad2u.gr>
Subject: Autofs TLS and binddn/bindpw patch.
Date: Thu, 31 Mar 2005 04:33:04 +0100
Message-ID: <424B6F70.8060802@ad2u.gr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050105000601030609030706"
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------050105000601030609030706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear maintainer,

this patch adds support for TLS and non-anonymous binds for autofs.


You could include it in your next release if you feel so.




Thanks,


MzOzD

--------------050105000601030609030706
Content-Type: text/plain;
 name="autofs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs.patch"

--- samples/autofs-ldap-auto-master.c.orig	2005-03-30 17:43:06.000000000 +0100
+++ samples/autofs-ldap-auto-master.c	2005-03-31 01:11:23.000000000 +0100
@@ -26,6 +26,8 @@
 #define ENTRYOC "nisObject"
 #define ENTRYKEY "cn"
 #define VALUE "nisMapEntry"
+#define BINDDN NULL
+#define BINDPW NULL
 
 static int
 dump_map(LDAP *ld,
@@ -162,12 +164,12 @@
 	int c;
 	const char *map_key = MAPKEY, *entry_key = ENTRYKEY, *value = VALUE;
 	const char *map_oc = MAPOC, *entry_oc = ENTRYOC;
-	const char *map = MAP;
+	const char *map = MAP, *bindpw=BINDPW, *binddn=BINDDN;  
 
 	setlocale(LC_ALL, "");
 
 	/* Scan through the argument list. */
-	while((c = getopt(argc, argv, "m:e:n:k:v:")) != -1) {
+	while((c = getopt(argc, argv, "m:e:n:k:v:U:P:")) != -1) {
 		switch(c) {
 			case 'm':
 				/* This is the object class we expect maps to
@@ -198,8 +200,22 @@
 				 * VALUE attribute. */
 				value = optarg;
 				break;
+			case 'U':
+			/* This is the BindDN for connecting to the server
+			 *  Particular usefull in my opinion...
+			 */
+				binddn = optarg;
+				break;
+			case 'P':
+			/* This is the BindPW for connecting to the server
+			 *  Particular usefull in my opinion...
+			 */
+				bindpw = optarg;
+				break;
 			default:
 				fprintf(stderr, "syntax: %s\n"
+					"\t[-U] BindDN\n"
+					"\t[-P] BindPW\n"
 					"\t[-m %s] (map object class)\n"
 					"\t[-e %s] (entry object class)\n"
 					"\t[-n %s] (attribute used as map key)\n"
@@ -235,8 +251,15 @@
 		ld = ldap_init(NULL, LDAP_PORT);
 	}
 
+	/* Start TLS */
+	result = ldap_start_tls_s(ld, NULL, NULL);
+	if (result != LDAP_SUCCESS) {
+		fprintf(stderr, "%s: ldap_connect: (TLS) ldap_start_tls() %s",
+                  argv[0], ldap_err2string(result));
+	}
+
 	/* Connect to the server anonymously. */
-	result = ldap_simple_bind_s(ld, NULL, NULL);
+	result = ldap_simple_bind_s(ld, binddn, bindpw);
 	if(result != LDAP_SUCCESS) {
 		fprintf(stderr, "%s: error binding to server: %s\n",
 			argv[0], ldap_err2string(result));
@@ -244,6 +267,7 @@
 		return 2;
 	}
 
+
 	/* Try to dump the map given the preferred or user-supplied schema. */
 	if(!dump_map(ld, map, map_oc, entry_oc, map_key, entry_key, value)) {
 		if(strcmp(map_oc, "automountMap") ||

--------------050105000601030609030706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050105000601030609030706--

