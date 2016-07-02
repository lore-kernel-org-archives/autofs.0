From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs: Test autofs versions first on sb initialization
Date: Sat,  2 Jul 2016 22:29:43 +0900
Message-ID: <1467466183-7058-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OtIw2tf4fUvVWr1n1m5t5Ch6g6xDcuRNW/cEPTM+eLM=;
        b=F8WVwHdaECCu/jZUn0pN9Dx4PYentni3eqUylEIIw1vXCbpTFX2/bXSEdBU7gj7o+d
         4xkdgEtK3DdVpU+COTQKHye6hKow9dh2Yv3+Tg/YhCgp4ae9VmOo3O6JzEGfwPZPeL+I
         JHJMyAYV2MS6IoElPTJbYTQ29Kb4L+WfgtZRaSiFL5m3K4xm/g26NuoSI5jE74h6sCbH
         CTxa6+E8olk1h2nXG6HcXrkOFarSeDauMhDst/2RpqsHpmDAm2g8NTh6nqzNsHQ/9Iaj
         bz0Z3KpVezMKsmqXkTAImotwbu9fl5nLURMJQc5PEmQmRrURkI72k7B9Aqeaxpk5U8ee
         R9dA==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

This patch does what the below comment says.
It could be and it's considered better to do this first
before various functions get called during initialization.

/* Couldn't this be tested earlier? */
---
 fs/autofs4/inode.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 61b2105..8357544 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -274,6 +274,23 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 		goto fail_dput;
 	}
 
+	/* Test versions first */
+	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
+	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
+		pr_err("kernel does not match daemon version "
+		       "daemon (%d, %d) kernel (%d, %d)\n",
+		       sbi->min_proto, sbi->max_proto,
+		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
+		goto fail_dput;
+	}
+
+	/* Establish highest kernel protocol version */
+	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
+		sbi->version = AUTOFS_MAX_PROTO_VERSION;
+	else
+		sbi->version = sbi->max_proto;
+	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+
 	if (pgrp_set) {
 		sbi->oz_pgrp = find_get_pid(pgrp);
 		if (!sbi->oz_pgrp) {
@@ -291,23 +308,6 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	root_inode->i_fop = &autofs4_root_operations;
 	root_inode->i_op = &autofs4_dir_inode_operations;
 
-	/* Couldn't this be tested earlier? */
-	if (sbi->max_proto < AUTOFS_MIN_PROTO_VERSION ||
-	    sbi->min_proto > AUTOFS_MAX_PROTO_VERSION) {
-		pr_err("kernel does not match daemon version "
-		       "daemon (%d, %d) kernel (%d, %d)\n",
-		       sbi->min_proto, sbi->max_proto,
-		       AUTOFS_MIN_PROTO_VERSION, AUTOFS_MAX_PROTO_VERSION);
-		goto fail_dput;
-	}
-
-	/* Establish highest kernel protocol version */
-	if (sbi->max_proto > AUTOFS_MAX_PROTO_VERSION)
-		sbi->version = AUTOFS_MAX_PROTO_VERSION;
-	else
-		sbi->version = sbi->max_proto;
-	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
-
 	pr_debug("pipe fd = %d, pgrp = %u\n", pipefd, pid_nr(sbi->oz_pgrp));
 	pipe = fget(pipefd);
 
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
