From: mzozd <mzozd@ad2u.gr>
Subject: Re: Autofs TLS and binddn/bindpw patch.
Date: Sun, 03 Apr 2005 14:45:54 +0100
Message-ID: <424FF392.6070300@ad2u.gr>
References: <424B6F70.8060802@ad2u.gr>
	<Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070502030904030100020304"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
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
To: raven@themaw.net, autofs@linux.kernel.org
Cc: root@ad2u.ath.cx

This is a multi-part message in MIME format.
--------------070502030904030100020304
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Dear Raven,

please DISREGARD MY PREVIOUS PATCH. I have created two seperate patches
to address this issue more seriously.

I am attaching the patches in this e-mail and i am going to give you a
short explanation of what is changed and why:

The problem is that if an ldap server is NOT allowing anonymous binds,
there is no way for autofs to acquire the information from the autofs
schema in ldap. Thus, it is also impossible to query for the schema if
the ldap server ENFORCES a TLS only authenticatiion.

The attached two patches address that issue by doing the following:

a) Open /etc/ldap.conf to read any rootbinddn option.
b) Open /etc/ldap.secret to read any password if the rootbinddn option
is in the conf.
c) Try to initiate TLS with the server (assuming the path to the
certifacte(s) is defined in /etc/openldap/ldap.conf).
d) Bind with rootdn and password defines in the configuration files.

I have successfully tested this patch with the latest autofs and
openldap autofs schema and it works. It may be needed some minor
adjustments. I have tried, and as far as i tested succeed, to maintain
the previous behaviour of the program but other people should verify
that via testing.


Thanks you,

MzOzD

PS: For any updates for this patch you may look at
http://crux-ports.ad2u.ath.cx/ports/autofs-ldap/

raven@themaw.net wrote:
> On Thu, 31 Mar 2005, mzozd wrote:
> 
>>
>> this patch adds support for TLS and non-anonymous binds for autofs.
> 
> 
> That's for master maps only right?
> 
> Ian
> 
> 

--------------070502030904030100020304
Content-Type: text/plain;
 name="autofs-ldap-auto-master.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-ldap-auto-master.patch"

--- samples/autofs-ldap-auto-master.orig.c	2005-04-02 17:43:52.000000000 +0100
+++ samples/autofs-ldap-auto-master.c	2005-04-02 20:05:21.000000000 +0100
@@ -27,6 +27,84 @@
 #define ENTRYKEY "cn"
 #define VALUE "nisMapEntry"
 
+#define LDAP_CONFIG "/etc/ldap.conf"
+#define LDAP_SECRET "/etc/ldap.secret"
+#define bsize 4096
+const char *binddn=NULL;
+const char *bindpw=NULL;
+
+void ldap_readconfig() {
+FILE *fp,*fp2;
+char b[bsize];
+
+
+if ( (fp = fopen(LDAP_CONFIG, "r")) != NULL) {
+
+while (fgets (b, sizeof (b), fp) != NULL) {
+  char *k, *v;
+  int len;
+
+if (*b == '\n' || *b == '#')
+        continue;
+      k = b;
+      v = k;
+/* skip past all characters in keyword */
+      while (*v != '\0' && *v != ' ' && *v != '\t')
+        v++;
+      if (*v == '\0')
+        continue;
+ /* terminate keyword */
+      *(v++) = '\0';
+
+      /* skip empty lines with more than 3 spaces at the start of the line */
+      /* rds.oliver@samera.com.py 01-set-2004                              */
+      if (*v == '\n')
+        continue;
+
+ /* skip all whitespaces between keyword and value */
+      /* Lars Oergel <lars.oergel@innominate.de>, 05.10.2000 */
+      while (*v == ' ' || *v == '\t')
+        v++;
+
+      /* kick off all whitespaces and newline at the end of value */
+      /* Bob Guo <bob@mail.ied.ac.cn>, 08.10.2001 */
+      len = strlen (v) - 1;
+      while (v[len] == ' ' || v[len] == '\t' || v[len] == '\n')
+        --len;
+      v[++len] = '\0';
+if (!strcasecmp (k, "rootbinddn")) {
+	binddn=v;
+	/* Open the /etc/ldap.secret now and read the password */
+	if ( (fp2 = fopen (LDAP_SECRET, "r")) == NULL) {
+		/* We couldn't read the pass, reset binddn and print
+		 * an error message
+		 */
+		binddn=NULL;
+		fprintf(stderr,"file %s couldn't be opened\n",LDAP_SECRET);
+	} else {
+		char tmp[128];
+		memset(tmp,0,sizeof(tmp));
+		if (fgets (tmp, sizeof (tmp), fp2) != NULL) {
+			int len;
+			len = strlen (tmp);
+			char buffer[128];
+			memset(buffer,0,sizeof(buffer));
+			if (len > 0 && tmp[len - 1] == '\n')
+	        		len--;
+	        	strncpy (buffer, tmp, len);
+			buffer[len] = '\0';
+	       		bindpw=buffer;
+		}
+	  fclose (fp2);
+	}
+    break;
+    }
+}
+fclose(fp);
+} else  
+	fprintf(stderr,"file %s couldn't be opened\n",LDAP_CONFIG);
+}
+
 static int
 dump_map(LDAP *ld,
 	 const char *map_name,
@@ -235,8 +313,27 @@
 		ld = ldap_init(NULL, LDAP_PORT);
 	}
 
