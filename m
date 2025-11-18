Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D31DB551
	for <autofs@vger.kernel.org>; Tue, 18 Nov 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473302; cv=none; b=D7ZPzdyQXUlssg+kHkG8F7IU1Cm3iKaDeelBujfh6tePR2Fd/TGhMBZKNdzMxw/S3CZ0cW5QOfEIi0sqzcyNtITkjTIzWiSyf8s2bwzcZTLq60HYByM0qpBKEv5zAWbf0f2gNCSwaG84SVyDw13d5LLdyejdfSUKffp2EQnOfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473302; c=relaxed/simple;
	bh=ezTCnDLMhxJSeUnST9GV5+1XsDOB/OD8gO6o08NluLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFvnD852R46nV/PdHr91IXOlQjv68XAXqwEjMG1DNwhLaLlpZF6cCBKg/2GmG8Rmm8o4cM0yKUF/eBzRzxWbrl5QXPNvEjBQcLJVVsJWx2vCl4kQgdPgmryr4pnzQSztvS3gPz7SYaNmb1TBwo7mFiwqjG8YWt6602c2aw84JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3xnFttt; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3xnFttt"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763473297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zqkcGyS0ZMRVs5Iun+iRiMAhmb3qL/lC9WaGR9+xlPU=;
	b=h3xnFtttB4fz82d4dRHBiv4fJXAGlPzxqrFFprQk72Yitz5oKkNQDcssyTha6u2Tn5LFf6
	Gy827kaQp3pAw4L19XtyoKM6a3IBrgUKPPYhZ8E9f9q0QF7U9alLOKqX4JpK27dbHOKOiu
	atIaADBY/I+xhCTwDF26R2foZVn4JKg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Ian Kent <raven@themaw.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	autofs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] autofs: replace manual symlink buffer allocation in autofs_dir_symlink
Date: Tue, 18 Nov 2025 14:41:28 +0100
Message-ID: <20251118134129.100224-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: autofs@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
List-Subscribe: <mailto:autofs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:autofs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The symlink name was previously duplicated using an explicit kmalloc()
followed by strcpy(), which is deprecated [1]. Replace this open-coded
string duplication with kstrdup(), which allocates and copies the
symlink name with a single helper function.

Remove the local variable 'size' and set 'i_size' directly using
strlen(cp), which is equivalent to the previous value of 'size'.

This simplifies the code, uses common string-handling helpers, and
removes the deprecated use of strcpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/autofs/root.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 174c7205fee4..36b7b34d23b5 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -7,6 +7,7 @@
 
 #include <linux/capability.h>
 #include <linux/compat.h>
+#include <linux/string.h>
 
 #include "autofs_i.h"
 
@@ -570,7 +571,6 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
 	struct autofs_info *p_ino;
 	struct inode *inode;
-	size_t size = strlen(symname);
 	char *cp;
 
 	pr_debug("%s <- %pd\n", symname, dentry);
@@ -581,19 +581,17 @@ static int autofs_dir_symlink(struct mnt_idmap *idmap,
 
 	autofs_del_active(dentry);
 
-	cp = kmalloc(size + 1, GFP_KERNEL);
+	cp = kstrdup(symname, GFP_KERNEL);
 	if (!cp)
 		return -ENOMEM;
 
-	strcpy(cp, symname);
-
 	inode = autofs_get_inode(dir->i_sb, S_IFLNK | 0555);
 	if (!inode) {
 		kfree(cp);
 		return -ENOMEM;
 	}
 	inode->i_private = cp;
-	inode->i_size = size;
+	inode->i_size = strlen(cp);
 	d_add(dentry, inode);
 
 	dget(dentry);
-- 
2.51.1

