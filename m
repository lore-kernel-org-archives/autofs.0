From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix fix symlinks arent checked for expiry
Date: Tue, 24 Dec 2013 17:44:59 +0800
Message-ID: <20131224094459.20051.4889.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=6BW1NXrcCeKWckhK5r7jtEx
	OWJE=; b=UuAn23Ynyg9DsRus0qBQEPfSI/K7bCdQ6AfZua0I2Jz+bCBKjmvYq2W
	uoing/+SyIaGDpxVpV+nsSJ0xX+qO1iN0l9qAbhXpu1LMQOKzDynUfYRPVFMO5Hm
	JoiRJX9Z9aFtNfwkfsPY4iJgGkCVqgue9ooZgZt+FJdgKp6sLQgc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=6BW1NXrcCeKWckhK5r7jtExOWJE=; b=tVxcIXdLYkT57w2vOjEAGIwthqJH
	X7ibEd1DIWGRZp0vTp6ZDb5pa31qHjvQwqbvtywOPsLosuVBJJfFnTNwifdqJWF3
	AyWmeM2sp0BlVOQJRrmP8ceHWGvVsRdr98d7MGwCbk8h6nOrYIW1b3o2zRkc60qJ
	YycddLnWQMRq/FA=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

When following a symlink the last_used counter is unconditionally
updated causing the expire checks from user space to prevent
expiry. Opps!

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/symlink.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/symlink.c b/fs/autofs4/symlink.c
index 061a692..1e8ea19 100644
--- a/fs/autofs4/symlink.c
+++ b/fs/autofs4/symlink.c
@@ -14,8 +14,9 @@
 
 static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
-	if (ino)
+	if (ino && !autofs4_oz_mode(sbi))
 		ino->last_used = jiffies;
 	nd_set_link(nd, dentry->d_inode->i_private);
 	return NULL;

