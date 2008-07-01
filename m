From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/5] autofs4 - fix symlink name allocation
Date: Tue, 01 Jul 2008 17:25:50 +0800
Message-ID: <20080701092548.12041.69868.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The length of the symlink name has been moved but it needs to be
set before allocating space for it in the dentry info struct.
This corrects a mistake in a recent patch.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/root.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 7f3ebf1..10add99 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -774,6 +774,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 		list_del_init(&ino->active);
 	spin_unlock(&sbi->lookup_lock);
 
+	ino->size = strlen(symname);
 	cp = kmalloc(ino->size + 1, GFP_KERNEL);
 	if (!cp) {
 		if (!dentry->d_fsdata)
@@ -805,7 +806,6 @@ static int autofs4_dir_symlink(struct inode *dir,
 		atomic_inc(&p_ino->count);
 	ino->inode = inode;
 
-	ino->size = strlen(symname);
 	ino->u.symlink = cp;
 	dir->i_mtime = CURRENT_TIME;
 
