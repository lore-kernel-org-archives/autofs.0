From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/13] autofs-5.0.4 - renew sasl creds upon
	reconnect fail
Date: Thu, 12 Feb 2009 01:00:30 +0900
Message-ID: <20090211160029.12578.18406.stgit@zeus.themaw.net>
References: <20090211154853.12578.50525.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090211154853.12578.50525.stgit@zeus.themaw.net>
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
To: autofs mailing list <autofs@linux.kernel.org>

If a server re-connect fails it could be due to the authentication
credentail having timed out. So we need to dispose of this and retry
the connection including refreshing re-authenticating.
---

 CHANGELOG             |    1 +
 modules/lookup_ldap.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index b093451..7dee674 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -11,6 +11,7 @@
 - use CLOEXEC flag for setmntent also.
 - fix hosts map use after free (Paul Wankadia).
 - fix uri list locking (again).
+- check for stale SASL credentials upon connect fail.
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index b6784e1..bee97ae 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -675,6 +675,13 @@ static LDAP *do_reconnect(unsigned logopt, struct lookup_context *ctxt)
 
 	if (ctxt->server || !ctxt->uris) {
 		ldap = do_connect(logopt, ctxt->server, ctxt);
+#ifdef WITH_SASL
+		/* Dispose of the sasl authentication connection and try again. */
+		if (!ldap) {
+			autofs_sasl_dispose(ctxt);
+			ldap = connect_to_server(logopt, ctxt->server, ctxt);
+		}
+#endif
 		return ldap;
 	}
 
@@ -682,6 +689,16 @@ static LDAP *do_reconnect(unsigned logopt, struct lookup_context *ctxt)
 	this = ctxt->uri;
 	uris_mutex_unlock(ctxt);
 	ldap = do_connect(logopt, this->uri, ctxt);
+#ifdef WITH_SASL
+	/*
+	 * Dispose of the sasl authentication connection and try the
+	 * current server again before trying other servers in the list.
+	 */
+	if (!ldap) {
+		autofs_sasl_dispose(ctxt);
+		ldap = connect_to_server(logopt, this->uri, ctxt);
+	}
+#endif
 	if (ldap)
 		return ldap;
