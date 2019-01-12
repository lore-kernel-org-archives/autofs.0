From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/3] autofs: add ignore mount option
Date: Sat, 12 Jan 2019 08:00:40 +0800
Message-ID: <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

Add an autofs file system mount option that can be used to provide
a generic indicator to applications that the mount entry should be
ignored when displaying mount information.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h         |    1 +
 fs/autofs/inode.c            |    9 ++++++++-
 include/uapi/linux/auto_fs.h |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 3e59f0ed777b..b735f2b1e462 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -105,6 +105,7 @@ struct autofs_wait_queue {
 
 #define AUTOFS_SBI_CATATONIC	0x0001
 #define AUTOFS_SBI_STRICTEXPIRE 0x0002
+#define AUTOFS_SBI_IGNORE	0x0004
 
 struct autofs_sb_info {
 	u32 magic;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 078992eee299..8647ecaa89fc 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -89,6 +89,8 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",indirect");
 	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
 		seq_printf(m, ",strictexpire");
+	if (sbi->flags & AUTOFS_SBI_IGNORE)
+		seq_printf(m, ",ignore");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
@@ -111,7 +113,8 @@ static const struct super_operations autofs_sops = {
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire};
+	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
+	Opt_ignore};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -124,6 +127,7 @@ static const match_table_t tokens = {
 	{Opt_direct, "direct"},
 	{Opt_offset, "offset"},
 	{Opt_strictexpire, "strictexpire"},
+	{Opt_ignore, "ignore"},
 	{Opt_err, NULL}
 };
 
@@ -206,6 +210,9 @@ static int parse_options(char *options,
 		case Opt_strictexpire:
 			sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
 			break;
+		case Opt_ignore:
+			sbi->flags |= AUTOFS_SBI_IGNORE;
+			break;
 		default:
 			return 1;
 		}
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 082119630b49..1f7925afad2d 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		4
+#define AUTOFS_PROTO_SUBVERSION		5
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed

