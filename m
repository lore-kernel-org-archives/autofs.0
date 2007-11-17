From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: patch: fix for dynamic logging breaking non-sasl build
Date: Sat, 17 Nov 2007 13:22:39 +0100
Message-ID: <473EDD0F.3070705@inria.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090801060108080109090906"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------090801060108080109090906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

autofs-5.0.2-dynamic-logging.patch breaks non-sasl enabled build by
calling autofs_sasl_done unconditonaly in lookup_ldap.c

Attached patch fix this issue
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62

--------------090801060108080109090906
Content-Type: text/x-patch;
 name="autofs-5.0.2-dynamic-logging-fixes2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="autofs-5.0.2-dynamic-logging-fixes2.patch"

diff -Naur --exclude '*~' autofs-5.0.2/modules/lookup_ldap.c autofs-5.0.2-dynamic-logging-fixes2.patch/modules/lookup_ldap.c
--- autofs-5.0.2/modules/lookup_ldap.c	2007-11-17 12:02:24.000000000 +0100
+++ autofs-5.0.2-dynamic-logging-fixes2.patch/modules/lookup_ldap.c	2007-11-17 12:03:32.000000000 +0100
@@ -579,7 +579,9 @@
 		list_add_tail(&this->list, ctxt->uri);
 	}
 
+#ifdef WITH_SASL
 	autofs_sasl_done(ctxt);
+#endif
 
 	/* Current server failed connect, try the rest */
 	ldap = find_server(logopt, ctxt);

--------------090801060108080109090906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------090801060108080109090906--

