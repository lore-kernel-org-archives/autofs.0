From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/4] fs - make is_local_mountpoint() usable by others
Date: Wed, 14 Sep 2016 14:14:34 +0800
Message-ID: <20160914061434.24714.490.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=rJE
        AvzKqdy9pMl4MmXsjzo+2vd8=; b=N/AKvk/7Q/EXoPDyThXRK7DvFFOC7QpGUyu
        M37HfeM/YrKnxXZwRHeqyt4UAp9MRfURKfeQALmGdZRmIUAdTL8Cc1SM5NkEGJGx
        fo12R7+41dn+bAbt3vtBvWeCJvKQqx8keSVvNNAAS+PCpsgfQtTIU7xPFJ56gdbg
        XB3KqpVE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=rJEAvzKqdy9pMl4MmXsjzo+2vd8=; b=dok6T
        uJLXBFRAUPd5/rmZH/9GXZ14CkWCnqoPC0Md6zd36YjzozI0Py1PRMn8T7QFx5Lq
        sEpxAKF3R4a2uAhn4u1YDhhzgwdfwUV5wyOt0ij8Nw5ak20B+aHRM9W4d+UgJoSw
        wc8eXoDmWqN20L4oX6E5Hoy/M69sDClVHgCHho=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

The is_local_mountpoint() function will be needed for autofs
to check if a dentry is a mountpoint in the current namespace.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/mount.h            |    9 ---------
 fs/namespace.c        |    1 +
 include/linux/mount.h |    9 +++++++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index 14db05d..c25e6e8 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -127,12 +127,3 @@ struct proc_mounts {
 };
 
 extern const struct seq_operations mounts_op;
-
-extern bool __is_local_mountpoint(struct dentry *dentry);
-static inline bool is_local_mountpoint(struct dentry *dentry)
-{
-	if (!d_mountpoint(dentry))
-		return false;
-
-	return __is_local_mountpoint(dentry);
-}
diff --git a/fs/namespace.c b/fs/namespace.c
index 7bb2cda..bea1507 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -725,6 +725,7 @@ bool __is_local_mountpoint(struct dentry *dentry)
 out:
 	return is_covered;
 }
+EXPORT_SYMBOL(__is_local_mountpoint);
 
 static struct mountpoint *lookup_mountpoint(struct dentry *dentry)
 {
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 54a594d..575b745 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/atomic.h>
+#include <linux/dcache.h>
 
 struct super_block;
 struct vfsmount;
@@ -96,4 +97,12 @@ extern void mark_mounts_for_expiry(struct list_head *mounts);
 
 extern dev_t name_to_dev_t(const char *name);
 
+extern bool __is_local_mountpoint(struct dentry *dentry);
+static inline bool is_local_mountpoint(struct dentry *dentry)
+{
+	if (!d_mountpoint(dentry))
+		return false;
+
+	return __is_local_mountpoint(dentry);
+}
 #endif /* _LINUX_MOUNT_H */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
