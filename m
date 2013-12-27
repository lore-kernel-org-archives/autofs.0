From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix symlinks aren't checked for expiry
Date: Fri, 27 Dec 2013 12:32:16 +0800
Message-ID: <20131227043216.3519.3477.stgit@perseus.fritz.box>
References: <20131227042828.3519.11223.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=y10wq/s4/MPyKtXchniwC147UbQ=; b=XXWrjhX5xddOQmUB9o+hT8GrhbmY
	e8Ek6KsgqkRYl6/yrkQ0MOME8CgJ89zn6FR9qdZPA/Zc5uRQ2ruWrFJDynPNW/jc
	yPhsPfRfK8KpxBzF8z6XawaG9U46doO4nk2FN0k6uBad8IpK38aimGE2pxF7VdWB
	g8vLJmlV6xPqXCo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=y10wq/s4/MPyKtXchniwC1
	47UbQ=; b=r9cS5te4054WrDvEIM2b7P46NK1lsChedTjZeA6A0/XfuPoqmaA0Nz
	GihQYOVwT1CywyfhcNd34N6WFXOa5pknePhe44PTlYvq5u45CVN8/z/MRqhKy5Ee
	qSSbFYjY0Yi7ZIuIElOI86s+x+Kr2PO0H3t1LQK9vb4DVvbUfXgpA=
In-Reply-To: <20131227042828.3519.11223.stgit@perseus.fritz.box>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Ian Kent <ikent@redhat.com>

The autofs4 module doesn't consider symlinks for expire as it did
in the older autofs v3 module (so it's actually a long stnding
regression).

The user space daemon has focused on the use of bind mounts instead
of symlinks for a long time now and that's why this has not been
noticed. But with the future addition of amd map parsing to
automount(8), not to mention amd itself (of am-utils), symlink
expiry will be needed.

The direct and offset mount types can't be symlinks and the tree
mounts of version 4 were always real mounts so only indirect
mounts need expire symlinks.

Since the current users of the autofs4 module haven't reproted
this as a problem to date this patch probably isn't a candidate
for backport to stable.

Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/expire.c  |   14 ++++++++++++++
 fs/autofs4/symlink.c |    4 ++++
 2 files changed, 18 insertions(+)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 3d9d3f5..394e90b 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -402,6 +402,20 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 			goto next;
 		}
 
+		if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
+			DPRINTK("checking symlink %p %.*s",
+				dentry, (int)dentry->d_name.len, dentry->d_name.name);
+			/*
+			 * A symlink can't be "busy" in the usual sense so
+			 * just check last used for expire timeout.
+			 */
+			if (autofs4_can_expire(dentry, timeout, do_now)) {
+				expired = dentry;
+				goto found;
+			}
+			goto next;
+		}
+
 		if (simple_empty(dentry))
 			goto next;
 
diff --git a/fs/autofs4/symlink.c b/fs/autofs4/symlink.c
index f27c094..1e8ea19 100644
--- a/fs/autofs4/symlink.c
+++ b/fs/autofs4/symlink.c
@@ -14,6 +14,10 @@
 
 static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	if (ino && !autofs4_oz_mode(sbi))
+		ino->last_used = jiffies;
 	nd_set_link(nd, dentry->d_inode->i_private);
 	return NULL;
 }

