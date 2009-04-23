From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix incorect return in autofs4_mount_busy()
Date: Thu, 23 Apr 2009 15:34:52 +0800
Message-ID: <20090423073452.24530.8621.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, rhkernel-list@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>

This patch addresses bug 496766.

Fix an obvious incorect return status in autofs4_mount_busy().
---

 fs/autofs4/expire.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 75f7dda..3077d8f 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -70,8 +70,10 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 		 * Otherwise it's an offset mount and we need to check
 		 * if we can umount its mount, if there is one.
 		 */
-		if (!d_mountpoint(dentry))
+		if (!d_mountpoint(dentry)) {
+			status = 0;
 			goto done;
+		}
 	}
 
 	/* Update the expiry counter if fs is busy */

