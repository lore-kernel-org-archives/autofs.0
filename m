From: Ian Kent <raven@themaw.net>
Subject: [PATCH 7/7] autofs - take more care to not update last_used on path
 walk
Date: Mon, 30 Jan 2017 18:21:11 +0800
Message-ID: <148577167169.9801.1377050092212016834.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=6UTtRq3NE2OxuMo
        EGJSjy8HA0tk=; b=SE9my/XouOA4Y0fH1oQJ5CsyJrfxCT5GhGxo10qCDNQebx9
        R1SxYFkrWVLu0uPvbAbuMoiVJkj4xgIsbgxCdy0C6EsEwneEloDAaEDU4ZAHgv7g
        jBqtUyPITR+s2hNOuxtUtQEMwg/1tAkZv/f6sNAVljARX6qv3TLFum+GdoUU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=6UTtRq3NE2OxuMoEGJSjy8HA0tk=; b=MIVHCzC5Oj5D0BtnOtN3
        88ZyichYoTsQTrnJyrlm0SheRQoZ2JWOzvMv8FXfXVRNGLc5ln5MdtQqOhpVz4Xe
        PQ2KiUiNSP1IrTO0bigsXVB55EI/1l8mYm2Me5gsUrxb05rCY2p2er3F1kdx5Lgo
        8xrNi3p7Z04nFsPUmclX8Sg=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

GUI environments seem to be becoming more agressive at scanning
filesystems, to the point where autofs cannot expire mounts at
all.

This is one key reason the update of the autofs dentry info
last_used field is done in the expire system when the dentry
is seen to be in use.

But somewhere along the way instances of the update has crept
back into the autofs path walk functions which, with the more
aggressive file access patterns, is preventing expiration.

Changing the update in the path walk functions allows autofs
to at least make progress in spite of frequent immediate
re-mounts from file accesses.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index a11f731..6ddd4fa 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -281,8 +281,8 @@ static int autofs4_mount_wait(struct dentry *dentry, bool rcu_walk)
 		pr_debug("waiting for mount name=%pd\n", dentry);
 		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
+		ino->last_used = jiffies;
 	}
-	ino->last_used = jiffies;
 	return status;
 }
 
@@ -319,16 +319,21 @@ static struct dentry *autofs4_mountpoint_changed(struct path *path)
 	 */
 	if (autofs_type_indirect(sbi->type) && d_unhashed(dentry)) {
 		struct dentry *parent = dentry->d_parent;
-		struct autofs_info *ino;
 		struct dentry *new;
 
 		new = d_lookup(parent, &dentry->d_name);
 		if (!new)
 			return NULL;
-		ino = autofs4_dentry_ino(new);
-		ino->last_used = jiffies;
-		dput(path->dentry);
-		path->dentry = new;
+		if (new == dentry)
+			dput(new);
+		else {
+			struct autofs_info *ino;
+
+			ino = autofs4_dentry_ino(new);
+			ino->last_used = jiffies;
+			dput(path->dentry);
+			path->dentry = new;
+		}
 	}
 	return path->dentry;
 }

