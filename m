From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 72/72] autofs: fix error return in autofs_fill_super()
Date: Sat, 23 Feb 2019 16:04:22 -0500
Message-ID: <20190223210422.199966-72-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955998;
        bh=rm1pjeuZgujoWtqLzBSUx1GVZxftep5+WZQSIkKcL68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kOiB2ZXduYh+zY95mhnTn/DMTrcgcA3sLGG2RynSA9qsx9YHejXUDPs7OjMFIg6qk
         y9HasgXtk8CfhKfCwGzOuK80OVYVHXITd+bDaisFBKz19RGQukaRA1BElFzI/SExC7
         suZ+N7Dfb3gTHugdOTcGD+1EPvTBSDvJtFtZVUsA=
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
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

