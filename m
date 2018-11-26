From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] autofs: drop dentry reference only when it is never used
Date: Mon, 26 Nov 2018 09:58:14 +0800
Message-ID: <1543197494-15688-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=buvgAOLwqloDZN9VvB
        9AgWN/CLf0MdCHRVAHlRRuGsI=; b=kPXTuxwzDntOWfqBCGfz3LhHGFyOauA+Av
        IU/iMPUHF3Pviap2/ixs9Yr/e5CgXWPWnAsSaIqkfWsHIsKf6ozQQeI0OCQNRwG9
        SwievB5I+sqi//2IiALFwcADPezcfNifW4uIU2WPMZjpmGuAzZQOT2WSV1HlQbZz
        /xKlLWAqQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>

The function autofs_expire_run calls dput(dentry) to drop the reference
count of dentry. However, dentry is read via autofs_dentry_ino(dentry)
after that. This may result in a use-free-bug. The patch drops the
reference count of dentry only when it is never used.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/autofs/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244..28d9c2b 100644
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
 
-- 
2.7.4


