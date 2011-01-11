From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Tue, 11 Jan 2011 17:48:15 +0000
Message-ID: <20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Add a dentry op (d_automount) to handle automounting directories rather than
abusing the follow_link() inode operation.  The operation is keyed off a new
inode flag (S_AUTOMOUNT).

This makes it easier to add an AT_ flag to suppress terminal segment automount
during pathwalk.  It should also remove the need for the kludge code in the
pathwalk algorithm to handle directories with follow_link() semantics.

A new pathwalk subroutine, follow_automount() is added to handle mountpoints.
It will return -EREMOTE if the S_AUTOMOUNT was set, but no d_automount() op was
supplied, -ELOOP if we've encountered too many symlinks or mountpoints, -EISDIR
if the walk point should be used without mounting and 0 if successful.  path
will be updated if an automount took place to point to the mounted filesystem.

I've only changed __follow_mount() to handle call follow_automount(), but it
might be necessary to change follow_mount() too.  The latter is only called
from follow_dotdot(), but any automounts on ".." should be pinned whilst we're
using a child of it.

I've also extracted the mount/don't-mount logic from autofs4 and included it
here.  It makes the mount go ahead anyway if someone calls open() or creat(),
tries to traverse the directory, tries to chdir/chroot/etc. into the directory,
or sticks a '/' on the end of the pathname.  If they do a stat(), however,
they'll only trigger the automount if they didn't also say O_NOFOLLOW.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 Documentation/filesystems/Locking |    2 +
 Documentation/filesystems/vfs.txt |   13 ++++
 fs/namei.c                        |  120 ++++++++++++++++++++++++++++---------
 include/linux/dcache.h            |    4 +
 include/linux/fs.h                |    2 +
 5 files changed, 111 insertions(+), 30 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 977d891..7ebe42d 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -19,6 +19,7 @@ prototypes:
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)((struct dentry *dentry, char *buffer, int buflen);
+	struct vfsmount *(*d_automount)(struct path *path);
 
 locking rules:
 		rename_lock	->d_lock	may block	rcu-walk
@@ -29,6 +30,7 @@ d_delete:	no		yes		no		no
 d_release:	no		no		yes		no
 d_iput:		no		no		yes		no
 d_dname:	no		no		no		no
+d_automount:	no		no		no		yes
 
 --------------------------- inode_operations --------------------------- 
 prototypes:
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index fbb324e..bb8d277 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -864,6 +864,7 @@ struct dentry_operations {
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
+	struct vfsmount *(*d_automount)(struct path *);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
@@ -930,6 +931,18 @@ struct dentry_operations {
 	at the end of the buffer, and returns a pointer to the first char.
 	dynamic_dname() helper function is provided to take care of this.
 
+  d_automount: called when an automount dentry is to be traversed (optional).
+	This should create a new VFS mount record, mount it on the directory
+	and return the record to the caller.  The caller is supplied with a
+	path parameter giving the automount directory to describe the automount
+	target and the parent VFS mount record to provide inheritable mount
+	parameters.  NULL should be returned if someone else managed to make
+	the automount first.  If the automount failed, then an error code
+	should be returned.
+
+	This function is only used if S_AUTOMOUNT is set on the inode to which
+	the dentry refers.
+
 Example :
 
 static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
diff --git a/fs/namei.c b/fs/namei.c
index 24ece10..159da29 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -877,38 +877,84 @@ int follow_up(struct path *path)
 }
 
 /*
- * serialization is taken care of in namespace.c
+ * Perform an automount
+ * - return -EISDIR to tell __follow_mount() to stop and return the path we
+ *   were called with.
  */
-static void __follow_mount_rcu(struct nameidata *nd, struct path *path,
-				struct inode **inode)
+static int follow_automount(struct path *path, unsigned flags,
+			    bool *need_mntput)
 {
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted;
-		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
-		if (!mounted)
-			return;
-		path->mnt = mounted;
-		path->dentry = mounted->mnt_root;
-		nd->seq = read_seqcount_begin(&path->dentry->d_seq);
-		*inode = path->dentry->d_inode;
+	struct vfsmount *mnt;
+
+	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
+		return -EREMOTE;
+
+	/* We want to mount if someone is trying to open/create a file of any
+	 * type under the mountpoint, wants to traverse through the mountpoint
+	 * or wants to open the mounted directory.
+	 *
+	 * We don't want to mount if someone's just doing a stat and they've
+	 * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
+	 * appended a '/' to the name.
+	 */
+	if (!(flags & LOOKUP_FOLLOW) &&
+	    !(flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
+		       LOOKUP_OPEN | LOOKUP_CREATE)))
+		return -EISDIR;
+
+	current->total_link_count++;
+	if (current->total_link_count >= 40)
+		return -ELOOP;
+
+	mnt = path->dentry->d_op->d_automount(path);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+	if (!mnt) /* mount collision */
+		return 0;
+
+	if (mnt->mnt_sb == path->mnt->mnt_sb &&
+	    mnt->mnt_root == path->dentry) {
+		mntput(mnt);
+		return -ELOOP;
 	}
+
+	dput(path->dentry);
+	if (*need_mntput)
+		mntput(path->mnt);
+	path->mnt = mnt;
+	path->dentry = dget(mnt->mnt_root);
+	*need_mntput = true;
+	return 0;
 }
 
-static int __follow_mount(struct path *path)
+/*
+ * serialization is taken care of in namespace.c
+ */
+static int __follow_mount(struct path *path, unsigned flags)
 {
-	int res = 0;
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
+	struct vfsmount *mounted;
+	bool need_mntput = false;
+	int ret;
+
+	for (;;) {
+		while (d_mountpoint(path->dentry)) {
+			mounted = lookup_mnt(path);
+			if (!mounted)
+				break;
+			dput(path->dentry);
+			if (need_mntput)
+				mntput(path->mnt);
+			path->mnt = mounted;
+			path->dentry = dget(mounted->mnt_root);
+			need_mntput = true;
+		}
+		if (!d_automount_point(path->dentry))
 			break;
-		dput(path->dentry);
-		if (res)
-			mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
-		res = 1;
+		ret = follow_automount(path, flags, &need_mntput);
+		if (ret < 0)
+			return ret == -EISDIR ? 0 : ret;
 	}
-	return res;
+	return 0;
 }
 
 static void follow_mount(struct path *path)
@@ -939,6 +985,21 @@ int follow_down(struct path *path)
 	return 0;
 }
 
+static void __follow_mount_rcu(struct nameidata *nd, struct path *path,
+				struct inode **inode)
+{
+	while (d_mountpoint(path->dentry)) {
+		struct vfsmount *mounted;
+		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
+		if (!mounted)
+			return;
+		path->mnt = mounted;
+		path->dentry = mounted->mnt_root;
+		nd->seq = read_seqcount_begin(&path->dentry->d_seq);
+		*inode = path->dentry->d_inode;
+	}
+}
+
 static int follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct inode *inode = nd->inode;
@@ -1038,6 +1099,7 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	struct inode *dir;
+
 	/*
 	 * See if the low-level filesystem might want
 	 * to use its own hash..
@@ -1083,7 +1145,7 @@ found:
 done:
 		path->mnt = mnt;
 		path->dentry = dentry;
-		__follow_mount(path);
+		__follow_mount(path, nd->flags);
 		*inode = path->dentry->d_inode;
 	}
 	return 0;
@@ -2178,11 +2240,9 @@ static struct file *do_last(struct nameidata *nd, struct path *path,
 	if (open_flag & O_EXCL)
 		goto exit_dput;
 
-	if (__follow_mount(path)) {
-		error = -ELOOP;
-		if (open_flag & O_NOFOLLOW)
-			goto exit_dput;
-	}
+	error = __follow_mount(path, nd->flags);
+	if (error < 0)
+		goto exit_dput;
 
 	error = -ENOENT;
 	if (!path->dentry->d_inode)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 59fcd24..444614b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -167,6 +167,7 @@ struct dentry_operations {
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
+	struct vfsmount *(*d_automount)(struct path *);
 } ____cacheline_aligned;
 
 /*
@@ -404,6 +405,9 @@ static inline int d_mountpoint(struct dentry *dentry)
 	return dentry->d_flags & DCACHE_MOUNTED;
 }
 
+#define d_automount_point(dentry) \
+	(dentry->d_inode && IS_AUTOMOUNT(dentry->d_inode))
+
 extern struct vfsmount *lookup_mnt(struct path *);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f84d992..5416e1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -242,6 +242,7 @@ struct inodes_stat_t {
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	512	/* Inode is fs-internal */
 #define S_IMA		1024	/* Inode has an associated IMA struct */
+#define S_AUTOMOUNT	2048	/* Automount/referral quasi-directory */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -277,6 +278,7 @@ struct inodes_stat_t {
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
 #define IS_IMA(inode)		((inode)->i_flags & S_IMA)
+#define IS_AUTOMOUNT(inode)	((inode)->i_flags & S_AUTOMOUNT)
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */

