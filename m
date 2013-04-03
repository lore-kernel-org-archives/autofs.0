From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix sparse warning for autofs4_d_manage()
Date: Wed, 03 Apr 2013 11:09:56 +0800
Message-ID: <20130403030955.26780.24034.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=Q9bvUuWf6y2sjiFu+tCew0B
	gMxM=; b=yiV1LrSMJmrz9lkDrQiTHuAWE/R9prK28bCGTT9N7qy1XpmvjSK4jom
	A+wPhalNMMimLV78bcZqBf/+wvQ0Teu6wMt4LoLngLCM8OLgl9u9KX5wtDKpnJwf
	9bg6WszR/pQM4ynJ50E3eImKVA2VkhhIjK/1iIaHoR+l7YiQo/mo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=Q9bvUuWf6y2sjiFu+tCew0BgMxM=; b=lsUTR1VYUmtlRWPCbzTk3BjZ/B7g
	6smcrx4XRzfRXdYFK+Mon6w1+S9Y2osXuGMjhFM+Y/RQLCf9Uzxsa0p6dMBcktkk
	EV4JnS1yT3RPZatw947rgFCS63KakMNk1k9EUWksons57teldvPKaOfPuBgULJ5R
	5Zb4cWSWQNIxOic=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Claudiu Ghioc <claudiughioc@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Claudiu Ghioc <claudiughioc@gmail.com>

Fixed the sparse warning:
*   "fs/autofs4/root.c:411:5: warning:
    symbol 'autofs4_d_manage' was not declared.
    Should it be static?"

edit: imk
Clearly it should be static as the function is declared static at
the top of root.c.
end edit: imk

Signed-off-by: Claudiu Ghioc <claudiu.ghioc@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 9bd1625..085da86 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -408,7 +408,7 @@ done:
 	return NULL;
 }
 
-int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
+static int autofs4_d_manage(struct dentry *dentry, bool rcu_walk)
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);

