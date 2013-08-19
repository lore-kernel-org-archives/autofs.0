From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/25] autofs-5.0.7 - fix crash due to thread unsafe use of
 libldap
Date: Mon, 19 Aug 2013 09:12:27 +0800
Message-ID: <20130819011226.6472.70626.stgit@perseus.fritz.box>
References: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=ZC5keYz10mpNOOQPetu3hCP78m8=; b=IdUvfmMnlKpK6t9zdzl/Frkl63V5
	lmqX7maIjls0ndBZp5okUolt2rn2AVoZ4/h8b68FGt4I+wZYZtLuMhixdBOcrxjY
	I7shmMNLmoJ71jOIfXLx2nA9qQvNNszP2P2/nGu7lHwkOvFrb4OjsMZkScfGtqED
	hcUlF5/KZOETTEk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=ZC5keYz10mpNOOQPetu3hC
	P78m8=; b=Fz9Ixj8Uocb0UYWSuGuTGZdKZyPVPnnOSsl9VofOdb6tgCiz1jv2va
	n2/KQFU0KQBWXeysP9pHtQCF++PqaXr8grb5omRDDMnixRX0Cma4ORMZgwZ7Xq63
	pKzlr7Uw4v+hdMp9f6ArF9KOkgIqld6srEcJt0cDI2TSYupSTi4Rk=
In-Reply-To: <20130819010909.6472.32512.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>
Cc: Gordon Lack <gordon.m.lack@gsk.com>, "Lan Yixun (dlan)" <dennis.yxun@gmail.com>, Leonardo Chiquitto <leonardo.lists@gmail.com>, Dustin Polke <DuPol@gmx.de>

From: Leonardo Chiquitto <leonardo.lists@gmail.com>

Add locking around LDAP initialization calls

To prevent corruption inside SSL and LDAP libraries, it's necessary to
serialize all calls to functions that initialize LDAP contexts.

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
---
 CHANGELOG             |    1 +
 modules/lookup_ldap.c |   35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3228d6b..fe232f4 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -57,6 +57,7 @@
 - fix a couple of compiler warnings.
 - add after sssd dependency to unit file.
 - dont start readmap unless ready.
+- fix crash due to thread unsafe use of libldap.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index a2bfafd..655e9fa 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -52,6 +52,12 @@ static struct ldap_schema common_schema[] = {
 };
 static unsigned int common_schema_count = sizeof(common_schema)/sizeof(struct ldap_schema);
 
+/*
+ * Initialization of LDAP and OpenSSL must be always serialized to
+ * avoid corruption of context structures inside these libraries.
+ */
+pthread_mutex_t ldapinit_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 struct ldap_search_params {
 	struct autofs_point *ap;
 	LDAP *ldap;
@@ -136,6 +142,22 @@ int ldap_parse_page_control(LDAP *ldap, LDAPControl **controls,
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
+	return;
+}
+
 static void uris_mutex_lock(struct lookup_context *ctxt)
 {
 	int status = pthread_mutex_lock(&ctxt->uris_mutex);
@@ -196,7 +218,7 @@ int unbind_ldap_connection(unsigned logopt, LDAP *ldap, struct lookup_context *c
 	return rv;
 }
 
-LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct lookup_context *ctxt)
+LDAP *__init_ldap_connection(unsigned logopt, const char *uri, struct lookup_context *ctxt)
 {
 	LDAP *ldap = NULL;
 	struct timeval timeout     = { ctxt->timeout, 0 };
@@ -277,6 +299,17 @@ LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct lookup_conte
 	return ldap;
 }
 
+LDAP *init_ldap_connection(unsigned logopt, const char *uri, struct lookup_context *ctxt)
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
 static int get_query_dn(unsigned logopt, LDAP *ldap, struct lookup_context *ctxt, const char *class, const char *key)
 {
 	char buf[MAX_ERR_BUF];

