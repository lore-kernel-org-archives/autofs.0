From: "Newman, Edward \(GTI\)" <edward_newman@ml.com>
Subject: Re: AutoFS / SASL support
Date: Tue, 6 Nov 2007 09:30:17 -0500
Message-ID: <E5F741E838FC2043A0B843E48181813806AB752A@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Ian

FYI - The supplied patch appears to break ldap maps with --ghost at the
end. Seems to be considered part of the search DN.

Regarding config, the issue appears to be that SASL code calls OpenLDAP
ldap_get_option and only returns "host" value (which is an optional
setting). This is used to get LDAP host name (which may be different
depending on your other URI code). Sort of thing I was thinking about
would be:

- pick up server URI(s) from /etc/ldap.conf or via override in
/etc/sysconfig/autofs
- If explicit series of hosts supplied then attempt each in turn
(believe your code already does this but doesn't pass host name through
to SASL code)
- If only one supplied then might want to add option to check DNS to see
whether this returns multiple IP's - either through SRV records or via
multiple A records
- Code might also look at checking "supportedSASLMechanisms" for host
that it connects to as well as getting server name (dnsHostname). I was
originally testing with a load-balance name and SASL failed due to wrong
host principle for Kerberos ("Server not found in database").

Edward

___________________________________
Edward Newman
GTI A&E Identity Services, Merrill Lynch & Co
9th Fl, 222 Broadway, NY, NY 10038, USA
P: +1-212-670-1546  C: +1-917-975-2356



-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: 06 November 2007 07:23
To: Newman, Edward (GTI)
Cc: autofs@linux.kernel.org
Subject: RE: [autofs] AutoFS / SASL support


On Tue, 2007-11-06 at 06:41 -0500, Newman, Edward (GTI) wrote:
> Ian
> 
> Thanks. I was going to send you the attached patch which gets SASL
> working again. I will apply your patch and retest.
> 
> One thing I noticed in reviewing code is that three files have to be
> configured to set up LDAP - /etc/sysconfig/autofs,
> /etc/auto_ldap_auth.conf and /etc/openldap/ldap.conf. Is there a
reason
> for this? Can I look at rationalising this? Not clear why there is
made
> a dependency on XML libraries.

Not sure what to do about this fragmented configuration.

The dependency on /etc/openldap/ldap.conf was because we couldn't
specify servers to connect to or basedns to use for searching
in /etc/sysconfig/autofs but that has changed now with this problematic
enhancement (and another patch). I think allowing for the configuration
of the stuff needed from /etc/openldap/ldap.conf is the most important
thing to do and that's almost done. I guess there's the specification of
certificates as well but that's a fair bit of work and so it will have
to wait.

The /etc/auto_ldap_auth.conf being an XML file came along with the
Kerberos code that I merged from Jeff. I'm not sure why he wanted to use
XML and I wasn't really worried about it at the time. From memory it was
decided to put the authentication information in a separate, locked down
file, so it could be kept private while the general configuration could
still be read by anyone who may need to know about it.

Looks like there's a bit of line wrap in the attached patch, oops!

I think there's a memory leak as well calling parse_ldap_config multiple
times and I think calling autofs_sasl_init multiple times may be bad as
also. I think I dealt with that in my patch but I'll need to go over it
again before I commit it, if it actually works.

One little thing about patches, it's much easier for me to know what I'm
looking at if the -p option to diff is used when generating them.

