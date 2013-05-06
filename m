From: Ian Kent <raven@themaw.net>
Subject: [REPOST PATCH] autofs - fix sparse warning for autofs4_d_manage()
Date: Mon, 06 May 2013 13:47:16 +0800
Message-ID: <20130506054716.6004.92087.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=Q9bvUuWf6y2sjiFu+tCew0B
	gMxM=; b=FTwVzH9oqaSKm4lhSUniTIqvT1IwDuCwmL1XTQSyAWM1SS7zmY0tx1w
	udSwvZorQx+k7t63Qk1K/UlJZczUqmeQ0YMN5fC4H0yzqjUbTW0cPAikPodGUFQq
	6108FXml9hznNRA10j0MqxrCo8VyYTeqTEAKfoVaNebQHTfAlUTQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=Q9bvUuWf6y2sjiFu+tCew0BgMxM=; b=cdyOpVZ26kXrkUb6VybaFkAg5FXe
	bBmv5rZlChTbGnpHE8kFMw3lmGJrUFpvDxDrgj+VTDRKPzKh8AwZFk99LAD2XX5a
	RMfbHnV1i3EOwkZo66ZRAU68K5LamP4TGB6FP0LzenfPj72IekwfaxwtfziPZUFD
	d5KU+aOqwVR/j3I=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Claudiu Ghioc <claudiughioc@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

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

