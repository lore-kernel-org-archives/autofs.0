From: David Howells <dhowells@redhat.com>
Subject: [PATCH 18/18] Remove a further kludge from __do_follow_link()
Date: Tue, 11 Jan 2011 17:49:45 +0000
Message-ID: <20110111174945.2291.80911.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Remove a further kludge from __do_follow_link() as it's no longer retired with
the automount code.

This reverts the non-helper-function parts of
051d381259eb57d6074d02a6ba6e90e744f1a29f, which breaks union mounts.

Reported-by: vaurora@redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namei.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e2c5db2..d81c91e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -781,13 +781,8 @@ __do_follow_link(struct path *path, struct nameidata *nd, void **p)
 	touch_atime(path->mnt, dentry);
 	nd_set_link(nd, NULL);
 
-	if (path->mnt != nd->path.mnt) {
-		path_to_nameidata(path, nd);
-		nd->inode = nd->path.dentry->d_inode;
-		dget(dentry);
-	}
-	mntget(path->mnt);
-
+	if (path->mnt == nd->path.mnt)
+		mntget(path->mnt);
 	nd->last_type = LAST_BIND;
 	*p = dentry->d_inode->i_op->follow_link(dentry, nd);
 	error = PTR_ERR(*p);

