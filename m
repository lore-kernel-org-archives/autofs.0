From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 4/8] autofs - change autofs4_expire_wait() to take
 struct path
Date: Mon, 03 Oct 2016 08:46:43 +0800
Message-ID: <20161003004643.4865.9069.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=Y5Ny9uBT6prs4mwAYngFImZ2xQI=; b=nvaoYS
        /Zxm9pPBoEWTW0TAne/pHprzRP6NzWHiUCXFBzlQ2CFHcJfPNM7DsUTcgWyLa9t6
        BJLfMi3dWJHuJzLJ7EWYxGjDTl3Uz9wFnHmi0DluR15MELdYzvbCuC5HfYsUAso4
        2xHl8p/rAS5Oa9zd3UBQwR2O/Gl8L7wBKBQxs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Y5Ny9uBT6prs4mw
        AYngFImZ2xQI=; b=pQn8kwUh6uz+sIS49d+qylz6Q32ETHH1DGXmQ7xU+wkYblT
        XvEAU489tEnyegMkJp/E7Nq7ikUBwcejFPflLRcHbyPE/7XnlmuDS+7PcnBMi46F
        ChBJLoTE1ypaB3PonjGdv99MpOj01TLSdqjzP3Kpy2+yTuRR9V/7JsDER1v8=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

From: Ian Kent <ikent@redhat.com>

In order to use the functions path_is_mountpoint() (or it's rcu-walk
variant) and path_has_submounts() autofs needs to pass a struct path
in several places.

Start by changing autofs4_expire_wait() to take a struct path instead
of a struct dentry.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/autofs_i.h  |    2 +-
 fs/autofs4/dev-ioctl.c |    2 +-
 fs/autofs4/expire.c    |    3 ++-
 fs/autofs4/root.c      |   12 +++++++-----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index a439548..b548ee6 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -148,7 +148,7 @@ void autofs4_free_ino(struct autofs_info *);
 
 /* Expiration */
 int is_autofs4_dentry(struct dentry *);
-int autofs4_expire_wait(struct dentry *dentry, int rcu_walk);
+int autofs4_expire_wait(struct path *path, int rcu_walk);
 int autofs4_expire_run(struct super_block *, struct vfsmount *,
 		       struct autofs_sb_info *,
 		       struct autofs_packet_expire __user *);
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index c7fcc74..3cd96e6 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -457,7 +457,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	ino = autofs4_dentry_ino(path.dentry);
 	if (ino) {
 		err = 0;
-		autofs4_expire_wait(path.dentry, 0);
+		autofs4_expire_wait(&path, 0);
 		spin_lock(&sbi->fs_lock);
 		param->requester.uid =
 			from_kuid_munged(current_user_ns(), ino->uid);
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index d8e6d42..7eac498 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -495,8 +495,9 @@ found:
 	return expired;
 }
 
-int autofs4_expire_wait(struct dentry *dentry, int rcu_walk)
+int autofs4_expire_wait(struct path *path, int rcu_walk)
 {
+	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 0705daa..e5ed061 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -286,22 +286,24 @@ static int autofs4_mount_wait(struct dentry *dentry, bool rcu_walk)
 	return status;
 }
 
-static int do_expire_wait(struct dentry *dentry, bool rcu_walk)
+static int do_expire_wait(struct path *path, bool rcu_walk)
 {
+	struct dentry *dentry = path->dentry;
 	struct dentry *expiring;
 
 	expiring = autofs4_lookup_expiring(dentry, rcu_walk);
 	if (IS_ERR(expiring))
 		return PTR_ERR(expiring);
 	if (!expiring)
-		return autofs4_expire_wait(dentry, rcu_walk);
+		return autofs4_expire_wait(path, rcu_walk);
 	else {
+		struct path this = { .mnt = path->mnt, .dentry = expiring };
 		/*
 		 * If we are racing with expire the request might not
 		 * be quite complete, but the directory has been removed
 		 * so it must have been successful, just wait for it.
 		 */
-		autofs4_expire_wait(expiring, 0);
+		autofs4_expire_wait(&this, 0);
 		autofs4_del_expiring(expiring);
 		dput(expiring);
 	}
@@ -354,7 +356,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	 * and the directory was removed, so just go ahead and try
 	 * the mount.
 	 */
-	status = do_expire_wait(dentry, 0);
+	status = do_expire_wait(path, 0);
 	if (status && status != -EAGAIN)
 		return NULL;
 
@@ -438,7 +440,7 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 	}
 
 	/* Wait for pending expires */
-	if (do_expire_wait(dentry, rcu_walk) == -ECHILD)
+	if (do_expire_wait(path, rcu_walk) == -ECHILD)
 		return -ECHILD;
 
 	/*

