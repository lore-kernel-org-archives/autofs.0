From: David Howells <dhowells@redhat.com>
Subject: [PATCH 07/18] Add more dentry flags for special function directories
Date: Tue, 11 Jan 2011 17:48:47 +0000
Message-ID: <20110111174847.2291.7732.stgit@warthog.procyon.org.uk>
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

Add more flags to the d_flags in struct dentry for special function directories
such as mountpoints and autofs substructures.  The relevant flags are:

 (*) DCACHE_MOUNTED.

     (Already exists).  Indicates that this dentry has things mounted upon it.

 (*) DCACHE_NEED_AUTOMOUNT.

     This is a reflection of the S_AUTOMOUNT inode flag.  This is reflected by
     d_set_d_op().  follow_automount() is now keyed off of this rather than
     being keyed off S_AUTOMOUNT directly.  Possibly S_AUTOMOUNT should shift
     to the dentry entirely.

     This may also be tweaked live (such as by the autofs4 filesystem) to alter
     the effect.

 (*) DCACHE_MANAGE_TRANSIT.

     This is an indicator that the filesystem that owns the dentry wants to
     manage processes transiting away from that dentry.  If this is set on a
     dentry, then a new dentry op:

		int (*d_manage)(struct path *);

     is invoked.  This is allowed to sleep and is allowed to return an error.

     This allows autofs to hold non-Oz-mode processes here without any
     filesystem locks being held.

__follow_mount() is replaced by managed_dentry() which now handles transit to a
mountpoint's root dentry, automount points and points that the filesystem wants
to manage.


==========================
WHAT THIS MEANS FOR AUTOFS
==========================

autofs currently uses the lookup() inode op and the d_revalidate() dentry op to
trigger the automounting of indirect mounts, and both of these can be called
with i_mutex held.

autofs knows that the i_mutex will be held by the caller in lookup(), and so
can drop it before invoking the daemon - but this isn't so for d_revalidate(),
since the lock is only held on _some_ of the code paths that call it.  This
means that autofs can't risk dropping i_mutex from its d_revalidate() function
before it calls the daemon.

The bug could manifest itself as, for example, a process that's trying to
validate an automount dentry that gets made to wait because that dentry is
expired and needs cleaning up:

	mkdir         S ffffffff8014e05a     0 32580  24956
	Call Trace:
	 [<ffffffff885371fd>] :autofs4:autofs4_wait+0x674/0x897
	 [<ffffffff80127f7d>] avc_has_perm+0x46/0x58
	 [<ffffffff8009fdcf>] autoremove_wake_function+0x0/0x2e
	 [<ffffffff88537be6>] :autofs4:autofs4_expire_wait+0x41/0x6b
	 [<ffffffff88535cfc>] :autofs4:autofs4_revalidate+0x91/0x149
	 [<ffffffff80036d96>] __lookup_hash+0xa0/0x12f
	 [<ffffffff80057a2f>] lookup_create+0x46/0x80
	 [<ffffffff800e6e31>] sys_mkdirat+0x56/0xe4

versus the automount daemon which wants to remove that dentry, but can't
because the normal process is holding the i_mutex lock:

	automount     D ffffffff8014e05a     0 32581      1              32561
	Call Trace:
	 [<ffffffff80063c3f>] __mutex_lock_slowpath+0x60/0x9b
	 [<ffffffff8000ccf1>] do_path_lookup+0x2ca/0x2f1
	 [<ffffffff80063c89>] .text.lock.mutex+0xf/0x14
	 [<ffffffff800e6d55>] do_rmdir+0x77/0xde
	 [<ffffffff8005d229>] tracesys+0x71/0xe0
	 [<ffffffff8005d28d>] tracesys+0xd5/0xe0

which means that the system is deadlocked.

This patch allows autofs to hold up normal processes whilst the daemon goes
ahead and does things to the dentry tree behind the automouter point without
risking a deadlock as no locks are held in d_manage() or d_automount().

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 Documentation/filesystems/vfs.txt |   13 +++
 fs/dcache.c                       |    2 
 fs/namei.c                        |  153 ++++++++++++++++++++++++++-----------
 include/linux/dcache.h            |   13 ++-
 4 files changed, 130 insertions(+), 51 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index bb8d277..99f0127 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -865,6 +865,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
