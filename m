From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/6] autofs - use struct for mount params
Date: Tue, 13 Nov 2018 09:36:19 +0800
Message-ID: <154207297923.11064.15608451642929332541.stgit@pluto-themaw-net>
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

Use a structure to hold parsed parameters to simplify the
autofs_parse_options() function call.

Also seperate option parsing and applying the options into
seperate functions.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |  193 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 116 insertions(+), 77 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 93af0d5777ae..53ed6c637cbf 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -108,6 +108,17 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
+struct autofs_fs_params {
+	int pipefd;
+	kuid_t uid;
+	kgid_t gid;
+	int pgrp;
+	bool pgrp_set;
+	int min_proto;
+	int max_proto;
+	unsigned int type;
+};
+
 enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
 	Opt_indirect, Opt_direct, Opt_offset};
 
@@ -124,24 +135,26 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
-			 int *pgrp, bool *pgrp_set, unsigned int *type,
-			 int *minproto, int *maxproto)
+static int autofs_parse_options(char *options, struct autofs_fs_params *params)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
 	int option;
+	kuid_t uid;
+	kgid_t gid;
+
+	if (!options)
+		return 1;
 
-	*uid = current_uid();
-	*gid = current_gid();
+	params->pipefd = -1;
 
-	*minproto = AUTOFS_MIN_PROTO_VERSION;
-	*maxproto = AUTOFS_MAX_PROTO_VERSION;
+	params->uid = current_uid();
+	params->gid = current_gid();
 
-	*pipefd = -1;
+	params->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	params->max_proto = AUTOFS_MAX_PROTO_VERSION;
 
-	if (!options)
-		return 1;
+	params->pgrp_set = false;
 
 	while ((p = strsep(&options, ",")) != NULL) {
 		int token;
@@ -152,53 +165,126 @@ static int parse_options(char *options, int *pipefd, kuid_t *uid, kgid_t *gid,
 		token = match_token(p, tokens, args);
 		switch (token) {
 		case Opt_fd:
-			if (match_int(args, pipefd))
+			if (match_int(args, &option))
 				return 1;
+			params->pipefd = option;
 			break;
 		case Opt_uid:
 			if (match_int(args, &option))
 				return 1;
-			*uid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(*uid))
+			uid = make_kuid(current_user_ns(), option);
+			if (!uid_valid(uid))
 				return 1;
+			params->uid = uid;
 			break;
 		case Opt_gid:
 			if (match_int(args, &option))
 				return 1;
-			*gid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(*gid))
+			gid = make_kgid(current_user_ns(), option);
+			if (!gid_valid(gid))
 				return 1;
+			params->gid = gid;
 			break;
 		case Opt_pgrp:
 			if (match_int(args, &option))
 				return 1;
-			*pgrp = option;
-			*pgrp_set = true;
+			params->pgrp = option;
+			params->pgrp_set = true;
 			break;
 		case Opt_minproto:
 			if (match_int(args, &option))
 				return 1;
-			*minproto = option;
+			params->min_proto = option;
 			break;
 		case Opt_maxproto:
 			if (match_int(args, &option))
 				return 1;
-			*maxproto = option;
+			params->max_proto = option;
 			break;
 		case Opt_indirect:
-			set_autofs_type_indirect(type);
+			set_autofs_type_indirect(&params->type);
 			break;
 		case Opt_direct:
-			set_autofs_type_direct(type);
+			set_autofs_type_direct(&params->type);
 			break;
 		case Opt_offset:
-			set_autofs_type_offset(type);
+			set_autofs_type_offset(&params->type);
 			break;
 		default:
 			return 1;
 		}
 	}
