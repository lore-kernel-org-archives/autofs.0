From: Ian Kent <raven@themaw.net>
Subject: [PATCH 7/9] autofs-5.0.7 - use LIBS for link libraries
Date: Wed, 24 Jul 2013 16:53:49 +0800
Message-ID: <20130724085348.3884.84063.stgit@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=7UyaTEULK1M5X4ZISaKtBX1QCfk=; b=QkgZudmSc5shrdyQdGA2NFEMOHM+
	OoXWNZUZUMrwJPZxpro52k1g+XZuv+Su5cL3ydH4olg0NSICY55sN9pWKlP8eHPu
	Fr4+pd4l5HhZEkQTwT+n3+lNVdgEZXgWmNjCFVNrcA9viQ360RLmF5Vc8vnuawVs
	HJiUpPMdFBv5mGM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=7UyaTEULK1M5X4ZISaKtBX
	1QCfk=; b=bv3h6qINybDa+3vhZ3d5gwBguuquGZrYc67CQ0M6cKWu+2axFVnJrZ
	ECnDys1FMnEbABhgn54tCY0hxj0KjuEhxOX3Ir37+V/XQB9rDmijFrrCc/5J9B/R
	+k74lv+7vuJzogST7GrM+9bGvkb2ebLqxiBFXZ5A9DE90rxkGi53M=
In-Reply-To: <20130724084903.3884.13354.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

From: Lan Yixun (dlan) <dennis.yxun@gmail.com>

quote:
 "Don't use this variable to pass library names (-l) to the linker; use LIBS instead."

see the section "Variable: LDFLAGS" in:
http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/PreseOutput-Variables.html#Preset-Output-Variables

Edited by: Ian Kent <raven@themaw.net>
The variable usage changes for LDFLAGS and LIBS appear to be dependent
on each other so merge them to try and avoid breakage if not all are
used by someone. I also had changed the patch titles slightly when I
imported them but they should be easily recognisable.
- merge patches
  - pthread-link-library-should-be-put-into-LIBS-not-LDFLAGS
  - library-should-be-passed-via-variable-LIBS-not-LDFLAGS
  - accumulate-LIBS-variable-changes-otherwise-we-may-lose-early-settings
  - allow-user-to-pass-LDFLAGS-via-configure
- add LIBS to build rules, might fix DMALLOC build problem


Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 CHANGELOG        |    1 +
 Makefile.rules   |   10 ++++++----
 daemon/Makefile  |    2 +-
 modules/Makefile |   12 ++++++------
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a0af868..897a2b4 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -63,6 +63,7 @@
 - add missing libtirpc lib to mount_nfs.so when TIRPC enabled.
 - use compiler determined by configure instead of hard-coded ones.
 - remove hard-coded STRIP variable.
+- use LIBS for link libraries.
 
 25/07/2012 autofs-5.0.7
 =======================
diff --git a/Makefile.rules b/Makefile.rules
index d00ba3c..fa53459 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -45,17 +45,19 @@ LD        ?= ld
 SOLDFLAGS = -shared
 
 CFLAGS += -D_REENTRANT -D_FILE_OFFSET_BITS=64
-LDFLAGS += -lpthread
+LIBS += -lpthread
 
 ifdef TIRPCLIB
 CFLAGS += -I/usr/include/tirpc
-LDFLAGS += $(TIRPCLIB)
+LIBS += $(TIRPCLIB)
 endif
 
 ifdef DMALLOCLIB
-LDFLAGS += $(DMALLOCLIB)
+LIBS += $(DMALLOCLIB)
 endif
 
+LIBS += $(LIBNSL)
+
 # Standard rules
 
 .SUFFIXES: .c .o .s .so
@@ -67,5 +69,5 @@ endif
 	$(CC) $(CFLAGS) -S $<
 
 .c.so:
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(DMALLOCLIB) $(LIBNSL)
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) -o $*.so $< $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) $*.so
diff --git a/daemon/Makefile b/daemon/Makefile
index 9e9d635..6604c9a 100644
--- a/daemon/Makefile
+++ b/daemon/Makefile
@@ -20,7 +20,7 @@ CFLAGS += -DAUTOFS_FIFO_DIR=\"$(autofsfifodir)\"
 CFLAGS += -DAUTOFS_FLAG_DIR=\"$(autofsflagdir)\"
 CFLAGS += -DVERSION_STRING=\"$(version)\"
 LDFLAGS += -rdynamic
-LIBS = -ldl
+LIBS += -ldl
 
 ifeq ($(LDAP), 1)
     CFLAGS += $(XML_FLAGS)
diff --git a/modules/Makefile b/modules/Makefile
index e61e338..de01ebd 100644
--- a/modules/Makefile
+++ b/modules/Makefile
@@ -98,8 +98,8 @@ endif
 # Ad hoc compilation rules for modules which need auxilliary libraries
 #
 lookup_hesiod.so: lookup_hesiod.c
-	$(CC) $(SOLDFLAGS) $(CFLAGS) $(HESIOD_FLAGS) -o lookup_hesiod.so \
-		lookup_hesiod.c $(AUTOFS_LIB) $(LIBHESIOD) $(LIBRESOLV)
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) $(HESIOD_FLAGS) -o lookup_hesiod.so \
+		lookup_hesiod.c $(AUTOFS_LIB) $(LIBHESIOD) $(LIBRESOLV) $(LIBS)
 	$(STRIP) lookup_hesiod.so
 
 cyrus-sasl.o: cyrus-sasl.c
@@ -109,13 +109,13 @@ cyrus-sasl-extern.o: cyrus-sasl-extern.c
 	$(CC) $(CFLAGS) $(LDAP_FLAGS) -c $<
 
 lookup_ldap.so: lookup_ldap.c dclist.o base64.o $(SASL_OBJ)
-	$(CC) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) $(LDAP_FLAGS) -o lookup_ldap.so \
 		lookup_ldap.c dclist.o base64.o $(SASL_OBJ) \
-		$(AUTOFS_LIB) $(LIBLDAP) $(LIBRESOLV)
+		$(AUTOFS_LIB) $(LIBLDAP) $(LIBRESOLV) $(LIBS)
 	$(STRIP) lookup_ldap.so
 
 mount_nfs.so: mount_nfs.c replicated.o
-	$(CC) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
-		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBNSL) $(TIRPCLIB)
+	$(CC) $(LDFLAGS) $(SOLDFLAGS) $(CFLAGS) -o mount_nfs.so \
+		mount_nfs.c replicated.o $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) mount_nfs.so
 

