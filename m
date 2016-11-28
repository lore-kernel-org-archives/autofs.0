From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/7] vfs - change struct path to const in d_manage()
Date: Mon, 28 Nov 2016 10:12:04 +0800
Message-ID: <148029912424.27779.1122354411609730492.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=cl2r9WukmuxtR5/
        XzWDBhqzQIU8=; b=w5NQ6P/osIKkTTXJaneQn290l3d5ZBdvjLf6GdbZR6fz4K0
        fBDyvFm5lfLZEuLRJniqt5+rwbo4I1j+Me83f4LIcbOxmVFkgcUTy5gQ/YH9ltjr
        fXaW2oein94gR+Mu6vDUMs4DMJjde9C+pOWy8OmX006hwmuOWFiDJhASDLwA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=cl2r9WukmuxtR5/XzWDBhqzQIU8=; b=hQzm4gLkfliIbwkettzx
        iWBtO/EvRv+tjmGRQVYkWTR4IvLGUtjVjBWnlQGZQ80iB2N9XWq90djyYLVHK8ht
        DyyAsVTkfjo3zJTZGbU6BmMC1vbeb8pxBl0P/G+fXySBSXvliMExzBd6zJVHRird
        MoWOgbsCSrwGjexLyOtkTXg=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

The ->d_manage() function is meant to be used to check if an
automount is in progress and to block if needed before the
mount is followed.

It shouldn't need to modify the passed struct path.

Make that usage explicit by changing ->d_manage() path parameter
to a const.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 Documentation/filesystems/Locking |    2 +-
 Documentation/filesystems/vfs.txt |    2 +-
 fs/autofs4/root.c                 |    4 ++--
 fs/namei.c                        |    2 +-
 include/linux/dcache.h            |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 08c9e56..ace63cd 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -20,7 +20,7 @@ prototypes:
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
 	struct vfsmount *(*d_automount)(struct path *path);
-	int (*d_manage)(struct path *, bool);
+	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index e54e992..3893f4d 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -948,7 +948,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct path *, bool);
+	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 };
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 859eef9..08718d3 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -32,7 +32,7 @@ static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,
 				     struct dentry *, unsigned int);
 static struct vfsmount *autofs4_d_automount(struct path *);
-static int autofs4_d_manage(struct path *, bool);
+static int autofs4_d_manage(const struct path *, bool);
 static void autofs4_dentry_release(struct dentry *);
 
 const struct file_operations autofs4_root_operations = {
@@ -426,7 +426,7 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 	return NULL;
 }
 
-static int autofs4_d_manage(struct path *path, bool rcu_walk)
+static int autofs4_d_manage(const struct path *path, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
diff --git a/fs/namei.c b/fs/namei.c
index 1669c93d..8e9a358 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1263,7 +1263,7 @@ int follow_down_one(struct path *path)
 }
 EXPORT_SYMBOL(follow_down_one);
 
-static inline int managed_dentry_rcu(struct path *path)
+static inline int managed_dentry_rcu(const struct path *path)
 {
 	return (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) ?
 		path->dentry->d_op->d_manage(path, true) : 0;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 44a9a9b..f835bd4 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -139,7 +139,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct path *, bool);
+	int (*d_manage)(const struct path *, bool);
 	struct dentry *(*d_real)(struct dentry *, const struct inode *,
 				 unsigned int);
 } ____cacheline_aligned;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