-	return (*pipefd < 0);
+	return (params->pipefd < 0);
+}
+
+static int autofs_apply_sbi_options(struct autofs_sb_info *sbi,
+				    struct autofs_fs_params *params)
+{
+	int err;
+
+	sbi->pipefd = params->pipefd;
+
+	if (params->type)
+		sbi->type = params->type;
+
+	/* Test versions first */
+	if (params->max_proto < AUTOFS_MIN_PROTO_VERSION ||
+	    params->min_proto > AUTOFS_MAX_PROTO_VERSION) {
+		pr_err("kernel does not match daemon version\n");
+		pr_err("daemon (%d, %d) kernel (%d, %d)\n",
+			params->min_proto, params->max_proto,
+			AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
+		goto out;
+	}
+
+	sbi->max_proto = params->max_proto;
+	sbi->min_proto = params->min_proto;
+
+	if (sbi->min_proto > sbi->max_proto)
+		sbi->min_proto = params->max_proto;
+
+	/* Establish highest kernel protocol version */
+	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
+		sbi->version = AUTOFS_MAX_PROTO_VERSION;
+	else
+		sbi->version = params->max_proto;
+
+	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+
+	if (!params->pgrp_set)
+		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
+	else {
+		sbi->oz_pgrp = find_get_pid(params->pgrp);
+		if (!sbi->oz_pgrp) {
+			pr_err("could not find process group %d\n",
+			       params->pgrp);
+			goto out;
+		}
+	}
+
+	pr_debug("pipe fd = %d, pgrp = %u\n",
+		  sbi->pipefd, pid_nr(sbi->oz_pgrp));
+
+	sbi->pipe = fget(sbi->pipefd);
+	if (!sbi->pipe) {
+		pr_err("could not open pipe file descriptor\n");
+		goto out_put_pid;
+	}
+
+	err = autofs_prepare_pipe(sbi->pipe);
+	if (err < 0)
+		goto out_fput;
+
+	sbi->catatonic = 0;
+
+	return 0;
+
+out_fput:
+	fput(sbi->pipe);
+out_put_pid:
+	put_pid(sbi->oz_pgrp);
+out:
+	return 1;
 }
 
 static struct autofs_sb_info *autofs_alloc_sbi(struct super_block *s)
@@ -229,12 +315,9 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root;
-	struct file *pipe;
-	int pipefd;
+	struct autofs_fs_params params;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
 	int ret = -EINVAL;
 
 	sbi = autofs_alloc_sbi(s);
@@ -267,45 +350,20 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root = d_make_root(root_inode);
 	if (!root)
 		goto fail_iput;
-	pipe = NULL;
 
 	root->d_fsdata = ino;
 
-	/* Can this call block? */
-	if (parse_options(data, &pipefd, &root_inode->i_uid, &root_inode->i_gid,
-			  &pgrp, &pgrp_set, &sbi->type, &sbi->min_proto,
-			  &sbi->max_proto)) {
+	memset(&params, 0, sizeof(struct autofs_fs_params));
+	if (autofs_parse_options(data, &params)) {
 		pr_err("called with bogus options\n");
 		goto fail_dput;
 	}
+	root_inode->i_uid = params->uid;
+	root_inode->i_gid = params->gid;
 
-	/* Test versions first */
-	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
-	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		pr_err("kernel does not match daemon version "
-		       "daemon (%d, %d) kernel (%d, %d)\n",
-		       sbi->min_proto, sbi->max_proto,
-		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
+	ret = autofs_apply_sbi_options(sbi, &params);
+	if (ret)
 		goto fail_dput;
-	}
-
-	/* Establish highest kernel protocol version */
-	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
-		sbi->version = AUTOFS_MAX_PROTO_VERSION;
-	else
-		sbi->version = sbi->max_proto;
-	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
-
-	if (pgrp_set) {
-		sbi->oz_pgrp = find_get_pid(pgrp);
-		if (!sbi->oz_pgrp) {
-			pr_err("could not find process group %d\n",
-				pgrp);
-			goto fail_dput;
-		}
-	} else {
-		sbi->oz_pgrp = get_task_pid(current, PIDTYPE_PGID);
-	}
 
 	if (autofs_type_trigger(sbi->type))
 		__managed_dentry_set_managed(root);
@@ -313,20 +371,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_fop = &autofs_root_operations;
 	root_inode->i_op = &autofs_dir_inode_operations;
 
-	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
-
-	pipe = fget(pipefd);
-	if (!pipe) {
-		pr_err("could not open pipe file descriptor\n");
-		goto fail_put_pid;
-	}
-	ret = autofs_prepare_pipe(pipe);
-	if (ret < 0)
-		goto fail_fput;
-	sbi->pipe = pipe;
-	sbi->pipefd = pipefd;
-	sbi->catatonic = 0;
-
 	/*
 	 * Success! Install the root dentry now to indicate completion.
 	 */
@@ -336,11 +380,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	/*
 	 * Failure ... clean up.
 	 */
-fail_fput:
-	pr_err("pipe file descriptor does not contain proper ops\n");
-	fput(pipe);
-fail_put_pid:
-	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
 	goto fail_free;

