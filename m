From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] lookup_ldap.c: set result pointer to NULL when
	search fails
Date: Fri, 04 Sep 2009 12:38:19 -0400
Message-ID: <x49ocpqvf5w.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: ikent@redhat.com
Cc: autofs@linux.kernel.org

Hi, Ian,

It looks like we could end up with a result pointer that is non-null
from a failed call to ldap_search_s.  At least, in my brief look at the
library code it looks like this *might* happen.  So, to be safe, let's
check for that.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 2ecf5fe..3a31a8e 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -390,6 +390,10 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 				error(logopt,
 				      MODPREFIX "query failed for search dn %s: %s",
 				      this->basedn, ldap_err2string(rv));
+				if (result) {
+					ldap_msgfree(result);
+					result = NULL;
+				}
 			}
 
 			this = this->next;
