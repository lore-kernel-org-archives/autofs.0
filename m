From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/6] autofs - refactor super block info init
Date: Tue, 13 Nov 2018 09:36:12 +0800
Message-ID: <154207297202.11064.11609172823638684904.stgit@pluto-themaw-net>
References: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154207295533.11064.12485527860509413072.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Move the allocation and initialisation of the super block
info struct to its own function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e5c06b5a7371..93af0d5777ae 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -201,43 +201,49 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 	return (*pipefd < 0);
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static struct autofs_sb_info *autofs_alloc_sbi(struct super_block *s)
 {
-	struct inode *root_inode;
-	struct dentry *root;
-	struct file *pipe;
-	int pipefd;
 	struct autofs_sb_info *sbi;
-	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		return -ENOMEM;
-	pr_debug("starting up, sbi = %p\n", sbi);
+		return NULL;
 
-	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
+	sbi->sb = s;
 	sbi->pipefd = -1;
 	sbi->pipe = NULL;
 	sbi->catatonic = 1;
-	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = NULL;
-	sbi->sb = s;
-	sbi->version = 0;
-	sbi->sub_version = 0;
 	set_autofs_type_indirect(&sbi->type);
-	sbi->min_proto = 0;
-	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
 	spin_lock_init(&sbi->fs_lock);
-	sbi->queues = NULL;
 	spin_lock_init(&sbi->lookup_lock);
 	INIT_LIST_HEAD(&sbi->active_list);
 	INIT_LIST_HEAD(&sbi->expiring_list);
+
+	return sbi;
+}
+
+int autofs_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct inode *root_inode;
+	struct dentry *root;
+	struct file *pipe;
+	int pipefd;
+	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
+	int pgrp = 0;
+	bool pgrp_set = false;
+	int ret = -EINVAL;
+
+	sbi = autofs_alloc_sbi(s);
+	if (!sbi)
+		return -ENOMEM;
+
+	pr_debug("starting up, sbi = %p\n", sbi);
+
+	s->s_fs_info = sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;

