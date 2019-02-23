From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 65/65] autofs: fix error return in autofs_fill_super()
Date: Sat, 23 Feb 2019 16:06:40 -0500
Message-ID: <20190223210640.200911-65-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956114;
        bh=rm1pjeuZgujoWtqLzBSUx1GVZxftep5+WZQSIkKcL68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dONF2X1is6XST831AkKMYECNcc7KJDXAbPhuuh2gKC2fHayQMQP9+KtMp5iTlqE/i
         ChEeWM9ba16Ey4KvdN6uGATNKmNHDGP3Dl9Kc1lFeG/GDKd834vzAx+SASj5ALIUWd
         aBJWwrrPsYfO3jI8/51un3BGFh9oB+/ISCSPA/F4=
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, autofs@vger.kernel.org

From: Ian Kent <raven@themaw.net>

[ Upstream commit f585b283e3f025754c45bbe7533fc6e5c4643700 ]

In autofs_fill_super() on error of get inode/make root dentry the return
should be ENOMEM as this is the only failure case of the called
functions.

Link: http://lkml.kernel.org/r/154725123240.11260.796773942606871359.stgit@pluto-themaw-net
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 846c052569dd4..3c14a8e45ffb6 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -255,8 +255,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
-	if (!root)
+	if (!root) {
+		ret = -ENOMEM;
 		goto fail_ino;
+	}
 	pipe = NULL;
 
 	root->d_fsdata = ino;
-- 
2.19.1

