From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 1/2] autofs: Use autofs4_free_ino() to kfree dentry data
Date: Sun,  3 Jul 2016 02:24:23 +0900
Message-ID: <1467480264-1801-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oS4Jl1ZOJD4By5NcxqslNXyJ3c74TF/j94wK2Jp1+1k=;
        b=QvyF8q3vFdSpkWrWroLuEssPBgWVzHO5hr8yThF5NKAqzo5EbSvfpAqjTzFafqIxt1
         T5Ii2/PXhinNBJLQaSknNh60YfDr67uUea8ySXfPEW3lLLpBXREYCmyfWxxLOonTQdN6
         YTzlBC2G3jUUOSWZtjpwZbqzy9okDX9KcoEbVbqH2BEE+QQqLNyiMINVB96v08H79fO+
         E33fzlW2QohA/35TNwLIc5uTIueTnI6i7QPYMAz8wbkpgSB3TcJWkGyYdXy5ok613pV1
         ayyeY0wi3AZS2TkTgP15B8OizivosvEqXcY/cC1xpmQ/IfB+tBOtr7pzysrwEXE3eKRY
         kn5A==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

kfree dentry data allocated by autofs4_new_ino() with
autofs4_free_ino() instead of raw kfree.
(since we have the interface to free autofs_info*)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/inode.c | 2 +-
 fs/autofs4/root.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 8357544..ad0ee93 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -339,7 +339,7 @@ fail_dput:
 	dput(root);
 	goto fail_free;
 fail_ino:
-	kfree(ino);
+	autofs4_free_ino(ino);
 fail_free:
 	put_pid(sbi->oz_pgrp);
 	kfree(sbi);
diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 3767f66..93d3232 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -578,7 +578,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 	if (!inode) {
 		kfree(cp);
 		if (!dentry->d_fsdata)
-			kfree(ino);
+			autofs4_free_ino(ino);
 		return -ENOMEM;
 	}
 	inode->i_private = cp;
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
