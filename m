Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975E153598;
	Thu, 25 Dec 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766672886; cv=none; b=TCrDDkYlyYTo0VVFAPxsV5DltjnF1pq3d8PULEqaqDl47BNTx0HEoMyVpAZB8daYNlGL1Iq1OUhGaUfFkWlej87Dif8k+TXElaeF26fo0KbbR35O5+Gp9Lels9RMvr+nRIYVY+B4xJy66FJHT119kg5jG8XQ4+Z2mnI7/JDPq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766672886; c=relaxed/simple;
	bh=/dOvOA86FTLqe2OuxriresiCDRGJDPGXfPU/AN8DIYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkDRav3jX5QhfKAYU7MQpZcTBVJqZ2HG9ZSi53V+9o6qwJWWqQltws43aRMMjCFChUynj8yu+HMSCtn/esj4OnFP8+ya/91nlFHMeZ5+VeZZuM8DgiWrf/4Z18MJyX4s5rYJfEDvuCkt1jb1CnmYNfE099qTc0mDfTxTKLCtn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iMXX7QXg; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iMXX7QXg"
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e90b92d7;
	Thu, 25 Dec 2025 22:27:58 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] autofs: Fix memory leak in autofs_fill_super()
Date: Thu, 25 Dec 2025 14:27:54 +0000
Message-Id: <20251225142754.1114352-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b55e8cb0e03a1kunm0858d4a1511d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUhCVk0fS08YHxhNGElKSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=iMXX7QXgeqBYN+Aui1vY+tT+GVNvAl57u/fYdTlFmFi8KiU7gjWjzZXGXHOzqjKpNfoynHsjm4ancH92tHZRJEHSxEvXM4QVnTNrnhOhR/GBQZF5LSK3tGvUuhaVel/XOf/X8A2wvDWngn38+s2PvGXqLx5bu+NSz/V7aZo/224=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=aegVInfBJR9RZQTGezP+QbnojjDTFgMqmo3lmWG7m1Y=;
	h=date:mime-version:subject:message-id:from;

The autofs_new_ino() function allocates a new autofs_info structure.
If the subsequent call to autofs_get_inode() fails, this structure is
not freed, leading to a memory leak.

Fix this by adding a new error label to free the structure and jumping
to it upon failure.

While at it, consolidate the error handling for the d_make_root()
failure case to use the same label.

Fixes: 66917f85db600 ("autofs: add: new_inode check in autofs_fill_super()")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/autofs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index b932b1719dfc..391979f8b2bb 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -324,7 +324,7 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	if (!root_inode)
-		return -ENOMEM;
+		goto nomem;
 
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
@@ -332,10 +332,9 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 	root_inode->i_op = &autofs_dir_inode_operations;
 
 	s->s_root = d_make_root(root_inode);
-	if (unlikely(!s->s_root)) {
-		autofs_free_ino(ino);
-		return -ENOMEM;
-	}
+	if (unlikely(!s->s_root))
+		goto nomem;
+
 	s->s_root->d_fsdata = ino;
 
 	if (ctx->pgrp_set) {
@@ -358,6 +357,10 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 	return 0;
+
+nomem:
+	autofs_free_ino(ino);
+	return -ENOMEM;
 }
 
 /*
-- 
2.34.1

