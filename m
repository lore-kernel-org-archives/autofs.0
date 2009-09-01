From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix missed case when changing to use struct path
Date: Tue, 01 Sep 2009 11:26:22 +0800
Message-ID: <20090901032622.27252.19646.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, aaron@merfinllc.com, stefan@farestam.net

In the recent change by Al Viro that changes verious subsystems
to use "struct path" one case was missed in the autofs4 module
which causes mounts to no longer expire.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/expire.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index aa39ae8..3da18d4 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -77,7 +77,7 @@ static int autofs4_mount_busy(struct vfsmount *mnt, struct dentry *dentry)
 	}
 
 	/* Update the expiry counter if fs is busy */
-	if (!may_umount_tree(mnt)) {
+	if (!may_umount_tree(path.mnt)) {
 		struct autofs_info *ino = autofs4_dentry_ino(top);
 		ino->last_used = jiffies;
 		goto done;

