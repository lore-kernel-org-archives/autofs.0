From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/4] autofs: add comment about autofs_mountpoint_changed()
Date: Thu, 26 Mar 2020 13:23:36 +0800
Message-ID: <158520021604.5325.4342529050022426912.stgit@mickey.themaw.net>
References: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158520019862.5325.7856909810909592388.stgit@mickey.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The function autofs_mountpoint_changed() is unusual, add a comment
about two cases for which it is used.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 308cc49aca1d..a972bbaecb46 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -280,9 +280,24 @@ static struct dentry *autofs_mountpoint_changed(struct path *path)
 	struct dentry *dentry = path->dentry;
 	struct autofs_sb_info *sbi = autofs_sbi(dentry->d_sb);
 
-	/*
-	 * If this is an indirect mount the dentry could have gone away
-	 * as a result of an expire and a new one created.
+	/* If this is an indirect mount the dentry could have gone away
+	 * and a new one created.
+	 *
+	 * This is unusual and I can't remember the case for which it
+	 * was originally added now. But a example of how this can
+	 * happen is an autofs indirect mount that has the "browse"
+	 * option set and also has the "symlink" option in the autofs
+	 * map entry. In this case the daemon will remove the browse
+	 * directory and create a symlink as the mount (pointing to a
+	 * local path) leaving the struct path stale.
+	 *
+	 * Another not so obvious case is when a mount in an autofs
+	 * indirect mount that uses the "nobrowse" option is being
+	 * expired and the mount has been umounted but the mount point
+	 * directory remains when a stat family system call is made.
+	 * In this case the mount point is removed (by the daemon) and
+	 * a new mount triggered leading to a stale dentry in the struct
+	 * path of the waiting process.
 	 */
 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
 		struct dentry *parent = dentry->d_parent;

