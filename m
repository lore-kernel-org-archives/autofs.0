From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 5/6] add missing WITH_SASL in modules lookup_ldap.c
Date: Tue, 23 Jul 2013 18:35:45 +0800
Message-ID: <1374575745.3418.11.camel@perseus.fritz.box>
References: <dennis.yxun@gmail.com>
	 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
	 <1374505194-22668-6-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=O7wU4VDH3NowgPSlVxo5/u2GKII=; b=DFJSnqb2S1ysnx0ZdM/XsTWAmO3n
	pvBjBiMwcqSe2NiKRvEu/egjGXYmmn+t088Vqh7MbYKUzQb81yEN6vLqtpSCYRUr
	5ujWS/fMZKWGHed3z4t0Fbew6gLJSChlznhZtbkDneTkDsdZ4MGVHaKlDq11Qocv
	IZDF2x9IQKzNcM0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=O7wU4VDH3NowgPSlVxo5/u
	2GKII=; b=EcwOInS+oedNu7fVU6S4leYEtCE6qTNmaKPoTHTOeJLcb9ekBXfGds
	xGSdkldRGKRnSOO/JpCvG8WyrYWYZT8TOs44WjivZOE32rbOKeU1Za6W3g/Y9alA
	G+nRwsex5C18X4OE1Ny/BJKBv5XdsIt6CYMNLSWZR5/QEkg0kV75s=
In-Reply-To: <1374505194-22668-6-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs@vger.kernel.org

On Mon, 2013-07-22 at 22:59 +0800, Lan Yixun (dlan) wrote:
> From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
> 
> ---
> Gentoo Bugs:
>  https://bugs.gentoo.org/show_bug.cgi?id=361899

Not sure about this one either.
I have a patch in the queue that's been sitting for some time that does
this and some more. I'd like to include it in 5.0.8 but I'm not sure it
actually works properly. I need to go over it somewhat before I commit
it.

Here it is fyi:

autofs-5.0.7 - fix compilation of lookup_ldap.c without sasl

From: Dustin Polke <DuPol@gmx.de>

See https://bugs.gentoo.org/show_bug.cgi?id=361899 for more info.

Edited by: Ian Kent <raven@themaw.net>
- fix parse_ldap_config() is needed by ldap but previously excluded.
- exclude other references to ctxt->extern_cert and ctxt->extern_key.
- prevent memory leak if present in config but not used.
- remove now unused set_env().
---
 CHANGELOG             |    1 +
 include/lookup_ldap.h |    4 ++--
 lib/Makefile          |    4 ++++
 modules/Makefile      |    6 ++++--
 modules/lookup_ldap.c |   14 ++++++++++++--
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3228d6b..69fd1e7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -57,6 +57,7 @@
 - fix a couple of compiler warnings.
 - add after sssd dependency to unit file.
 - dont start readmap unless ready.
+- fix compilation of lookup_ldap.c without sasl.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/include/lookup_ldap.h b/include/lookup_ldap.h
index 9a4ce73..f34c029 100644
--- a/include/lookup_ldap.h
+++ b/include/lookup_ldap.h
@@ -11,6 +11,8 @@
 #include <krb5.h>
 #endif
 
+#include <libxml/tree.h>
+
 #include "list.h"
 #include "dclist.h"
 
@@ -92,7 +94,6 @@ struct lookup_context {
 };
 
 
-#ifdef WITH_SASL
 #define LDAP_AUTH_CONF_FILE "test"
 
 #define LDAP_TLS_DONT_USE	0
