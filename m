From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] autofs_sasl_dispose: ctxt is always valid
Date: Fri, 04 Sep 2009 15:07:52 -0400
Message-ID: <x49d466tto7.fsf@segfault.boston.devel.redhat.com>
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

If ctxt wasn't valid, other things would explode wildly.

Cheers,
Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
index 04001d0..4c6a671 100644
--- a/modules/cyrus-sasl.c
+++ b/modules/cyrus-sasl.c
@@ -922,7 +922,7 @@ void autofs_sasl_dispose(struct lookup_context *ctxt)
 {
 	int status, ret;
 
-	if (ctxt && ctxt->sasl_conn) {
+	if (ctxt->sasl_conn) {
 		sasl_dispose(&ctxt->sasl_conn);
 		ctxt->sasl_conn = NULL;
 	}
