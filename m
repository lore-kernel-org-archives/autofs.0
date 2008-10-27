From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix var shadowed by local delaration
Date: Mon, 27 Oct 2008 13:36:36 +0900
Message-ID: <20081027043636.15523.95519.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

A local definition of devid in autofs_dev_ioctl_ismountpoint() shadows
the fuction wide definition.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/dev-ioctl.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index a040639..e19d584 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -597,17 +597,17 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 			magic = nd.path.dentry->d_inode->i_sb->s_magic;
 		}
 	} else {
-		dev_t devid = new_encode_dev(sbi->sb->s_dev);
+		dev_t dev = autofs4_get_dev(sbi);
 
 		err = path_lookup(path, LOOKUP_PARENT, &nd);
 		if (err)
 			goto out;
 
-		err = autofs_dev_ioctl_find_super(&nd, devid);
+		err = autofs_dev_ioctl_find_super(&nd, dev);
 		if (err)
 			goto out_release;
 
-		devid = autofs4_get_dev(sbi);
+		devid = dev;
 
 		err = have_submounts(nd.path.dentry);
 

