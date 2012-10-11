From: Ian Kent <ikent@redhat.com>
Subject: [PATCH] autofs4 - fix reset pending flag on mount fail
Date: Thu, 11 Oct 2012 08:00:33 +0800
Message-ID: <20121011000033.3407.91516.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

From: Ian Kent <raven@themaw.net>

In autofs4_d_automount(), if a mount fail occurs the AUTOFS_INF_PENDING
mount pending flag is not cleared.

One effect of this is when using the "browse" option, directory entry
attributes show up with all "?"s due to the incorrect callback and
subsequent failure return (when in fact no callback should be made).

Signed-off-by: Ian Kent <ikent@redhat.com>
Cc: stable@vger.kernel.org
---

 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index e7396cf..91b1165 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -392,10 +392,12 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
 		status = autofs4_mount_wait(dentry);
-		if (status)
-			return ERR_PTR(status);
 		spin_lock(&sbi->fs_lock);
 		ino->flags &= ~AUTOFS_INF_PENDING;
+		if (status) {
+			spin_unlock(&sbi->fs_lock);
+			return ERR_PTR(status);
+		}
 	}
 done:
 	if (!(ino->flags & AUTOFS_INF_EXPIRING)) {

