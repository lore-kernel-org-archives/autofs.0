From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] sasl_choose_mech could return an uninitialized
	conn pointer
Date: Fri, 04 Sep 2009 15:18:41 -0400
Message-ID: <x4963bytt66.fsf@segfault.boston.devel.redhat.com>
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

If a server returns a set of mechanisms that all require authentication,
then the conn pointer is returned to the caller uninitialized.  Fix
that.

Cheers,
Jeff

diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
index 4c6a671..806bf9f 100644
--- a/modules/cyrus-sasl.c
+++ b/modules/cyrus-sasl.c
@@ -798,7 +798,7 @@ sasl_bind_mech(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt, const c
 sasl_conn_t *
 sasl_choose_mech(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt)
 {
-	sasl_conn_t *conn;
+	sasl_conn_t *conn = NULL;
 	int authenticated;
 	int i;
 	char **mechanisms;
