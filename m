From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] Harden autofs ioctl table
Date: Tue, 18 Aug 2020 13:22:03 +0100
Message-ID: <20200818122203.GO17456@casper.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+TgE1JF1d6UB4sQBGOF/uowtc9cBOuBWtMOMxeYqtZE=; b=QDR+C2ZsGEXI1Md5uEzhyt12rB
        wxfv99K4RX3S/Sm6bDwMNyKWKMGtv/py0zHaJC/knCmgpjQEmJzt/bu5uwDmbnu0iM1EBLEsTqLe/
        b0VOfKDyXWZkT11IJ3r1GaF/ZPC2KAEwHx5s1wG/l+4Qv5YLs6oN/8uIsPxVpLZLSdZLEoLJKiu0G
        1jAzlEzVdjQYtEXW4gCuml3TT58SQDpoKNtoZteS44eyVLL+DnwtR8iaOnLvaPMSMU9aYJs2Zb/cZ
        QlOtVUubgBGtn2wr76F8kHMJkJBIhoAZh3rYBVh83LrT/7mzpmin/jcjgLUTCAS6zHjYLbVeuxc8x
        oGoxueaA==;
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

The table of ioctl functions should be marked const in order to put them
in read-only memory, and we should use array_index_nospec() to avoid
speculation disclosing the contents of kernel memory to userspace.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 75105f45c51a..322b7dfb4ea0 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/magic.h>
+#include <linux/nospec.h>
 
 #include "autofs_i.h"
 
@@ -563,7 +564,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 {
-	static ioctl_fn _ioctls[] = {
+	static const ioctl_fn _ioctls[] = {
 		autofs_dev_ioctl_version,
 		autofs_dev_ioctl_protover,
 		autofs_dev_ioctl_protosubver,
@@ -581,7 +582,10 @@ static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 	};
 	unsigned int idx = cmd_idx(cmd);
 
-	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx];
+	if (idx >= ARRAY_SIZE(_ioctls))
+		return NULL;
+	idx = array_index_nospec(idx, ARRAY_SIZE(_ioctls));
+	return _ioctls[idx];
 }
 
 /* ioctl dispatcher */
