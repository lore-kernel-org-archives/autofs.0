From: Ian Kent <raven@themaw.net>
Subject: [PATCH v2 3/4] vfs: check for autofs expiring dentry in
 follow_automount()
Date: Tue, 31 Mar 2020 08:54:26 +0800
Message-ID: <158561606601.23197.9330916868830786372.stgit@mickey.themaw.net>
References: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

follow_automount() checks if a stat family system call path walk is
being done on a positive dentry and and returns -EISDIR to indicate
the dentry should be used as is without attempting an automount.

But if autofs is expiring the dentry at the time it should be
remounted following the expire.

There are two cases, in the case of a "nobrowse" indirect autofs
mount it would have been mounted on lookup anyway. In the case of
a "browse" indirect or direct autofs mount re-mounting it will
maintain the mount which is what user space would be expected.

This will defer expiration of the mount which might lead to mounts
unexpectedly remaining mounted under heavy stat activity but there's
no other choice in order to maintain consistency for user space.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   10 +++++++++-
 fs/namei.c       |   13 +++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index a1c9c32e104f..b3f748e4df08 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -406,9 +406,17 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 
 	/* Check for (possible) pending expire */
 	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
+		/* dentry possibly going to be picked for expire,
+		 * proceed to ref-walk mode.
+		 */
 		if (rcu_walk)
 			return -ECHILD;
-		return 0;
+
+		/* ref-walk mode, return 1 so follow_automount()
+		 * can wait on the expire outcome and possibly
+		 * attempt a re-mount.
+		 */
+		return 1;
 	}
 
 	/*
diff --git a/fs/namei.c b/fs/namei.c
index db6565c99825..a9c909251b2c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1227,11 +1227,20 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 	 * mounted directory.  Also, autofs may mark negative dentries
 	 * as being automount points.  These will need the attentions
 	 * of the daemon to instantiate them before they can be used.
+	 *
+	 * Also if ->d_manage() returns 1 the dentry transit needs
+	 * to be managed. For autofs, a return of 1 it tells us the
+	 * dentry might be expired, so proceed to ->d_automount().
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
 			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
-	    path->dentry->d_inode)
-		return -EISDIR;
+	    path->dentry->d_inode) {
+		if (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) {
+			if (!path->dentry->d_op->d_manage(path, false))
+				return -EISDIR;
+		} else
+			return -EISDIR;
+	}
 
 	nd->total_link_count++;
 	if (nd->total_link_count >= 40)

