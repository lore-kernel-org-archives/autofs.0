From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 1/6] fix compile error with heimdal support enabled
Date: Mon, 22 Jul 2013 22:59:49 +0800
Message-ID: <1374505194-22668-2-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NPH+bTpCM6wj1rh+itQbQOEuz8rPgm2THndzR9HW2BI=;
        b=pJOhBsfAKZLfasZfTaiq81PZAssWyKqHZiscTZKY5khvvh61eZWSqo/Dzg8AxDM0Av
         Jm10je1G59OWIXenviJOfLbvQtsVEcLoVqRSId6PCB3gBatljCCT1caEuQHFzOwgG80F
         YqnjU3twyr5OBIOi0rNxpenHVZ2+UFc/pW7a0gnt168EJk++8PutY03GIVma678TaE4y
         S/O45WaVwp6rvaRVklhAtktHcmlf3z/g6pNm84Q4KL2UF0qZijekrCrWIbqVRiTNKw6Q
         /GU+ggxVti9kETmrlKqDDv/fRMnvVkFi0KAuX0LQdssM7Oha+wvl0L3Ep3GHF9A+Abg9
         NdwA==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

this patch instroduce a compatible layer between Heimdal and MTT Krb5.
And I slightly rework the original patch to make it more readable.

---
Upstream Discussion:
  http://thread.gmane.org/gmane.linux.kernel.autofs/4203

Gentoo Bugs:
  https://bugs.gentoo.org/show_bug.cgi?id=210762

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 aclocal.m4           |  7 +++++++
 modules/cyrus-sasl.c | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/aclocal.m4 b/aclocal.m4
index c5de159..7a8b03c 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -299,6 +299,13 @@ else
   HAVE_KRB5=1
   KRB5_LIBS=`$KRB5_CONFIG --libs`
   KRB5_FLAGS=`$KRB5_CONFIG --cflags`
+
+  SAVE_CFLAGS=$CFLAGS
+  SAVE_LIBS=$LIBS
+  CFLAGS="$CFLAGS $KRB5_FLAGS"
+  LIBS="$LIBS $KRB5_LIBS"
+
+  AC_CHECK_FUNCS([krb5_principal_get_realm])
 fi])
 
 dnl --------------------------------------------------------------------------
diff --git a/modules/cyrus-sasl.c b/modules/cyrus-sasl.c
index 68f9242..6115f90 100644
--- a/modules/cyrus-sasl.c
+++ b/modules/cyrus-sasl.c
@@ -64,6 +64,31 @@
 #endif
 #endif
 
+#ifdef HAVE_KRB5_PRINCIPAL_GET_REALM
+void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
+                          const char **realm, int *len)
+{
+    *realm = krb5_principal_get_realm(context, princ);
+    *len = strlen(*realm);
+}
+#else
+void _krb5_princ_realm(krb5_context context, krb5_const_principal princ,
+                          const char **realm, int *len)
+{
+    const krb5_data *data;
+
+    data = krb5_princ_realm(context, princ);
+    if (data) {
+        *realm = data->data;
+        *len = data->length;
+    } else {
+        *realm = NULL;
+        *len = 0;
+    }
+}
+#endif
+
+
 /*
  *  Once a krb5 credentials cache is setup, we need to set the KRB5CCNAME
  *  environment variable so that the library knows where to find it.
@@ -379,7 +404,8 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
 	krb5_principal tgs_princ, krb5_client_princ;
 	krb5_creds my_creds;
 	char *tgs_name;
-	int status;
+	const char *realm_name;
+	int status, realm_length;
 
 	if (ctxt->kinit_done)
 		return 0;
@@ -450,12 +476,11 @@ sasl_do_kinit(unsigned logopt, struct lookup_context *ctxt)
 	}
 
 	/* setup a principal for the ticket granting service */
+	_krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ, &realm_name, &realm_length);
 	ret = krb5_build_principal_ext(ctxt->krb5ctxt, &tgs_princ,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
+		realm_length, realm_name,
 		strlen(KRB5_TGS_NAME), KRB5_TGS_NAME,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->length,
-		krb5_princ_realm(ctxt->krb5ctxt, krb5_client_princ)->data,
+		realm_length, realm_name,
 		0);
 	if (ret) {
 		error(logopt,
-- 
1.8.2.1

