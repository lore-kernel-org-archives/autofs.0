From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/18] Remove the automount through follow_link() kludge code
 from pathwalk
Date: Tue, 11 Jan 2011 17:48:36 +0000
Message-ID: <20110111174836.2291.83341.stgit@warthog.procyon.org.uk>
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

Remove the automount through follow_link() kludge code from pathwalk in favour
of using d_automount().

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>
---

 fs/namei.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 159da29..dfafb97 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1193,17 +1193,6 @@ fail:
 }
 
 /*
- * This is a temporary kludge to deal with "automount" symlinks; proper
- * solution is to trigger them on follow_mount(), so that do_lookup()
- * would DTRT.  To be killed before 2.6.34-final.
- */
-static inline int follow_on_final(struct inode *inode, unsigned lookup_flags)
-{
-	return inode && unlikely(inode->i_op->follow_link) &&
-		((lookup_flags & LOOKUP_FOLLOW) || S_ISDIR(inode->i_mode));
-}
-
-/*
  * Name resolution.
  * This is the basic name resolution function, turning a pathname into
  * the final dentry. We expect 'base' to be positive and a directory.
@@ -1341,7 +1330,8 @@ last_component:
 		err = do_lookup(nd, &this, &next, &inode);
 		if (err)
 			break;
-		if (follow_on_final(inode, lookup_flags)) {
+		if (inode && unlikely(inode->i_op->follow_link) &&
+		    (lookup_flags & LOOKUP_FOLLOW)) {
 			if (nameidata_dentry_drop_rcu_maybe(nd, next.dentry))
 				return -ECHILD;
 			BUG_ON(inode != next.dentry->d_inode);
@@ -2390,8 +2380,7 @@ reval:
 		struct path holder;
 		void *cookie;
 		error = -ELOOP;
-		/* S_ISDIR part is a temporary automount kludge */
-		if (!(nd.flags & LOOKUP_FOLLOW) && !S_ISDIR(nd.inode->i_mode))
+		if (!(nd.flags & LOOKUP_FOLLOW))
 			goto exit_dput;
 		if (count++ == 32)
 			goto exit_dput;

