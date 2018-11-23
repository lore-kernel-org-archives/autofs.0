From: Ian Kent <raven@themaw.net>
Subject: [PATCH v2 3/5] autofs - simplify parse_options() function call
Date: Fri, 23 Nov 2018 18:42:04 +0800
Message-ID: <154296972423.9889.9368859245676473329.stgit@pluto-themaw-net>
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

The parse_options() function uses a long list of parameters, most
of which are present in the super block info structure already.

The mount parameters set in parse_options() options don't require
cleanup so using the super block info struct directly is simpler.
---
 fs/autofs/inode.c |   55 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e5c06b5a7371..ccedd12c1ac5 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -124,21 +124,24 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
-			 int *pgrp, bool *pgrp_set, unsigned int *type,
-			 int *minproto, int *maxproto)
+static int parse_options(char *options,
+			 struct inode *root, int *pgrp, bool *pgrp_set,
+			 struct autofs_sb_info *sbi)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
+	int pipefd = -1;
+	kuid_t uid;
+	kgid_t gid;
 
-	*uid = current_uid();
-	*gid = current_gid();
+	root->i_uid = current_uid();
+	root->i_gid = current_gid();
 
-	*minproto = AUTOFS_MIN_PROTO_VERSION;
-	*maxproto = AUTOFS_MAX_PROTO_VERSION;
+	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
 
-	*pipefd = -1;
+	sbi->pipefd = -1;
 
 	if (!options)
 		return 1;
@@ -152,22 +155,25 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_fd:
-			if (match_int(args, pipefd))
+			if (match_int(args, &pipefd))
 				return 1;
+			sbi->pipefd = pipefd;
 			break;
 		case Opt_uid:
 			if (match_int(args, &option))
 				return 1;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
+			uid = make_kuid(current_user_ns(), option);
+			if (!uid_valid(uid))
 				return 1;
+			root->i_uid = uid;
 			break;
 		case Opt_gid:
 			if (match_int(args, &option))
 				return 1;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
+			gid = make_kgid(current_user_ns(), option);
+			if (!gid_valid(gid))
 				return 1;
+			root->i_gid = gid;
 			break;
 		case Opt_pgrp:
 			if (match_int(args, &option))
@@ -178,27 +184,27 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 		case Opt_minproto:
 			if (match_int(args, &option))
 				return 1;
-			*minproto = option;
+			sbi->min_proto = option;
 			break;
 		case Opt_maxproto:
 			if (match_int(args, &option))
 				return 1;
-			*maxproto = option;
+			sbi->max_proto = option;
 			break;
 		case Opt_indirect:
-			set_autofs_type_indirect(type);
+			set_autofs_type_indirect(&sbi->type);
 			break;
 		case Opt_direct:
-			set_autofs_type_direct(type);
+			set_autofs_type_direct(&sbi->type);
 			break;
 		case Opt_offset:
-			set_autofs_type_offset(type);
+			set_autofs_type_offset(&sbi->type);
 			break;
 		default:
 			return 1;
 		}
 	}
-	return (*pipefd < 0);
+	return (sbi->pipefd < 0);
 }
 
 int autofs_fill_super(struct super_block *s, void *data, int silent)
@@ -206,7 +212,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	struct inode *root_inode;
 	struct dentry *root;
 	struct file *pipe;
-	int pipefd;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 	int pgrp = 0;
@@ -266,9 +271,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root->d_fsdata = ino;
 
 	/* Can this call block? */
-	if (parse_options(data, &pipefd, &root_inode->i_uid, &root_inode->i_gid,
-			  &pgrp, &pgrp_set, &sbi->type, &sbi->min_proto,
-			  &sbi->max_proto)) {
+	if (parse_options(data, root_inode, &pgrp, &pgrp_set, sbi)) {
 		pr_err("called with bogus options\n");
 		goto fail_dput;
 	}
@@ -307,9 +310,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_fop = &autofs_root_operations;
 	root_inode->i_op = &autofs_dir_inode_operations;
 
-	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
+	pr_debug("pipe fd = %d, pgrp = %u\n",
+		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
 
-	pipe = fget(pipefd);
+	pipe = fget(sbi->pipefd);
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
 		goto fail_put_pid;
@@ -318,7 +322,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	if (ret < 0)
 		goto fail_fput;
 	sbi->pipe = pipe;
-	sbi->pipefd = pipefd;
 	sbi->catatonic = 0;
 
 	/*

