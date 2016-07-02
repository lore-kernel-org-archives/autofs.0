From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 2/2] autofs: Fix conditional to kfree dentry data
Date: Sun,  3 Jul 2016 02:24:24 +0900
Message-ID: <1467480264-1801-2-git-send-email-kusumi.tomohiro@gmail.com>
References: <1467480264-1801-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YsL/J7eGM5HKUG0Gx9fI6IM+aLLxt6C6A6ikvIg3QcQ=;
        b=gWMoRazFEr7jmlvG7SferJtkkCJfMtKyBzSNyZrqhn7/TtabMcqPRk85qGZZbt6OPz
         qKn8h5eRgd/3VHLX6TjYbql7I36XYPWKr5KfaSz+iA8FfoZuRWzYI2LZA/EtRRtV3pYv
         rZjeqUzY0KThwhqHHgoQyfNT/aE/wJdGN5xkMnlRHM+QCvL6cwx9ug3Vw0QOGlx6Fmiq
         KazaEhHhInmAjRNVAbkmVW5gLG6C75n7t1Z6hbVlUemxl7PgZpfM4uOx+x2gvniNFIXo
         5k5Gpw5que0w8HTJBfYVgTT4agkq2KjHHMLIFbNfUnmmcPK+wCjq0cCkvaC8kbZpj3i7
         E+Wg==
In-Reply-To: <1467480264-1801-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

if (!dentry->d_fsdata) should be testing d_fsdata or ino without !.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 93d3232..5a877bf 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -577,7 +577,7 @@ static int autofs4_dir_symlink(struct inode *dir,
 	inode = autofs4_get_inode(dir->i_sb, S_IFLNK | 0555);
 	if (!inode) {
 		kfree(cp);
-		if (!dentry->d_fsdata)
+		if (ino)
 			autofs4_free_ino(ino);
 		return -ENOMEM;
 	}
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
