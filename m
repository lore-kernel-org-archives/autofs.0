From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - zero timeout prevents shutdown
Date: Tue, 19 Sep 2006 11:48:15 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

If the timeout of an autofs mount is set to zero then umounts
are disabled. This works fine, however the kernel module checks
the expire timeout and goes no further if it is zero. This is
not the right thing to do at shutdown as the module is passed
an option to expire mounts regardless of their timeout setting.

This patch allows autofs to honor the force expire option.

Signed-off-by: Ian Kent <raven@themaw.net>

---

--- linux-2.6.18-rc6-mm2/fs/autofs4/expire.c.zero-timeout	2006-09-14 10:25:55.000000000 +0800
+++ linux-2.6.18-rc6-mm2/fs/autofs4/expire.c	2006-09-14 10:37:54.000000000 +0800
@@ -32,7 +32,7 @@ static inline int autofs4_can_expire(str
 
 	if (!do_now) {
 		/* Too young to die */
-		if (time_after(ino->last_used + timeout, now))
+		if (!timeout || time_after(ino->last_used + timeout, now))
 			return 0;
 
 		/* update last_used here :-
@@ -253,7 +253,7 @@ static struct dentry *autofs4_expire_dir
 	struct dentry *root = dget(sb->s_root);
 	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 
-	if (!sbi->exp_timeout || !root)
+	if (!root)
 		return NULL;
 
 	now = jiffies;
@@ -293,7 +293,7 @@ static struct dentry *autofs4_expire_ind
 	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 	int exp_leaves = how & AUTOFS_EXP_LEAVES;
 
-	if ( !sbi->exp_timeout || !root )
+	if (!root)
 		return NULL;
 
 	now = jiffies;
