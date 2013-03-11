From: Claudiu Ghioc <claudiughioc@gmail.com>
Subject: [PATCH] fs: sparse warning fix for autofs4/root.c
Date: Mon, 11 Mar 2013 10:29:04 +0200
Message-ID: <1362990544-4365-1-git-send-email-claudiu.ghioc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=VTS6Vm2jJUZho9NewwB1S6I3+LRCB3ruELJNOPawbzs=;
        b=H3xBYu5Cto/y+926SzdFFAw2kWuZpW6LGxmYJRivDkC6F8MV30QnZ4VYHQHdfDUc0P
         bwoOY02eZYjHs+PdNCz/Dt7qOJQ7zYL3oY596JXtH8kNM4tFcsJ2XfaPtN8/shuDBLyp
         uy+c15lBL1WkiYUUVqde8FJNxze9KQcYoL8AlCjJym4+O659mNM3C2eRv6RrCKoqikKt
         /us2z2oCPl7FuEUqd/u3ZBuCC5iq89HBLIpeuNSmi9X0+xGuvJ022LWG7oEgeI6Hm6Fr
         dps8XCIiXt4W/36HmSQ0A+mLLv9d6cJMmOoBTV6/Sge08xdOBsMghdAF924TgbDRScXo
         prGw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu Ghioc <claudiu.ghioc@gmail.com>

Fixed the sparse warning:
*   "fs/autofs4/root.c:411:5: warning:
    symbol 'autofs4_d_manage' was not declared.
    Should it be static?"

Signed-off-by: Claudiu Ghioc <claudiu.ghioc@gmail.com>
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
-- 
1.7.10.4
