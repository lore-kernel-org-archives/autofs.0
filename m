From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/7] autofs - fix directory and symlink access
Date: Tue, 19 Jun 2018 10:50:18 +0800
Message-ID: <152937661793.20656.604490449672006599.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Depending on how it is configured the autofs user space daemon can
leave in use mounts mounted at exit and re-connect to them at start
up. But for this to work best the state of the autofs file system
needs to be left intact over the restart.

Also, at system shutdown, mounts in an autofs file system might be
umounted exposing a mount point trigger for which subsequent access
can lead to a hang. So recent versions of automount(8) now does its
best to set autofs file system mounts catatonic at shutdown.

When autofs file system mounts are catatonic it's currently possible
to create and remove directories and symlinks which can be a problem
at restart, as described above.

So return EACCES in the directory, symlink and unlink methods if the
autofs file system is catatonic.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a3d414150578..782e57b911ab 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -559,6 +559,13 @@ static int autofs_dir_symlink(struct inode *dir,
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	BUG_ON(!ino);
 
 	autofs_clean_ino(ino);
@@ -612,9 +619,15 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 
-	/* This allows root to remove symlinks */
-	if (!autofs_oz_mode(sbi) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	if (!autofs_oz_mode(sbi))
+		return -EACCES;
+
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
 
 	if (atomic_dec_and_test(&ino->count)) {
 		p_ino = autofs_dentry_ino(dentry->d_parent);
@@ -697,6 +710,13 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	spin_lock(&sbi->lookup_lock);
 	if (!simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
@@ -735,6 +755,13 @@ static int autofs_dir_mkdir(struct inode *dir,
 	if (!autofs_oz_mode(sbi))
 		return -EACCES;
 
+	/* autofs_oz_mode() needs to allow path walks when the
+	 * autofs mount is catatonic but the state of an autofs
+	 * file system needs to be preserved over restarts.
+	 */
+	if (sbi->catatonic)
+		return -EACCES;
+
 	pr_debug("dentry %p, creating %pd\n", dentry, dentry);
 
 	BUG_ON(!ino);

