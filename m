From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/18] Add an AT_NO_AUTOMOUNT flag to suppress terminal
 automount
Date: Tue, 11 Jan 2011 17:48:41 +0000
Message-ID: <20110111174841.2291.59504.stgit@warthog.procyon.org.uk>
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

Add an AT_NO_AUTOMOUNT flag to suppress terminal automounting of directories
with follow_link semantics.  This can be used by fstatat() users to permit the
gathering of attributes on an automount point and also prevent
mass-automounting of a directory of automount points by ls.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 fs/namei.c            |    6 ++++++
 fs/stat.c             |    4 +++-
 include/linux/fcntl.h |    1 +
 include/linux/namei.h |    2 ++
 4 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index dfafb97..7622825 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -889,6 +889,12 @@ static int follow_automount(struct path *path, unsigned flags,
 	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
 		return -EREMOTE;
 
+	/* We don't want to mount if someone supplied AT_NO_AUTOMOUNT
+	 * and this is the terminal part of the path.
+	 */
+	if ((flags & LOOKUP_NO_AUTOMOUNT) && !(flags & LOOKUP_CONTINUE))
+		return -EXDEV; /* we actually want to stop here */
+
 	/* We want to mount if someone is trying to open/create a file of any
 	 * type under the mountpoint, wants to traverse through the mountpoint
 	 * or wants to open the mounted directory.
diff --git a/fs/stat.c b/fs/stat.c
index 12e90e2..d5c61cf 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -75,11 +75,13 @@ int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
 	int error = -EINVAL;
 	int lookup_flags = 0;
 
-	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+	if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT)) != 0)
 		goto out;
 
 	if (!(flag & AT_SYMLINK_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flag & AT_NO_AUTOMOUNT)
+		lookup_flags |= LOOKUP_NO_AUTOMOUNT;
 
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (error)
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index afc00af..a562fa5 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -45,6 +45,7 @@
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
 #define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
+#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
 
 #ifdef __KERNEL__
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 18d06ad..a12d0d7 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -45,6 +45,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
  *  - ending slashes ok even for nonexistent files
  *  - internal "there are more path components" flag
  *  - dentry cache is untrusted; force a real lookup
+ *  - suppress terminal automount
  */
 #define LOOKUP_FOLLOW		0x0001
 #define LOOKUP_DIRECTORY	0x0002
@@ -53,6 +54,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_PARENT		0x0010
 #define LOOKUP_REVAL		0x0020
 #define LOOKUP_RCU		0x0040
+#define LOOKUP_NO_AUTOMOUNT	0x0080
 /*
  * Intent data
  */

