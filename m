From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/6] autofs4 - correct offset mount expire check
Date: Thu, 23 Oct 2008 10:35:13 +0800
Message-ID: <20081023023513.4508.54940.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

When checking a directory tree in autofs_tree_busy() we can incorrectly
decide that the tree isn't busy. This happens for the case of an active
offset mount as autofs4_follow_mount() follows past the active offset
mount, which has an open file handle used for expires, causing the file
handle not to count toward the busyness check.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---

 fs/autofs4/expire.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)


diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index cde2f8e..4b6fb3f 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -56,12 +56,23 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	mntget(mnt);
 	dget(dentry);
 
-	if (!autofs4_follow_mount(&mnt, &dentry))
+	if (!follow_down(&mnt, &dentry))
 		goto done;
 
-	/* This is an autofs submount, we can't expire it */
-	if (is_autofs4_dentry(dentry))
-		goto done;
+	if (is_autofs4_dentry(dentry)) {
+		struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+
+		/* This is an autofs submount, we can't expire it */
+		if (sbi->type == AUTOFS_TYPE_INDIRECT)
+			goto done;
+
+		/*
+		 * Otherwise it's an offset mount and we need to check
+		 * if we can umount its mount, if there is one.
+		 */
+		if (!d_mountpoint(dentry))
+			goto done;
+	}
 
 	/* Update the expiry counter if fs is busy */
 	if (!may_umount_tree(mnt)) {

