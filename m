From: Andreas Oberritter <obi@saftware.de>
Subject: [PATCH v2] autofs-5.0.7 - create a shared library
Date: Thu, 14 Mar 2013 23:30:13 +0100
Message-ID: <1363300213-12657-1-git-send-email-obi@saftware.de>
References: <1363274460-27237-3-git-send-email-obi@saftware.de>
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1363274460-27237-3-git-send-email-obi@saftware.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

This reduces the (stripped) binary size from 1.6M to 572K
on my system.

Signed-off-by: Andreas Oberritter <obi@saftware.de>
---
v2: Fix LDFLAGS: add soname and use += operator

 Makefile.conf.in |    3 +++
 Makefile.rules   |    2 +-
 daemon/Makefile  |    2 +-
 lib/Makefile     |   22 +++++++++++++++-------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/Makefile.conf.in b/Makefile.conf.in
index 3766d45..daad614 100644
--- a/Makefile.conf.in
+++ b/Makefile.conf.in
@@ -76,6 +76,9 @@ DMALLOCLIB = @DMALLOCLIB@
 prefix = @prefix@
 exec_prefix = @exec_prefix@
 
+# Where to install libraries
+libdir=@libdir@
+
 # SSS library module directory
 ssslibdir=@sssldir@
 
diff --git a/Makefile.rules b/Makefile.rules
index 58b4bb2..88e0278 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -13,7 +13,7 @@ INCFILES = COPYING COPYRIGHT NEWS README* TODO Makefile Makefile.rules \
 INSTALLROOT = $(DESTDIR)
 
 # autofs utility library
-AUTOFS_LIB = ../lib/autofs.a
+AUTOFS_LIB = -L../lib -lautofs
 
 # Compilers, linkers and flags
 # The STRIP defined here *must not* remove any dynamic-loading symbols
diff --git a/daemon/Makefile b/daemon/Makefile
index 9e9d635..a5a4d8e 100644
--- a/daemon/Makefile
+++ b/daemon/Makefile
@@ -29,7 +29,7 @@ endif
 
 all: automount
 
-automount: $(OBJS) $(AUTOFS_LIB)
+automount: $(OBJS)
 	$(CC) $(LDFLAGS) $(DAEMON_LDFLAGS) -o automount $(OBJS) $(AUTOFS_LIB) $(LIBS)
 	$(STRIP) automount
 
diff --git a/lib/Makefile b/lib/Makefile
index 5418009..4129f94 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -18,20 +18,24 @@ OBJS = cache.o mount_clnt.o mount_xdr.o cat_path.o rpc_subs.o \
 YACCSRC = nss_tok.c nss_parse.tab.c nss_parse.tab.h \
 	  master_tok.c master_parse.tab.c master_parse.tab.h
 
-LIB = autofs.a
+LIB = libautofs.so
+VERSION := $(shell cat ../.version)
+MAJOR = $(firstword $(subst ., ,$(VERSION)))
 
 CFLAGS += -I../include -fPIC -D_GNU_SOURCE
 CFLAGS += -DAUTOFS_MAP_DIR=\"$(autofsmapdir)\"
 CFLAGS += -DAUTOFS_CONF_DIR=\"$(autofsconfdir)\"
+LDFLAGS += -shared -Wl,-soname,$(LIB).$(MAJOR)
 
 .PHONY: all install clean
 
-all: autofs.a
+all: $(LIB)
 
-autofs.a: $(OBJS)
-	rm -f $(LIB)
-	$(AR) $(ARFLAGS) $(LIB) $(OBJS)
-	-$(RANLIB) $(LIB)
+$(LIB).$(VERSION): $(OBJS)
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) -o $@
+
+$(LIB): $(LIB).$(VERSION)
+	ln -sf $< $@
 
 mount.h: mount.x
 	$(RPCGEN) -h -o mount.h mount.x
@@ -71,7 +75,11 @@ nss_tok.o: nss_tok.c nss_parse.tab.h
 nss_parse.tab.o: nss_parse.tab.c nss_parse.tab.h
 
 install: all
+	install -d -m 755 $(INSTALLROOT)$(libdir)
+	install -c $(LIB).$(VERSION) -m 755 $(INSTALLROOT)$(libdir)
+	ln -sf $(LIB).$(VERSION) $(INSTALLROOT)$(libdir)/$(LIB).$(MAJOR)
+	ln -sf $(LIB).$(VERSION) $(INSTALLROOT)$(libdir)/$(LIB)
 
 clean:
-	rm -f $(LIB) $(RPCS) $(OBJS) $(YACCSRC) *.output *~
+	rm -f $(LIB)* $(RPCS) $(OBJS) $(YACCSRC) *.output *~
 
-- 
1.7.10.4

