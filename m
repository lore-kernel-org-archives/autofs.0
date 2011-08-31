From: Ian Kent <raven@themaw.net>
Subject: Re: Segmentation fault in read_one_map() -> ldap_msgfree()
Date: Wed, 31 Aug 2011 09:54:13 +0800
Message-ID: <1314755653.3238.5.camel@perseus.themaw.net>
References: <20110830182735.GA31035@libre.l.ngdn.org>
 <1314753385.3238.2.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=AycthEqo327ddZunch0I64
 wJE+U=; b=P2j11phWQUHlFPjDnZMJEgOaWFCjWou8EDpigODUK066n0Iyx8fS21
 A9MTff1ySXMYBrSsdioN3gxSeaWkOc5zEDNgO6tMl04MkTho3GNDfDAnF9rGEizy
 KB7rLXUovCkLaaA/KlnctiQ+8DbPGbnCebGkPw8++RMkPrxYqphuA=
In-Reply-To: <1314753385.3238.2.camel@perseus.themaw.net>
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

On Wed, 2011-08-31 at 09:16 +0800, Ian Kent wrote:
> On Tue, 2011-08-30 at 14:27 -0400, Leonardo Chiquitto wrote:
> > Hello,
> > 
> > A customer reported a segmentation fault in automount (one occurrence
> > so far, but we have a core dump). More information about the exact
> > autofs version and included patches below.
> 
> Thanks for reporting this and for spending the time to try and work out
> what's going on.
> 
> I'll have a look see too.

btw, you may find this patch useful too, although you may need to do a
bit of work for it to apply, not sure (since the line numbers you give
don't quite match mine).

autofs-5.0.6 - fix paged query more results check

From: Ian Kent <raven@themaw.net>

When getting paged results from an LDAP server the server returns an
opaque cookie (of type berval) that is used to retrieve the next page.
The criteria for deciding if there are more pages is that the berval
value is non-null and has a non-zero length.

To determine if the berval value has non-zero length autofs checks the
strlen() of the value but on ppc64 and s390x this can return 0 even if
the value has non-zero length causing a premature termination of the
query.

Fix this by also checking the berval length field.
Also make sure we free the opaque cookie when the query is finished.
---

 CHANGELOG             |    1 +
 modules/lookup_ldap.c |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index a178b74..884a9ae 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -2,6 +2,7 @@
 =======================
 - fix ipv6 name for lookup fix.
 - improve mount location error reporting.
+- fix paged query more results check.
 
 28/06/2011 autofs-5.0.6
 -----------------------
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 719fed1..a25050a 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -2041,7 +2041,8 @@ do_paged:
 	rv = ldap_parse_page_control(sp->ldap,
 				     returnedControls, &sp->totalCount,
 				     &sp->cookie);
-	if (sp->cookie && sp->cookie->bv_val && strlen(sp->cookie->bv_val))
+	if (sp->cookie && sp->cookie->bv_val &&
+	    (strlen(sp->cookie->bv_val) || sp->cookie->bv_len))
 		sp->morePages = TRUE;
 	else
 		sp->morePages = FALSE;
@@ -2382,6 +2383,10 @@ static int read_one_map(struct autofs_point *ap,
 		    rv == LDAP_SIZELIMIT_EXCEEDED) {
 			if (sp.result)
 				ldap_msgfree(sp.result);
+			if (sp.cookie) {
+				ber_bvfree(sp.cookie);
+				sp.cookie = NULL;
+			}
 			sp.pageSize = sp.pageSize / 2;
 			if (sp.pageSize < 5) {
 				debug(ap->logopt, MODPREFIX
@@ -2397,6 +2402,8 @@ static int read_one_map(struct autofs_point *ap,
 		if (rv != LDAP_SUCCESS || !sp.result) {
 			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 			*result_ldap = rv;
+			if (sp.cookie)
+				ber_bvfree(sp.cookie);
 			free(sp.query);
 			return NSS_STATUS_UNAVAIL;
 		}
@@ -2406,6 +2413,8 @@ static int read_one_map(struct autofs_point *ap,
 			ldap_msgfree(sp.result);
 			unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 			*result_ldap = rv;
+			if (sp.cookie)
+				ber_bvfree(sp.cookie);
 			free(sp.query);
 			return NSS_STATUS_NOTFOUND;
 		}
@@ -2417,6 +2426,8 @@ static int read_one_map(struct autofs_point *ap,
 	unbind_ldap_connection(ap->logopt, sp.ldap, ctxt);
 
 	source->age = age;
+	if (sp.cookie)
+		ber_bvfree(sp.cookie);
 	free(sp.query);
 
 	return NSS_STATUS_SUCCESS;
