From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - fix lockref lookup
Date: Wed, 23 Apr 2014 13:20:36 +0800
Message-ID: <20140423052035.5999.69412.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=jm30FuTu4IYuy8PLxQHy1fO
	uik4=; b=Mt9zGAZ6pK6cv3WS7tTgfNdSwljENSy6JJIt/2LnDC1AOo9mphqOd7e
	xlx9ZmqUriHc05XucoM/Gl9uMuR/T/hXA9iJZZGVrrCTkcmKfYS2Y2tPfFl3vYKi
	4rXkD8MxwQstkPrpwIJjBZXehi378hJ+7SJ6V5m1VNGnkO6Xrp/0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=jm30FuTu4IYuy8PLxQHy1fOuik4=; b=rSZPuDmWu6ktxliFtG848Hzkf7jx
	4vmvhDVgEeZO6dib9/VhSSMl+vftBtVT/K5IFJGEpAJPzblmKMFNGMg7Zh0xPG6w
	mhDnZSSSuTsIlZmgFo86m37RAOZiaA8U4LfXHeMExAVCj+wHIOL4uToQicpXDisi
	0AC1t9BKYn7lteY=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

autofs needs to be able to see private data dentry flags for
its dentrys that are being created but not yet hashed and for
its dentys that have been rmdir()ed but not yet freed. It
needs to do this so it can block processes in these states
until a status has been returned to indicate the given
operation is complete.

It does this by keeping two lists, active and expring, of
dentrys in this state and uses ->d_release() to keep them
stable while it checks the reference count to determine
if they should be used.

But with the recent lockref changes dentrys being freed
sometimes don't transition to a reference count of 0 before
being freed so autofs can occassionally use a dentry that
is invalid which can lead to a panic.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/root.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 2caf36a..cc87c1a 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -179,7 +179,7 @@ static struct dentry *autofs4_lookup_active(struct dentry *dentry)
 		spin_lock(&active->d_lock);
 
 		/* Already gone? */
-		if (!d_count(active))
+		if ((int) d_count(active) <= 0)
 			goto next;
 
 		qstr = &active->d_name;
@@ -230,7 +230,7 @@ static struct dentry *autofs4_lookup_expiring(struct dentry *dentry)
 
 		spin_lock(&expiring->d_lock);
 
-		/* Bad luck, we've already been dentry_iput */
+		/* We've already been dentry_iput or unlinked */
 		if (!expiring->d_inode)
 			goto next;
 

