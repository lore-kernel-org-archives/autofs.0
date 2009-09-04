From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] lookup_ldap.c: no need to free a result that is
	NULL
Date: Fri, 04 Sep 2009 12:41:49 -0400
Message-ID: <x49k50evf02.fsf@segfault.boston.devel.redhat.com>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

Hi, Ian,

Here's another trivial patch.  If we already know the result pointer is
null, there's no need to call ldap_msgfree on it!

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/Makefile.rules b/Makefile.rules
index f2ba386..26da6d8 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -38,7 +38,7 @@ STRIP     = strip --strip-debug
 endif
 endif
 
-CC        = gcc
+# CC        = gcc
 CXX       = g++
 CXXFLAGS  = $(CFLAGS)
 LD        = ld
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index 3a31a8e..d0cbdca 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -400,7 +400,6 @@ static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt
 		}
 
 		if (!result) {
-			ldap_msgfree(result);
 			error(logopt,
 			      MODPREFIX "failed to find query dn under search base dns");
 			free(query);
