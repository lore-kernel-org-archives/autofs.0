From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/8] vfs - add path_is_mountpoint() helper
Date: Tue, 11 Oct 2016 13:33:58 +0800
Message-ID: <20161011053358.27645.9729.stgit@pluto.themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=Vvl0KD7IiHe3FsE343LhScnULjo=; b=j2x95Q
        VO81oiZEojAN6tG8ywF5FCo+eGOB58z63zizr5zelEq8F2ER7m41iI3o7xXMRWz5
        9X31ErrstgVfuSKdurZCgT/tlHtxF6+DRhBiCjJ338F52pz3AX8biwnWvefJZ1se
        OXMOPjDwwjBURc+XT/VH8Ve0MGODGFPm4PBQ4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Vvl0KD7IiHe3FsE
        343LhScnULjo=; b=uADOy/r2qkR2F05KK1touHWLcCGO+oZ36Cf14U29N6/QB+a
        vD52aUJzfPLcn9+c/3WhIKdMBOgcvB0facJhPjmbul+AMtI0dDHZVuVNmw8xCv/A
        kewYCIGGf+jf5Ca7XlwxIf4y7PyekpXe7vXRs5nW2FCHj7gXFg+0T4EZp4ps=
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

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
index ff1cd14..5ef9618 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1160,6 +1160,49 @@ struct vfsmount *mntget(struct vfsmount *mnt)
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
index 09a8c41..deaf08b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2142,6 +2142,8 @@ extern int vfs_ustat(dev_t, struct kstatfs *);
 extern int freeze_super(struct super_block *super);
 extern int thaw_super(struct super_block *super);
 extern bool our_mnt(struct vfsmount *mnt);
+extern bool path_is_mountpoint(struct path *);
+extern bool path_is_mountpoint_rcu(struct path *);
 
 extern int current_umask(void);
 