-	/* Connect to the server anonymously. */
-	result = ldap_simple_bind_s(ld, NULL, NULL);
+	/* Get binddn/bindpw credentials from system config files.
+	 * That functions sucks. Someone fix this.
+	 */
+	ldap_readconfig(); 
+
+/*	fprintf(stderr,"Credentials: %s[%d]/%s[%d]\n",binddn,
+						      strlen(binddn),
+					              bindpw,
+						      strlen(bindpw));
+*/	
+       /* Start TLS */
+       result = ldap_start_tls_s(ld, NULL, NULL);
+       if (result != LDAP_SUCCESS) {
+               fprintf(stderr, "%s: ldap_connect: (TLS) ldap_start_tls() %s",
+                  argv[0], ldap_err2string(result));
+       }
+
+	/* Connect to the server anonymously or with the dn specified in the
+	 * system config files.
+	 */
+	result = ldap_simple_bind_s(ld, binddn, bindpw);
 	if(result != LDAP_SUCCESS) {
 		fprintf(stderr, "%s: error binding to server: %s\n",
 			argv[0], ldap_err2string(result));

--------------070502030904030100020304
Content-Type: text/plain;
 name="autofs-module-ldap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-module-ldap.patch"

--- modules/lookup_ldap.c.orig	2005-04-02 22:44:35.000000000 +0100
+++ modules/lookup_ldap.c	2005-04-02 22:43:46.000000000 +0100
@@ -27,7 +27,12 @@
 #define MAPFMT_DEFAULT "sun"
 
 #define MODPREFIX "lookup(ldap): "
-
+#define LDAP_CONFIG "/etc/ldap.conf"
+#define LDAP_SECRET "/etc/ldap.secret"
+#define bsize 4096 
+const char *binddn=NULL;
+const char *bindpw=NULL;
+	
 struct lookup_context {
 	char *server, *base;
 	int port;
@@ -36,6 +41,78 @@
 
 int lookup_version = AUTOFS_LOOKUP_VERSION;	/* Required by protocol */
 
+
+void ldap_readconfig() {
+
+FILE *fp,*fp2;
+char b[bsize];
+if ( (fp = fopen(LDAP_CONFIG, "r")) != NULL) {
+ 
+while (fgets (b, sizeof (b), fp) != NULL) {
+  char *k, *v;
+  int len;
+
+if (*b == '\n' || *b == '#')
+        continue;
+      k = b;
+      v = k;
+/* skip past all characters in keyword */
+      while (*v != '\0' && *v != ' ' && *v != '\t')
+        v++;
+      if (*v == '\0')   
+        continue;
+ /* terminate keyword */
+      *(v++) = '\0';
+
+      /* skip empty lines with more than 3 spaces at the start of the line */
+      /* rds.oliver@samera.com.py 01-set-2004                              */
+      if (*v == '\n')
+        continue;
+
+ /* skip all whitespaces between keyword and value */
+      /* Lars Oergel <lars.oergel@innominate.de>, 05.10.2000 */
+      while (*v == ' ' || *v == '\t')
+        v++;
+        
+      /* kick off all whitespaces and newline at the end of value */
+      /* Bob Guo <bob@mail.ied.ac.cn>, 08.10.2001 */
+      len = strlen (v) - 1;
+      while (v[len] == ' ' || v[len] == '\t' || v[len] == '\n')
+        --len;
+      v[++len] = '\0';  
+if (!strcasecmp (k, "rootbinddn")) {
+        binddn=v;
+        /* Open the /etc/ldap.secret now and read the password */
+        if ( (fp2 = fopen (LDAP_SECRET, "r")) == NULL) {
+                /* We couldn't read the pass, reset binddn and print
+                 * an error message
+               */  
+                binddn=NULL;
+                fprintf(stderr,"file %s couldn't be opened\n",LDAP_SECRET);
+        } else {
+                char tmp[128];
+                memset(tmp,0,sizeof(tmp));
+                if (fgets (tmp, sizeof (tmp), fp2) != NULL) {
+                        int len;
+                        len = strlen (tmp);
+                        char buffer[128];
+                        memset(buffer,0,sizeof(buffer));
+                        if (len > 0 && tmp[len - 1] == '\n')
+                                len--;
+                        strncpy (buffer, tmp, len);  
+                        buffer[len] = '\0';
+                        bindpw=buffer;
+                }
+          fclose (fp2);
+        }
+    break;
+    }
+}
+fclose(fp);
+} else
+        fprintf(stderr,"file %s couldn't be opened\n",LDAP_CONFIG);
+}
+
 /*
  * This initializes a context (persistent non-global data) for queries to
  * this module.  Return zero if we succeed.
@@ -131,11 +208,23 @@
 		}
 	}
 
+	/* Get binddn/bindpw credentials from system config files.
+	* That functions sucks. Someone fix this.
+	*/
+	ldap_readconfig();
+
+    /* Start TLS */
+       rv = ldap_start_tls_s(ldap, NULL, NULL);
+       if (rv != LDAP_SUCCESS) {
+               fprintf(stderr, "ldap_connect: (TLS) ldap_start_tls() %s", 
+                  ldap_err2string(rv));
+       }
+
 	/* Connect to the server as an anonymous user. */
 	if (version == 2)
 		rv = ldap_simple_bind_s(ldap, ctxt->base, NULL);
 	else
-		rv = ldap_simple_bind_s(ldap, NULL, NULL);
+		rv = ldap_simple_bind_s(ldap, binddn, bindpw);
 
 	if (rv != LDAP_SUCCESS) {
 		crit(MODPREFIX "couldn't connect to %s", ctxt->server);
@@ -203,11 +292,24 @@
 		}
 	}
 
+       /* Start TLS */
+       rv = ldap_start_tls_s(ldap, NULL, NULL);
+       if (rv != LDAP_SUCCESS) {
+               fprintf(stderr, "ldap_connect: (TLS) ldap_start_tls() %s",
+                  ldap_err2string(rv));
+       }
+
+       /* Get binddn/bindpw credentials from system config files.
+        * That functions sucks. Someone fix this.
+        */
+
+	ldap_readconfig();
+	
 	/* Connect to the server as an anonymous user. */
 	if (version == 2)
 		rv = ldap_simple_bind_s(ldap, ctxt->base, NULL);
 	else
-		rv = ldap_simple_bind_s(ldap, NULL, NULL);
+		rv = ldap_simple_bind_s(ldap, binddn, bindpw);
 
 	if (rv != LDAP_SUCCESS) {
 		crit(MODPREFIX "couldn't bind to %s",

--------------070502030904030100020304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070502030904030100020304--

