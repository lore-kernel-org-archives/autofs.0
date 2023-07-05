From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 26/92] autofs: convert to ctime accessor functions
Date: Wed,  5 Jul 2023 15:00:51 -0400
Message-ID: <20230705190309.579783-24-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583828;
        bh=VKXzwQVEpqzwAn2zr28fV/ocLF/ZTfcqcAZm4WHBcUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QL+9A8CRS0JtOr1uR0GOj5A9Ne5Uh2DuRDFtt6sauq4vBdl9YbFxhrOnlAvEOBmi8
         QiLozocDcw8otXcnlIOYHOY+Q3ufzOEb71eqpT+tR9UrYLp7eM8xwSYt6/7Tu+HN8f
         dg5ecqw0Ngs18gpqShHvR8YkWrsLa3mUerTocRqPs4bccL28SAzAfSwOapba/4tVPv
         BaMIrjKJslGoIksb4lLT0oTuTmSw+mhy2isJQWq9vxiDUax9xqGCaFvzOD12/VAoLf
         TaDyCtArYiYqZV47eh3z16ysFTJbNCWeGnqm2zP2SCkvIpBVNz1lwxlyO8NMMu1GPZ
         NrlJ746LIvDLw==
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, autofs@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Reviewed-by: Ian Kent <raven@themaw.net>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/autofs/inode.c | 2 +-
 fs/autofs/root.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index affa70360b1f..2b49662ed237 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_uid = d_inode(sb->s_root)->i_uid;
 		inode->i_gid = d_inode(sb->s_root)->i_gid;
 	}
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	inode->i_ino = get_next_ino();
 
 	if (S_ISDIR(mode)) {
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 93046c9dc461..512b9a26c63d 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	return 0;
 }
@@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs_add_expiring(dentry);
@@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 
 	return 0;
 }
-- 
2.41.0

