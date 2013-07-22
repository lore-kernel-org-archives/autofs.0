From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 5/6] add missing WITH_SASL in modules lookup_ldap.c
Date: Mon, 22 Jul 2013 22:59:53 +0800
Message-ID: <1374505194-22668-6-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bDDYv4xmP+khG8u/VPxhrfRrwOzG1mXQ1lpkuvQA4JA=;
        b=NOz0Xteeer0ZqlggDp5doVak/21WhzhwpVJ2+a2XwQPg/k5V/ReCw7o6Lb6oj09Xb3
         QbOJRkLdjhDifYF2Z9L/mUBdTBOVxkNwSWk11MiXadOf6RWf+23WRzgiP8ZlRQ4YQbE5
         9u6rOxsi46f8s7YRGn21l+DefmvD5uUm9kakZ7VU5Lgvc0LS3ws096zSKuF+brlaZmUr
         4ds6rREnASQ+AosmH5SKRq75iwHl3LMYgyYh/FJAyz7M7xQmHgFeCVl4pquWGyt7i5P2
         EIlTqh11mW2WwLXgt8jwD/UlJTT7OHCJae5xGxwGzo6q1MykvUy7tsMGYkJyeumw7b+M
         Py0w==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

=46rom: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

---
Gentoo Bugs:
 https://bugs.gentoo.org/show_bug.cgi?id=3D361899

x86_64-pc-linux-gnu-gcc -Wl,-O1 -Wl,--as-needed -Wl,-O1 -Wl,--hash-styl=
e=3Dgnu -Wl,--sort-common
-shared -O2 -pipe -march=3Dcore2 -mcx16 -msahf -mpopcnt -msse4.2 --para=
m l1-cache-size=3D32 --param
l1-cache-line-size=3D64 --param l2-cache-size=3D8192 -frecord-gcc-switc=
hes -g
-Wimplicit-function-declaration -D_REENTRANT -D_FILE_OFFSET_BITS=3D64 -=
D_REENTRANT
-D_FILE_OFFSET_BITS=3D64 -I../include -I../lib -fPIC -D_GNU_SOURCE
-DAUTOFS_LIB_DIR=3D\"/usr/lib64/autofs\" -DAUTOFS_MAP_DIR=3D\"/etc/auto=
fs\" -DLDAP_DEPRECATED=3D1 -o
lookup_ldap.so \
		lookup_ldap.c dclist.o  \
		../lib/autofs.a -lldap -llber -lresolv
lookup_ldap.c: In function =E2=80=98do_connect=E2=80=99:
lookup_ldap.c:598:10: error: =E2=80=98struct lookup_context=E2=80=99 ha=
s no member named =E2=80=98extern_cert=E2=80=99
lookup_ldap.c:598:31: error: =E2=80=98struct lookup_context=E2=80=99 ha=
s no member named =E2=80=98extern_key=E2=80=99
lookup_ldap.c:599:41: error: =E2=80=98struct lookup_context=E2=80=99 ha=
s no member named =E2=80=98extern_cert=E2=80=99
lookup_ldap.c:600:40: error: =E2=80=98struct lookup_context=E2=80=99 ha=
s no member named =E2=80=98extern_key=E2=80=99
lookup_ldap.c: In function =E2=80=98free_context=E2=80=99:
lookup_ldap.c:1379:10: error: =E2=80=98struct lookup_context=E2=80=99 h=
as no member named =E2=80=98extern_cert=E2=80=99
lookup_ldap.c:1380:12: error: =E2=80=98struct lookup_context=E2=80=99 h=
as no member named =E2=80=98extern_cert=E2=80=99
lookup_ldap.c:1381:10: error: =E2=80=98struct lookup_context=E2=80=99 h=
as no member named =E2=80=98extern_key=E2=80=99
lookup_ldap.c:1382:12: error: =E2=80=98struct lookup_context=E2=80=99 h=
as no member named =E2=80=98extern_key=E2=80=99
make[1]: *** [lookup_ldap.so] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory `/var/tmp/portage/net-fs/autofs-5.0.5-r2/wor=
k/autofs-5.0.5/modules'
make: *** [daemon] Error 2

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 modules/lookup_ldap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index fad558d..ddfb060 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -588,10 +588,12 @@ static LDAP *do_connect(unsigned logopt, const ch=
ar *uri, struct lookup_context
 {
 	LDAP *ldap;
=20
+#ifdef WITH_SASL
 	if (ctxt->extern_cert && ctxt->extern_key) {
 		set_env(logopt, ENV_LDAPTLS_CERT, ctxt->extern_cert);
 		set_env(logopt, ENV_LDAPTLS_KEY, ctxt->extern_key);
 	}
+#endif
=20
 	ldap =3D init_ldap_connection(logopt, uri, ctxt);
 	if (ldap) {
@@ -1393,10 +1395,12 @@ static void free_context(struct lookup_context =
*ctxt)
 		defaults_free_searchdns(ctxt->sdns);
 	if (ctxt->dclist)
 		free_dclist(ctxt->dclist);
+#ifdef WITH_SASL
 	if (ctxt->extern_cert)
 		free(ctxt->extern_cert);
 	if (ctxt->extern_key)
 		free(ctxt->extern_key);
+#endif
 	free(ctxt);
=20
 	return;
--=20
1.8.2.1

