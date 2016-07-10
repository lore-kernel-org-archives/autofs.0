From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 09/12] autofs: Fix wrong file/function/macro names in comments
Date: Sun, 10 Jul 2016 17:07:50 +0900
Message-ID: <1468138073-4870-9-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnD/QJ1BWTRgpA5Qe6NVYHQ+DNXdD82SPuVpbbWRiVc=;
        b=LVYN4zUVr4ZEHH/g72BtwgWAdvmmxkMPC9QwBReVjV9U6U/EAUlCdbfajRh8vZ4vS+
         8211HrL087v+0Q8DTYBee/X4NR4NSX3nVvyBKDVDfE68+ubnECLBa86Q4qTA4CvjOAPG
         lkdKBUbGIyx3vAzl8vpjziqGWxtGHAFZH8j0s02apv7nN1BKVmtua2GAGIlC4gqw0X10
         NwYfPoF13RjGzllG4Wgn2QZGbh81/SHV343v1YP8CFQc4whyhQwoYRcA6wAjMDhhe8rV
         fMS1CELwSHsaam3FP191ZwJUWmzFoxTaPOJ0p6av9xyZOF8F0N2UqQgk24W7e4il2nCb
         73Mw==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/root.c              | 2 +-
 include/linux/auto_dev-ioctl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index b5e6f64..a00e71b 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -645,7 +645,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
  * Version 4 of autofs provides a pseudo direct mount implementation
  * that relies on directories at the leaves of a directory tree under
  * an indirect mount to trigger mounts. To allow for this we need to
- * set the DMANAGED_AUTOMOUNT and DMANAGED_TRANSIT flags on the leaves
+ * set the DCACHE_NEED_AUTOMOUNT and DCACHE_MANAGE_TRANSIT flags on the leaves
  * of the directory tree. There is no need to clear the automount flag
  * following a mount or restore it after an expire because these mounts
  * are always covered. However, it is necessary to ensure that these
diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index bf82e3a..f7e1f2c 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -122,7 +122,7 @@ static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
 
 /*
  * If you change this make sure you make the corresponding change
- * to autofs-dev-ioctl.c:lookup_ioctl()
+ * to fs/autofs4/dev-ioctl.c:lookup_dev_ioctl()
  */
 enum {
 	/* Get various version info */
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
