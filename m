From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix autofs_sbi() does not check super block type
Date: Mon, 20 Aug 2018 16:37:09 +0800
Message-ID: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The autofs_sbi() inline function does not check the super block
magic number to verify it has been given an autofs super block.

Reported-by: syzbot+87c3c541582e56943277@syzkaller.appspotmail.com
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    4 +++-
 fs/autofs/inode.c    |    1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 9400a9f6318a..5057b9f0f846 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/completion.h>
 #include <linux/file.h>
+#include <linux/magic.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
@@ -124,7 +125,8 @@ struct autofs_sb_info {
 
 static inline struct autofs_sb_info *autofs_sbi(struct super_block *sb)
 {
-	return (struct autofs_sb_info *)(sb->s_fs_info);
+	return sb->s_magic != AUTOFS_SUPER_MAGIC ?
+		NULL : (struct autofs_sb_info *)(sb->s_fs_info);
 }
 
 static inline struct autofs_info *autofs_dentry_ino(struct dentry *dentry)
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index b51980fc274e..846c052569dd 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -10,7 +10,6 @@
 #include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/parser.h>
-#include <linux/magic.h>
 
 #include "autofs_i.h"
 

