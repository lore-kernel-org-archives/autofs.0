From: Ian Kent <raven@themaw.net>
Subject: [PATCH 04/18] autofs - fix autofs4_fill_super() error exit handling
Date: Fri, 12 Aug 2016 10:47:49 +0800
Message-ID: <20160812024749.12352.15100.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=PDIkZnvGu77fuuQ2s8WQ5MOOwHM=; b=Qc8Hn8
	u0DFBvrSc6UaUpZgsQxk6a/W/fEzlp0QRqtB3v66Zt6vY91Bn0GMq2JNPY5CwyNh
	JhRQfe0n7ZlAjJnUitRBx+k+PrFOWxrlWtAgbTK7b5jlZ8BWA+tF2H5x3Ftomcv7
	gdA9HvSM9CZHRqGFpvu5xvw2U/Oy/Rk5OH5XI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=PDIkZnvGu77fuuQ
	2s8WQ5MOOwHM=; b=FgNPOCrGb7nkZwztvrDcVor0wi7LVPfsdKDyCTzb+Xd/BiI
	TXo5hd1adDqFFtQDiEx2vAqmzmsBNYfz+Kw3TyByVgAbYyG6E7A6r4J3k0rhs/Pk
	J+ASIKFWsbl21dST1c3iHk7jjx+6zepglQIrkS8hpuuVJwhh9esN0FSx7HCo=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Somewhere along the line the error handling gotos have become incorrect.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/inode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 8357544..64d721f 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -313,7 +313,7 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 
 	if (!pipe) {
 		pr_err("could not open pipe file descriptor\n");
-		goto fail_dput;
+		goto fail_put_pid;
 	}
 	ret = autofs_prepare_pipe(pipe);
 	if (ret < 0)
@@ -334,14 +334,14 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 fail_fput:
 	pr_err("pipe file descriptor does not contain proper ops\n");
 	fput(pipe);
-	/* fall through */
+fail_put_pid:
+	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
 	goto fail_free;
 fail_ino:
 	kfree(ino);
 fail_free:
-	put_pid(sbi->oz_pgrp);
 	kfree(sbi);
 	s->s_fs_info = NULL;
 	return ret;

