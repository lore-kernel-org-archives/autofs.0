From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/3] autofs: drop dentry reference only when it is never used
Date: Sat, 12 Jan 2019 08:00:24 +0800
Message-ID: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Pan Bian <bianpan2016@163.com>

From: Pan Bian <bianpan2016@163.com>

The function autofs_expire_run calls dput(dentry) to drop the reference
count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
after that. This may result in a use-free-bug. The patch drops the
reference count of dentry only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244b79df..28d9c2b1b3bb 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -596,7 +596,6 @@ int autofs_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if (copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)))
 		ret = -EFAULT;
@@ -609,6 +608,8 @@ int autofs_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 

