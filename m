From: Andreas Oberritter <obi@saftware.de>
Subject: [PATCH 1/3] autofs-5.0.7 - include linux/nfs.h directly in rpc_subs.h
Date: Thu, 14 Mar 2013 16:20:58 +0100
Message-ID: <1363274460-27237-1-git-send-email-obi@saftware.de>
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@vger.kernel.org

Fixes compile error with uclibc. Glibc's nfs/nfs.h contains
nothing but "#include linux/nfs.h". rpc_subs.h already includes
other linux/nfs*.h files directly.

Signed-off-by: Andreas Oberritter <obi@saftware.de>
---
 include/rpc_subs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rpc_subs.h b/include/rpc_subs.h
index b6d59f9..a2d9648 100644
--- a/include/rpc_subs.h
+++ b/include/rpc_subs.h
@@ -18,7 +18,7 @@
 
 #include <rpc/rpc.h>
 #include <rpc/pmap_prot.h>
-#include <nfs/nfs.h>
+#include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
 
-- 
1.7.10.4

