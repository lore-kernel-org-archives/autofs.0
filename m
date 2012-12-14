From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - use simple_empty() for empty directory check
Date: Fri, 14 Dec 2012 10:23:29 +0800
Message-ID: <20121214022328.2969.56282.stgit@perseus.themaw.net>
References: <20121214022323.2969.31644.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=from
	:subject:to:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=n0EfwdDr2pEjlklUnqB0PJx+OV8=; b=lYSk/FzNSoolKJqB8XgMdvvExj9H
	LnBl2KVwceFASmMelHsoAO0I9tATfuFUtnHc8n/7zuupGkrvy6r7eD6X9b0BR+Uw
	D+rhUM1W/drtumoOgTYqo/5L3Dsz30bNJn/rvAB5pZINO107FuM4Y9uIsF/QQB5a
	N0r5qo7M7+T66X4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:subject:to:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=n0EfwdDr2pEjlklUnqB0PJ
	x+OV8=; b=tat0HLw6TBa5xz/Xsbg2YY4WFDIFt6OyUBfUhULeI1LtyDiG/wmUuJ
	3vgBMF0cHjSn7lPi5tz2/FTrXOiZx6bNtNZoEXpPk2HLR9QIoSbYfm4dy0wjUMuw
	d81Ha87gkZyQjM+G7XBHQspnP4P/HHC83fFfS/CSUZFPJK38xlAF8=
In-Reply-To: <20121214022323.2969.31644.stgit@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>

For direct (and offset) mounts, if an automounted mount is manually
umounted the trigger mount dentry can appear non-empty causing it to
not trigger mounts. This can also happen if there is a file handle
leak in a user space automounting application.

This happens because, when a ioctl control file handle is opened
on the mount, a cursor dentry is created which causes list_empty()
to see the dentry as non-empty. Since there is a case where listing
the directory of these dentrys is needed, the use of dcache_dir_*()
functions for .open() and .release() is needed.

Consequently simple_empty() must be used instead of list_empty()
when checking for an empty directory.

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/root.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 30a6ab66..c934476 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -124,13 +124,10 @@ static int autofs4_dir_open(struct inode *inode, struct file *file)
 	 * it.
 	 */
 	spin_lock(&sbi->lookup_lock);
-	spin_lock(&dentry->d_lock);
-	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
-		spin_unlock(&dentry->d_lock);
+	if (!d_mountpoint(dentry) && simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOENT;
 	}
-	spin_unlock(&dentry->d_lock);
 	spin_unlock(&sbi->lookup_lock);
 
 out:
@@ -386,12 +383,8 @@ static struct vfsmount *autofs4_d_automount(struct path *path)
 				goto done;
 			}
 		} else {
-			spin_lock(&dentry->d_lock);
-			if (!list_empty(&dentry->d_subdirs)) {
-				spin_unlock(&dentry->d_lock);
+			if (!simple_empty(dentry))
 				goto done;
-			}
-			spin_unlock(&dentry->d_lock);
 		}
 		ino->flags |= AUTOFS_INF_PENDING;
 		spin_unlock(&sbi->fs_lock);
@@ -610,9 +603,7 @@ static int autofs4_dir_unlink(struct inode *dir, struct dentry *dentry)
 
 	spin_lock(&sbi->lookup_lock);
 	__autofs4_add_expiring(dentry);
-	spin_lock(&dentry->d_lock);
-	__d_drop(dentry);
-	spin_unlock(&dentry->d_lock);
+	d_drop(dentry);
 	spin_unlock(&sbi->lookup_lock);
 
 	return 0;
@@ -683,15 +674,12 @@ static int autofs4_dir_rmdir(struct inode *dir, struct dentry *dentry)
 		return -EACCES;
 
 	spin_lock(&sbi->lookup_lock);
-	spin_lock(&dentry->d_lock);
-	if (!list_empty(&dentry->d_subdirs)) {
-		spin_unlock(&dentry->d_lock);
+	if (!simple_empty(dentry)) {
 		spin_unlock(&sbi->lookup_lock);
 		return -ENOTEMPTY;
 	}
 	__autofs4_add_expiring(dentry);
-	__d_drop(dentry);
-	spin_unlock(&dentry->d_lock);
+	d_drop(dentry);
 	spin_unlock(&sbi->lookup_lock);
 
 	if (sbi->version < 5)

