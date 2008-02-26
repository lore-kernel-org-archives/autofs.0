From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/4] autofs4 - check for invalid dentry in getpath
Date: Tue, 26 Feb 2008 12:22:34 +0900 (WST)
Message-ID: <Pine.LNX.4.64.0802261156490.8490@raven.themaw.net>
References: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0802261151400.8490@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Hi Andrew,

Patch to catch invalid dentry when calculating it's path.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

---
diff -up linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.getpath-check-valid-dentry linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c
--- linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c.getpath-check-valid-dentry	2008-02-20 12:55:39.000000000 +0900
+++ linux-2.6.25-rc2-mm1/fs/autofs4/waitq.c	2008-02-20 12:54:46.000000000 +0900
@@ -171,7 +171,7 @@ static int autofs4_getpath(struct autofs
 	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
 		len += tmp->d_name.len + 1;
 
-	if (--len > NAME_MAX) {
+	if (!len || --len > NAME_MAX) {
 		spin_unlock(&dcache_lock);
 		return 0;
 	}
