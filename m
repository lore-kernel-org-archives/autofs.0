From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - need to invalidate children on tree mount expire
Date: Mon, 12 Jun 2006 14:52:45 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606121427080.9538@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

I've found a case where invalid dentrys in a mount tree, waiting to be 
cleaned up by d_invalidate, prevent the expected expire.

In this case dentrys created during a lookup for which a mount fails or 
has no entry in the mount map contribute to the d_count of the parent 
dentry. These dentrys may not be invalidated prior to comparing the 
interanl usage count of valid autofs dentrys against the dentry d_count 
which makes a mount tree appear busy so it doesn't expire.

Signed-off-by: Ian Kent <raven@themaw.net>

--

--- linux-2.6.17-rc6-mm2/fs/autofs4/expire.c.need-invalidate-on-tree-expire	2006-06-12 14:24:21.000000000 +0800
+++ linux-2.6.17-rc6-mm2/fs/autofs4/expire.c	2006-06-12 14:24:36.000000000 +0800
@@ -174,6 +174,12 @@ static int autofs4_tree_busy(struct vfsm
 			struct autofs_info *ino = autofs4_dentry_ino(p);
 			unsigned int ino_count = atomic_read(&ino->count);
 
+			/*
+			 * Clean stale dentries below that have not been
+			 * invalidated after a mount fail during lookup
+			 */
+			d_invalidate(p);
+
 			/* allow for dget above and top is already dgot */
 			if (p == top)
 				ino_count += 2;