@@ -104,7 +105,6 @@ struct lookup_context {
 #define LDAP_AUTH_REQUIRED	0x0002
 #define LDAP_AUTH_AUTODETECT	0x0004
 #define LDAP_NEED_AUTH		(LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)
-#endif
 
 #define LDAP_AUTH_USESIMPLE	0x0008
 
diff --git a/lib/Makefile b/lib/Makefile
index 5418009..4a5b712 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -24,6 +24,10 @@ CFLAGS += -I../include -fPIC -D_GNU_SOURCE
 CFLAGS += -DAUTOFS_MAP_DIR=\"$(autofsmapdir)\"
 CFLAGS += -DAUTOFS_CONF_DIR=\"$(autofsconfdir)\"
 
+ifeq ($(LDAP), 1)
+  CFLAGS += $(XML_FLAGS) $(XML_LIBS)
+endif
+
 .PHONY: all install clean
 
 all: autofs.a
diff --git a/modules/Makefile b/modules/Makefile
index c5deb24..2589ae0 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -45,10 +45,12 @@ endif
 ifeq ($(LDAP), 1)
   SRCS += lookup_ldap.c
   MODS += lookup_ldap.so
+  LDAP_FLAGS += $(XML_FLAGS) -DLDAP_THREAD_SAFE
+  LIBLDAP += $(XML_LIBS)
   ifeq ($(SASL), 1)
     SASL_OBJ = cyrus-sasl.o cyrus-sasl-extern.o
-    LDAP_FLAGS += $(SASL_FLAGS) $(XML_FLAGS) $(KRB5_FLAGS)
-DLDAP_THREAD_SAFE
-    LIBLDAP += $(LIBSASL) $(XML_LIBS) $(KRB5_LIBS)
+    LDAP_FLAGS += $(SASL_FLAGS) $(KRB5_FLAGS)
+    LIBLDAP += $(LIBSASL) $(KRB5_LIBS)
   endif
 endif
 
diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index a2bfafd..904cc21 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -66,6 +66,7 @@ struct ldap_search_params {
 
 static int decode_percent_hack(const char *, char **);
 
+#ifdef HAVE_SASL
 static int set_env(unsigned logopt, const char *name, const char *val)
 {
 	int ret = setenv(name, val, 1);
@@ -75,6 +76,7 @@ static int set_env(unsigned logopt, const char *name,
const char *val)
 	}
 	return 1;
 }
+#endif
 
 #ifndef HAVE_LDAP_CREATE_PAGE_CONTROL
 int ldap_create_page_control(LDAP *ldap, ber_int_t pagesize,
@@ -585,10 +587,12 @@ static LDAP *do_connect(unsigned logopt, const
char *uri, struct lookup_context
 {
 	LDAP *ldap;
 
+#ifdef HAVE_SASL
 	if (ctxt->extern_cert && ctxt->extern_key) {
 		set_env(logopt, ENV_LDAPTLS_CERT, ctxt->extern_cert);
 		set_env(logopt, ENV_LDAPTLS_KEY, ctxt->extern_key);
 	}
+#endif
 
 	ldap = init_ldap_connection(logopt, uri, ctxt);
 	if (ldap) {
@@ -791,7 +795,6 @@ find_server:
 	return ldap;
 }
 
-#ifdef WITH_SASL
 int get_property(unsigned logopt, xmlNodePtr node, const char *prop,
char **value)
 {
 	xmlChar *ret;
@@ -812,6 +815,7 @@ int get_property(unsigned logopt, xmlNodePtr node,
const char *prop, char **valu
 	return 0;
 }
 
+#ifdef WITH_SASL
 /*
  *  For plain text, login and digest-md5 authentication types, we need
  *  user and password credentials.
@@ -824,6 +828,7 @@ int authtype_requires_creds(const char *authtype)
 		return 1;
 	return 0;
 }
+#endif
 
 /*
  *  Returns:
@@ -1056,6 +1061,7 @@ auth_fail:
 		}
 	} else if (auth_required == LDAP_AUTH_REQUIRED &&
 		  (authtype && !strncmp(authtype, "EXTERNAL", 8))) {
+#ifdef WITH_SASL
 		ret = get_property(logopt, root, "external_cert",  &extern_cert);
 		ret |= get_property(logopt, root, "external_key",  &extern_key);
 		/*
@@ -1074,6 +1080,7 @@ auth_fail:
 			if (extern_key)
 				free(extern_key);
 		}
+#endif
 	}
 
 	/*
@@ -1094,8 +1101,10 @@ auth_fail:
 	ctxt->secret = secret;
 	ctxt->client_princ = client_princ;
 	ctxt->client_cc = client_cc;
+#ifdef WITH_SASL
 	ctxt->extern_cert = extern_cert;
 	ctxt->extern_key = extern_key;
+#endif
 
 	debug(logopt, MODPREFIX
 	      "ldap authentication configured with the following options:");
@@ -1127,7 +1136,6 @@ out:
 
 	return ret;
 }
-#endif
 
 /*
  *  Take an input string as specified in the master map, and break it
@@ -1390,10 +1398,12 @@ static void free_context(struct lookup_context
*ctxt)
 		defaults_free_searchdns(ctxt->sdns);
 	if (ctxt->dclist)
 		free_dclist(ctxt->dclist);
+#ifdef HAVE_SASL
 	if (ctxt->extern_cert)
 		free(ctxt->extern_cert);
 	if (ctxt->extern_key)
 		free(ctxt->extern_key);
+#endif
 	free(ctxt);
 
 	return;


