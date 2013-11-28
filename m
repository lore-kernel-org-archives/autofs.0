From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix symlinks aren't checked for expiry
Date: Thu, 28 Nov 2013 16:38:13 +0800
Message-ID: <20131128083812.15855.54556.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=LbkC3DHTdZw+DtqAO5iinmF
	Wgds=; b=C25sIO9AmTlJZ1PKnyJ7+7csgDvbHalHGVObsOaoBmISgV+HU0haxOX
	H/dTS5ep4iuNA3IqjHH2+iH56AyrcY8KlwNFZ4nS/5fmkWPubr/oYA2apy3quLH4
	6f8W2eF1Z7DSfFVXD1ahAgNiM2tU9o3o22a7C8LcZFSaWaDuWlQ0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=LbkC3DHTdZw+DtqAO5iinmFWgds=; b=NGeJjCGp9Ho3mTxCphvlPJcvsr0Z
	Z2P/ynAMxL4jZL8imp4XPyYZBiISJFJ87wmqjQvv3iRArVf+6vEqCzueADHkGFXq
	FjyhoG3O0zvAXcfXMiIcUwEVPX8vmWiU5jHnMPQ4rwnFdW7Nzbiy+3xFYl10uFdG
	osyeWL8U65A638I=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>

From: Ian Kent <ikent@redhat.com>

The autofs4 module doesn't consider symlinks for expire.

The user space daemon has focused on the use of bind mounts
instead of symlinks for a long time now. But, with the
future addition of amd map parsing in automount(8), not
to mention amd iteslf, symlink expiry is needed.

The direct and offset mount types can't be symlinks and
the tree mounts of version 4 were always real mounts so
only indirect mounts need expire symlinks.

Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/expire.c  |   12 ++++++++++++
 fs/autofs4/symlink.c |    3 +++
 2 files changed, 15 insertions(+)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 3d9d3f5..ce7df7c 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -402,6 +402,18 @@ struct dentry *autofs4_expire_indirect(struct super_block *sb,
 			goto next;
 		}
 
+		if (dentry->d_inode && S_ISLNK(dentry->d_inode->i_mode)) {
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
index f27c094..061a692 100644
--- a/fs/autofs4/symlink.c
+++ b/fs/autofs4/symlink.c
@@ -14,6 +14,9 @@
 
 static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	struct autofs_info *ino = autofs4_dentry_ino(dentry);
+	if (ino)
+		ino->last_used = jiffies;
 	nd_set_link(nd, dentry->d_inode->i_private);
 	return NULL;
 }

