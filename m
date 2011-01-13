From: David Howells <dhowells@redhat.com>
Subject: [PATCH 18/18] Allow d_manage() to be used in RCU-walk mode [ver #4]
Date: Thu, 13 Jan 2011 21:55:36 +0000
Message-ID: <20110113215536.19406.16664.stgit@warthog.procyon.org.uk>
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

Allow d_manage() to be called from pathwalk when it is in RCU-walk mode as well
as when it is in Ref-walk mode.  This permits __follow_mount_rcu() to call
d_manage() directly.  d_manage() needs a parameter to indicate that it is in
RCU-walk mode as it isn't allowed to sleep if in that mode (but should return
-ECHILD instead).

autofs4_d_manage() can then be set to retain RCU-walk mode if the daemon
accesses it and otherwise request dropping back to ref-walk mode.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/filesystems/Locking |    2 +-
 Documentation/filesystems/vfs.txt |    7 ++++++-
 fs/autofs4/root.c                 |    8 ++++++--
 fs/namei.c                        |   14 +++++++-------
 include/linux/dcache.h            |    2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index 621ee98..b3b0ac4 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -31,7 +31,7 @@ d_release:	no		no		yes		no
 d_iput:		no		no		yes		no
 d_dname:	no		no		no		no
 d_automount:	no		no		yes		no
-d_manage:	no		no		yes		no
+d_manage:	no		no		yes (ref-walk)	maybe
 
 --------------------------- inode_operations --------------------------- 
 prototypes:
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 3d68c2e..9bc28c2f 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -865,7 +865,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct path *, bool);
+	int (*d_manage)(struct path *, bool, bool);
 };
 
   d_revalidate: called when the VFS needs to revalidate a dentry. This
@@ -960,6 +960,11 @@ struct dentry_operations {
 	held by the caller and the function should not initiate any mounts or
 	unmounts that it will then wait for.
 
+	If the 'rcu_walk' parameter is true, then the caller is doing a
+	pathwalk in RCU-walk mode.  Sleeping is not permitted in this mode,
+	and the caller can be asked to leave it and call again by returing
+	-ECHILD.
+
 	This function is only used if DCACHE_MANAGE_TRANSIT is set on the
 	dentry being transited from.
 
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 752693f..c46d6fb 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -36,7 +36,7 @@ static long autofs4_root_compat_ioctl(struct file *,unsigned int,unsigned long);
 static int autofs4_dir_open(struct inode *inode, struct file *file);
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static struct vfsmount *autofs4_d_automount(struct path *);
-static int autofs4_d_manage(struct path *, bool);
+static int autofs4_d_manage(struct path *, bool, bool);
 
 const struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
@@ -454,7 +454,7 @@ done:
 	return NULL;
 }
 
-int autofs4_d_manage(struct path *path, bool mounting_here)
+int autofs4_d_manage(struct path *path, bool mounting_here, bool rcu_walk)
 {
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
@@ -469,6 +469,10 @@ int autofs4_d_manage(struct path *path, bool mounting_here)
 		return 0;
 	}
 
+	/* We need to sleep, so we need pathwalk to be in ref-mode */
+	if (rcu_walk)
+		return -ECHILD;
+
 	/* Wait for pending expires */
 	do_expire_wait(dentry);
 
diff --git a/fs/namei.c b/fs/namei.c
index c983c92..5c15daa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -967,7 +967,7 @@ static int follow_managed(struct path *path, unsigned flags)
 		if (managed & DCACHE_MANAGE_TRANSIT) {
 			BUG_ON(!path->dentry->d_op);
 			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(path, false);
+			ret = path->dentry->d_op->d_manage(path, false, false);
 			if (ret < 0)
 				return ret == -EISDIR ? 0 : ret;
 		}
@@ -1028,13 +1028,12 @@ int follow_down_one(struct path *path)
 static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 			       struct inode **inode, bool reverse_transit)
 {
-	unsigned abort_mask =
-		reverse_transit ? 0 : DCACHE_MANAGE_TRANSIT;
-
 	while (d_mountpoint(path->dentry)) {
 		struct vfsmount *mounted;
-		if (path->dentry->d_flags & abort_mask)
-			return true;
+		if (unlikely(path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) &&
+		    !reverse_transit &&
+		    path->dentry->d_op->d_manage(path, false, true) < 0)
+			return false;
 		mounted = __lookup_mnt(path->mnt, path->dentry, 1);
 		if (!mounted)
 			break;
@@ -1112,7 +1111,8 @@ int follow_down(struct path *path, bool mounting_here)
 		if (managed & DCACHE_MANAGE_TRANSIT) {
 			BUG_ON(!path->dentry->d_op);
 			BUG_ON(!path->dentry->d_op->d_manage);
-			ret = path->dentry->d_op->d_manage(path, mounting_here);
+			ret = path->dentry->d_op->d_manage(path, mounting_here,
+							   false);
 			if (ret < 0)
 				return ret == -EISDIR ? 0 : ret;
 		}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 946521d..236a384 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -168,7 +168,7 @@ struct dentry_operations {
 	void (*d_iput)(struct dentry *, struct inode *);
 	char *(*d_dname)(struct dentry *, char *, int);
 	struct vfsmount *(*d_automount)(struct path *);
-	int (*d_manage)(struct path *, bool);
+	int (*d_manage)(struct path *, bool, bool);
 } ____cacheline_aligned;
 
 /*

