From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - use seq_puts() for simple strings in
 autofs_show_options()
Date: Thu, 31 Jan 2019 07:15:26 +0800
Message-ID: <154889012613.4863.12231175554744203482.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Fix checkpatch.sh WARNING about the use of seq_printf() to print simple
strings in autofs_show_options(), use seq_puts() in this case.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 8647ecaa89fc..80597b88718b 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -82,20 +82,20 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",maxproto=%d", sbi->max_proto);
 
 	if (autofs_type_offset(sbi->type))
-		seq_printf(m, ",offset");
+		seq_puts(m, ",offset");
 	else if (autofs_type_direct(sbi->type))
-		seq_printf(m, ",direct");
+		seq_puts(m, ",direct");
 	else
-		seq_printf(m, ",indirect");
+		seq_puts(m, ",indirect");
 	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
-		seq_printf(m, ",strictexpire");
+		seq_puts(m, ",strictexpire");
 	if (sbi->flags & AUTOFS_SBI_IGNORE)
-		seq_printf(m, ",ignore");
+		seq_puts(m, ",ignore");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
 	else
-		seq_printf(m, ",pipe_ino=-1");
+		seq_puts(m, ",pipe_ino=-1");
 #endif
 	return 0;
 }