+	int (*d_manage)(struct path *);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
@@ -940,8 +941,16 @@ struct dentry_operations {
 	the automount first.  If the automount failed, then an error code
 	should be returned.
 
-	This function is only used if S_AUTOMOUNT is set on the inode to which
-	the dentry refers.
+	This function is only used if DMANAGED_AUTOMOUNT is set on the dentry.
+	This is set by d_add() if S_AUTOMOUNT is set on the inode being added.
+
+  d_manage: called to allow the filesystem to manage the transition from a
+	dentry (optional).  This allows autofs, for example, to hold up clients
+	waiting to explore behind a 'mountpoint', whilst letting the daemon go
+	past and construct the subtree there.
+
+	This function is only used if DMANAGED_TRANSIT is set on the dentry
+	being transited from.
 
 Example :
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 5699d4c..0e0978a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1371,6 +1371,8 @@ void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 		dentry->d_flags |= DCACHE_OP_REVALIDATE;
 	if (op->d_delete)
 		dentry->d_flags |= DCACHE_OP_DELETE;
+	if (op->d_automount && dentry->d_inode && IS_AUTOMOUNT(dentry->d_inode))
+		dentry->d_flags |= DCACHE_NEED_AUTOMOUNT;
 
 }
 EXPORT_SYMBOL(d_set_d_op);
diff --git a/fs/namei.c b/fs/namei.c
index 7622825..1e31f96 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -878,7 +878,7 @@ int follow_up(struct path *path)
 
 /*
  * Perform an automount
- * - return -EISDIR to tell __follow_mount() to stop and return the path we
+ * - return -EISDIR to tell managed_dentry() to stop and return the path we
  *   were called with.
  */
 static int follow_automount(struct path *path, unsigned flags,
@@ -893,7 +893,7 @@ static int follow_automount(struct path *path, unsigned flags,
 	 * and this is the terminal part of the path.
 	 */
 	if ((flags & LOOKUP_NO_AUTOMOUNT) && !(flags & LOOKUP_CONTINUE))
-		return -EXDEV; /* we actually want to stop here */
+		return -EISDIR; /* we actually want to stop here */
 
 	/* We want to mount if someone is trying to open/create a file of any
 	 * type under the mountpoint, wants to traverse through the mountpoint
@@ -913,8 +913,20 @@ static int follow_automount(struct path *path, unsigned flags,
 		return -ELOOP;
 
 	mnt = path->dentry->d_op->d_automount(path);
-	if (IS_ERR(mnt))
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
 		return PTR_ERR(mnt);
+	}
 	if (!mnt) /* mount collision */
 		return 0;
 
@@ -934,46 +946,66 @@ static int follow_automount(struct path *path, unsigned flags,
 }
 
 /*
- * serialization is taken care of in namespace.c
+ * Handle a dentry that is managed in some way.
+ * - Flagged for transit management (autofs)
+ * - Flagged as mountpoint
+ * - Flagged as automount point
+ *
+ * This may only be called in refwalk mode.
  */
-static int __follow_mount(struct path *path, unsigned flags)
+static int managed_dentry(struct path *path, unsigned flags)
 {
-	struct vfsmount *mounted;
+	unsigned managed;
 	bool need_mntput = false;
 	int ret;
 
-	for (;;) {
-		while (d_mountpoint(path->dentry)) {
-			mounted = lookup_mnt(path);
-			if (!mounted)
-				break;
-			dput(path->dentry);
-			if (need_mntput)
-				mntput(path->mnt);
-			path->mnt = mounted;
-			path->dentry = dget(mounted->mnt_root);
-			need_mntput = true;
+	/* Given that we're not holding a lock here, we retain the value in a
+	 * local variable for each dentry as we look at it so that we don't see
+	 * the components of that value change under us */
+	while (managed = ACCESS_ONCE(path->dentry->d_flags),
+	       managed &= DCACHE_MANAGED_DENTRY,
+	       unlikely(managed != 0)) {
+		/* Allow the filesystem to manage the transit without i_mutex
+		 * being held. */
+		if (managed & DCACHE_MANAGE_TRANSIT) {
+			BUG_ON(!path->dentry->d_op);
+			BUG_ON(!path->dentry->d_op->d_manage);
+			ret = path->dentry->d_op->d_manage(path);
+			if (ret < 0)
+				return ret;
 		}
-		if (!d_automount_point(path->dentry))
-			break;
-		ret = follow_automount(path, flags, &need_mntput);
-		if (ret < 0)
-			return ret == -EISDIR ? 0 : ret;
-	}
-	return 0;
-}
 
-static void follow_mount(struct path *path)
-{
-	while (d_mountpoint(path->dentry)) {
-		struct vfsmount *mounted = lookup_mnt(path);
-		if (!mounted)
-			break;
-		dput(path->dentry);
-		mntput(path->mnt);
-		path->mnt = mounted;
-		path->dentry = dget(mounted->mnt_root);
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
@@ -991,19 +1023,31 @@ int follow_down(struct path *path)
 	return 0;
 }
 
-static void __follow_mount_rcu(struct nameidata *nd, struct path *path,
-				struct inode **inode)
+/*
+ * Skip to top of mountpoint pile in rcuwalk mode.  If requested we abort the
+ * walk when we hit a dentry that has DCACHE_MANAGE_TRANSIT flagged (we don't
+ * want to take note of it when walking "..").
+ */
+static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
+			       struct inode **inode,
+			       bool abort_on_managed_dentry)
 {
+	unsigned abort_mask =
+		abort_on_managed_dentry ? DCACHE_MANAGE_TRANSIT : 0;
+
 	while (d_mountpoint(path->dentry)) {
 		struct vfsmount *mounted;
+		if (path->dentry->d_flags & abort_mask)
+			return true;
 		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
 		if (!mounted)
-			return;
+			break;
 		path->mnt = mounted;
 		path->dentry = mounted->mnt_root;
 		nd->seq = read_seqcount_begin(&path->dentry->d_seq);
 		*inode = path->dentry->d_inode;
 	}
+	return false;
 }
 
 static int follow_dotdot_rcu(struct nameidata *nd)
@@ -1012,7 +1056,7 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 
 	set_root_rcu(nd);
 
-	while(1) {
+	while (1) {
 		if (nd->path.dentry == nd->root.dentry &&
 		    nd->path.mnt == nd->root.mnt) {
 			break;
@@ -1035,12 +1079,28 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 		inode = nd->path.dentry->d_inode;
 	}
-	__follow_mount_rcu(nd, &nd->path, &inode);
+	__follow_mount_rcu(nd, &nd->path, &inode, false);
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
@@ -1105,13 +1165,14 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 	struct vfsmount *mnt = nd->path.mnt;
 	struct dentry *dentry, *parent = nd->path.dentry;
 	struct inode *dir;
+	int err;
 
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
@@ -1140,7 +1201,9 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 			goto need_revalidate;
 		path->mnt = mnt;
 		path->dentry = dentry;
-		__follow_mount_rcu(nd, path, inode);
+		if (unlikely(__follow_mount_rcu(nd, path, inode, true)) &&
+		    nameidata_drop_rcu(nd))
+			return -ECHILD;
 	} else {
 		dentry = __d_lookup(parent, name);
 		if (!dentry)
@@ -1151,7 +1214,9 @@ found:
 done:
 		path->mnt = mnt;
 		path->dentry = dentry;
-		__follow_mount(path, nd->flags);
+		err = managed_dentry(path, nd->flags);
+		if (unlikely(err < 0))
+			return err;
 		*inode = path->dentry->d_inode;
 	}
 	return 0;
@@ -2236,7 +2301,7 @@ static struct file *do_last(struct nameidata *nd, struct path *path,
 	if (open_flag & O_EXCL)
 		goto exit_dput;
 
-	error = __follow_mount(path, nd->flags);
+	error = managed_dentry(path, nd->flags);
 	if (error < 0)
 		goto exit_dput;
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 444614b..c6a4821 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -168,6 +168,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
+	int (*d_manage)(struct path *);
 } ____cacheline_aligned;
 
 /*
@@ -206,13 +207,18 @@ struct dentry_operations {
 
 #define DCACHE_CANT_MOUNT	0x0100
 #define DCACHE_GENOCIDE		0x0200
-#define DCACHE_MOUNTED		0x0400	/* is a mountpoint */
 
 #define DCACHE_OP_HASH		0x1000
 #define DCACHE_OP_COMPARE	0x2000
 #define DCACHE_OP_REVALIDATE	0x4000
 #define DCACHE_OP_DELETE	0x8000
 
+#define DCACHE_MOUNTED		0x10000	/* is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT	0x20000	/* handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT	0x40000	/* manage transit from this dirent */
+#define DCACHE_MANAGED_DENTRY \
+	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
+
 extern seqlock_t rename_lock;
 
 static inline int dname_external(struct dentry *dentry)
@@ -400,14 +406,11 @@ static inline void dont_mount(struct dentry *dentry)
 
 extern void dput(struct dentry *);
 
-static inline int d_mountpoint(struct dentry *dentry)
+static inline bool d_mountpoint(struct dentry *dentry)
 {
 	return dentry->d_flags & DCACHE_MOUNTED;
 }
 
-#define d_automount_point(dentry) \
-	(dentry->d_inode && IS_AUTOMOUNT(dentry->d_inode))
-
 extern struct vfsmount *lookup_mnt(struct path *);
 extern struct dentry *lookup_create(struct nameidata *nd, int is_dir);
 

