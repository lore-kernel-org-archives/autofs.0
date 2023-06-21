From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 13/79] autofs: switch to new ctime accessors
Date: Wed, 21 Jun 2023 10:45:26 -0400
Message-ID: <20230621144735.55953-12-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687358877;
        bh=1s5jb03ngCAy3P6/5pQ4jEHKe8Ls9LBYi2bivIIThCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfjrU8aKKDtyx20ZuKC+t4c8fe7fTPTGpgT2TMwrgAznX9O0Qr+kcfBOrI7+0KfRc
         G2GNJaecNaF5zwGYdc4z323q6bxyAiSuTX8JlpTGUX0vI0Z5TbkAq1Vdr4jnPcshyG
         lpkZPYO5cTGuMrpVO7/0bIh3x/+4zvvLmz/hjvjd2TJESG33nAkUA504I4xGy8GRVa
         gMgFLAVJeYKLIIv3hptk1Bs2I1a7B/W4+TxcDij+HIqqdhtFJHQJjsI6htekFlDyu6
         jo/OUqSMMZiEN9Gr0k8YbMC/+sAf209oCz62i1DbGvF6KI1HfdcJLOweQNtZ9U4S+v
         8/bnAVTJpkx2w==
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/autofs/inode.c | 2 +-
 fs/autofs/root.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index affa70360b1f..47e3054b29dc 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -370,7 +370,7 @@ struct inode *autofs_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_uid = d_inode(sb->s_root)->i_uid;
 		inode->i_gid = d_inode(sb->s_root)->i_gid;
 	}
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_ctime_set_current(inode);
 	inode->i_ino = get_next_ino();
 
 	if (S_ISDIR(mode)) {
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 93046c9dc461..4c0fc0f8d688 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -600,7 +600,7 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 
 	return 0;
 }
@@ -633,7 +633,7 @@ static int autofs_dir_unlink(struct inode *dir, struct dentry *dentry)
 	d_inode(dentry)->i_size = 0;
 	clear_nlink(d_inode(dentry));
 
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs_add_expiring(dentry);
@@ -749,7 +749,7 @@ static int autofs_dir_mkdir(struct mnt_idmap *idmap,
 	p_ino = autofs_dentry_ino(dentry->d_parent);
 	p_ino->count++;
 	inc_nlink(dir);
-	dir->i_mtime = dir->i_ctime = current_time(dir);
+	dir->i_mtime = inode_ctime_set_current(dir);
 
 	return 0;
 }
-- 
2.41.0

