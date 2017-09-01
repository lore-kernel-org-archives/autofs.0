From: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
Subject: [RFC PATCH 1/2] autofs: set compat flag on sbi when daemon uses
 32bit addressation
Date: Fri, 01 Sep 2017 15:21:44 +0400
Message-ID: <20170901112144.2669.1453.stgit@localhost.localdomain>
References: <20170901110906.2669.1577.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20170901110906.2669.1577.stgit@localhost.localdomain>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, devel@openvz.org, ldv@altlinux.org

Signed-off-by: Stanislav Kinsburskiy <skinsbursky@virtuozzo.com>
---
 fs/autofs4/autofs_i.h  |    3 +++
 fs/autofs4/dev-ioctl.c |    3 +++
 fs/autofs4/inode.c     |    4 +++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4737615..3da105f 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -120,6 +120,9 @@ struct autofs_sb_info {
 	struct list_head active_list;
 	struct list_head expiring_list;
 	struct rcu_head rcu;
+#ifdef CONFIG_COMPAT
+	unsigned is32bit:1;
+#endif
 };
 
 static inline struct autofs_sb_info *autofs4_sbi(struct super_block *sb)
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index b7c816f..467d6c4 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -397,6 +397,9 @@ static int autofs_dev_ioctl_setpipefd(struct file *fp,
 		sbi->pipefd = pipefd;
 		sbi->pipe = pipe;
 		sbi->catatonic = 0;
+#ifdef CONFIG_COMPAT
+		sbi->is32bit = is_compat_task();
+#endif
 	}
 out:
 	put_pid(new_pid);
diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 09e7d68..21d3c0b 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -301,7 +301,9 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	} else {
 		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
 	}
-
+#ifdef CONFIG_COMPAT
+	sbi->is32bit = is_compat_task();
+#endif
 	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
