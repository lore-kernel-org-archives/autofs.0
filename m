From: Ian Kent <raven@themaw.net>
Subject: [PATCH 7/8] autofs - use path_has_submounts() to fix unreliable
 have_submount() checks
Date: Tue, 11 Oct 2016 13:34:23 +0800
Message-ID: <20161011053423.27645.91233.stgit@pluto.themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=8O3zJjg6acLzTJTFnHHLz/vHAHg=; b=FIRzQD
        CLM6nURSSFP46hzkL+Zl65XryQWQvCc+F3mJEyTsjmtcWUqd+jz6orCQ3eHL6DdJ
        uy1RXdbqoXf0PcZV6Qcg+uQq4WXHDoNB6s1a87/c8NbYcubpt3Zh4u39FNNd+r42
        rqI9GgAeXl2E8DipejrP/Vv526y+Z0dfx7tdU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8O3zJjg6acLzTJT
        FnHHLz/vHAHg=; b=Cmb/twfjqH6qCq9b50e30ykuVQe4Gy6ABk4GNnKCXsjx+3/
        /IdbOc2VrvpWQIw+W+cyKcOH6miFMe3Gz3H/4v1/Wf9R5oec/DSX5pg0WEzCU49r
        CpgT07PsWmP1O0BL7BOn7GhugHUgz8QJ1vxXIa+0WbovWel0wWbIM51ztn/I=
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

If an automount mount is clone(2)ed into a file system that is propagation
private, when it later expires in the originating namespace, subsequent
calls to autofs ->d_automount() for that dentry in the original namespace
will return ELOOP until the mount is umounted in the cloned namespace.

Now that a struct path is available where needed use path_has_submounts()
instead of have_submounts() so we don't get false positives when checking
if a dentry is a mount point or contains mounts in the current namespace.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/dev-ioctl.c |    2 +-
 fs/autofs4/root.c      |   14 +++++++-------
 fs/autofs4/waitq.c     |   10 +++++++---
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 40c69f9..afacdaa 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -575,7 +575,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 		devid = new_encode_dev(dev);
 
-		err = have_submounts(path.dentry);
+		err = path_has_submounts(&path);
 
 		if (follow_down_one(&path))
 			magic = path.dentry->d_sb->s_magic;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index d7e48fe..c4df881 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -387,16 +387,16 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		/*
 		 * It's possible that user space hasn't removed directories
 		 * after umounting a rootless multi-mount, although it
-		 * should. For v5 have_submounts() is sufficient to handle
-		 * this because the leaves of the directory tree under the
-		 * mount never trigger mounts themselves (they have an autofs
-		 * trigger mount mounted on them). But v4 pseudo direct mounts
-		 * do need the leaves to trigger mounts. In this case we
-		 * have no choice but to use the list_empty() check and
+		 * should. For v5 path_has_submounts() is sufficient to
+		 * handle this because the leaves of the directory tree under
+		 * the mount never trigger mounts themselves (they have an
+		 * autofs trigger mount mounted on them). But v4 pseudo direct
+		 * mounts do need the leaves to trigger mounts. In this case
+		 * we have no choice but to use the list_empty() check and
 		 * require user space behave.
 		 */
 		if (sbi->version > 4) {
-			if (have_submounts(dentry)) {
+			if (path_has_submounts(path)) {
 				spin_unlock(&sbi->fs_lock);
 				goto done;
 			}
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index f757f87..ed05cae 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -250,8 +250,9 @@ autofs4_find_wait(struct autofs_sb_info *sbi, const struct qstr *qstr)
 static int validate_request(struct autofs_wait_queue **wait,
 			    struct autofs_sb_info *sbi,
 			    const struct qstr *qstr,
-			    struct dentry *dentry, enum autofs_notify notify)
+			    struct path *path, enum autofs_notify notify)
 {
+	struct dentry *dentry = path->dentry;
 	struct autofs_wait_queue *wq;
 	struct autofs_info *ino;
 
@@ -314,6 +315,7 @@ static int validate_request(struct autofs_wait_queue **wait,
 	 */
 	if (notify == NFY_MOUNT) {
 		struct dentry *new = NULL;
+		struct path this;
 		int valid = 1;
 
 		/*
@@ -333,7 +335,9 @@ static int validate_request(struct autofs_wait_queue **wait,
 					dentry = new;
 			}
 		}
-		if (have_submounts(dentry))
+		this.mnt = path->mnt;
+		this.dentry = dentry;
+		if (path_has_submounts(&this))
 			valid = 0;
 
 		if (new)
@@ -406,7 +410,7 @@ int autofs4_wait(struct autofs_sb_info *sbi,
 		return -EINTR;
 	}
 
-	ret = validate_request(&wq, sbi, &qstr, dentry, notify);
+	ret = validate_request(&wq, sbi, &qstr, path, notify);
 	if (ret <= 0) {
 		if (ret != -EINTR)
 			mutex_unlock(&sbi->wq_mutex);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
