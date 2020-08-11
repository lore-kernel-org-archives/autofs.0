From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs: autofs: delete repeated words in comments
Date: Mon, 10 Aug 2020 19:18:17 -0700
Message-ID: <20200811021817.24982-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KC4Xk9+BSS3xq+MetJHETebtbJQTzZeqEni3gSzxfmc=; b=mNTtX+BpXnpeDwddUKKjrnzwkX
        6/Xv8r5K9M6I1W9KvQsuyr1pAErm2r2PSxN5xVmNHMy17n2fx/xxvdg/y8vVL2ppedhXd3Ob4pSKH
        kTYcstXlJfj7jvZ9l3sVUMHjDGErpgp+SYFTMvm1eOZMHT31TqDPvraaYLIuqCqcMRGuKsgVhhSs9
        4bwPopo7ywsLpdfvj6ygpRGIPuU9Ly7LkZcZX6CD0LLfMhxqIrTThjJWXXwfYxzgPZqE3F+ZDO9W6
        fVEWWGhO2QLohI+tALpW4otDWWweCKdQFFbhJmP3KXuAHCfeANMAm3+qshCQmqWCneblbWmktOoz6
        LVWvRxpQ==;
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

Drop duplicated words {the, at} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
---
 fs/autofs/dev-ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
+++ linux-next-20200807/fs/autofs/dev-ioctl.c
@@ -20,7 +20,7 @@
  * another mount. This situation arises when starting automount(8)
  * or other user space daemon which uses direct mounts or offset
  * mounts (used for autofs lazy mount/umount of nested mount trees),
- * which have been left busy at at service shutdown.
+ * which have been left busy at service shutdown.
  */
 
 typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
@@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
  * located path is the root of a mount we return 1 along with
  * the super magic of the mount or 0 otherwise.
  *
- * In both cases the the device number (as returned by
+ * In both cases the device number (as returned by
  * new_encode_dev()) is also returned.
  */
 static int autofs_dev_ioctl_ismountpoint(struct file *fp,
