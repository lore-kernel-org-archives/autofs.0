From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs: revert fix AT_NO_AUTOMOUNT not being honored
Date: Mon, 27 Nov 2017 09:48:21 +0800
Message-ID: <151174730120.6162.3848002191530283984.stgit@pluto.themaw.net>
References: <151174729420.6162.1832622523537052460.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151174729420.6162.1832622523537052460.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, NeilBrown <neilb@suse.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>

Commit 42f4614821 allowed the fstatat(2) system call to properly honor
the AT_NO_AUTOMOUNT flag but introduced a semantic change.

In order to honor AT_NO_AUTOMOUNT a semantic change was made to the
negative dentry case for stat family system calls in follow_automount().

This changed the unconditional triggering of an automount in this case
to no longer be done and an error returned instead.

This has caused more problems than I expected so reverting the change
is needed.

In a discussion with Neil Brown it was concluded that the automount(8)
daemon can implement this change without kernel modifications. So that
will be done instead and the autofs module documentation updated with
a description of the problem and what needs to be done by module users
for this specific case.

Reverts: 42f4614821

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Neil Brown <neilb@suse.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
---
 fs/namei.c         |   15 +++------------
 include/linux/fs.h |    3 ++-
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f0c7a7b9b6ca..9cc91fb7f156 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1129,18 +1129,9 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 	 * of the daemon to instantiate them before they can be used.
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
-			   LOOKUP_OPEN | LOOKUP_CREATE |
-			   LOOKUP_AUTOMOUNT))) {
-		/* Positive dentry that isn't meant to trigger an
-		 * automount, EISDIR will allow it to be used,
-		 * otherwise there's no mount here "now" so return
-		 * ENOENT.
-		 */
-		if (path->dentry->d_inode)
-			return -EISDIR;
-		else
-			return -ENOENT;
-	}
+			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
+	    path->dentry->d_inode)
+		return -EISDIR;
 
 	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
 		return -EACCES;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2995a271ec46..9c4a43e391ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3088,7 +3088,8 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 static inline int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
+	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
+			 stat, STATX_BASIC_STATS);
 }
 static inline int vfs_fstat(int fd, struct kstat *stat)
 {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
