From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: [PATCH v2] autofs: show pipe inode in mount options
Date: Mon, 25 Jan 2016 15:29:43 +0400
Message-ID: <20160125112929.3570.41795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net
Cc: criu@openvz.org, skinsbursky@virtuozzo.com

This is required for CRIU (Checkpoint Restart In Userspace) to migrate a mount
point, when write end in user space is closed.
Below is the brief description of the problem.
To migrate non-catatonic autofs mount point, one have to restore control
pipe between kernel and and autofs master process.
One of the autofs masters is systemd, which closes pipe write end after
passing it to the kernel with mount call.
To be able to restore systemd control pipe, one have to know, which read pipe
end in systemd corresponds to the write pipe end in the kernel. Pipe "fd" in
mount options is not enough, because it was closed and probably replaced by
some other descriptor.
Thus, some other attribute is required to be able to find the read pipe end.
The best attribute, allowing to find correct pipe end is inode number, becuase
it's unique for the whole system and can't be reused until autofs mount
exists. This attribute also allows to recognize a situation with autofs mount
without master (no process with specified "pgrp" or not file descriptor with
"pipe_ino", specified in autofs mount options).

v2:
1) New option "pipe_ino" was moved to the end of the options list.
2) Option is printed only if CONFIG_CHECKPOINT_RESTORE is set.


Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
---
 fs/autofs4/inode.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index a3ae0b2..4320faa 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -94,7 +94,12 @@ static int autofs4_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",direct");
 	else
 		seq_printf(m, ",indirect");
-
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	if (sbi->pipe)
+		seq_printf(m, ",pipe_ino=%ld", sbi->pipe->f_inode->i_ino);
+	else
+		seq_printf(m, ",pipe_ino=-1");
+#endif
 	return 0;
 }
 

