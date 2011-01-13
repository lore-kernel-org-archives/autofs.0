From: David Howells <dhowells@redhat.com>
Subject: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link() [ver #4]
Date: Thu, 13 Jan 2011 21:54:05 +0000
Message-ID: <20110113215405.19406.73651.stgit@warthog.procyon.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@zeniv.linux.org.uk, raven@themaw.net, npiggin@kernel.dk
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Add a dentry op (d_automount) to handle automounting directories rather than
abusing the follow_link() inode operation.  The operation is keyed off a new
dentry flag (DCACHE_NEED_AUTOMOUNT).

This also makes it easier to add an AT_ flag to suppress terminal segment
automount during pathwalk and removes the need for the kludge code in the
pathwalk algorithm to handle directories with follow_link() semantics.

The ->d_automount() dentry operation:

	struct vfsmount *(*d_automount)(struct path *mountpoint);

takes a pointer to the directory to be mounted upon, which is expected to
provide sufficient data to determine what should be mounted.  If successful, it
should return the vfsmount struct it creates (which it should also have added
to the namespace using do_add_mount() or similar).  If there's a collision with
another automount attempt, NULL should be returned.  If the directory specified
by the parameter should be used directly rather than being mounted upon,
-EISDIR should be returned.  In any other case, an error code should be
returned.

The ->d_automount() operation is called with no locks held and may sleep.  At
this point the pathwalk algorithm will be in ref-walk mode.


Within fs/namei.c itself, a new pathwalk subroutine (follow_automount()) is
added to handle mountpoints.  It will return -EREMOTE if the automount flag was
set, but no d_automount() op was supplied, -ELOOP if we've encountered too many
symlinks or mountpoints, -EISDIR if the walk point should be used without
mounting and 0 if successful.  The path will be updated to point to the mounted
filesystem if a successful automount took place.

__follow_mount() is replaced by follow_managed() which is more generic
(especially with the patch that adds ->d_manage()).  This handles transits from
directories during pathwalk, including automounting and skipping over
mountpoints (and holding processes with the next patch).

__follow_mount_rcu() will jump out of RCU-walk mode if it encounters an
automount point with nothing mounted on it.

follow_dotdot*() does not handle automounts as you don't want to trigger them
whilst following "..".

I've also extracted the mount/don't-mount logic from autofs4 and included it
here.  It makes the mount go ahead anyway if someone calls open() or creat(),
tries to traverse the directory, tries to chdir/chroot/etc. into the directory,
or sticks a '/' on the end of the pathname.  If they do a stat(), however,
they'll only trigger the automount if they didn't also say O_NOFOLLOW.

I've also added an inode flag (S_AUTOMOUNT) so that filesystems can mark their
inodes as automount points.  This flag is automatically propagated to the
dentry as DCACHE_NEED_AUTOMOUNT by __d_instantiate().  This saves NFS and could
save AFS a private flag bit apiece, but is not strictly necessary.  It would be
preferable to do the propagation in d_set_d_op(), but that doesn't normally
have access to the inode.

Signed-off-by: David Howells <dhowells@redhat.com>
Was-Acked-by: Ian Kent <raven@themaw.net>
---

 Documentation/filesystems/Locking |    2 
 Documentation/filesystems/vfs.txt |   14 +++
 fs/dcache.c                       |    5 +
 fs/namei.c                        |  205 +++++++++++++++++++++++++++++--------
 include/linux/dcache.h            |    7 +
 include/linux/fs.h                |    2 
 6 files changed, 187 insertions(+), 48 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 977d891..5f0c52a 100644
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
+d_automount:	no		no		yes		no
 
 --------------------------- inode_operations --------------------------- 
 prototypes:
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index fbb324e..992cf74 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -864,6 +864,7 @@ struct dentry_operations {
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
+	struct vfsmount *(*d_automount)(struct path *);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
@@ -930,6 +931,19 @@ struct dentry_operations {
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
+	This function is only used if DCACHE_NEED_AUTOMOUNT is set on the
+	dentry.  This is set by __d_instantiate() if S_AUTOMOUNT is set on the
+	inode being added.
+
 Example :
 
 static char *pipefs_dname(struct dentry *dent, char *buffer, int buflen)
diff --git a/fs/dcache.c b/fs/dcache.c
index 5699d4c..2ef5fcd 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1378,8 +1378,11 @@ EXPORT_SYMBOL(d_set_d_op);
 static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	spin_lock(&dentry->d_lock);
-	if (inode)
+	if (inode) {
+		if (unlikely(IS_AUTOMOUNT(inode)))
+			dentry->d_flags |= DCACHE_NEED_AUTOMOUNT;
 		list_add(&dentry->d_alias, &inode->i_dentry);
+	}
 	dentry->d_inode = inode;
 	dentry_rcuwalk_barrier(dentry);
 	spin_unlock(&dentry->d_lock);
diff --git a/fs/namei.c b/fs/namei.c
index 24ece10..f55c11a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -877,51 +877,120 @@ int follow_up(struct path *path)
 }
 
 /*
- * serialization is taken care of in namespace.c
+ * Perform an automount
+ * - return -EISDIR to tell follow_managed() to stop and return the path we
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
+	if (IS_ERR(mnt)) {
+		/*
+		 * The filesystem is allowed to return -EISDIR here to indicate
+		 * it doesn't want to automount.  For instance, autofs would do
+		 * this so that its userspace daemon can mount on this dentry.
+		 *
+		 * However, we can only permit this if it's a terminal point in
+		 * the path being looked up; if it wasn't then the remainder of
+		 * the path is inaccessible and we should say so.
+		 */
+		if (PTR_ERR(mnt) == -EISDIR && (flags & LOOKUP_CONTINUE))
+			return -EREMOTE;
+		return PTR_ERR(mnt);
 	}
-}
+	if (!mnt) /* mount collision */
+		return 0;
 
