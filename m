From: Dan Cox <dcox@wep.net>
Subject: [PATCH] LDAP Network Timeout
Date: Tue,  8 Feb 2005 13:53:05 -0600
Message-ID: <20050208135305.rehg3vgyogwogsg8@home.wep.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_49pvtfkjeoys"
Content-Transfer-Encoding: 7bit
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

This message is in MIME format.

--=_49pvtfkjeoys
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Currently, autofs doesn't set LDAP_OPT_NETWORK_TIMEOUT for the LDAP connection.
This means, among other things, that an LDAP failover operation to a secondary
server can take as much as a full TCP timeout (~180 seconds) to occur. Of
course, this is bad :) Attached is a patch which sets the timeout to something
a bit more reasonable at 5 seconds.

I've been using this patch in production for several months, and its working
great.

-- 
Dan-

--=_49pvtfkjeoys
Content-Type: text/x-patch; charset=UTF-8;
	name="autofs-4.1.3-ldap-timeout.patch"
Content-Disposition: attachment;
	filename="autofs-4.1.3-ldap-timeout.patch"
Content-Transfer-Encoding: 7bit

diff -Naur autofs-4.1.3.orig/modules/lookup_ldap.c autofs-4.1.3/modules/lookup_ldap.c
--- autofs-4.1.3.orig/modules/lookup_ldap.c	2004-04-03 01:14:33.000000000 -0600
+++ autofs-4.1.3/modules/lookup_ldap.c	2004-09-29 01:04:47.106827662 -0500
@@ -46,6 +46,7 @@
 	int rv, l;
 	LDAP *ldap;
 	int version = 3;
+    int net_timeout = 5; /* TCP network connection timeout */
 	char *ptr = NULL;
 
 	/* If we can't build a context, bail. */
@@ -131,6 +132,13 @@
 		}
 	}
 
+/* Sane network connection timeout */
+#ifdef LDAP_OPT_NETWORK_TIMEOUT
+    if (ldap_set_option(ldap, LDAP_OPT_NETWORK_TIMEOUT, &net_timeout) != LDAP_SUCCESS) {
+        debug(MODPREFIX "couldn't set network connection timeout to %i", &net_timeout);
+    }
+#endif
+
 	/* Connect to the server as an anonymous user. */
 	if (version == 2)
 		rv = ldap_simple_bind_s(ldap, ctxt->base, NULL);
@@ -163,6 +171,7 @@
 	char *attrs[] = { key, type, NULL };
 	LDAP *ldap;
 	int version = 3;
+    int net_timeout = 5; /* TCP network connection timeout */
 
 	if (ctxt == NULL) {
 		crit(MODPREFIX "context was NULL");
@@ -203,6 +212,13 @@
 		}
 	}
 
+/* Sane network connection timeout */
+#ifdef LDAP_OPT_NETWORK_TIMEOUT
+    if (ldap_set_option(ldap, LDAP_OPT_NETWORK_TIMEOUT, &net_timeout) != LDAP_SUCCESS) {
+        debug(MODPREFIX "couldn't set network connection timeout to %i", &net_timeout);
+    }
+#endif
+
 	/* Connect to the server as an anonymous user. */
 	if (version == 2)
 		rv = ldap_simple_bind_s(ldap, ctxt->base, NULL);

--=_49pvtfkjeoys
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=_49pvtfkjeoys--

