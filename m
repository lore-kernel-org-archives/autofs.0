From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs: Add BUG_ON(1) for non dir/link inode case
Date: Sun,  3 Jul 2016 19:29:42 +0900
Message-ID: <1467541782-1676-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QKH1bWYGNyKhgXqaUUQ3VImS+KZP+RU5r7dE/fAUKh4=;
        b=vPQCLOMjRC2Wl1gDT+5nW2zgW5tHL4E5bVHFdcF5CE8BBIHrJ3HtNCBS9ZBF5sF6mu
         QpOuxjM1cb8LEk5wpu283EP71bTOCaMooHXjegBA5q+RmluXTMU689TPwnAlOV83F8RP
         ixgt+tsy2ZFZUeLxXB1BkL0vF7HTkL34MfNpYkltErPlHo1IgKHzK4OpzBU2VZp6Z1h4
         4z/leQXLKc+ZDxt+8rUs0dmlTtdwQ74iie3DfrZWmQg0c6gGg2TFZkjdcSI9mThQNMzd
         O34B67sq0i6BDPxOKT6DdMW6HPkB88S4Wv3uV00Ki8krBPDo/yOwIkz1mgkKwTYps7fc
         Btqg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

It's invalid if the given mode is neither dir nor link,
so don't let it fallthrough on else case.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index ad0ee93..7f35c82 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
 
+	BUG_ON(!root_inode->i_fop || !root_inode->i_op);
 	root_inode->i_fop = &autofs4_root_operations;
 	root_inode->i_op = &autofs4_dir_inode_operations;
 
@@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &autofs4_symlink_inode_operations;
-	}
+	} else
+		BUG_ON(1);
 
 	return inode;
 }
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
