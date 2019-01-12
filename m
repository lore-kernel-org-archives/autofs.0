From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/3] autofs - fix error return in autofs_fill_super()
Date: Sat, 12 Jan 2019 08:00:33 +0800
Message-ID: <154725123240.11260.796773942606871359.stgit@pluto-themaw-net>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

In autofs_fill_super() on error of get inode/make root dentry the
return should be ENOMEM as this is the only failure case of the
called functions.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 0e8ea2d9a2bb..078992eee299 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -266,8 +266,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
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

