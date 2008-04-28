From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/2] autofs4 - fix incorect return from root.c:try_to_fill_dentry()
Date: Mon, 28 Apr 2008 14:30:29 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0804281427050.10684@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


Hi Andrew,

Jeff Moyer has identified a case where the autofs4 function
root.c:try_to_fill_dentry() can return -EBUSY when it should return
0.

Jeffs description of the way this happens is:

"automount starts an expire for directory d.
after the callout to the daemon, but before the rmdir, another
process tries to walk into the same directory.  It puts itself
onto the waitq, pending the expiration.

When the expire finishes, the second process is woken up.  In
try_to_fill_dentry, it does this check:

                status = d_invalidate(dentry);
                if (status != -EBUSY)
                        return -EAGAIN;

And status is EBUSY.  The dentry still has a non-zero d_inode, and the
flags do not contain LOOKUP_CONTINUE or LOOKUP_DIRECTORY

So, we fall through and return -EBUSY to the caller."

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Acked-by: Ian Kent <raven@themaw.net>

Ian

---
diff -up linux-2.6.25-mm1/fs/autofs4/root.c.correct-return-in-ttfd linux-2.6.25-mm1/fs/autofs4/root.c
--- linux-2.6.25-mm1/fs/autofs4/root.c.correct-return-in-ttfd	2008-04-28 11:47:20.000000000 +0800
+++ linux-2.6.25-mm1/fs/autofs4/root.c	2008-04-28 11:48:00.000000000 +0800
@@ -245,7 +245,7 @@ static int try_to_fill_dentry(struct den
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct dentry *new;
-	int status = 0;
+	int status;
 
 	/* Block on any pending expiry here; invalidate the dentry
            when expiration is done to trigger mount request with a new
@@ -342,7 +342,7 @@ static int try_to_fill_dentry(struct den
 		}
 	}
 
-	return status;
+	return 0;
 }
 
 /* For autofs direct mounts the follow link triggers the mount */
