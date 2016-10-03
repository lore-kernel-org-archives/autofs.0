From: Ian Kent <raven@themaw.net>
Subject: [RFC PATCH 1/8] vfs - change d_manage() to take a struct path
Date: Mon, 03 Oct 2016 08:46:28 +0800
Message-ID: <20161003004628.4865.18679.stgit@pluto.themaw.net>
References: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=YiScpb7unjNbb3O7pZsH9vWAoCc=; b=jhXpAt
        /YrmTxkf5GXtsVQWArZAs8Zfw3NS68CzAfGfFx3PirjVQfFKnTkZTSEuuMpaq+BN
        DgpRy67kQUJXsYiV0euG6UtKSrV+QTHs1SpqYUiRLND24VWiHW3SDRXM6//T1Fsz
        qGZISi92stj9yQqr0mmnKlAxL0p/cc1PrarmE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=YiScpb7unjNbb3O
        7pZsH9vWAoCc=; b=GBVTITIxBGwRpRnoNev6BeC1gx0kiGu3SGsSTDTA/UI/egc
        2HZXiVPyzSjXTshKtSDTtyoddgF3+s93IixlKkN6eW0iJnSJejSW3rmquVDkurTG
        PMp1Seu+JzpxRGRwgGMqMgHC5kDBYTnk2iKaJ5RFy6g4PN2Eai3FkJkh9o/k=
In-Reply-To: <20161003003646.4865.42500.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

For the autofs module to be able to reliably check if a dentry is a
mountpoint in a multiple namespace environment the ->d_manage() dentry
operation will need to take a path argument instead of a dentry.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 Documentation/filesystems/Locking |    2 +-
 Documentation/filesystems/vfs.txt |    2 +-
 fs/autofs4/root.c                 |    5 +++--
 fs/namei.c                        |   13 ++++++-------
 include/linux/dcache.h            |    2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index d30fb2c..189ea98 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -20,7 +20,7 @@ prototypes:
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
-	int (*d_manage)(struct dentry *, bool);
+	int (*d_manage)(struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 9ace359..0035ac8 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -939,7 +939,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct dentry *, bool);
+	int (*d_manage)(struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 };
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index fa84bb8..0705daa 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -32,7 +32,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,
 				     struct dentry *, unsigned int);
 static struct vfsmount *autofs4_d_automount(struct path *);
-static int autofs4_d_manage(struct dentry *, bool);
+static int autofs4_d_manage(struct path *, bool);
 static void autofs4_dentry_release(struct dentry *);
 
 const struct file_operations autofs4_root_operations = {
@@ -421,8 +421,9 @@ done:
 	return NULL;
 }
 
-static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
+static int autofs4_d_manage(struct path *path, bool rcu_walk)
 {
+	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	int status;
diff --git a/fs/namei.c b/fs/namei.c
index adb0414..e86b9d0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1200,7 +1200,7 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		if (managed & DCACHE_MANAGE_TRANSIT) {
 			BUG_ON(!path->dentry->d_op);
 			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(path->dentry, false);
+			ret = path->dentry->d_op->d_manage(path, false);
 			if (ret < 0)
 				break;
 		}
@@ -1263,10 +1263,10 @@ int follow_down_one(struct path *path)
 }
 EXPORT_SYMBOL(follow_down_one);
 
-static inline int managed_dentry_rcu(struct dentry *dentry)
+static inline int managed_dentry_rcu(struct path *path)
 {
-	return (dentry->d_flags & DCACHE_MANAGE_TRANSIT) ?
-		dentry->d_op->d_manage(dentry, true) : 0;
+	return (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) ?
+		path->dentry->d_op->d_manage(path, true) : 0;
 }
 
 /*
@@ -1282,7 +1282,7 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		 * Don't forget we might have a non-mountpoint managed dentry
 		 * that wants to block transit.
 		 */
-		switch (managed_dentry_rcu(path->dentry)) {
+		switch (managed_dentry_rcu(path)) {
 		case -ECHILD:
 		default:
 			return false;
@@ -1392,8 +1392,7 @@ int follow_down(struct path *path)
 		if (managed & DCACHE_MANAGE_TRANSIT) {
 			BUG_ON(!path->dentry->d_op);
 			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(
-				path->dentry, false);
+			ret = path->dentry->d_op->d_manage(path, false);
 			if (ret < 0)
 				return ret == -EISDIR ? 0 : ret;
 		}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 5ff3e9a..ad2df92 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -139,7 +139,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct dentry *, bool);
+	int (*d_manage)(struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 } ____cacheline_aligned;

