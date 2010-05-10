From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4-2.6.34-rc1 - fix link_count usage
Date: Mon, 10 May 2010 16:46:08 +0800
Message-ID: <20100510084603.26099.56481.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, autofs mailing list <autofs@linux.kernel.org>

Following the commit below in 2.6.34-rc1 autofs direct mounts stop
working. This is caused by current->link_count being 0 when
->follow_link() is called from do_filp_open().

I can't work out why this hasn't been seen before Als patch series.

This patch removes the autofs dependence on current->link_count.

1f36f774b22a0ceb7dd33eca626746c81a97b6a5 is the first bad commit
commit 1f36f774b22a0ceb7dd33eca626746c81a97b6a5
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sat Dec 26 10:56:19 2009 -0500

    Switch !O_CREAT case to use of do_last()

    ... and now we have all intents crap well localized

    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

:040000 040000 53c1effc5b22746bb83cdbc6a419bf898067882d 9606f7275fde188a056fd174aa1d622ac0630893 M	fs

Signed-off-by: Ian Kent <raven@themaw.net>
---

 fs/autofs4/root.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 109a6c6..e8e5e63 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -177,8 +177,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 		}
 	/* Trigger mount for path component or follow link */
 	} else if (ino->flags & AUTOFS_INF_PENDING ||
-			autofs4_need_mount(flags) ||
-			current->link_count) {
+			autofs4_need_mount(flags)) {
 		DPRINTK("waiting for mount name=%.*s",
 			dentry->d_name.len, dentry->d_name.name);
 
@@ -262,7 +261,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 		spin_unlock(&dcache_lock);
 		spin_unlock(&sbi->fs_lock);
 
-		status = try_to_fill_dentry(dentry, 0);
+		status = try_to_fill_dentry(dentry, nd->flags);
 		if (status)
 			goto out_error;
 
