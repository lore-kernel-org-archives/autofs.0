From: Ian Kent <raven@themaw.net>
Subject: [PATCH 6/7] autofs - dont hold spin lock over direct mount expire
Date: Mon, 28 Nov 2016 10:12:14 +0800
Message-ID: <148029913453.27779.15747032937407838983.stgit@pluto.themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=5GZkY+gefQqd8DF
        LRee0OuMcLqU=; b=ht1OO+uEVYvfMcZ0oACG10Yf3IXylA7wigevczl9d6RLpJo
        j51piOnJf7yght5RU4XEO4FKLbWOWeb2wBQzvmLWNAFroMB5wH2TJcMTf4rCuhxw
        f4scVq+8FywqxvNkpwXqlRAbj2I9D5albvM3HMP7NPJm68k0NyezLqYNkUJQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=5GZkY+gefQqd8DFLRee0OuMcLqU=; b=mRVwwYBcZjZ3qQbEDYVQ
        2UzZ1Ail14WoyShtm3QQcEGJyGBexrMV3MI9tS2G7e5LLuA44pwUTRJwXJRvKP8T
        WeW6uoIzBKA1e8IpwDEeFFfdpqTVuHJpIxnuJcV+noW4xsMfcVoV8BGA39BEwM+f
        7UCLmLLJf4OCAduwo0ms2ns=
In-Reply-To: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Al Viro <viro@ZenIV.linux.org.uk>

From: Ian Kent <ikent@redhat.com>

Commit 7cbdb4a286 altered the autofs indirect mount expire to
not hold a spin lock during the expire check.

The direct mount expire needs the same treatment because to
make autofs expires namespace aware may_umount_tree() needs to
to use a similar method to may_umount() when checking if a mount
tree is in use.

This means may_umount_tree() will end up taking the namespace_sem
for the check so the autofs direct mount expire won't be allowed
to hold a spin lock over the check.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Omar Sandoval <osandov@osandov.com>
---
 fs/autofs4/expire.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 13178bf..57725d4 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -310,26 +310,29 @@ struct dentry *autofs4_expire_direct(struct super_block *sb,
 	now = jiffies;
 	timeout = sbi->exp_timeout;
 
-	spin_lock(&sbi->fs_lock);
-	ino = autofs4_dentry_ino(root);
-	/* No point expiring a pending mount */
-	if (ino->flags & AUTOFS_INF_PENDING)
-		goto out;
 	if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+		spin_lock(&sbi->fs_lock);
+		ino = autofs4_dentry_ino(root);
+		/* No point expiring a pending mount */
+		if (ino->flags & AUTOFS_INF_PENDING) {
+			spin_unlock(&sbi->fs_lock);
+			goto out;
+		}
 		ino->flags |= AUTOFS_INF_WANT_EXPIRE;
 		spin_unlock(&sbi->fs_lock);
 		synchronize_rcu();
-		spin_lock(&sbi->fs_lock);
 		if (!autofs4_direct_busy(mnt, root, timeout, do_now)) {
+			spin_lock(&sbi->fs_lock);
 			ino->flags |= AUTOFS_INF_EXPIRING;
 			init_completion(&ino->expire_complete);
 			spin_unlock(&sbi->fs_lock);
 			return root;
 		}
+		spin_lock(&sbi->fs_lock);
 		ino->flags &= ~AUTOFS_INF_WANT_EXPIRE;
+		spin_unlock(&sbi->fs_lock);
 	}
 out:
-	spin_unlock(&sbi->fs_lock);
 	dput(root);
 
 	return NULL;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
