From: David Howells <dhowells@redhat.com>
Subject: [PATCH] VFS: Fix automount for negative autofs dentries
Date: Mon, 11 Jul 2011 14:20:57 +0100
Message-ID: <20110711132057.14641.36229.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: viro@ZenIV.linux.org.uk
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>

Autofs may set the DCACHE_NEED_AUTOMOUNT flag on negative dentries.  These
need attention from the automounter daemon regardless of the LOOKUP_FOLLOW flag.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 fs/namei.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0223c41..93e221e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -777,18 +777,29 @@ static int follow_automount(struct path *path, unsigned flags,
 	if ((flags & LOOKUP_NO_AUTOMOUNT) && !(flags & LOOKUP_CONTINUE))
 		return -EISDIR; /* we actually want to stop here */
 
-	/* We want to mount if someone is trying to open/create a file of any
-	 * type under the mountpoint, wants to traverse through the mountpoint
-	 * or wants to open the mounted directory.
-	 *
-	 * We don't want to mount if someone's just doing a stat and they've
+	/* We don't want to mount if someone's just doing a stat and they've
 	 * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
 	 * appended a '/' to the name.
 	 */
-	if (!(flags & LOOKUP_FOLLOW) &&
-	    !(flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
-		       LOOKUP_OPEN | LOOKUP_CREATE)))
+	if (!(flags & LOOKUP_FOLLOW)) {
+		/* We do, however, want to mount if someone wants to open or
+		 * create a file of any type under the mountpoint, wants to
+		 * traverse through the mountpoint or wants to open the mounted
+		 * directory.
+		 */
+		if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
+			     LOOKUP_OPEN | LOOKUP_CREATE))
+			goto need_automount;
+
+		/* Also, autofs may mark negative dentries as being automount
+		 * points.  These will need the attentions of the daemon to
+		 * instantiate them before they can be used.
+		 */
+		if (!path->dentry->d_inode)
+			goto need_automount;
 		return -EISDIR;
+	}
+need_automount:
 
 	current->total_link_count++;
 	if (current->total_link_count >= 40)

