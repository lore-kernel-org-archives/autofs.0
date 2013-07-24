From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 6/7] allow user to pass LDFLAGS via ./configure
Date: Wed, 24 Jul 2013 10:38:17 +0800
Message-ID: <1374633498-28385-6-git-send-email-dennis.yxun@gmail.com>
References: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cDAMp+q2hOVFoTaA3a40SCLdY8cnAykh+uCNmLOAv+0=;
        b=lxYmxZTj0Etav4pJ0qRGpvX3Sn5XQOXvbaEY6i581f3cw0CRue0IZ1eoMfUWxHrZ4d
         Lr9W6AbCKBvLv5UV2G7rxbep0w7HKwwEqNDVgVTun1Z2LmOY6uk/TyKrSIytl0dNoG3F
         8PqDXYffBadjxoS5EQI5Wut2BwgXelH+7OwBhxjubw9iT9Ma+ivsEMpUeT1B1KncoB7L
         0TRbXTSsGIZu7/XChy8wWSSu6WlLL/UFbDJPjwEUKiz9ZoGaeSQptNSrAu8fflPinbYz
         Q017monQ0fzVlrnD8LIAWk/NEoqSEK5zrHtx7jDQEqc1aOEQDp+D1mOCSkRACe9x0Nci
         LOsg==
In-Reply-To: <1374633498-28385-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 Makefile.rules   | 2 +-
 modules/Makefile | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile.rules b/Makefile.rules
index c431eca..fa53459 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -69,5 +69,5 @@ LIBS += $(LIBNSL)
 	$(CC) $(CFLAGS) -S $<
 
 .c.so:
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(LIBS)
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) $*.so
diff --git a/modules/Makefile b/modules/Makefile
index 0fe8ae8..fa3a317 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -98,7 +98,7 @@ endif
 # Ad hoc compilation rules for modules which need auxilliary libraries
 #
 lookup_hesiod.so: lookup_hesiod.c
-	$(CC) $(SOLDFLAGS) $(CFLAGS) $(HESIOD_FLAGS) -o lookup_hesiod.so \
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) $(HESIOD_FLAGS) -o lookup_hesiod.so \
 		lookup_hesiod.c $(AUTOFS_LIB) $(LIBHESIOD) $(LIBRESOLV)
 	$(STRIP) lookup_hesiod.so
 
@@ -109,13 +109,13 @@ cyrus-sasl-extern.o: cyrus-sasl-extern.c
 	$(CC) $(CFLAGS) $(LDAP_FLAGS) -c $<
 
 lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
-	$(CC) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
 		lookup_ldap.c dclist.o base64.o $(SASL_OBJ) \
 		$(AUTOFS_LIB) $(LIBLDAP) $(LIBRESOLV)
 	$(STRIP) lookup_ldap.so
 
 mount_nfs.so: mount_nfs.c replicated.o
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
 		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
 	$(STRIP) mount_nfs.so
 
-- 
1.8.3.2

