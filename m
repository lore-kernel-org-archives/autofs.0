From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Tue, 08 Aug 2017 12:26:52 +0800
Message-ID: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
of an automount by the call. But this flag is unconditionally cleared
for all stat family system calls except statx().

stat family system calls have always triggered mount requests for the
negative dentry case in follow_automount() which is intended but prevents
the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.

In order to handle the AT_NO_AUTOMOUNT for both system calls the
negative dentry case in follow_automount() needs to be changed to
return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
required flags are clear).

AFAICT this change doesn't have any noticable side effects and may,
in some use cases (although I didn't see it in testing) prevent
unnecessary callbacks to the automount daemon.

It's also possible that a stat family call has been made with a
path that is in the process of being mounted by some other process.
But stat family calls should return the automount state of the path
as it is "now" so it shouldn't wait for mount completion.

This is the same semantic as the positive dentry case already
handled.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>
Cc: Colin Walters <walters@redhat.com>
Cc: Ondrej Holy <oholy@redhat.com>
---
 fs/namei.c         |   15 ++++++++++++---
 include/linux/fs.h |    3 +--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ddb6a7c2b3d4..1180f9c58093 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1129,9 +1129,18 @@ static int follow_automount(struct path *path, struct nameidata *nd,
 	 * of the daemon to instantiate them before they can be used.
 	 */
 	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
-			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
-	    path->dentry->d_inode)
-		return -EISDIR;
+			   LOOKUP_OPEN | LOOKUP_CREATE |
+			   LOOKUP_AUTOMOUNT))) {
+		/* Positive dentry that isn't meant to trigger an
+		 * automount, EISDIR will allow it to be used,
+		 * otherwise there's no mount here "now" so return
+		 * ENOENT.
+		 */
+		if (path->dentry->d_inode)
+			return -EISDIR;
+		else
+			return -ENOENT;
+	}
 
 	if (path->dentry->d_sb->s_user_ns != &init_user_ns)
 		return -EACCES;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d21248..37c96f52e48e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3022,8 +3022,7 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 static inline int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
 {
-	return vfs_statx(dfd, filename, flags | AT_NO_AUTOMOUNT,
-			 stat, STATX_BASIC_STATS);
+	return vfs_statx(dfd, filename, flags, stat, STATX_BASIC_STATS);
 }
 static inline int vfs_fstat(int fd, struct kstat *stat)
 {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
