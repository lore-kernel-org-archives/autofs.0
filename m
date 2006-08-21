From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4 - pending flag not cleared on mount fail
Date: Mon, 21 Aug 2006 12:12:48 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608211202530.24684@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeff Moyer <jmoyer@redhat.com>


Hi Andrew,

During testing I've found that the mount pending flag can be left set at 
exit from autofs4_lookup after a failed mount request. This shouldn't be 
allowed to happen and causes incorrect error returns.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

-- 

--- linux-2.6.18-rc4-mm2/fs/autofs4/root.c.clear-pending	2006-08-20 13:20:23.000000000 +0800
+++ linux-2.6.18-rc4-mm2/fs/autofs4/root.c	2006-08-20 13:21:30.000000000 +0800
@@ -281,9 +281,6 @@ static int try_to_fill_dentry(struct den
 
 		DPRINTK("mount done status=%d", status);
 
-		if (status && dentry->d_inode)
-			return status; /* Try to get the kernel to invalidate this dentry */
-
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			spin_lock(&dentry->d_lock);
@@ -540,6 +537,9 @@ static struct dentry *autofs4_lookup(str
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
 	}
 
 	/*
