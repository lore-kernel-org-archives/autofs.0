From: Joe Perches <joe@perches.com>
Subject: [PATCH 54/62] fs/autofs/dirhash.c: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:26:59 -0700
Message-ID: <4a9aa1ca3ca167d2bb45515d61e9f88b7e0c0e78.1246173683.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760112AbZF1Qlb@vger.kernel.org>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, autofs@linux.kernel.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/autofs/dirhash.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/autofs/dirhash.c b/fs/autofs/dirhash.c
index 2316e94..e947915 100644
--- a/fs/autofs/dirhash.c
+++ b/fs/autofs/dirhash.c
@@ -90,7 +90,7 @@ struct autofs_dir_ent *autofs_expire(struct super_block *sb,
 			DPRINTK(("autofs: not expirable (not a mounted directory): %s\n", ent->name));
 			continue;
 		}
-		while (d_mountpoint(path.dentry) && follow_down(&path));
+		while (d_mountpoint(path.dentry) && follow_down(&path))
 			;
 		umount_ok = may_umount(path.mnt);
 		path_put(&path);
-- 
1.6.3.1.10.g659a0.dirty
