From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: [PATCH] autofs: show pipe inode in mount options
Date: Wed, 16 Dec 2015 16:02:28 +0400
Message-ID: <20151216120222.19097.54512.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: criu@openvz.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

This is required for CRIU to migrate a mount point, when write end in user
space is closed.
To be able to migrate such mount, read end of the pipe have to be searched
within autofs master process, and pipe inode will be used as a key.

Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
---
 fs/autofs4/inode.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index a3ae0b2..16f875a 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -77,6 +77,10 @@ static int autofs4_show_options(struct seq_file *m, struct dentry *root)
 		return 0;
 
 	seq_printf(m, ",fd=%d", sbi->pipefd);
+	if (sbi->pipe)
+		seq_printf(m, ",pipe_ino=%ld", sbi->pipe->f_inode->i_ino);
+	else
+		seq_printf(m, ",pipe_ino=-1");
 	if (!uid_eq(root_inode->i_uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
 			from_kuid_munged(&init_user_ns, root_inode->i_uid));