-static int __follow_mount(struct path *path)
-{
-	int res = 0;
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
-			break;
-		dput(path->dentry);
-		if (res)
-			mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
-		res = 1;
+	if (mnt->mnt_sb == path->mnt->mnt_sb &&
+	    mnt->mnt_root == path->dentry) {
+		mntput(mnt);
+		return -ELOOP;
 	}
-	return res;
+
+	dput(path->dentry);
+	if (*need_mntput)
+		mntput(path->mnt);
+	path->mnt = mnt;
+	path->dentry = dget(mnt->mnt_root);
+	*need_mntput = true;
+	return 0;
 }
 
-static void follow_mount(struct path *path)
+/*
+ * Handle a dentry that is managed in some way.
+ * - Flagged as mountpoint
+ * - Flagged as automount point
+ *
+ * This may only be called in refwalk mode.
+ *
+ * Serialization is taken care of in namespace.c
+ */
+static int follow_managed(struct path *path, unsigned flags)
 {
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
-			break;
-		dput(path->dentry);
-		mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
+	unsigned managed;
+	bool need_mntput = false;
+	int ret;
+
+	/* Given that we're not holding a lock here, we retain the value in a
+	 * local variable for each dentry as we look at it so that we don't see
+	 * the components of that value change under us */
+	while (managed = ACCESS_ONCE(path->dentry->d_flags),
+	       managed &= DCACHE_MANAGED_DENTRY,
+	       unlikely(managed != 0)) {
+		/* Transit to a mounted filesystem. */
+		if (managed & DCACHE_MOUNTED) {
+			struct vfsmount *mounted = lookup_mnt(path);
+			if (mounted) {
+				dput(path->dentry);
+				if (need_mntput)
+					mntput(path->mnt);
+				path->mnt = mounted;
+				path->dentry = dget(mounted->mnt_root);
+				need_mntput = true;
+				continue;
+			}
+
+			/* Something is mounted on this dentry in another
+			 * namespace and/or whatever was mounted there in this
+			 * namespace got unmounted before we managed to get the
+			 * vfsmount_lock */
+		}
+
+		/* Handle an automount point */
+		if (managed & DCACHE_NEED_AUTOMOUNT) {
+			ret = follow_automount(path, flags, &need_mntput);
+			if (ret < 0)
+				return ret == -EISDIR ? 0 : ret;
+			continue;
+		}
+
+		/* We didn't change the current path point */
+		break;
 	}
+	return 0;
 }
 
 int follow_down(struct path *path)
@@ -939,13 +1008,37 @@ int follow_down(struct path *path)
 	return 0;
 }
 
