From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link() [ver #4]
Date: Sun, 16 Jan 2011 00:09:47 +0000
Message-ID: <20110116000947.GO19804@ZenIV.linux.org.uk>
References: <20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
 <20110113215405.19406.73651.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110113215405.19406.73651.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2011 at 09:54:05PM +0000, David Howells wrote:
> @@ -1038,12 +1147,14 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,

> -		__follow_mount_rcu(nd, path, inode);
> +		if (unlikely(!__follow_mount_rcu(nd, path, inode, false)) &&
> +		    nameidata_drop_rcu(nd))
> +			return -ECHILD;

Gotcha.  That's what'd been causing fun with autofs.  Look: we run into
automount.  __follow_mount_rcu() fails.  nd->path *AND* path contain
vfsmounts/dentries we hadn't grabbed references to.  nameidata_drop_rcu()
brings nd->path to normal.  Good for it, but path is *still* not grabbed.
And LOOKUP_RCU is gone, so when the caller feeds it to path_to_nameidata()
the fun things start happening.  We drop nd->dentry, for starters.  And
replace it with ungrabbed dentry we just got from dcache.  Better yet,
if automount dentry had been sitting on top of mountpoint (e.g. it was
a direct autofs mountpoint), we'll drop nd->mnt and replace it with
vfsmount we hadn't grabbed.  Then we'll proceed to treat both as if they'd
been grabbed, eventually doing path_put() on the suckers.

vfsmount will stay around, since it's mounted and thus mntput() optimizations
will assume we are not dropping the last reference and not free the sucker.
dentry, OTOH, will be freed after a few time through that.  At which point
it gets reused and we are left with complete crap.  E.g. with vfsmount
mounted on that mountpoint, its ->mnt_root pointing to dentry from completely
unrelated fs.  Keep walking into that and you'll get _that_ dentry freed
under whoever might be using it, etc.

Fix is trivial: if __follow_mount_rcu() succeeds (the normal case) just
return 0.  Otherwise, try nameidata_drop_rcu(); if it fails, we bugger off.
So far it's equivalent to your variant, but if nameidata_drop_rcu() succeeds,
we fall through to non-RCU case instead of just returning 0.

I've dropped the following into for-next; autofs seems to be working fine
with it.  I'll fold that into your first patch in #untested.

AFS issue is completely separate story; that one is mine and it's old.
Just that now it became more visible; earlier it only messed the expiry
logics (by screwing ->mnt_ghosts accounting).  I've a half-finished fix
for that, but it needs more beating (and will be stable@ fodder, BTW).
Later...

commit c737c31d6f1ba4eb3f1aec523741ed49d5f6a22a
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Jan 15 18:10:31 2011 -0500

    [foldme] fix do_lookup() handling of automount in RCU case
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namei.c b/fs/namei.c
index 9367fea..8f7b41a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1277,24 +1277,25 @@ static int do_lookup(struct nameidata *nd, struct qstr *name,
 done2:
 		path->mnt = mnt;
 		path->dentry = dentry;
-		if (unlikely(!__follow_mount_rcu(nd, path, inode, false)) &&
-		    nameidata_drop_rcu(nd))
+		if (likely(__follow_mount_rcu(nd, path, inode, false)))
+			return 0;
+		if (nameidata_drop_rcu(nd))
 			return -ECHILD;
-	} else {
-		dentry = __d_lookup(parent, name);
-		if (!dentry)
-			goto need_lookup;
+		/* fallthru */
+	}
+	dentry = __d_lookup(parent, name);
+	if (!dentry)
+		goto need_lookup;
 found:
-		if (dentry->d_flags & DCACHE_OP_REVALIDATE)
-			goto need_revalidate;
+	if (dentry->d_flags & DCACHE_OP_REVALIDATE)
+		goto need_revalidate;
 done:
-		path->mnt = mnt;
-		path->dentry = dentry;
-		err = follow_managed(path, nd->flags);
-		if (unlikely(err < 0))
-			return err;
-		*inode = path->dentry->d_inode;
-	}
+	path->mnt = mnt;
+	path->dentry = dentry;
+	err = follow_managed(path, nd->flags);
+	if (unlikely(err < 0))
+		return err;
+	*inode = path->dentry->d_inode;
 	return 0;
 
 need_lookup:
