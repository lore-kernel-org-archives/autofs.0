From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Wed, 14 Sep 2016 14:14:45 +0800
Message-ID: <20160914061445.24714.68331.stgit@pluto.themaw.net>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=dzTJaU1M5NoLjWUzpOaUhnWLh2E=; b=eMa6rd
        PZGIdm0KYgFOfoazF/n6ENtPuzJo0KF4ysXVJObbvR5/UzzeQqTc+q1ZIBqa+M7u
        DtC6fvucZ7aN8yv71dmAAKt9K2i9CThVORrqmsCkv1cnAfacPYuRZzHzl3LrYQwE
        iDCj1UK4Szi6uLFE8ETXwG28epcZBmU6xMxic=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=dzTJaU1M5NoLjWU
        zpOaUhnWLh2E=; b=b9EuLx+YZrSDq6z0/+KahIZzEGz09vxfzU35g5oRj5Xqos/
        E/o61sIH3UV0VhWTiLmtNM9BtTl3lRJef8KGerG9hOXEvyBFCm1GSqdU65W8PTQJ
        JeyHYer/zm2o+B4Actlk9zB2Iy0hQVPilknLxplPl9UsylqDra40Tt2xXQAg=
In-Reply-To: <20160914061434.24714.490.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, "Eric W. Biederman" <ebiederm@xmission.com>

If an automount mount is clone(2)ed into a file system that is
propagation private, when it later expires in the originating
namespace subsequent calls to autofs ->d_automount() for that
dentry in the original namespace will return ELOOP until the
mount is manually umounted in the cloned namespace.

In the same way, if an autofs mount is triggered by automount(8)
running within a container the dentry will be seen as mounted in
the root init namespace and calls to ->d_automount() in that namespace
will return ELOOP until the mount is umounted within the container.

Also, have_submounts() can return an incorect result when a mount
exists in a namespace other than the one being checked.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/dev-ioctl.c |    2 +-
 fs/autofs4/expire.c    |    4 ++--
 fs/autofs4/root.c      |   30 +++++++++++++++---------------
 fs/autofs4/waitq.c     |    2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index c7fcc74..0024e25 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -564,7 +564,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 		devid = new_encode_dev(dev);
 
-		err = have_submounts(path.dentry);
+		err = have_local_submounts(path.dentry);
 
 		if (follow_down_one(&path))
 			magic = path.dentry->d_sb->s_magic;
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d8e6d42..7cc34ef 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -236,7 +236,7 @@ static int autofs4_tree_busy(struct vfsmount *mnt,
 		 * count for the autofs dentry.
 		 * If the fs is busy update the expiry counter.
 		 */
-		if (d_mountpoint(p)) {
+		if (is_local_mountpoint(p)) {
 			if (autofs4_mount_busy(mnt, p)) {
 				top_ino->last_used = jiffies;
 				dput(p);
@@ -280,7 +280,7 @@ static struct dentry *autofs4_check_leaves(struct vfsmount *mnt,
 	while ((p = get_next_positive_dentry(p, parent))) {
 		pr_debug("dentry %p %pd\n", p, p);
 
-		if (d_mountpoint(p)) {
+		if (is_local_mountpoint(p)) {
 			/* Can we umount this guy */
 			if (autofs4_mount_busy(mnt, p))
 				continue;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index fa84bb8..4150ad6 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -123,7 +123,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&sbi->lookup_lock);
-	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
+	if (!is_local_mountpoint(dentry) && simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOENT;
 	}
@@ -370,28 +370,28 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 
 	/*
 	 * If the dentry is a symlink it's equivalent to a directory
-	 * having d_mountpoint() true, so there's no need to call back
-	 * to the daemon.
+	 * having is_local_mountpoint() true, so there's no need to
+	 * call back to the daemon.
 	 */
 	if (d_really_is_positive(dentry) && d_is_symlink(dentry)) {
 		spin_unlock(&sbi->fs_lock);
 		goto done;
 	}
 
-	if (!d_mountpoint(dentry)) {
+	if (!is_local_mountpoint(dentry)) {
 		/*
 		 * It's possible that user space hasn't removed directories
 		 * after umounting a rootless multi-mount, although it
-		 * should. For v5 have_submounts() is sufficient to handle
-		 * this because the leaves of the directory tree under the
-		 * mount never trigger mounts themselves (they have an autofs
-		 * trigger mount mounted on them). But v4 pseudo direct mounts
-		 * do need the leaves to trigger mounts. In this case we
-		 * have no choice but to use the list_empty() check and
-		 * require user space behave.
+		 * should. For v5 have_local_submounts() is sufficient to
+		 * handle this because the leaves of the directory tree under
+		 * the mount never trigger mounts themselves (they have an
+		 * autofs trigger mount mounted on them). But v4 pseudo
+		 * direct mounts do need the leaves to trigger mounts. In
+		 * this case we have no choice but to use the list_empty()
+		 * check and require user space behave.
 		 */
 		if (sbi->version > 4) {
-			if (have_submounts(dentry)) {
+			if (have_local_submounts(dentry)) {
 				spin_unlock(&sbi->fs_lock);
 				goto done;
 			}
@@ -431,7 +431,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 
 	/* The daemon never waits. */
 	if (autofs4_oz_mode(sbi)) {
-		if (!d_mountpoint(dentry))
+		if (!is_local_mountpoint(dentry))
 			return -EISDIR;
 		return 0;
 	}
@@ -460,7 +460,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 
 		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
 			return 0;
-		if (d_mountpoint(dentry))
+		if (is_local_mountpoint(dentry))
 			return 0;
 		inode = d_inode_rcu(dentry);
 		if (inode && S_ISLNK(inode->i_mode))
@@ -487,7 +487,7 @@ static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 		 * we can avoid needless calls ->d_automount() and avoid
 		 * an incorrect ELOOP error return.
 		 */
-		if ((!d_mountpoint(dentry) && !simple_empty(dentry)) ||
+		if ((!is_local_mountpoint(dentry) && !simple_empty(dentry)) ||
 		    (d_really_is_positive(dentry) && d_is_symlink(dentry)))
 			status = -EISDIR;
 	}
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 431fd7e..911f4d5 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -333,7 +333,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 					dentry = new;
 			}
 		}
-		if (have_submounts(dentry))
+		if (have_local_submounts(dentry))
 			valid = 0;
 
 		if (new)

