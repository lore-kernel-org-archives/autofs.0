From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 71/72] autofs: drop dentry reference only when it is never used
Date: Sat, 23 Feb 2019 16:04:21 -0500
Message-ID: <20190223210422.199966-71-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955997;
        bh=Z89t9QdpXqF4+TcRXl/MfORsjP6JrY8g4Bg32oSTBrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=futBeUWqHTcPPbDv0+4syvhRCmTbwhW+PrF7Ak5td0B9hihB4vWfrV+DANJ3s+z2b
         wZbYQ79FPi5arBciNNUKEhSsmrfNXjDjmmqEKxUiU3pgIuiilSZbq+7wwST1AYQEcc
         k0PpqOjSTwXQqoh5W92VaxHn//VgkYH1HEZ+JMoA=
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Pan Bian <bianpan2016@163.com>, Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, autofs@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 63ce5f552beb9bdb41546b3a26c4374758b21815 ]

autofs_expire_run() calls dput(dentry) to drop the reference count of
dentry.  However, dentry is read via autofs_dentry_ino(dentry) after
that.  This may result in a use-free-bug.  The patch drops the reference
count of dentry only when it is never used.

Link: http://lkml.kernel.org/r/154725122396.11260.16053424107144453867.stgit@pluto-themaw-net
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index d441244b79df9..28d9c2b1b3bb3 100644
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
2.19.1

