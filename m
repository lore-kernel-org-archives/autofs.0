From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs: revert take more care to not update last_used
 on path walk
Date: Mon, 27 Nov 2017 09:48:14 +0800
Message-ID: <151174729420.6162.1832622523537052460.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, NeilBrown <neilb@suse.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>

While the patch of commit 092a53452b helped (partially) resolve a
problem where automounts were not expiring due to aggressive accesses
from user space it has a side effect for very large environments.

This change helps with the expire problem by making the expire more
aggressive but, for very large environments, that means more mount
requests from clients. When there are a lot of clients that can mean
fairly significant server load increases.

It turns out I put the last_used in this position to solve this
very problem and failed to update my own thinking of the autofs
expire policy. So the patch being reverted introduces a regression
which should be fixed.

Reverts: 092a53452b

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Neil Brown <neilb@suse.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
---
 fs/autofs4/root.c |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index d79ced925861..82e8f6edfb48 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -281,8 +281,8 @@ static int autofs4_mount_wait(const struct path *path, bool rcu_walk)
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
 		status = autofs4_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
-		ino->last_used = jiffies;
 	}
+	ino->last_used = jiffies;
 	return status;
 }
 
@@ -321,21 +321,16 @@ static struct dentry *autofs4_mountpoint_changed(struct path *path)
 	 */
 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
 		struct dentry *parent = dentry->d_parent;
+		struct autofs_info *ino;
 		struct dentry *new;
 
 		new = d_lookup(parent, &dentry->d_name);
 		if (!new)
 			return NULL;
-		if (new == dentry)
-			dput(new);
-		else {
-			struct autofs_info *ino;
-
-			ino = autofs4_dentry_ino(new);
-			ino->last_used = jiffies;
-			dput(path->dentry);
-			path->dentry = new;
-		}
+		ino = autofs4_dentry_ino(new);
+		ino->last_used = jiffies;
+		dput(path->dentry);
+		path->dentry = new;
 	}
 	return path->dentry;
 }

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
