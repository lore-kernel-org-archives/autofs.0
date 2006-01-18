From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - fix typo in expire-not-busy-only patch
Date: Wed, 18 Jan 2006 18:11:32 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0601181807480.9142@eagle.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Sorry, this error got through.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc1/fs/autofs4/expire.c.expire-not-busy-only-fix	2006-01-18 17:55:15.000000000 +0800
+++ linux-2.6.16-rc1/fs/autofs4/expire.c	2006-01-18 17:56:28.000000000 +0800
@@ -255,11 +255,11 @@ static struct dentry *autofs4_expire(str
 				dentry, (int)dentry->d_name.len, dentry->d_name.name);
 
 			/* Can we umount this guy */
-			if (autofs4_mount_busy(mnt, dentry)) {
+			if (autofs4_mount_busy(mnt, dentry))
 				goto next;
 
 			/* Can we expire this guy */
-			if (autofs4_can_expire(dentry, timeout, do_now))
+			if (autofs4_can_expire(dentry, timeout, do_now)) {
 				expired = dentry;
 				break;
 			}

