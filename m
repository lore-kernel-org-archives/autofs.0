From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/8] autofs - change autofs4_wait() to take struct path
Date: Tue, 11 Oct 2016 13:34:13 +0800
Message-ID: <20161011053413.27645.84666.stgit@pluto.themaw.net>
References: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=2IoKtZHUIOYemVAUPiD7xkJQ2yY=; b=mxoLBk
        QntoQi3aiYmKHXRBWywsMHzxJIKarN1HKFZXPVOTxFeoaPWxcu6airEZgA/kjJ+p
        1+JOgOV8RGyc4TOkdMOuN9ysSJGyd+RrNBA/aguB2yV5KcwK3cRrn+VZaSueZr7h
        lE7FNwyCjOiCakGUgoqtjaeyZAR2mCHC2vhh0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=2IoKtZHUIOYemVA
        UPiD7xkJQ2yY=; b=NX2Gbaphyr9bWsdeOrg54hnQsImp4b7k8sFxN1Dn2T6GJHo
        B8V0eMo4pPUmpp3kyoqBXhtUNyWFx4UeCmOgXFyTemd4Y8crtTt8a/P9fFlN2Vce
        sCRHPdrlYvle74YGsoIN2/7PGeGMc91rpRFM+8O2pexSwPDddZzw1HJKjrHA=
In-Reply-To: <20161011053352.27645.83962.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

In order to use the functions path_is_mountpoint() (or its rcu-walk
variant) and path_has_submounts() autofs needs to pass a struct path
in several places.

Now change autofs4_wait() to take a struct path instead of a struct
dentry.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/autofs_i.h |    2 +-
 fs/autofs4/expire.c   |    5 +++--
 fs/autofs4/root.c     |   16 ++++++++--------
 fs/autofs4/waitq.c    |    3 ++-
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 6d72bba..14cef41 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -217,7 +217,7 @@ static inline int autofs_prepare_pipe(struct file *pipe)
 
 /* Queue management functions */
 
-int autofs4_wait(struct autofs_sb_info *, struct dentry *, enum autofs_notify);
+int autofs4_wait(struct autofs_sb_info *, struct path *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *, autofs_wqt_t, int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
 
diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 7eac498..a37ba40 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -526,7 +526,7 @@ int autofs4_expire_wait(struct path *path, int rcu_walk)
 
 		pr_debug("waiting for expire %p name=%pd\n", dentry, dentry);
 
-		status = autofs4_wait(sbi, dentry, NFY_NONE);
+		status = autofs4_wait(sbi, path, NFY_NONE);
 		wait_for_completion(&ino->expire_complete);
 
 		pr_debug("expire done status=%d\n", status);
@@ -593,11 +593,12 @@ int autofs4_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 
 	if (dentry) {
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
+		struct path path = { .mnt = mnt, .dentry = dentry };
 
 		/* This is synchronous because it makes the daemon a
 		 * little easier
 		 */
-		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
+		ret = autofs4_wait(sbi, &path, NFY_EXPIRE);
 
 		spin_lock(&sbi->fs_lock);
 		/* avoid rapid-fire expire attempts if expiry fails */
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 35096e3..d47930ad 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -269,17 +269,17 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry,
 	return NULL;
 }
 
-static int autofs4_mount_wait(struct dentry *dentry, bool rcu_walk)
+static int autofs4_mount_wait(struct path *path, bool rcu_walk)
 {
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	struct autofs_sb_info *sbi = autofs4_sbi(path->dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(path->dentry);
 	int status = 0;
 
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		if (rcu_walk)
 			return -ECHILD;
-		pr_debug("waiting for mount name=%pd\n", dentry);
-		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+		pr_debug("waiting for mount name=%pd\n", path->dentry);
+		status = autofs4_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
 	}
 	ino->last_used = jiffies;
@@ -364,7 +364,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	spin_lock(&sbi->fs_lock);
 	if (ino->flags & AUTOFS_INF_PENDING) {
 		spin_unlock(&sbi->fs_lock);
-		status = autofs4_mount_wait(dentry, 0);
+		status = autofs4_mount_wait(path, 0);
 		if (status)
 			return ERR_PTR(status);
 		goto done;
@@ -405,7 +405,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
-		status = autofs4_mount_wait(dentry, 0);
+		status = autofs4_mount_wait(path, 0);
 		spin_lock(&sbi->fs_lock);
 		ino->flags &= ~AUTOFS_INF_PENDING;
 		if (status) {
@@ -447,7 +447,7 @@ static int autofs4_d_manage(struct path *path, bool rcu_walk)
 	 * This dentry may be under construction so wait on mount
 	 * completion.
 	 */
-	status = autofs4_mount_wait(dentry, rcu_walk);
+	status = autofs4_mount_wait(path, rcu_walk);
 	if (status)
 		return status;
 
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 431fd7e..f757f87 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -345,8 +345,9 @@ static int validate_request(struct autofs_wait_queue **wait,
 }
 
 int autofs4_wait(struct autofs_sb_info *sbi,
-		 struct dentry *dentry, enum autofs_notify notify)
+		 struct path *path, enum autofs_notify notify)
 {
+	struct dentry *dentry = path->dentry;
 	struct autofs_wait_queue *wq;
 	struct qstr qstr;
 	char *name;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
