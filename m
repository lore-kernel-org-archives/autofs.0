From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix direct mount pending expire race - correction
Date: Fri, 18 Jul 2008 11:14:54 +0800
Message-ID: <20080718031453.12148.79135.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Appologies, somehow I seem to have sent an out dated version of this
patch. Here is an additional patch that brings the patch up to date.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/root.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index b1536c1..7a7ed94 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -190,13 +190,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 			/* Follow down to our covering mount. */
 			if (!follow_down(&nd->path.mnt, &nd->path.dentry))
 				goto done;
-			/*
-			 * We shouldn't need to do this but we have no way
-			 * of knowing what may have been done so try a follow
-			 * just in case.
-			 */
-			autofs4_follow_mount(&nd->path.mnt, &nd->path.dentry);
-			goto done;
+			goto follow;
 		}
 		spin_unlock(&sbi->fs_lock);
 		goto done;
@@ -208,7 +202,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 	/* We trigger a mount for almost all flags */
 	lookup_type = nd->flags & (TRIGGER_FLAGS | TRIGGER_INTENTS);
 	if (!(lookup_type || dentry->d_flags & DCACHE_AUTOFS_PENDING))
-		goto done;
+		goto follow;
 
 	/*
 	 * If the dentry contains directories then it is an autofs
