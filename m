From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Subject: [PATCH 4/6] fix no "libxml/tree.h" error in modules lookup_ldap.c
Date: Mon, 22 Jul 2013 22:59:52 +0800
Message-ID: <1374505194-22668-5-git-send-email-dennis.yxun@gmail.com>
References: <dennis.yxun@gmail.com>
 <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5b9bel1x7/mryvyRNH66OSVnJg4ugOLsFUCVMitUXaw=;
        b=RX1EyZiWwAV/5hcuDvU8DGgXCr/MobNHlFhSAcYKcc5MI0WXpBb2voKf0E1USsak53
         yBVFlFmZt5x68fgd6OVaqE6eZhCUs1NgNt3Q4H7TcHAUCYEwml8OLJG+qfrU2pLQnW7i
         LNMwBI/jG11HKclXmTy95eWpva91dTc8zJACD9C2JGmMG/gY4+QBcVPdl7M5CTc5vs01
         MGZJNp8o9WH94xdJBmPE1whs/ioex8b2FQcg9p8qpp32b/OnKeZnA/ngVVCcNwNhARQp
         jU1ndwcD7HO0DGFEy4tqY/ROXXO5dwRoiZPITZ1XxSd23zlztSWr/10lBWvWc9eTVdGN
         2moQ==
In-Reply-To: <1374505194-22668-1-git-send-email-dennis.yxun@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org
Cc: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

From: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>

make "libxml/tree.h" controlled by WITH_SASL, also move it beind line of
#include "automount.h", since WITH_SASL is defined in config.h which is
included by automout.h

---
Gentoo Bugs:
 https://bugs.gentoo.org/show_bug.cgi?id=468606

gcc -shared -O2 -pipe -march=core2  -D_REENTRANT -D_FILE_OFFSET_BITS=64 -D_REENTRANT
-D_FILE_OFFSET_BITS=
64 -I../include -I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib64/autofs\"
-DAUTOFS_MAP_DIR=\"/e
tc/autofs\" -DLDAP_DEPRECATED=1 -o lookup_ldap.so \
        lookup_ldap.c dclist.o base64.o  \
        ../lib/autofs.a -lldap -llber -lresolv
: lookup_yp.so
lookup_ldap.c:31:25: fatal error: libxml/tree.h: No such file or directory
 #include <libxml/tree.h>
                         ^
compilation terminated.

Signed-off-by: Lan Yixun (dlan) <dennis.yxun@gmail.com>
---
 modules/lookup_ldap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
index b8970a6..fad558d 100644
--- a/modules/lookup_ldap.c
+++ b/modules/lookup_ldap.c
@@ -28,7 +28,6 @@
 #include <arpa/nameser.h>
 #include <resolv.h>
 #include <lber.h>
-#include <libxml/tree.h>
 
 #define MODULE_LOOKUP
 #include "automount.h"
@@ -36,6 +35,10 @@
 #include "lookup_ldap.h"
 #include "base64.h"
 
+#ifdef WITH_SASL
+#include <libxml/tree.h>
+#endif
+
 #define MAPFMT_DEFAULT "sun"
 
 #define MODPREFIX "lookup(ldap): "
-- 
1.8.2.1

