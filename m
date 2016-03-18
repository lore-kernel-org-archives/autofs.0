From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] autofs: fix contained_in_local_fs and improve scalability
Date: Fri, 18 Mar 2016 17:25:59 -0400
Message-ID: <56EC7267.6000103@suse.com>
References: <56EC6897.7040409@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <56EC6897.7040409@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>

Commit d3ce65e05d1 (autofs-5.0.3 - allow directory create on NFS root),
introduced a bug where contained_in_local_fs would *always* return true. 

Since the goal of contained_in_local_fs is only to determine if the
path would be created on a local file system, it's enough to check a
few things directly without parsing the mount table at all.

We can check via stat calls:
1) If parent is the root directory
2) If the parent is located on the root file system
3) If the parent is located within a file system mounted
   via a block device

Large numbers of direct mounts when using /proc/self/mounts instead
of /etc/mtab result in very slow startup time.  In testing, we observed
~8k mounts taking over 6 hours to complete.

This is due to reading /proc/self/mounts for every path component of
every mount.  For my test case, that turns out to be about 119k times
for a total of just under 400 GB read.  If it were a flat file, it
would be also be slow, but /proc/self/mounts is dynamically generated
every time it's read.

By avoiding reading /proc/self/mounts many times, startup time with 8k
direct mounts drops from ~6 hours to about 25 seconds.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 daemon/automount.c |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 include/mounts.h   |    1 -
 lib/mounts.c       |   45 ---------------------------------------------
 3 files changed, 44 insertions(+), 49 deletions(-)

--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -98,6 +98,46 @@ static int umount_all(struct autofs_poin
 
 extern struct master *master_list;
 
+#define SYSFS_PATTERN "/sys/dev/block/%d:%d"
+static int contained_in_local_fs(const char *parent)
+{
+	char buf[128];
+	struct stat st, root;
+	int ret;
+
+	/* The root directory is always considered local, even if it's not. */
+	if (!*parent)
+		return 1;
+
+	ret = stat("/", &root);
+	if (ret != 0) {
+		logerr("error: stat failed on /: %s", strerror(errno));
+		return 0;
+	}
+
+	ret = stat(parent, &st);
+	if (ret)
+		return 0;
+	/*
+	 * If the parent is on the root file system, it's local.
+	 */
+	if (root.st_dev == st.st_dev)
+		return 1;
+
+	/*
+	 * If the sysfs node for the block device exists, it's local.
+	 */
+	ret = snprintf(buf, sizeof(buf), SYSFS_PATTERN,
+		       major(st.st_dev), minor(st.st_dev));
+	if (ret != 0) {
+		logerr("error: not enough space for sysfs path");
+		return 0;
+	}
+
+	ret = stat(buf, &st);
+	return (ret == 0);
+}
+
 static int do_mkdir(const char *parent, const char *path, mode_t mode)
 {
 	int status;
@@ -114,14 +154,15 @@ static int do_mkdir(const char *parent,
 	}
 
 	/*
-	 * If we're trying to create a directory within an autofs fs
-	 * or the path is contained in a localy mounted fs go ahead.
+	 * If we're trying to create a directory within an autofs fs,
+	 * the parent is the root directory, or the path is contained
+	 * in a locally mounted fs go ahead.
 	 */
 	status = -1;
 	if (*parent)
 		status = statfs(parent, &fs);
 	if ((status != -1 && fs.f_type == (__SWORD_TYPE) AUTOFS_SUPER_MAGIC) ||
-	    contained_in_local_fs(path)) {
+	    contained_in_local_fs(parent)) {
 		mode_t mask = umask(0022);
 		int ret = mkdir(path, mode);
 		(void) umask(mask);
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -96,7 +96,6 @@ char *make_mnt_name_string(char *path);
 struct mnt_list *get_mnt_list(const char *table, const char *path, int include);
 struct mnt_list *reverse_mnt_list(struct mnt_list *list);
 void free_mnt_list(struct mnt_list *list);
-int contained_in_local_fs(const char *path);
 int is_mounted(const char *table, const char *path, unsigned int type);
 int has_fstab_option(const char *opt);
 char *get_offset(const char *prefix, char *offset,
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -636,51 +636,6 @@ void free_mnt_list(struct mnt_list *list
 	}
 }
 
-int contained_in_local_fs(const char *path)
-{
-	struct mnt_list *mnts, *this;
-	size_t pathlen = strlen(path);
-	int ret;
-
-	if (!path || !pathlen || pathlen > PATH_MAX)
-		return 0;
-
-	mnts = get_mnt_list(_PATH_MOUNTED, "/", 1);
-	if (!mnts)
-		return 0;
-
-	ret = 0;
-
-	for (this = mnts; this != NULL; this = this->next) {
-		size_t len = strlen(this->path);
-
-		if (!strncmp(path, this->path, len)) {
-			if (len > 1 && pathlen > len && path[len] != '/')
-				continue;
-			else if (len == 1 && this->path[0] == '/') {
-				/*
-				 * always return true on rootfs, we don't
-				 * want to break diskless clients.
-				 */
-				ret = 1;
-			} else if (this->fs_name[0] == '/') {
-				if (strlen(this->fs_name) > 1) {
-					if (this->fs_name[1] != '/')
-						ret = 1;
-				} else
-					ret = 1;
-			} else if (!strncmp("LABEL=", this->fs_name, 6) ||
-				   !strncmp("UUID=", this->fs_name, 5))
-				ret = 1;
-			break;
-		}
-	}
-
-	free_mnt_list(mnts);
-
-	return ret;
-}
-
 static int table_is_mounted(const char *table, const char *path, unsigned int type)
 {
 	struct mntent *mnt;
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
