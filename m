From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 6/8] autofs - use path_is_mountpoint() to fix unreliable
 d_mountpoint() checks
Date: Mon, 03 Oct 2016 08:46:54 +0800
Message-ID: <20161003004654.4865.8095.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=JusLi/FNzTuGh46VAIVtijPnChc=; b=S7Utpt
        0WF00ZDNmoayd68Ys+xGkutNzhGQpPl2+tnF6eUw+qCr6uI0NEdt8XLiJQ24Fra+
        0TWcujdJf+kU/WpaSZxYhx9zZHqGSDWwRuKXB+sTgaUJUeEMQWEU5ak74CRXgl2g
        MJf4hElgnd1930VyyYU3TqDuQLZP+lKiOPse0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=JusLi/FNzTuGh46
        VAIVtijPnChc=; b=cv6mXlwC39nhtFD8OP+nj0h/zVtXnQdKwHRohRWMVkUihsd
        Wp/LaVpuCqNAm+u9NIoFxESvFUnECN4NkkcL0z6uNYXXob8uD7tDtlucfbReACRq
        Gs7rqJs/2PsXDx//kaZAtwcWzeaADDZJ0dIDje2OPwvk26ddtnG57yj+Vp5A=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Ian Kent <ikent@redhat.com>

If an automount mount is clone(2)ed into a file system that is propagation
private, when it later expires in the originating namespace, subsequent
calls to autofs ->d_automount() for that dentry in the original namespace
will return ELOOP until the mount is umounted in the cloned namespace.

Now that a struct path is available where needed use path_is_mountpoint()
instead of d_mountpoint() so we don't get false positives when checking
if a dentry is a mount point in the current namespace.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/root.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index a12c248..0f5d264 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -107,12 +107,15 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct path path;
 
 	pr_debug("file=%p dentry=%p %pd\n", file, dentry, dentry);
 
 	if (autofs4_oz_mode(sbi))
 		goto out;
 
+	path = file->f_path;
+
 	/*
 	 * An empty directory in an autofs file system is always a
 	 * mount point. The daemon must have failed to mount this
@@ -123,7 +126,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&sbi->lookup_lock);
-	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
+	if (!path_is_mountpoint(&path) && simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOENT;
 	}
@@ -372,15 +375,15 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 
 	/*
 	 * If the dentry is a symlink it's equivalent to a directory
-	 * having d_mountpoint() true, so there's no need to call back
-	 * to the daemon.
+	 * having path_is_mountpoint() true, so there's no need to call
+	 * back to the daemon.
 	 */
 	if (d_really_is_positive(dentry) && d_is_symlink(dentry)) {
 		spin_unlock(&sbi->fs_lock);
 		goto done;
 	}
 
-	if (!d_mountpoint(dentry)) {
+	if (!path_is_mountpoint(path)) {
 		/*
 		 * It's possible that user space hasn't removed directories
 		 * after umounting a rootless multi-mount, although it
@@ -434,8 +437,13 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 
 	/* The daemon never waits. */
 	if (autofs4_oz_mode(sbi)) {
-		if (!d_mountpoint(dentry))
-			return -EISDIR;
+		if (rcu_walk) {
+			if (!path_is_mountpoint_rcu(path))
+				return -EISDIR;
+		} else {
+			if (!path_is_mountpoint(path))
+				return -EISDIR;
+		}
 		return 0;
 	}
 
@@ -463,7 +471,7 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 
 		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
 			return 0;
-		if (d_mountpoint(dentry))
+		if (path_is_mountpoint_rcu(path))
 			return 0;
 		inode = d_inode_rcu(dentry);
 		if (inode && S_ISLNK(inode->i_mode))
@@ -490,7 +498,7 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 		 * we can avoid needless calls ->d_automount() and avoid
 		 * an incorrect ELOOP error return.
 		 */
-		if ((!d_mountpoint(dentry) && !simple_empty(dentry)) ||
+		if ((!path_is_mountpoint(path) && !simple_empty(dentry)) ||
 		    (d_really_is_positive(dentry) && d_is_symlink(dentry)))
 			status = -EISDIR;
 	}

