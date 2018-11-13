From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/6] autofs - fix possible inode leak in autofs_fill_super()
Date: Tue, 13 Nov 2018 09:36:05 +0800
Message-ID: <154207296462.11064.11496013579571371405.stgit@pluto-themaw-net>
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

There is no check at all for a failure to allocate the root inode
in autofs_fill_super(), handle it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 846c052569dd..e5c06b5a7371 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -254,9 +254,13 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_free;
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	if (!root_inode) {
+		ret = -ENOMEM;
+		goto fail_ino;
+	}
 	root = d_make_root(root_inode);
 	if (!root)
-		goto fail_ino;
+		goto fail_iput;
 	pipe = NULL;
 
 	root->d_fsdata = ino;
@@ -304,8 +308,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_op = &autofs_dir_inode_operations;
 
 	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(pipefd);
 
+	pipe = fget(pipefd);
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
 		goto fail_put_pid;
@@ -334,6 +338,8 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 fail_dput:
 	dput(root);
 	goto fail_free;
+fail_iput:
+	iput(root_inode);
 fail_ino:
 	autofs_free_ino(ino);
 fail_free:

