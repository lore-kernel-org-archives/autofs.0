From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Automount crashes due to thread-unsafe use of libldap
Date: Fri, 26 Jul 2013 14:46:00 -0300
Message-ID: <CAEySpB7JfazYbx2DvECohKFTH7ihoH=z0inzxGCpZd1-YxCVRA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oaiVnfHQQN6vI5xf4YUlUk8jpVNXyhuqjpe/VoTb4gM=;
        b=SZ6aWgO7q5n2jaQvDW31ZTf5LkysxBlWGgKgDnoQL5jk1XCu0i4k/rpS2E3hcev1JM
         2mioTNb7GIbkj6C6HyOuvZ3gRdLSJerlDoBKpEm7UXuMHJYbt0C+MHEKkR1G7fxUat/H
         BM/niK0vN/mpxCOAvQ5y8msXP//czTTAvv93F46GTYTC8Rh+h2aeaNJRngQ4HSXqjfsa
         15ejijCcYXkgT2s+b6yMBGYvFb0LnN7x+MDmywWwYGcTWNiy2Edqr4RdQmf1tQ9kqWHr
         oUCf0Yv7Pzk9wiCMHXq0eNQhE7fFx+q+wQvqyDhCbtCXYvdL72Dck7p38B4gd2+8C1J8
         R/lw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs <autofs@vger.kernel.org>

Hello,

I'm investigating some random crashes of automount inside libcrypto and
I'd like to report my findings and ask for comments.

How to reproduce the problem:

- Setup an LDAP server with SSL/TLS support enabled
- Configure AutoFS to fetch the maps from LDAP
- Make sure the OpenLDAP client library is configured to use SSL
  connections and "usetls" is set to yes in autofs_ldap_auth.conf.

In one directory handled by AutoFS (an indirect mount point), trigger in
parallel some dozens of invalid mounts (ie, try to access keys that do not
exist in the AutoFS map). Repeat until it crashes.

Here it always crashes in less than 20 minutes, normally inside OpenSSL.
Core dump inspection shows that internal SSL structures are corrupted,
with function pointers pointing to random addresses.

Trying to find similar reports on the web, I found this email from an
OpenLDAP developer (partial quote, emphasis mine) [1]:

"As far as I know, libldap is thread safe in the sense that multiple
threads can use separate LDAP* handles without running into concurrency
issues; *except for library initialization*, all accesses to common data
(i.e. global variables) is read-only."

[1]http://www.openldap.org/cgi-bin/wilma_hiliter/openldap-software/200606/msg00252.html

AutoFS implements no locking around LDAP initialization libraries and
it's quite common to see multiple threads executing ldap_initialize()
or ldap_start_tls_s() at the same time.

To avoid corruption inside SSL and LDAP libraries, I'd like to propose
the following patch.

I have plenty of additional information about this issue (core dumps, scripts
to reproduce the crash, a small program to simulate the problem without
AutoFS). Let me know if you would like to see more and I'll forward it. I
didn't want to put it all in this report because it would make it too long.

Thanks,
Leonardo

Add locking around LDAP initialization calls

To prevent corruption inside SSL and LDAP libraries, it's necessary to
serialize all calls to functions that initialize LDAP contexts.

diff --git a/CHANGELOG b/CHANGELOG
index 5d90139..2de174e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -53,6 +53,7 @@
 - fix probe each nfs version in turn for singleton mounts.
 - misc man page fixes.
 - fix add null check in parse_server_string().
+- serialize ldap initialization.

 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index a2bfafd..60f4c05 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -52,6 +52,12 @@ static struct ldap_schema common_schema[] = {
 };
 static unsigned int common_schema_count =
sizeof(common_schema)/sizeof(struct ldap_schema);

+/*
+ * Initialization of LDAP and OpenSSL must be always serialized to
+ * avoid corruption of context structures inside these libraries.
+ */
+pthread_mutex_t ldapinit_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 struct ldap_search_params {
 	struct autofs_point *ap;
 	LDAP *ldap;
@@ -136,6 +142,21 @@ int ldap_parse_page_control(LDAP *ldap,
LDAPControl **controls,
 }
 #endif /* HAVE_LDAP_PARSE_PAGE_CONTROL */

+static void ldapinit_mutex_lock(void)
+{
+	int status = pthread_mutex_lock(&ldapinit_mutex);
+	if (status)
+		fatal(status);
+	return;
+}
+
+static void ldapinit_mutex_unlock(void)
+{
+	int status = pthread_mutex_unlock(&ldapinit_mutex);
+	if (status)
+		fatal(status);
+}
+
 static void uris_mutex_lock(struct lookup_context *ctxt)
 {
 	int status = pthread_mutex_lock(&ctxt->uris_mutex);
@@ -196,7 +217,7 @@ int unbind_ldap_connection(unsigned logopt, LDAP
*ldap, struct lookup_context *c
 	return rv;
 }

-LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct
lookup_context *ctxt)
+LDAP *__init_ldap_connection(unsigned logopt, const char *uri, struct
lookup_context *ctxt)
 {
 	LDAP *ldap = NULL;
 	struct timeval timeout     = { ctxt->timeout, 0 };
@@ -277,6 +298,17 @@ LDAP *init_ldap_connection(unsigned logopt, const
char *uri, struct lookup_conte
 	return ldap;
 }

+LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct
lookup_context *ctxt)
+{
+	LDAP *ldap;
+
+	ldapinit_mutex_lock();
+	ldap = __init_ldap_connection(logopt, uri, ctxt);
+	ldapinit_mutex_unlock();
+
+	return ldap;
+}
+
 static int get_query_dn(unsigned logopt, LDAP *ldap, struct
lookup_context *ctxt, const char *class, const char *key)
 {
 	char buf[MAX_ERR_BUF];
