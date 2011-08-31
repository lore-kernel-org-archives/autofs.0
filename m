From: Ian Kent <raven@themaw.net>
Subject: Re: Segmentation fault in read_one_map() -> ldap_msgfree()
Date: Wed, 31 Aug 2011 10:28:06 +0800
Message-ID: <1314757686.3238.21.camel@perseus.themaw.net>
References: <20110830182735.GA31035@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=KJlArZVirWMKaJOskD02xg
 9vTU0=; b=I96xfZTvjIrPae2Vfd3Yq1Q3PA4RFaL4N4sMFrIHIyS6brvBgetEQ+
 bsCzl9gBgNACv/EDCjCxvlXeBoYKOn3waCwXO8yvLWWeC9qMfsjhhF5cWcgsVbmU
 sKHW3foupc5VvHBbaoM5R1tAQZtP+1YeAViPwQ5iOAPfcBaLcEOJ0=
In-Reply-To: <20110830182735.GA31035@libre.l.ngdn.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2011-08-30 at 14:27 -0400, Leonardo Chiquitto wrote:
> Hello,
> 
> A customer reported a segmentation fault in automount (one occurrence
> so far, but we have a core dump). More information about the exact
> autofs version and included patches below.

snip ...

> I'd also like to suggest the patch below. I believe it can potentially
> avoid the crash.
> 
> Thanks,
> Leonardo
> 
> AutoFS version is 5.0.5 plus all upstream patches up and including
> autofs-5.0.5-fix-submount-shutdown-wait.patch plus these assorted
> bug fixes:
> 
> autofs-5.0.5-auto-adjust-ldap-page-size.patch
> autofs-5.0.5-replace-gplv3-code.patch
> autofs-5.0.5-fix-paged-ldap-map-read.patch
> autofs-5.0.5-fix-next-task-list-update.patch
> autofs-5.0.5-fix-stale-map-read.patch
> autofs-5.0.5-fix-out-of-order-locking-in-readmap.patch
> autofs-5.0.5-remove-master_mutex_unlock-leftover.patch
> autofs-5.0.5-fix-null-cache-deadlock.patch
> 
> Index: autofs/modules/lookup_ldap.c
> ===================================================================
> --- autofs.orig/modules/lookup_ldap.c
> +++ autofs/modules/lookup_ldap.c
> @@ -361,6 +361,7 @@ static int get_query_dn(unsigned logopt,
>  			      MODPREFIX "query succeeded, no matches for %s",
>  			      query);
>  			ldap_msgfree(result);
> +			result = NULL;
>  			free(query);
>  			return 0;

There's a check on result just above this so result can't (or shouldn't
be able to) be NULL here, it isn't included within a loop (that can
potentially change result) and the function returns straight after so
this isn't needed.

>  		}
> @@ -1583,6 +1584,7 @@ int lookup_read_master(struct master *ma
>  		      MODPREFIX "query succeeded, no matches for %s",
>  		      query);
>  		ldap_msgfree(result);
> +		result = NULL;
>  		unbind_ldap_connection(logging, ldap, ctxt);
>  		free(query);
>  		return NSS_STATUS_NOTFOUND;

Same here.

> @@ -2380,8 +2382,8 @@ static int read_one_map(struct autofs_po
>  
>  		if (rv == LDAP_ADMINLIMIT_EXCEEDED ||
>  		    rv == LDAP_SIZELIMIT_EXCEEDED) {
> -			if (sp.result)
> -				ldap_msgfree(sp.result);
> +			ldap_msgfree(sp.result);
> +			sp.result = NULL;
>  			sp.pageSize = sp.pageSize / 2;
>  			if (sp.pageSize < 5) {
>  				debug(ap->logopt, MODPREFIX
> @@ -2404,12 +2406,14 @@ static int read_one_map(struct autofs_po
>  		rv = do_get_entries(&sp, source, ctxt);
>  		if (rv != LDAP_SUCCESS) {
>  			ldap_msgfree(sp.result);
> +			sp.result = NULL;

This one isn't needed because sp.result has been checked for NULL in the
if statement above and the next thing we do is return.

>  			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
>  			*result_ldap = rv;
>  			free(sp.query);
>  			return NSS_STATUS_NOTFOUND;
>  		}
>  		ldap_msgfree(sp.result);
> +		sp.result = NULL;
>  	} while (sp.morePages == TRUE);

But this looks suspect.

My not setting sp.result to NULL after freeing it within the loop (when
continuing) is dangerous and needs to be fixed. This is probably due to
not really knowing what the state of the fields of the sp structure (at
least sp.result and sp.cookie) are when we get LDAP_ADMINLIMIT_EXCEEDED
or LDAP_SIZELIMIT_EXCEEDED as a return.

>  
>  	debug(ap->logopt, MODPREFIX "done updating map");
> @@ -2582,6 +2586,7 @@ static int lookup_one(struct autofs_poin
>  		debug(ap->logopt,
>  		     MODPREFIX "got answer, but no entry for %s", query);
>  		ldap_msgfree(result);
> +		result = NULL;
>  		unbind_ldap_connection(ap->logopt, ldap, ctxt);
>  		free(query);
>  		return CHE_MISSING;
> @@ -2768,6 +2773,7 @@ next:
>  	}
>  
>  	ldap_msgfree(result);
> +	result = NULL;
>  	unbind_ldap_connection(ap->logopt, ldap, ctxt);

And this is the same as the case in get_query_dn() and
lookup_read_master() too.

>  
>  	/* Failed to find wild entry, update cache if needed */

So I think this patch might help, can you get it tested?
It assumes the other patch I posted has already been applied.

autofs-5.0.6 - fix result null check in read_one_map()

From: Ian Kent <ikent@redhat.com>


---

 modules/lookup_ldap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)


diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 6f8b466..9f2d4f3 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -2380,8 +2380,10 @@ static int read_one_map(struct autofs_point *ap,
 
 		if (rv == LDAP_ADMINLIMIT_EXCEEDED ||
 		    rv == LDAP_SIZELIMIT_EXCEEDED) {
-			if (sp.result)
+			if (sp.result) {
 				ldap_msgfree(sp.result);
+				sp.result = NULL;
+			}
 			if (sp.cookie) {
 				ber_bvfree(sp.cookie);
 				sp.cookie = NULL;
@@ -2401,6 +2403,8 @@ static int read_one_map(struct autofs_point *ap,
 		if (rv != LDAP_SUCCESS || !sp.result) {
 			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 			*result_ldap = rv;
+			if (sp.result)
+				ldap_msgfree(sp.result);
 			if (sp.cookie)
 				ber_bvfree(sp.cookie);
 			free(sp.query);
@@ -2418,6 +2422,7 @@ static int read_one_map(struct autofs_point *ap,
 			return NSS_STATUS_NOTFOUND;
 		}
 		ldap_msgfree(sp.result);
+		sp.result = NULL;
 	} while (sp.morePages == TRUE);
 
 	debug(ap->logopt, MODPREFIX "done updating map");