> 
> Edward
> 
> 
> 
> diff -U 3 -r --exclude-from=exclude-files a/configure.in
b/configure.in
> --- a/configure.in	2007-11-05 17:53:01.000000000 -0500
> +++ b/configure.in	2007-11-05 16:18:59.000000000 -0500
> @@ -234,7 +234,7 @@
>  		SASL_FLAGS="-I${withval}/include"
>  	fi
>  )
> -if test -z "$HAVE_SASL" -a "$HAVE_LIBXML" == "1"
> +if test -n "$HAVE_SASL" -a "$HAVE_LIBXML" == "1"
>  then
>  	HAVE_SASL=0
>  	AC_CHECK_LIB(sasl2, sasl_client_start, HAVE_SASL=1
> LIBSASL="$LIBSASL -lsasl2", , -lsasl2 $LIBS)
> diff -U 3 -r --exclude-from=exclude-files a/modules/cyrus-sasl.c
> b/modules/cyrus-sasl.c
> --- a/modules/cyrus-sasl.c	2007-11-05 17:53:01.000000000 -0500
> +++ b/modules/cyrus-sasl.c	2007-11-05 16:41:08.000000000 -0500
> @@ -386,7 +386,7 @@
>  
>  	debug(logopt,
>  	      "initializing kerberos ticket: client principal %s ",
> -	      ctxt->client_princ ? "" : "autofsclient");
> +	      ctxt->client_princ ? ctxt->client_princ : "autofsclient");
>  
>  	ret = krb5_init_context(&ctxt->krb5ctxt);
>  	if (ret) {
> diff -U 3 -r --exclude-from=exclude-files a/modules/lookup_ldap.c
> b/modules/lookup_ldap.c
> --- a/modules/lookup_ldap.c	2007-11-05 17:53:01.000000000 -0500
> +++ b/modules/lookup_ldap.c	2007-11-05 16:28:04.000000000 -0500
> @@ -50,6 +50,7 @@
>  static unsigned int common_schema_count =
> sizeof(common_schema)/sizeof(struct ldap_schema);
>  
>  static LDAP *auth_init(unsigned logopt, const char *, struct
> lookup_context *);
> +static int parse_ldap_config(unsigned logopt, struct lookup_context
> *ctxt);
>  
>  int bind_ldap_anonymous(unsigned logopt, LDAP *ldap, struct
> lookup_context *ctxt)
>  {
> @@ -495,8 +496,35 @@
>  	 * Determine which authentication mechanism to use if we require
>  	 * authentication.
>  	 */
> +	int ret;
> +
> +	ret = parse_ldap_config(logopt, ctxt);
> +	if (ret)
> +		return NULL;
> +
>  	if (ctxt->auth_required & LDAP_AUTH_REQUIRED) {
> -		ldap = auth_init(logopt, uri, ctxt);
> +		//ldap = auth_init(logopt, uri, ctxt);
> +
> +		ldap = init_ldap_connection(logopt, uri, ctxt);
> +		if (!ldap)
> +			return NULL;
> +
> +		/*
> +	 	*  Initialize the sasl library.  It is okay if user and
> secret
> +	 	*  are NULL, here.
> +	 	*
> +	 	*  The autofs_sasl_init routine will figure out which
> mechamism
> +	 	*  to use. If kerberos is used, it will also take care
> to initialize
> +	 	*  the credential cache and the client and service
> principals.
> +	 	*/
> +		debug(logopt, "EN: Before autofs_sasl_init");
> +		ret = autofs_sasl_init(logopt, ldap, ctxt);
> +		debug(logopt, "EN: After autofs_sasl_init");
> +		if (ret) {
> +			ctxt->sasl_mech = NULL;
> +			return NULL;
> +		}
> +
>  		if (!ldap && ctxt->auth_required & LDAP_AUTH_AUTODETECT)
>  			info(logopt,
>  			     "no authentication mechanisms auto
> detected.");
> @@ -514,6 +542,8 @@
>  
>  		return ldap;
>  	}
> +	else
> +	{
>  #endif
>  
>  	ldap = do_connect(logopt, uri, ctxt);
> @@ -525,6 +555,11 @@
>  	}
>  
>  	return ldap;
> +
> +#ifdef WITH_SASL
> +	}
> +#endif
> +
>  }
>  
>  static LDAP *find_server(unsigned logopt, struct lookup_context
*ctxt)
> 
> 
> Edward
> 
> ___________________________________
> Edward Newman
> GTI A&E Identity Services, Merrill Lynch & Co
> 9th Fl, 222 Broadway, NY, NY 10038, USA
> P: +1-212-670-1546  C: +1-917-975-2356
> 
> 
> 
> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: 06 November 2007 01:21
> To: Newman, Edward (GTI)
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] AutoFS / SASL support
> 
> 
> On Fri, 2007-11-02 at 14:25 -0400, Newman, Edward (GTI) wrote:
> > Just wanted to confirm whether SASL support is currently broken in
> 5.0.2
> > with all outstanding patches applied. 
> > 
> > Debug of code suggests following issues:
> > 
> > - Makefile has invalid test for HAVE_SASL in configure.in and thus
> > doesn't include correct libraries (-z instead of -n in test step)
> 
> OK, so for now just don't use --with-sasl and it should build in SASL
> support.
> 
> > - patched code in connect_to_server in lookup_ldap.c does not call
> > auth_init prior to testing for auth_required and thus fails SASL in
> all
> > cases
> 
> Yes, please try patch below.
> 
> > - order of code sequence currently fails to enable SASL correctly.
> 
> As Jeff says, is this just restating the point above?
> 
> > 
> > I am also trying to use an existing keytab for Kerberos GSSAPI
> > authentication to directory and currently sasl_kinit code appears to
> > fail. Haven't worked out exact cause yet but appears to not passing
a
> > keytab name and environment is not picking up location from
krb5.conf.
> 
> This is a bit more interesting.
> We need to be able to use alternate keytabs.
> I believe that the code, as it is, will use the Kerberos5 mechanisms
to
> locate the keytab. Are you setting KRB5_KTNAME?
> 
> Anyway, this patch should fix the second issue you mentioned above.
> Can you give it a try please?
> 
> ---
> diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
> index 18733f3..75b8667 100644
> --- a/modules/cyrus-sasl.c
> +++ b/modules/cyrus-sasl.c
> @@ -75,6 +75,7 @@ static const char *krb5ccval = "MEMORY:_autofstkt";
>  static pthread_mutex_t krb5cc_mutex = PTHREAD_MUTEX_INITIALIZER;
>  static unsigned int krb5cc_in_use = 0;
>  
> +static unsigned int init_callbacks = 1;
>  static int sasl_log_func(void *, int, const char *);
>  static int getpass_func(sasl_conn_t *, void *, int, sasl_secret_t
**);
>  static int getuser_func(void *, int, const char **, unsigned *);
> @@ -721,23 +722,30 @@ autofs_sasl_init(unsigned logopt, LDAP *ldap,
> struct lookup_context *ctxt)
>  	sasl_conn_t *conn;
>  
>  	/* Start up Cyrus SASL--only needs to be done once. */
> -	if (sasl_client_init(callbacks) != SASL_OK) {
> +	if (init_callbacks && sasl_client_init(callbacks) != SASL_OK) {
>  		error(logopt, "sasl_client_init failed");
>  		return -1;
>  	}
> +	init_callbacks = 0;
>  
>  	sasl_auth_id = ctxt->user;
>  	sasl_auth_secret = ctxt->secret;
>  
>  	/*
> -	 *  If sasl_mech was not filled in, it means that there was no
> -	 *  mechanism specified in the configuration file.  Try to auto-
> -	 *  select one.
> +	 *  If LDAP_AUTH_AUTODETECT is set, it means that there was no
> +	 *  mechanism specified in the configuration file or auto
> +	 *  selection has been requested, so try to auto-select an
> +	 *  auth mechanism.
>  	 */
> -	if (ctxt->sasl_mech)
> +	if (!(ctxt->auth_required & LDAP_AUTH_AUTODETECT))
>  		conn = sasl_bind_mech(logopt, ldap, ctxt,
> ctxt->sasl_mech);
> -	else
> +	else {
> +		if (ctxt->sasl_mech) {
> +			free(ctxt->sasl_mech);
> +			ctxt->sasl_mech = NULL;
> +		}
>  		conn = sasl_choose_mech(logopt, ldap, ctxt);
> +	}
>  
>  	if (conn) {
>  		sasl_dispose(&conn);
> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> index dfb3054..fc2ed52 100644
> --- a/modules/lookup_ldap.c
> +++ b/modules/lookup_ldap.c
> @@ -400,8 +400,7 @@ static int do_bind(unsigned logopt, LDAP *ldap,
> struct lookup_context *ctxt)
>  	debug(logopt, MODPREFIX "auth_required: %d, sasl_mech %s",
>  	      ctxt->auth_required, ctxt->sasl_mech);
>  
> -	if (ctxt->sasl_mech ||
> -	   (ctxt->auth_required &
> (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT))) {
> +	if (ctxt->auth_required &
> (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)) {
>  		rv = autofs_sasl_bind(logopt, ldap, ctxt);
>  		debug(logopt, MODPREFIX "autofs_sasl_bind returned %d",
> rv);
>  	} else {
> @@ -495,7 +494,7 @@ static LDAP *connect_to_server(unsigned logopt,
> const char *uri, struct lookup_c
>  	 * Determine which authentication mechanism to use if we require
>  	 * authentication.
>  	 */
> -	if (ctxt->auth_required & LDAP_AUTH_REQUIRED) {
> +	if (ctxt->auth_required &
> (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)) {
>  		ldap = auth_init(logopt, uri, ctxt);
>  		if (!ldap && ctxt->auth_required & LDAP_AUTH_AUTODETECT)
>  			info(logopt,
> @@ -577,7 +576,9 @@ static LDAP *do_reconnect(unsigned logopt, struct
> lookup_context *ctxt)
>  		list_add_tail(&this->list, ctxt->uri);
>  	}
>  
> +#ifdef WITH_SASL
>  	autofs_sasl_done(ctxt);
> +#endif
>  
>  	/* Current server failed connect, try the rest */
>  	ldap = find_server(logopt, ctxt);
> @@ -840,6 +841,8 @@ int parse_ldap_config(unsigned logopt, struct
> lookup_context *ctxt)
>  	ctxt->tls_required = tls_required;
>  	ctxt->auth_required = auth_required;
>  	ctxt->sasl_mech = authtype;
> +	if (!authtype && (auth_required & LDAP_AUTH_REQUIRED))
> +		ctxt->auth_required |= LDAP_AUTH_AUTODETECT;
>  	ctxt->user = user;
>  	ctxt->secret = secret;
>  	ctxt->client_princ = client_princ;
> @@ -882,16 +885,6 @@ static LDAP *auth_init(unsigned logopt, const
char
> *uri, struct lookup_context *
>  	int ret;
>  	LDAP *ldap;
>  
> -	/*
> -	 *  First, check to see if a preferred authentication method was
> -	 *  specified by the user.  parse_ldap_config will return error
> -	 *  if the permissions on the file were incorrect, or if the
> -	 *  specified authentication type is not valid.
> -	 */
> -	ret = parse_ldap_config(logopt, ctxt);
> -	if (ret)
> -		return NULL;
> -
>  	ldap = init_ldap_connection(logopt, uri, ctxt);
>  	if (!ldap)
>  		return NULL;
> @@ -1180,6 +1173,7 @@ int lookup_init(const char *mapfmt, int argc,
> const char *const *argv, void **co
>  	struct lookup_context *ctxt;
>  	char buf[MAX_ERR_BUF];
>  	LDAP *ldap = NULL;
> +	int ret;
>  
>  	*context = NULL;
>  
> @@ -1220,6 +1214,20 @@ int lookup_init(const char *mapfmt, int argc,
> const char *const *argv, void **co
>  		}
>  	}
>  
> +#ifdef WITH_SASL
> +	/*
> +	 *  First, check to see if a preferred authentication method was
> +	 *  specified by the user.  parse_ldap_config will return error
> +	 *  if the permissions on the file were incorrect, or if the
> +	 *  specified authentication type is not valid.
> +	 */
> +	ret = parse_ldap_config(LOGOPT_NONE, ctxt);
> +	if (ret) {
> +		free_context(ctxt);
> +		return 1;
> +	}
> +#endif
> +
>  	if (ctxt->server || !ctxt->uri) {
>  		ldap = connect_to_server(LOGOPT_NONE, ctxt->server,
> ctxt);
>  		if (!ldap) {
> --------------------------------------------------------
> 
> This message w/attachments (message) may be privileged, confidential
or proprietary, and if you are not an intended recipient, please notify
the sender, do not use or share it and delete it. Unless specifically
indicated, this message is not an offer to sell or a solicitation of any
investment products or other financial product or service, an official
confirmation of any transaction, or an official statement of Merrill
Lynch. Subject to applicable law, Merrill Lynch may monitor, review and
retain e-communications (EC) traveling through its networks/systems. The
laws of the country of each sender/recipient may impact the handling of
EC, and EC may be archived, supervised and produced in countries other
than the country in which you are located. This message cannot be
guaranteed to be secure or error-free. This message is subject to terms
available at the following link:
http://www.ml.com/e-communications_terms/. By messaging with Merrill
Lynch you consent to the foregoing.
> --------------------------------------------------------
