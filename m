From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - detect invalid direct mount requests
Date: Fri, 20 Jun 2008 13:13:03 +0800
Message-ID: <20080620051301.9988.94307.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

autofs v5 dierct and offset mounts within an autofs filesystem are
triggered by existing autofs triger mounts so the mount point dentry
must be positive. If the mount point dentry is negative then the
trigger doesn't exist so we can return fail immediately.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/waitq.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index cd21fd4..ae637d9 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -307,6 +307,10 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 	if (sbi->catatonic)
 		return -ENOENT;
 
+	if (!dentry->d_inode &&
+	    (sbi->type & (AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET)))
+		return -ENOENT;
+
 	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
