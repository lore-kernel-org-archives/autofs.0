From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/6] autofs - make autofs_expire_indirect() static
Date: Tue, 19 Jun 2018 11:02:15 +0800
Message-ID: <152937733512.21213.10509996499623738446.stgit@pluto.themaw.net>
References: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

autofs_expire_indirect() isn't used outside of fs/autofs/expire.c
so make it static.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    3 ---
 fs/autofs/expire.c   |    8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 4192f8002f89..b1f70bc45ca3 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -154,9 +154,6 @@ int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 			   struct autofs_sb_info *sbi, int when);
 int autofs_expire_multi(struct super_block *, struct vfsmount *,
 			struct autofs_sb_info *, int __user *);
-struct dentry *autofs_expire_indirect(struct super_block *sb,
-				      struct vfsmount *mnt,
-				      struct autofs_sb_info *sbi, int how);
 
 /* Device node initialization */
 
diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index 64e6eba2c628..5fb47a4ca48c 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -424,10 +424,10 @@ static struct dentry *should_expire(struct dentry *dentry,
  *  - it is unused by any user process
  *  - it has been unused for exp_timeout time
  */
-struct dentry *autofs_expire_indirect(struct super_block *sb,
-				      struct vfsmount *mnt,
-				      struct autofs_sb_info *sbi,
-				      int how)
+static struct dentry *autofs_expire_indirect(struct super_block *sb,
+					     struct vfsmount *mnt,
+					     struct autofs_sb_info *sbi,
+					     int how)
 {
 	unsigned long timeout;
 	struct dentry *root = sb->s_root;

