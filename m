From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - autofs4_follow_link false negative fix
Date: Mon, 21 Aug 2006 12:00:04 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608211149230.24684@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeff Moyer <jmoyer@redhat.com>


Hi Andrew,

The check for an empty directory in the autofs4_follow_link method fails 
occassionally due to old dentrys. We had the same problem 
autofs4_revalidate ages ago. I thought we wouldn't need this in 
autofs4_follow_link, silly me.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

-- 

--- linux-2.6.18-rc4-mm1/fs/autofs4/root.c.follow_link-false-negative	2006-08-14 10:13:59.000000000 +0800
+++ linux-2.6.18-rc4-mm1/fs/autofs4/root.c	2006-08-14 10:15:26.000000000 +0800
@@ -359,7 +359,7 @@ static void *autofs4_follow_link(struct 
 	 * don't try to mount it again.
 	 */
 	spin_lock(&dcache_lock);
-	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
+	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
 		spin_unlock(&dcache_lock);
 
 		status = try_to_fill_dentry(dentry, 0);
