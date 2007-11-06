From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS / SASL support
Date: Tue, 06 Nov 2007 15:21:08 +0900
Message-ID: <1194330068.3095.6.camel@raven.themaw.net>
References: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
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
To: "Newman, Edward (GTI)" <edward_newman@ml.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-11-02 at 14:25 -0400, Newman, Edward (GTI) wrote:
> Just wanted to confirm whether SASL support is currently broken in 5.0.2
> with all outstanding patches applied. 
> 
> Debug of code suggests following issues:
> 
> - Makefile has invalid test for HAVE_SASL in configure.in and thus
> doesn't include correct libraries (-z instead of -n in test step)

OK, so for now just don't use --with-sasl and it should build in SASL
support.

> - patched code in connect_to_server in lookup_ldap.c does not call
> auth_init prior to testing for auth_required and thus fails SASL in all
> cases

Yes, please try patch below.

> - order of code sequence currently fails to enable SASL correctly.

As Jeff says, is this just restating the point above?

> 
> I am also trying to use an existing keytab for Kerberos GSSAPI
> authentication to directory and currently sasl_kinit code appears to
> fail. Haven't worked out exact cause yet but appears to not passing a
> keytab name and environment is not picking up location from krb5.conf.

This is a bit more interesting.
We need to be able to use alternate keytabs.
I believe that the code, as it is, will use the Kerberos5 mechanisms to
locate the keytab. Are you setting KRB5_KTNAME?

Anyway, this patch should fix the second issue you mentioned above.
Can you give it a try please?

---
diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
index 18733f3..75b8667 100644
--- a/modules/cyrus-sasl.c
+++ b/modules/cyrus-sasl.c
@@ -75,6 +75,7 @@ static const char *krb5ccval = "MEMORY:_autofstkt";
 static pthread_mutex_t krb5cc_mutex = PTHREAD_MUTEX_INITIALIZER;
 static unsigned int krb5cc_in_use = 0;
 
+static unsigned int init_callbacks = 1;
 static int sasl_log_func(void *, int, const char *);
 static int getpass_func(sasl_conn_t *, void *, int, sasl_secret_t **);
 static int getuser_func(void *, int, const char **, unsigned *);
@@ -721,23 +722,30 @@ autofs_sasl_init(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt)
 	sasl_conn_t *conn;
 
 	/* Start up Cyrus SASL--only needs to be done once. */
-	if (sasl_client_init(callbacks) != SASL_OK) {
+	if (init_callbacks && sasl_client_init(callbacks) != SASL_OK) {
 		error(logopt, "sasl_client_init failed");
 		return -1;
 	}
+	init_callbacks = 0;
 
 	sasl_auth_id = ctxt->user;
 	sasl_auth_secret = ctxt->secret;
 
 	/*
-	 *  If sasl_mech was not filled in, it means that there was no
-	 *  mechanism specified in the configuration file.  Try to auto-
-	 *  select one.
+	 *  If LDAP_AUTH_AUTODETECT is set, it means that there was no
+	 *  mechanism specified in the configuration file or auto
+	 *  selection has been requested, so try to auto-select an
+	 *  auth mechanism.
 	 */
-	if (ctxt->sasl_mech)
+	if (!(ctxt->auth_required & LDAP_AUTH_AUTODETECT))
 		conn = sasl_bind_mech(logopt, ldap, ctxt, ctxt->sasl_mech);
-	else
+	else {
+		if (ctxt->sasl_mech) {
+			free(ctxt->sasl_mech);
+			ctxt->sasl_mech = NULL;
+		}
 		conn = sasl_choose_mech(logopt, ldap, ctxt);
+	}
 
 	if (conn) {
 		sasl_dispose(&conn);
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index dfb3054..fc2ed52 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -400,8 +400,7 @@ static int do_bind(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt)
 	debug(logopt, MODPREFIX "auth_required: %d, sasl_mech %s",
 	      ctxt->auth_required, ctxt->sasl_mech);
 
-	if (ctxt->sasl_mech ||
-	   (ctxt->auth_required & (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT))) {
+	if (ctxt->auth_required & (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)) {
 		rv = autofs_sasl_bind(logopt, ldap, ctxt);
 		debug(logopt, MODPREFIX "autofs_sasl_bind returned %d", rv);
 	} else {
@@ -495,7 +494,7 @@ static LDAP *connect_to_server(unsigned logopt, const char *uri, struct lookup_c
 	 * Determine which authentication mechanism to use if we require
 	 * authentication.
 	 */
-	if (ctxt->auth_required & LDAP_AUTH_REQUIRED) {
+	if (ctxt->auth_required & (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)) {
 		ldap = auth_init(logopt, uri, ctxt);
 		if (!ldap && ctxt->auth_required & LDAP_AUTH_AUTODETECT)
 			info(logopt,
@@ -577,7 +576,9 @@ static LDAP *do_reconnect(unsigned logopt, struct lookup_context *ctxt)
 		list_add_tail(&this->list, ctxt->uri);
 	}
 
+#ifdef WITH_SASL
 	autofs_sasl_done(ctxt);
+#endif
 
 	/* Current server failed connect, try the rest */
 	ldap = find_server(logopt, ctxt);
@@ -840,6 +841,8 @@ int parse_ldap_config(unsigned logopt, struct lookup_context *ctxt)
 	ctxt->tls_required = tls_required;
 	ctxt->auth_required = auth_required;
 	ctxt->sasl_mech = authtype;
+	if (!authtype && (auth_required & LDAP_AUTH_REQUIRED))
+		ctxt->auth_required |= LDAP_AUTH_AUTODETECT;
 	ctxt->user = user;
 	ctxt->secret = secret;
 	ctxt->client_princ = client_princ;
@@ -882,16 +885,6 @@ static LDAP *auth_init(unsigned logopt, const char *uri, struct lookup_context *
 	int ret;
 	LDAP *ldap;
 
-	/*
-	 *  First, check to see if a preferred authentication method was
-	 *  specified by the user.  parse_ldap_config will return error
-	 *  if the permissions on the file were incorrect, or if the
-	 *  specified authentication type is not valid.
-	 */
-	ret = parse_ldap_config(logopt, ctxt);
-	if (ret)
-		return NULL;
-
 	ldap = init_ldap_connection(logopt, uri, ctxt);
 	if (!ldap)
 		return NULL;
@@ -1180,6 +1173,7 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 	struct lookup_context *ctxt;
 	char buf[MAX_ERR_BUF];
 	LDAP *ldap = NULL;
+	int ret;
 
 	*context = NULL;
 
@@ -1220,6 +1214,20 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
 		}
 	}
 
+#ifdef WITH_SASL
+	/*
+	 *  First, check to see if a preferred authentication method was
+	 *  specified by the user.  parse_ldap_config will return error
+	 *  if the permissions on the file were incorrect, or if the
+	 *  specified authentication type is not valid.
+	 */
+	ret = parse_ldap_config(LOGOPT_NONE, ctxt);
+	if (ret) {
+		free_context(ctxt);
+		return 1;
+	}
+#endif
+
 	if (ctxt->server || !ctxt->uri) {
 		ldap = connect_to_server(LOGOPT_NONE, ctxt->server, ctxt);
 		if (!ldap) {
