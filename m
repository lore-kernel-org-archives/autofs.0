From: Ian Kent <raven@themaw.net>
Subject: Re: Debug of autofs 5.0.2-27
Date: Sun, 09 Mar 2008 15:48:34 +0900
Message-ID: <1205045314.2950.11.camel@raven.themaw.net>
References: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
	<1204984653.4451.2.camel@raven.themaw.net>
	<1204996041.30569.14.camel@cowie.iouk.ioroot.tld>
	<1204997239.4451.8.camel@raven.themaw.net>
	<1204997376.19321.1.camel@raven.themaw.net>
	<1204997597.30569.19.camel@cowie.iouk.ioroot.tld>
	<1204998824.4502.1.camel@raven.themaw.net>
	<1204999782.30569.34.camel@cowie.iouk.ioroot.tld>
	<1205000622.4502.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205000622.4502.16.camel@raven.themaw.net>
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
To: Colin.Simpson@iongeo.com
Cc: autofs@linux.kernel.org


On Sun, 2008-03-09 at 03:23 +0900, Ian Kent wrote:
> > 
> > In this version 5.0.2-27 in order to get autofs to bind to ldap with
> > gssapi we had to change in slapd.conf on the openldap server:
> > 
> > sasl-secprops  noplain,noactive,noanonymous,minssf=128
> > to
> > sasl-secprops  noplain,noactive,noanonymous,minssf=0
> > 
> > But for some reason autofs-5.0.2-16.i386.rpm is happy with
> > minssf=128 and binds fine, and works fine until the kerberos ticket
> > expires. 
> 
> I'll investigate.
> But the debug stuff appears to imply that the library callbacks aren't
> set, which is odd, maybe there's something unusual about the way the
> shared library data segments are handled. 

After looking at the sasl library code these global callbacks shouldn't
go away until the sasl library is unloaded, which would be a bit strange
since we are using it at the time this happens. Additionally, this could
be caused by to many calls to sasl_done() which autofs didn't call at
all.

Anyway, autofs isn't doing things quite right, not that that should lead
to this issue. The patch below shouldn't resolve this but it would be
good if you could try it in case I'm not understanding something about
shared library local data handling.

---
diff -up autofs-5.0.2/include/lookup_ldap.h.init-cb-on-load autofs-5.0.2/include/lookup_ldap.h
--- autofs-5.0.2/include/lookup_ldap.h.init-cb-on-load	2008-03-09 13:50:30.000000000 +0900
+++ autofs-5.0.2/include/lookup_ldap.h	2008-03-09 13:52:52.000000000 +0900
@@ -99,10 +99,12 @@ int unbind_ldap_connection(unsigned logo
 int authtype_requires_creds(const char *authtype);
 
 /* cyrus-sasl.c */
+int autofs_sasl_client_init(unsigned logopt);
 int autofs_sasl_init(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt);
 int autofs_sasl_bind(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt);
 void autofs_sasl_unbind(struct lookup_context *ctxt);
-void autofs_sasl_done(struct lookup_context *ctxt);
+void autofs_sasl_dispose(struct lookup_context *ctxt);
+void autofs_sasl_done(void);
 #endif
 
 #endif
diff -up autofs-5.0.2/modules/lookup_ldap.c.init-cb-on-load autofs-5.0.2/modules/lookup_ldap.c
--- autofs-5.0.2/modules/lookup_ldap.c.init-cb-on-load	2008-03-09 13:50:30.000000000 +0900
+++ autofs-5.0.2/modules/lookup_ldap.c	2008-03-09 13:58:47.000000000 +0900
@@ -599,7 +599,7 @@ static LDAP *connect_to_server(unsigned 
 
 		if (!do_bind(logopt, ldap, ctxt)) {
 			unbind_ldap_connection(logopt, ldap, ctxt);
-			autofs_sasl_done(ctxt);
+			autofs_sasl_dispose(ctxt);
 			error(logopt, MODPREFIX "cannot bind to server");
 			return NULL;
 		}
@@ -672,7 +672,7 @@ static LDAP *do_reconnect(unsigned logop
 	list_add_tail(&this->list, ctxt->uri);
 
 #ifdef WITH_SASL
-	autofs_sasl_done(ctxt);
+	autofs_sasl_dispose(ctxt);
 #endif
 
 	/* Current server failed connect, try the rest */
@@ -1330,6 +1330,13 @@ int lookup_init(const char *mapfmt, int 
 		free_context(ctxt);
 		return 1;
 	}
+
+	/* Init the sasl callbacks */
+	if (!autofs_sasl_client_init(LOGOPT_NONE)) {
+		error(LOGOPT_ANY, "failed to init sasl client");
+		free_context(ctxt);
+		return 1;
+	}
 #endif
 
 	if (ctxt->server || !ctxt->uri) {
@@ -2640,7 +2647,8 @@ int lookup_done(void *context)
 	struct lookup_context *ctxt = (struct lookup_context *) context;
 	int rv = close_parse(ctxt->parse);
 #ifdef WITH_SASL
-	autofs_sasl_done(ctxt);
+	autofs_sasl_dispose(ctxt);
+	autofs_sasl_done();
 #endif
 	free_context(ctxt);
 	return rv;
diff -up autofs-5.0.2/modules/cyrus-sasl.c.init-cb-on-load autofs-5.0.2/modules/cyrus-sasl.c
--- autofs-5.0.2/modules/cyrus-sasl.c.init-cb-on-load	2008-03-09 13:50:30.000000000 +0900
+++ autofs-5.0.2/modules/cyrus-sasl.c	2008-03-09 13:56:59.000000000 +0900
@@ -76,7 +76,6 @@ static const char *default_client = "aut
 static pthread_mutex_t krb5cc_mutex = PTHREAD_MUTEX_INITIALIZER;
 static unsigned int krb5cc_in_use = 0;
 
-static unsigned int init_callbacks = 1;
 static int sasl_log_func(void *, int, const char *);
 static int getpass_func(sasl_conn_t *, void *, int, sasl_secret_t **);
 static int getuser_func(void *, int, const char **, unsigned *);
@@ -878,13 +877,6 @@ autofs_sasl_init(unsigned logopt, LDAP *
 {
 	sasl_conn_t *conn;
 
-	/* Start up Cyrus SASL--only needs to be done once. */
-	if (init_callbacks && sasl_client_init(callbacks) != SASL_OK) {
-		error(logopt, "sasl_client_init failed");
-		return -1;
-	}
-	init_callbacks = 0;
-
 	sasl_auth_id = ctxt->user;
 	sasl_auth_secret = ctxt->secret;
 
@@ -916,8 +908,7 @@ autofs_sasl_init(unsigned logopt, LDAP *
  *  Destructor routine.  This should be called when finished with an ldap
  *  session.
  */
-void
-autofs_sasl_done(struct lookup_context *ctxt)
+void autofs_sasl_dispose(struct lookup_context *ctxt)
 {
 	int status, ret;
 
@@ -953,3 +944,28 @@ autofs_sasl_done(struct lookup_context *
 		ctxt->kinit_successful = 0;
 	}
 }
+
+/*
+ * Initialize the sasl callbacks, which increments the global
+ * use counter.
+ */
+int autofs_sasl_client_init(unsigned logopt)
+{
+	/* Start up Cyrus SASL--only needs to be done at library load. */
+	if (sasl_client_init(callbacks) != SASL_OK) {
+		error(logopt, "sasl_client_init failed");
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Decrement the library reference count and free resources if
+ * we are the last to close the library.
+ */
+void autofs_sasl_done(void)
+{
+	sasl_done();
+	return;
+}
+
