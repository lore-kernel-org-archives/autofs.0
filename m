From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/13] autofs4 - change printks AUTOFS defined prints
Date: Mon, 03 Nov 2014 16:12:34 +0800
Message-ID: <20141103081234.6215.82821.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=KjdXFRlthbu7SRxk27QhXZS/iz4=; b=p2Iuhj1gRrR7CLjOjP
	IJYi6GlBMRtdF1qBWRzjppw7GrcYNc1PLqDtp4HUszTQGvumsWijSCDsS1gzD8fK
	rAQomkSCHK/glh57wnQAJCbrBqXZzAXxxrIFDDco2X0N5clir5DY04cM/Mi5Fnca
	8LETIdyrqORTTzYxQT6H17KEE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=KjdXFRlthbu7SRxk27QhXZ
	S/iz4=; b=ILrr5yw17sXcm4FPk10U2lq/vyYBk7tYPLbxwByKoMU0KlA8Oe5lTd
	72x2Sw55DD4Hh/4pNxBZjjUoVK0RJ8dHCGnGWmimRjOmG3fwDlF9KAEhecIdlmGt
	HBvTUJkEwkV7RxQaoyDOqGCiLGGEDSpQLMraPQ9XwNsL2e3VjqHdc=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Use the AUTOFS_*() print defines instead of raw printks.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |   13 +++++++------
 fs/autofs4/waitq.c |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 80389af..7849591 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -266,14 +266,14 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	if (parse_options(data, &pipefd, &root_inode->i_uid, &root_inode->i_gid,
 			  &pgrp, &pgrp_set, &sbi->type, &sbi->min_proto,
 			  &sbi->max_proto)) {
-		printk("autofs: called with bogus options\n");
+		AUTOFS_ERROR("autofs: called with bogus options");
 		goto fail_dput;
 	}
 
 	if (pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(pgrp);
 		if (!sbi->oz_pgrp) {
-			pr_warn("autofs: could not find process group %d\n",
+			AUTOFS_ERROR("autofs: could not find process group %d",
 				pgrp);
 			goto fail_dput;
 		}
@@ -290,8 +290,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	/* Couldn't this be tested earlier? */
 	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
 	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		printk("autofs: kernel does not match daemon version "
-		       "daemon (%d, %d) kernel (%d, %d)\n",
+		AUTOFS_ERROR("autofs: kernel does not match daemon version "
+			     "daemon (%d, %d) kernel (%d, %d)",
 			sbi->min_proto, sbi->max_proto,
 			AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
 		goto fail_dput;
@@ -308,7 +308,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	pipe = fget(pipefd);
 
 	if (!pipe) {
-		printk("autofs: could not open pipe file descriptor\n");
+		AUTOFS_ERROR("autofs: could not open pipe file descriptor");
 		goto fail_dput;
 	}
 	ret = autofs_prepare_pipe(pipe);
@@ -328,7 +328,8 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	 * Failure ... clean up.
 	 */
 fail_fput:
-	printk("autofs: pipe file descriptor does not contain proper ops\n");
+	AUTOFS_ERROR(
+		"autofs: pipe file descriptor does not contain proper ops");
 	fput(pipe);
 	/* fall through */
 fail_dput:
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index b7f2deb..3a28d29 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -162,7 +162,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
 		break;
 	}
 	default:
-		printk("autofs4_notify_daemon: bad type %d!\n", type);
+		AUTOFS_WARN("autofs4_notify_daemon: bad type %d!", type);
 		mutex_unlock(&sbi->wq_mutex);
 		return;
 	}
