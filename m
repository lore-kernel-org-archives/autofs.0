From: Ian Kent <raven@themaw.net>
Subject: [PATCH v2 5/5] autofs - add strictexpire mount option
Date: Fri, 23 Nov 2018 18:42:19 +0800
Message-ID: <154296973880.9889.14085372741514507967.stgit@pluto-themaw-net>
References: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154296962626.9889.644199825100770992.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Commit 092a53452b (("autofs: take more care to not update last_used
on path walk") helped to (partially) resolve a problem where automounts
were not expiring due to aggressive accesses from user space.

This patch was later reverted because, for very large environments,
it meant more mount requests from clients and when there are a lot
of clients this caused a fairly significant increase in server load.

But there is a need for both types of expire check, depending on use
case, so add a mount option to allow for strict update of last use
of autofs dentrys (which just means not updating the last use on path
walk access).

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h         |    1 +
 fs/autofs/inode.c            |    8 +++++++-
 fs/autofs/root.c             |    5 ++++-
 include/uapi/linux/auto_fs.h |    2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 032cbb12531a..fa3733beb52e 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -102,6 +102,7 @@ struct autofs_wait_queue {
 #define AUTOFS_SBI_MAGIC 0x6d4a556d
 
 #define AUTOFS_SBI_CATATONIC	0x0001
+#define AUTOFS_SBI_STRICTEXPIRE 0x0002
 
 struct autofs_sb_info {
 	u32 magic;
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 8cfd3f67af57..501833cc49a8 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -87,6 +87,8 @@ static int autofs_show_options(struct seq_file *m, struct dentry *root)
 		seq_printf(m, ",direct");
 	else
 		seq_printf(m, ",indirect");
+	if (sbi->flags & AUTOFS_SBI_STRICTEXPIRE)
+		seq_printf(m, ",strictexpire");
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	if (sbi->pipe)
 		seq_printf(m, ",pipe_ino=%ld", file_inode(sbi->pipe)->i_ino);
@@ -109,7 +111,7 @@ static const struct super_operations autofs_sops = {
 };
 
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset};
+	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
@@ -121,6 +123,7 @@ static const match_table_t tokens = {
 	{Opt_indirect, "indirect"},
 	{Opt_direct, "direct"},
 	{Opt_offset, "offset"},
+	{Opt_strictexpire, "strictexpire"},
 	{Opt_err, NULL}
 };
 
@@ -200,6 +203,9 @@ static int parse_options(char *options,
 		case Opt_offset:
 			set_autofs_type_offset(&sbi->type);
 			break;
+		case Opt_strictexpire:
+			sbi->flags |= AUTOFS_SBI_STRICTEXPIRE;
+			break;
 		default:
 			return 1;
 		}
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 164ccd3402cf..1246f396bf0e 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -275,8 +275,11 @@ static int autofs_mount_wait(const struct path *path, bool rcu_walk)
 		pr_debug("waiting for mount name=%pd\n", path->dentry);
 		status = autofs_wait(sbi, path, NFY_MOUNT);
 		pr_debug("mount wait done status=%d\n", status);
+		ino->last_used = jiffies;
+		return status;
 	}
-	ino->last_used = jiffies;
+	if (!(sbi->flags & AUTOFS_SBI_STRICTEXPIRE))
+		ino->last_used = jiffies;
 	return status;
 }
 
diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index df31aa9c9a8c..082119630b49 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -23,7 +23,7 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		3
+#define AUTOFS_PROTO_SUBVERSION		4
 
 /*
  * The wait_queue_token (autofs_wqt_t) is part of a structure which is passed

