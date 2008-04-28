From: Jan Blunck <jblunck@suse.de>
Subject: [PATCH 3/3] AutoFS: path_{get,put}() cleanups
Date: Mon, 28 Apr 2008 18:37:34 +0200
Message-ID: <20080428163732.201203178@T61.localnet>
References: <20080428163731.774191296@T61.localnet>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline; filename=vfs/path_get_put-cleanups-autofs.diff
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-fsdevel Mailinglist <linux-fsdevel@vger.kernel.org>
Cc: raven@themaw.net, autofs@linux.kernel.org

Here are some more places where path_{get,put}() can be used instead of
dput()/mntput() pair. Besides that it fixes a bug in autofs4_mount_busy()
where mntput() was called before dput().

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/autofs4/expire.c |    2 +-
 fs/autofs4/root.c   |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: b/fs/autofs4/expire.c
===================================================================
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -73,8 +73,8 @@ static int autofs4_mount_busy(struct vfs
 	status = 0;
 done:
 	DPRINTK("returning = %d", status);
-	mntput(mnt);
 	dput(dentry);
+	mntput(mnt);
 	return status;
 }
 
Index: b/fs/autofs4/root.c
===================================================================
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -146,17 +146,17 @@ static int autofs4_dir_open(struct inode
 
 	if (d_mountpoint(dentry)) {
 		struct file *fp = NULL;
-		struct vfsmount *fp_mnt = mntget(mnt);
-		struct dentry *fp_dentry = dget(dentry);
+		struct path fp_path = { .dentry = dentry, .mnt = mnt };
 
-		if (!autofs4_follow_mount(&fp_mnt, &fp_dentry)) {
-			dput(fp_dentry);
-			mntput(fp_mnt);
+		path_get(&fp_path);
+
+		if (!autofs4_follow_mount(&fp_path.mnt, &fp_path.dentry)) {
+			path_put(&fp_path);
 			dcache_dir_close(inode, file);
 			goto out;
 		}
 
-		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
+		fp = dentry_open(fp_path.dentry, fp_path.mnt, file->f_flags);
 		status = PTR_ERR(fp);
 		if (IS_ERR(fp)) {
 			dcache_dir_close(inode, file);


