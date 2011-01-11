From: David Howells <dhowells@redhat.com>
Subject: [PATCH 14/18] autofs4: Clean up autofs4_free_ino()
Date: Tue, 11 Jan 2011 17:49:24 +0000
Message-ID: <20110111174924.2291.44496.stgit@warthog.procyon.org.uk>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net
Cc: dhowells@redhat.com, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

When this function is called the local reference count does't need to
be updated since the dentry is going away and dput definitely must
not be called here.

Also the autofs info struct field inode isn't used so remove it.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/autofs4/inode.c |   13 -------------
 fs/autofs4/root.c  |    9 ---------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 427c357..3ecd2e2 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -45,7 +45,6 @@ struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
 
 	if (!reinit) {
 		ino->flags = 0;
-		ino->inode = NULL;
 		ino->dentry = NULL;
 		ino->size = 0;
 		INIT_LIST_HEAD(&ino->active);
@@ -76,19 +75,8 @@ struct autofs_info *autofs4_init_ino(struct autofs_info *ino,
 
 void autofs4_free_ino(struct autofs_info *ino)
 {
-	struct autofs_info *p_ino;
-
 	if (ino->dentry) {
 		ino->dentry->d_fsdata = NULL;
-		if (ino->dentry->d_inode) {
-			struct dentry *parent = ino->dentry->d_parent;
-			if (atomic_dec_and_test(&ino->count)) {
-				p_ino = autofs4_dentry_ino(parent);
-				if (p_ino && parent != ino->dentry)
-					atomic_dec(&p_ino->count);
-			}
-			dput(ino->dentry);
-		}
 		ino->dentry = NULL;
 	}
 	if (ino->free)
@@ -390,7 +378,6 @@ struct inode *autofs4_get_inode(struct super_block *sb,
 	if (inode == NULL)
 		return NULL;
 
-	inf->inode = inode;
 	inode->i_mode = inf->mode;
 	if (sb->s_root) {
 		inode->i_uid = sb->s_root->d_inode->i_uid;
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index b3ab9e9..51a4c2a 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -151,11 +151,8 @@ void autofs4_dentry_release(struct dentry *de)
 	DPRINTK("releasing %p", de);
 
 	inf = autofs4_dentry_ino(de);
-	de->d_fsdata = NULL;
-
 	if (inf) {
 		struct autofs_sb_info *sbi = autofs4_sbi(de->d_sb);
-
 		if (sbi) {
 			spin_lock(&sbi->lookup_lock);
 			if (!list_empty(&inf->active))
@@ -164,10 +161,6 @@ void autofs4_dentry_release(struct dentry *de)
 				list_del(&inf->expiring);
 			spin_unlock(&sbi->lookup_lock);
 		}
-
-		inf->dentry = NULL;
-		inf->inode = NULL;
-
 		autofs4_free_ino(inf);
 	}
 }
@@ -588,7 +581,6 @@ static int autofs4_dir_symlink(struct inode *dir,
 	p_ino = autofs4_dentry_ino(dentry->d_parent);
 	if (p_ino && dentry->d_parent != dentry)
 		atomic_inc(&p_ino->count);
-	ino->inode = inode;
 
 	ino->u.symlink = cp;
 	dir->i_mtime = CURRENT_TIME;
@@ -718,7 +710,6 @@ static int autofs4_dir_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 	p_ino = autofs4_dentry_ino(dentry->d_parent);
 	if (p_ino && dentry->d_parent != dentry)
 		atomic_inc(&p_ino->count);
-	ino->inode = inode;
 	inc_nlink(dir);
 	dir->i_mtime = CURRENT_TIME;
 

