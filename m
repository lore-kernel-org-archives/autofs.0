From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC PATCH 1/3] Make MAX_ERR_BUF and PARSE_MAX_BUF	use
	easier to audit
Date: Sat, 17 Jan 2009 15:02:08 +0900
Message-ID: <1232172128.3072.8.camel@zeus.themaw.net>
References: <1232164730-9397-1-git-send-email-vaurora@redhat.com>
	<1232164730-9397-2-git-send-email-vaurora@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232164730-9397-2-git-send-email-vaurora@redhat.com>
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
To: Valerie Aurora Henson <vaurora@redhat.com>
Cc: autofs@linux.kernel.org, Paul Wankadia <junyer@google.com>

On Fri, 2009-01-16 at 19:58 -0800, Valerie Aurora Henson wrote:
> Non-critical changes to make auditing buffer lengths easier.
> 
> * Some buffers were the wrong (too big) size, some were used twice for
>   different purposes.
> * Use sizeof(buf) instead of repeating the *MAX* define in functions
>   that need to know the size of a statically allocated buffer.
> * Fix a compiler warning about discarding the const on a string.

It's hard to see how any of this could cause any regressions (except for
that one snprintf below).

I'll import it into my StGIT patch list and run it through Connectathon.

> ---
>  modules/lookup_ldap.c |   49 ++++++++++++++++++++++---------------------------
>  1 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> index 6ba80eb..83e11a9 100644
> --- a/modules/lookup_ldap.c
> +++ b/modules/lookup_ldap.c
> @@ -274,7 +274,7 @@ LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct lookup_conte
>  
>  static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt, const char *class, const char *key)
>  {
> -	char buf[PARSE_MAX_BUF];
> +	char buf[MAX_ERR_BUF];
>  	char *query, *dn, *qdn;
>  	LDAPMessage *result, *e;
>  	struct ldap_searchdn *sdns = NULL;
> @@ -298,7 +298,7 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
>  
>  	query = alloca(l);
>  	if (query == NULL) {
> -		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		char *estr = strerror_r(errno, buf, sizeof(buf));
>  		crit(logopt, MODPREFIX "alloca: %s", estr);
>  		return NSS_STATUS_UNAVAIL;
>  	}
> @@ -1073,7 +1073,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  			}
>  			if (!tmp) {
>  				char *estr;
> -				estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +				estr = strerror_r(errno, buf, sizeof(buf));
>  				logerr(MODPREFIX "malloc: %s", estr);
>  				return 0;
>  			}
> @@ -1095,7 +1095,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  			tmp = malloc(l + 1);
>  			if (!tmp) {
>  				char *estr;
> -				estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +				estr = strerror_r(errno, buf, sizeof(buf));
>  				crit(logopt, MODPREFIX "malloc: %s", estr);
>  				return 0;
>  			}
> @@ -1130,7 +1130,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  		/* Isolate the server's name. */
>  		if (!tmp) {
>  			char *estr;
> -			estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +			estr = strerror_r(errno, buf, sizeof(buf));
>  			logerr(MODPREFIX "malloc: %s", estr);
>  			return 0;
>  		}
> @@ -1171,7 +1171,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  				ctxt->mapname = map;
>  			else {
>  				char *estr;
> -				estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +				estr = strerror_r(errno, buf, sizeof(buf));
>  				logerr(MODPREFIX "malloc: %s", estr);
>  				if (ctxt->server)
>  					free(ctxt->server);
> @@ -1182,7 +1182,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  			base = malloc(l + 1);
>  			if (!base) {
>  				char *estr;
> -				estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +				estr = strerror_r(errno, buf, sizeof(buf));
>  				logerr(MODPREFIX "malloc: %s", estr);
>  				if (ctxt->server)
>  					free(ctxt->server);
> @@ -1196,7 +1196,7 @@ static int parse_server_string(unsigned logopt, const char *url, struct lookup_c
>  		char *map = malloc(l + 1);
>  		if (!map) {
>  			char *estr;
> -			estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +			estr = strerror_r(errno, buf, sizeof(buf));
>  			logerr(MODPREFIX "malloc: %s", estr);
>  			if (ctxt->server)
>  				free(ctxt->server);
> @@ -1309,7 +1309,7 @@ int lookup_init(const char *mapfmt, int argc, const char *const *argv, void **co
>  	/* If we can't build a context, bail. */
>  	ctxt = malloc(sizeof(struct lookup_context));
>  	if (!ctxt) {
> -		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		char *estr = strerror_r(errno, buf, sizeof(buf));
>  		logerr(MODPREFIX "malloc: %s", estr);
>  		return 1;
>  	}
> @@ -1410,8 +1410,9 @@ int lookup_read_master(struct master *master, time_t age, void *context)
>  	unsigned int timeout = master->default_timeout;
>  	unsigned int logging = master->default_logging;
>  	unsigned int logopt = master->logopt;
> -	int rv, l, count, blen;
> -	char buf[PARSE_MAX_BUF];
> +	int rv, l, count;
> +	char buf[MAX_ERR_BUF];
> +	char parse_buf[PARSE_MAX_BUF];
>  	char *query;
>  	LDAPMessage *result, *e;
>  	char *class, *info, *entry;
> @@ -1433,7 +1434,7 @@ int lookup_read_master(struct master *master, time_t age, void *context)
>  
>  	query = alloca(l);
>  	if (query == NULL) {
> -		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		char *estr = strerror_r(errno, buf, sizeof(buf));
>  		logerr(MODPREFIX "alloca: %s", estr);
>  		return NSS_STATUS_UNAVAIL;
>  	}
> @@ -1523,18 +1524,12 @@ int lookup_read_master(struct master *master, time_t age, void *context)
>  			goto next;
>  		}
>  
> -		blen = strlen(*keyValue) + 1 + strlen(*values) + 2;
> -		if (blen > PARSE_MAX_BUF) {
> +		if (snprintf(parse_buf, sizeof(parse_buf), "%s %s",
> +			     *keyValue, *values) > sizeof(parse_buf)) {

Think that has to be >=, as Jeff mentioned earlier.

>  			error(logopt, MODPREFIX "map entry too long");
>  			ldap_value_free(values);
>  			goto next;
>  		}
> -		memset(buf, 0, PARSE_MAX_BUF);
> -
> -		strcpy(buf, *keyValue);
> -		strcat(buf, " ");
> -		strcat(buf, *values);
> -
>  		master_parse_entry(buf, timeout, logging, age);
>  next:
>  		ldap_value_free(keyValue);
> @@ -1552,7 +1547,7 @@ static int get_percent_decoded_len(const char *name)
>  {
>  	int escapes = 0;
>  	int escaped = 0;
> -	char *tmp = name;
> +	const char *tmp = name;
>  	int look_for_close = 0;
>  
>  	while (*tmp) {
> @@ -2051,7 +2046,7 @@ static int do_get_entries(struct ldap_search_params *sp, struct map_source *sour
>  				mapent = malloc(v_len + 1);
>  				if (!mapent) {
>  					char *estr;
> -					estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +					estr = strerror_r(errno, buf, sizeof(buf));
>  					logerr(MODPREFIX "malloc: %s", estr);
>  					ldap_value_free_len(bvValues);
>  					goto next;
> @@ -2071,7 +2066,7 @@ static int do_get_entries(struct ldap_search_params *sp, struct map_source *sour
>  					mapent_len = new_size;
>  				} else {
>  					char *estr;
> -					estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +					estr = strerror_r(errno, buf, sizeof(buf));
>  					logerr(MODPREFIX "realloc: %s", estr);
>  				}
>  			}
> @@ -2172,7 +2167,7 @@ static int read_one_map(struct autofs_point *ap,
>  
>  	sp.query = alloca(l);
>  	if (sp.query == NULL) {
> -		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		char *estr = strerror_r(errno, buf, sizeof(buf));
>  		logerr(MODPREFIX "malloc: %s", estr);
>  		return NSS_STATUS_UNAVAIL;
>  	}
> @@ -2326,7 +2321,7 @@ static int lookup_one(struct autofs_point *ap,
>  
>  	query = alloca(l);
>  	if (query == NULL) {
> -		char *estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +		char *estr = strerror_r(errno, buf, sizeof(buf));
>  		crit(ap->logopt, MODPREFIX "malloc: %s", estr);
>  		if (enc_len1) {
>  			free(enc_key1);
> @@ -2498,7 +2493,7 @@ static int lookup_one(struct autofs_point *ap,
>  				mapent = malloc(v_len + 1);
>  				if (!mapent) {
>  					char *estr;
> -					estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +					estr = strerror_r(errno, buf, sizeof(buf));
>  					logerr(MODPREFIX "malloc: %s", estr);
>  					ldap_value_free_len(bvValues);
>  					goto next;
> @@ -2518,7 +2513,7 @@ static int lookup_one(struct autofs_point *ap,
>  					mapent_len = new_size;
>  				} else {
>  					char *estr;
> -					estr = strerror_r(errno, buf, MAX_ERR_BUF);
> +					estr = strerror_r(errno, buf, sizeof(buf));
>  					logerr(MODPREFIX "realloc: %s", estr);
>  				}
>  			}
