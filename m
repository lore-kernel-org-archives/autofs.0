From: Ian Kent <raven@themaw.net>
Subject: [PATCH 7/7] vfs - make may_umount_tree() mount propogation aware
Date: Mon, 28 Nov 2016 10:12:19 +0800
Message-ID: <148029913966.27779.10094416563067823851.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=/3rox2kNnSY79mm
        7k96pnh9w0wM=; b=wOrBe4KZSInYgYDlrczy1+JBKdnH5dCaKKoL0bQL6d9azan
        fqtjiKjPan8A9ud/oyb23UvtbcPtTzBbbZ+Bv8o2FF2sqq+Q7BG7rC3zO3y8a48o
        /lZf+DMLAn5MIM1NkY9bDjjXxavFwfG/GIcOqn1LlNrYRu5NzToQE1h43Na8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=/3rox2kNnSY79mm7k96pnh9w0wM=; b=Lrwzy90/hZ0PTI0edkSD
        SIFhu0OgMvUefHJArV0Luh1+tarnd36iRILb8aM0wc6TdL3ieSzXgyhcCOjFxiQA
        aOTbbfuHWywPdJAPL0XnltT0KANi96jaU638YuwYqwB9evLoSvG97PNiFmAGyt4g
        WlnGHf8JXrEeEbdNRLGxqlE=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

Now that autofs has namespace aware mounted checks the expire needs
changes to make it aware of mount propagation.

When checking for expiration may_umount_tree() checks only if the
given mount is in use. This leads to a callback to the automount
daemon to umount the mount which will fail if any propagated mounts
are in use.

To avoid this unnecessary call back may_umount_tree() needs to check
propagated mount trees also.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/expire.c |    4 +--
 fs/namespace.c      |   71 +++++++++++++++++++++++++++++++++++++++++++++------
 fs/pnode.c          |    3 +-
 fs/pnode.h          |    1 +
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 57725d4..d44ae32 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -52,7 +52,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 			goto done;
 	}
 
-	/* Update the expiry counter if fs is busy */
+	/* Update the expiry counter if fs is busy in any namespace */
 	if (!may_umount_tree(path.mnt)) {
 		struct autofs_info *ino;
 
@@ -191,7 +191,7 @@ static int autofs4_direct_busy(struct vfsmount *mnt,
 {
 	pr_debug("top %p %pd\n", top, top);
 
-	/* If it's busy update the expiry counters */
+	/* If it's busy in any namespace update the expiry counters */
 	if (!may_umount_tree(mnt)) {
 		struct autofs_info *ino;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index da1cd87..092d75c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1311,6 +1311,33 @@ const struct seq_operations mounts_op = {
 };
 #endif  /* CONFIG_PROC_FS */
 
+struct mnt_tree_refs {
+	struct mount *root;
+	unsigned int refs;
+	unsigned int min_refs;
+};
+
+static void mnt_get_tree_refs(struct mnt_tree_refs *mtr)
+{
+	struct mount *mnt = mtr->root;
+	struct mount *p;
+
+	/*
+	 * Each propagated tree contribues 2 * #mounts - 1 to
+	 * the minimal reference count. But when a mount is
+	 * umounted and connected the mount doesn't hold a
+	 * reference to its parent so it contributes a single
+	 * reference.
+	 */
+	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		mtr->refs += mnt_get_count(p);
+		if (p == mnt || p->mnt.mnt_flags & MNT_UMOUNT)
+			mtr->min_refs++;
+		else
+			mtr->min_refs += 2;
+	}
+}
+
 /**
  * may_umount_tree - check if a mount tree is busy
  * @mnt: root of mount tree
@@ -1322,25 +1349,51 @@ const struct seq_operations mounts_op = {
 int may_umount_tree(struct vfsmount *m)
 {
 	struct mount *mnt = real_mount(m);
-	int actual_refs = 0;
-	int minimum_refs = 0;
-	struct mount *p;
+	struct mount *parent = mnt->mnt_parent;
+	struct mnt_tree_refs mtr;
+	struct mount *p, *child;
+
 	BUG_ON(!m);
 
-	/* write lock needed for mnt_get_count */
+	down_read(&namespace_sem);
 	lock_mount_hash();
-	for (p = mnt; p; p = next_mnt(p, mnt)) {
-		actual_refs += mnt_get_count(p);
-		minimum_refs += 2;
+
+	mtr.root = mnt;
+	mtr.refs = 0;
+	mtr.min_refs = 0;
+
+	mnt_get_tree_refs(&mtr);
+	/*
+	 * Caller holds a mount reference so minimum references
+	 * to the tree at mnt is one greater than the minumum
+	 * references.
+	 */
+	mtr.min_refs++;
+
+	/* The pnode.c propagation_next() function (as used below)
+	 * returns each mount propogated from a given mount. Using
+	 * the parent of mnt and matching the mnt->mnt_mountpoint
+	 * gets the list of mounts propogated from mnt. To work
+	 * out if the tree is in use (eg. open file or pwd) the
+	 * reference counts of each of these mounts needs to be
+	 * checked as well as mnt itself.
+	 */
+	for (p = propagation_next(parent, parent); p;
+			p = propagation_next(p, parent)) {
+		child = __lookup_mnt_last(&p->mnt, mnt->mnt_mountpoint);
+		if (child) {
+			mtr.root = child;
+			mnt_get_tree_refs(&mtr);
+		}
 	}
 	unlock_mount_hash();
+	up_read(&namespace_sem);
 
-	if (actual_refs > minimum_refs)
+	if (mtr.refs > mtr.min_refs)
 		return 0;
 
 	return 1;
 }
-
 EXPORT_SYMBOL(may_umount_tree);
 
 /**
diff --git a/fs/pnode.c b/fs/pnode.c
index 234a9ac..ae6f95e 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -143,8 +143,7 @@ void change_mnt_propagation(struct mount *mnt, int type)
  * vfsmount found while iterating with propagation_next() is
  * a peer of one we'd found earlier.
  */
-static struct mount *propagation_next(struct mount *m,
-					 struct mount *origin)
+struct mount *propagation_next(struct mount *m, struct mount *origin)
 {
 	/* are there any slaves of this mount? */
 	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
diff --git a/fs/pnode.h b/fs/pnode.h
index 550f5a8..2accd2d 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -38,6 +38,7 @@ static inline void set_mnt_shared(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_SHARED;
 }
 
+struct mount *propagation_next(struct mount *, struct mount *);
 void change_mnt_propagation(struct mount *, int);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);

