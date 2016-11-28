From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Mon, 28 Nov 2016 10:11:48 +0800
Message-ID: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=qFE8ZRby331jQmYRsI6N5MRyqN4=; b=dPWwc5
        Rd1Q2o8gKa245k2WXYr8K/AwwOjsB+fNOFFo+8QfPpFld8LXvhK+qyGqJjKPmC85
        wooDGBAYndLMQEMcOWLOSoWi0qCoNShaFViYRNmAv4vWVtEICY8szer8qNNzl6Xu
        zEMJPgAZpbOUP1QaFbP8S3To2aFPjJ3XrtM5A=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=qFE8ZRby331jQm
        YRsI6N5MRyqN4=; b=E1P7otUWDsEzxDzqTxPCok9ZKFcc3rItEaCINHw1iD6m2A
        MLVaNwHyDpKCNnymR3gQA8YojIMj2c0AiRoXi93SBW8iefoPUUzEmjsfE96GZQHD
        VUkS8opUBqGLHrQ44jzvu0wa4ZvqbCSdmlEK+uncArop9wEw2LogoIarv0C2E=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

Forgetting that the rcu lock allows nesting I added a superfluous rcu
version of path_is_mountpoint().

Merge it and the rcu version, make the common case (d_mountpoint()
returning true) inline and change the path parameter to a const.

Also move the function definition to include/linux/mount.h as it
seems a more sensible place for it.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/root.c     |   11 +++--------
 fs/namespace.c        |   41 ++++++++++++++---------------------------
 include/linux/fs.h    |    2 --
 include/linux/mount.h |   11 +++++++++++
 4 files changed, 28 insertions(+), 37 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index c4df881..dd2ea5d 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -437,13 +437,8 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 
 	/* The daemon never waits. */
 	if (autofs4_oz_mode(sbi)) {
-		if (rcu_walk) {
-			if (!path_is_mountpoint_rcu(path))
-				return -EISDIR;
-		} else {
-			if (!path_is_mountpoint(path))
-				return -EISDIR;
-		}
+		if (!path_is_mountpoint(path))
+			return -EISDIR;
 		return 0;
 	}
 
@@ -471,7 +466,7 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 
 		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
 			return 0;
-		if (path_is_mountpoint_rcu(path))
+		if (path_is_mountpoint(path))
 			return 0;
 		inode = d_inode_rcu(dentry);
 		if (inode && S_ISLNK(inode->i_mode))
diff --git a/fs/namespace.c b/fs/namespace.c
index 79473ee..da1cd87 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1160,12 +1160,23 @@ struct vfsmount *mntget(struct vfsmount *mnt)
 }
 EXPORT_SYMBOL(mntget);
 
-static bool __path_is_mountpoint(struct path *path)
+/* __path_is_mountpoint() - Check if path is a mount in the current
+ *                          namespace.
+ *
+ *  d_mountpoint() can only be used reliably to establish if a dentry is
+ *  not mounted in any namespace and that common case is handled inline.
+ *  d_mountpoint() isn't aware of the possibility there may be multiple
+ *  mounts using a given dentry in a different namespace. This function
+ *  checks if the passed in path is a mountpoint rather than the dentry
+ *  alone.
+ */
+bool __path_is_mountpoint(const struct path *path)
 {
 	struct mount *mount;
 	struct vfsmount *mnt;
 	unsigned seq;
 
+	rcu_read_lock();
 	do {
 		seq = read_seqbegin(&mount_lock);
 		mount = __lookup_mnt(path->mnt, path->dentry);
@@ -1173,35 +1184,11 @@ static bool __path_is_mountpoint(struct path *path)
 	} while (mnt &&
 		 !(mnt->mnt_flags & MNT_SYNC_UMOUNT) &&
 		 read_seqretry(&mount_lock, seq));
-
-	return mnt != NULL;
-}
-
-/* Check if path is a mount in current namespace */
-bool path_is_mountpoint(struct path *path)
-{
-	bool res;
-
-	if (!d_mountpoint(path->dentry))
-		return false;
-
-	rcu_read_lock();
-	res = __path_is_mountpoint(path);
 	rcu_read_unlock();
 
-	return res;
-}
-EXPORT_SYMBOL(path_is_mountpoint);
-
-/* Check if path is a mount in current namespace */
-bool path_is_mountpoint_rcu(struct path *path)
-{
-	if (!d_mountpoint(path->dentry))
-		return false;
-
-	return __path_is_mountpoint(path);
+	return mnt != NULL;
 }
-EXPORT_SYMBOL(path_is_mountpoint_rcu);
+EXPORT_SYMBOL(__path_is_mountpoint);
 
 struct vfsmount *mnt_clone_internal(struct path *path)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03a5a39..83de8b6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2095,8 +2095,6 @@ extern int vfs_ustat(dev_t, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
 extern bool our_mnt(struct vfsmount *mnt);
-extern bool path_is_mountpoint(struct path *);
-extern bool path_is_mountpoint_rcu(struct path *);
 
 extern int current_umask(void);
 
diff --git a/include/linux/mount.h b/include/linux/mount.h
index 1172cce..42dc62b 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -15,6 +15,8 @@
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/atomic.h>
+#include <linux/path.h>
+#include <linux/dcache.h>
 
 struct super_block;
 struct vfsmount;
@@ -98,4 +100,13 @@ extern dev_t name_to_dev_t(const char *name);
 
 extern unsigned int sysctl_mount_max;
 
+extern bool __path_is_mountpoint(const struct path *path);
+static inline bool path_is_mountpoint(const struct path *path)
+{
+	if (!d_mountpoint(path->dentry))
+		return 0;
+
+	return __path_is_mountpoint(path);
+}
+
 #endif /* _LINUX_MOUNT_H */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