+/*
+ * Skip to top of mountpoint pile in rcuwalk mode.  We abort the rcu-walk if we
+ * meet an automount point and we're not walking to "..".  True is returned to
+ * continue, false to abort.
+ */
+static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
+			       struct inode **inode, bool reverse_transit)
+{
+	while (d_mountpoint(path->dentry)) {
+		struct vfsmount *mounted;
+		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
+		if (!mounted)
+			break;
+		path->mnt = mounted;
+		path->dentry = mounted->mnt_root;
+		nd->seq = read_seqcount_begin(&path->dentry->d_seq);
+		*inode = path->dentry->d_inode;
+	}
+
+	if (unlikely(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT))
+		return reverse_transit;
+	return true;
+}
+
 static int follow_dotdot_rcu(struct nameidata *nd)
 {
 	struct inode *inode = nd->inode;
 
 	set_root_rcu(nd);
 
-	while(1) {
+	while (1) {
 		if (nd->path.dentry == nd->root.dentry &&
 		    nd->path.mnt == nd->root.mnt) {
 			break;
@@ -968,12 +1061,28 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 		inode = nd->path.dentry->d_inode;
 	}
-	__follow_mount_rcu(nd, &nd->path, &inode);
+	__follow_mount_rcu(nd, &nd->path, &inode, true);
 	nd->inode = inode;
 
 	return 0;
 }
 
+/*
+ * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
+ */
+static void follow_mount(struct path *path)
+{
+	while (d_mountpoint(path->dentry)) {
+		struct vfsmount *mounted = lookup_mnt(path);
+		if (!mounted)
+			break;
+		dput(path->dentry);
+		mntput(path->mnt);
+		path->mnt = mounted;
+		path->dentry = dget(mounted->mnt_root);
+	}
+}
+
 static void follow_dotdot(struct nameidata *nd)
 {
 	set_root(nd);
@@ -1038,12 +1147,14 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	struct inode *dir;
+	int err;
+
 	/*
 	 * See if the low-level filesystem might want
 	 * to use its own hash..
 	 */
 	if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
-		int err = parent->d_op->d_hash(parent, nd->inode, name);
+		err = parent->d_op->d_hash(parent, nd->inode, name);
 		if (err < 0)
 			return err;
 	}
@@ -1072,7 +1183,9 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 			goto need_revalidate;
 		path->mnt = mnt;
 		path->dentry = dentry;
-		__follow_mount_rcu(nd, path, inode);
+		if (unlikely(!__follow_mount_rcu(nd, path, inode, false)) &&
+		    nameidata_drop_rcu(nd))
+			return -ECHILD;
 	} else {
 		dentry = __d_lookup(parent, name);
 		if (!dentry)
@@ -1083,7 +1196,9 @@ found:
 done:
 		path->mnt = mnt;
 		path->dentry = dentry;
-		__follow_mount(path);
+		err = follow_managed(path, nd->flags);
+		if (unlikely(err < 0))
+			return err;
 		*inode = path->dentry->d_inode;
 	}
 	return 0;
@@ -2178,11 +2293,9 @@ static struct file *do_last(struct nameidata *nd, struct path *path,
 	if (open_flag & O_EXCL)
 		goto exit_dput;
 
-	if (__follow_mount(path)) {
-		error = -ELOOP;
-		if (open_flag & O_NOFOLLOW)
-			goto exit_dput;
-	}
+	error = follow_managed(path, nd->flags);
+	if (error < 0)
+		goto exit_dput;
 
 	error = -ENOENT;
 	if (!path->dentry->d_inode)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 59fcd24..ee6c26d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -167,6 +167,7 @@ struct dentry_operations {
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
+	struct vfsmount *(*d_automount)(struct path *);
 } ____cacheline_aligned;
 
 /*
@@ -205,13 +206,17 @@ struct dentry_operations {
 
 #define DCACHE_CANT_MOUNT	0x0100
 #define DCACHE_GENOCIDE		0x0200
-#define DCACHE_MOUNTED		0x0400	/* is a mountpoint */
 
 #define DCACHE_OP_HASH		0x1000
 #define DCACHE_OP_COMPARE	0x2000
 #define DCACHE_OP_REVALIDATE	0x4000
 #define DCACHE_OP_DELETE	0x8000
 
+#define DCACHE_MOUNTED		0x10000	/* is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT	0x20000	/* handle automount on this dir */
+#define DCACHE_MANAGED_DENTRY \
+	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT)
+
 extern seqlock_t rename_lock;
 
 static inline int dname_external(struct dentry *dentry)
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

