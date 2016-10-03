From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 2/8] vfs - add path_is_mountpoint() helper
Date: Mon, 03 Oct 2016 08:46:33 +0800
Message-ID: <20161003004633.4865.1482.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=0pKX6c1KB+tKG4xdbqwAX77kcF0=; b=uUHGzo
        odU1N0FFYqIEHVcoQTy75CQ+AXyQN7uHrvw0txfGQOrJrdLWht61a/ZqIqJyZY3N
        6joj23MZjQZiFgYj3i4mrXIbm6L/JBinFbBxLNlue3xBQ8aWWxqgxLgIrxb9ZY/P
        QgQvgvorbRwAy2m+WqcrkqfFDE5kZLRWkDy90=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=0pKX6c1KB+tKG4x
        dbqwAX77kcF0=; b=XnrBcv70MQWlScr0ubXNlDRYUjpCee1MUB6i8GZdowD3Yud
        6fJPb9gaQZM9MN1kMd68Ve5CShSCxdlp4Gnk1M3tKPll9g6ejzJ77WgYnLUwzwfv
        JC2HqRrYl/fBy5dlz/l/9inY1soxnlXWEIsk6CEbXwt+rPrhzI4kCk4xX/DM=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Ian Kent <ikent@redhat.com>

d_mountpoint() can only be used reliably to establish if a dentry is
not mounted in any namespace. It isn't aware of the possibility there
may be multiple mounts using a given dentry that may be in a different
namespace.

Add helper functions, path_is_mountpoint() and an rcu version , that
checks if a struct path is a mountpoint for this case.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/namespace.c     |   43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    2 ++
 2 files changed, 45 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7bb2cda..ca1faaa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1153,6 +1153,49 @@ struct vfsmount *mntget(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(mntget);
 
+static bool __path_is_mountpoint(struct path *path)
+{
+	struct mount *mount;
+	struct vfsmount *mnt;
+	unsigned seq;
+
+	do {
+		seq = read_seqbegin(&mount_lock);
+		mount = __lookup_mnt(path->mnt, path->dentry);
+		mnt = mount ? &mount->mnt : NULL;
+	} while (mnt &&
+		 !(mnt->mnt_flags & MNT_SYNC_UMOUNT) &&
+		 read_seqretry(&mount_lock, seq));
+
+	return mnt != NULL;
+}
+
+/* Check if path is a mount in current namespace */
+bool path_is_mountpoint(struct path *path)
+{
+	bool res;
+
+	if (!d_mountpoint(path->dentry))
+		return 0;
+
+	rcu_read_lock();
+	res = __path_is_mountpoint(path);
+	rcu_read_unlock();
+
+	return res;
+}
+EXPORT_SYMBOL(path_is_mountpoint);
+
+/* Check if path is a mount in current namespace */
+bool path_is_mountpoint_rcu(struct path *path)
+{
+	if (!d_mountpoint(path->dentry))
+		return 0;
+
+	return __path_is_mountpoint(path);
+}
+EXPORT_SYMBOL(path_is_mountpoint_rcu);
+
 struct vfsmount *mnt_clone_internal(struct path *path)
 {
 	struct mount *p;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 901e25d..d588b26 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2117,6 +2117,8 @@ extern int vfs_ustat(dev_t, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
 extern bool our_mnt(struct vfsmount *mnt);
+extern bool path_is_mountpoint(struct path *);
+extern bool path_is_mountpoint_rcu(struct path *);
 
 extern int current_umask(void);
 

