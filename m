From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH v2] autofs: Add WARN_ON(1) for non dir/link inode case
Date: Mon,  4 Jul 2016 12:40:03 +0900
Message-ID: <1467603603-1530-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ItbC9gbgF3mOWygXIiemdBgWoOAZNfPigDfad0sqIpU=;
        b=nQlJpD/xpY0nBzTMp0Chwuw1NvrPZRMdtoEgzmraUBiDXUzVMaNXg+arPUNXZxsZ2d
         4dymIGbs94QdEI0PZJ3FERN/Zh/2QymJRQp2ohOEZT4qnAUSiXwNeJIs5R0y/1qTueqD
         7HZARjBRq1vxuaWK1Ce0kQWT4Kj/x5aY1edvPL9vMVpbLulZYwfSJ5pEeNwwAs2h2m1d
         aHz/3ctQvETL89dZ0BXD82BUg5D5/J8ReYOoCwJqK307m99GHC8sOYId60Yh5RH4XabI
         nq7vAKOcIurD1OhrP9AZAxqfbhg1UPjZ9mxnxka5rYvhqJmSsRvQGI0zpyNLG95uVueO
         dQlA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, jeffm@suse.com
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

It's invalid if the given mode is neither dir nor link,
so warn on else case.

(v2 changed BUG_ON to WARN_ON)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index ad0ee93..89174ec 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -305,6 +305,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
 
+	WARN_ON(!root_inode->i_fop || !root_inode->i_op);
 	root_inode->i_fop = &autofs4_root_operations;
 	root_inode->i_op = &autofs4_dir_inode_operations;
 
@@ -368,7 +369,8 @@ struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &autofs4_symlink_inode_operations;
-	}
+	} else
+		WARN_ON(1);
 
 	return inode;
 }
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
