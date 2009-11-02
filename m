From: Jan Blunck <jblunck@suse.de>
Subject: [PATCH 10/27] BKL: Remove BKL from autofs4
Date: Mon,  2 Nov 2009 11:04:50 +0100
Message-ID: <1257156307-24175-11-git-send-email-jblunck@suse.de>
References: <1257156307-24175-1-git-send-email-jblunck@suse.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754644AbZKBKHc@vger.kernel.org>
In-Reply-To: <1257156307-24175-1-git-send-email-jblunck@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel@vger.kernel.org
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, Jan Blunck <jblunck@suse.de>, Ian Kent <raven@themaw.net>, James Morris <jmorris@namei.org>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Moyer <jmoyer@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, autofs@linux.kernel.org

BKL is only used in fill_super. It is safe to remove it.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 fs/autofs4/inode.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 3adaba9..69c8142 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -323,8 +323,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 
-	lock_kernel();
-
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
 		goto fail_unlock;
@@ -420,7 +418,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	 * Success! Install the root dentry now to indicate completion.
 	 */
 	s->s_root = root;
-	unlock_kernel();
 	return 0;
 	
 	/*
@@ -442,7 +439,6 @@ fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;
 fail_unlock:
-	unlock_kernel();
 	return -EINVAL;
 }
 
-- 
1.6.4.2
