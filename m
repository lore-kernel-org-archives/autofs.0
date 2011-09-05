From: Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Mon, 05 Sep 2011 18:06:26 +0200
Message-ID: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:subject:cc:date:message-id:user-agent:mime-version
         :content-type;
        bh=gQTU3c8hk2q3g9F3qAq6rFlbNyTbMlLqqKX7VblnFVA=;
        b=BrTCQ/YKS6rjaBzw0kwabESCvO5AEq4SO+BM412iAwFECaAmYoOd++VYdZRWSMF0QF
         XZ7/fV5zkoNfF9h1KbjdBafNTqh/hz6cGGyHj8lRbf9Ss15NHYe5PXTg4rXBT+at89zB
         CW9mLMVEQjLyi0E0ZTe6O/DZmmDarmd1KYGCU=
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Leonardo Chiquitto <leonardo.lists@gmail.com>, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

From: Miklos Szeredi <mszeredi@suse.cz>

Prior to 2.6.38 automount would not trigger on either stat(2) or
lstat(2) on the automount point.

After 2.6.38, with the introduction of the ->d_automount()
infrastructure, stat(2) and others would start triggering automount
while lstat(2), etc. still would not.  This is a regression and a
userspace ABI change.

Problem originally reported here:

  http://thread.gmane.org/gmane.linux.kernel.autofs/6098

It appears that there was an attempt at fixing various userspace tools
to not trigger the automount.  But since the stat system call is
rather common it is impossible to "fix" all userspace.

This patch reverts the original behavior, which is to not trigger on
stat(2) and other symlink following syscalls.

Reported-by: Leonardo Chiquitto <leonardo.lists@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
CC: David Howells <dhowells@redhat.com>
CC: Ian Kent <raven@themaw.net>
CC: stable@kernel.org
---
 fs/namei.c |   33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

Index: linux-2.6/fs/namei.c
===================================================================
--- linux-2.6.orig/fs/namei.c	2011-09-05 14:37:25.000000000 +0200
+++ linux-2.6/fs/namei.c	2011-09-05 17:31:14.000000000 +0200
@@ -727,25 +727,22 @@ static int follow_automount(struct path
 	if ((flags & LOOKUP_NO_AUTOMOUNT) && !(flags & LOOKUP_PARENT))
 		return -EISDIR; /* we actually want to stop here */
 
-	/*
-	 * We don't want to mount if someone's just doing a stat and they've
-	 * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
-	 * appended a '/' to the name.
+	/* We don't want to mount if someone's just doing a stat -
+	 * unless they're stat'ing a directory and appended a '/' to
+	 * the name.
+	 *
+	 * We do, however, want to mount if someone wants to open or
+	 * create a file of any type under the mountpoint, wants to
+	 * traverse through the mountpoint or wants to open the
+	 * mounted directory.  Also, autofs may mark negative dentries
+	 * as being automount points.  These will need the attentions
+	 * of the daemon to instantiate them before they can be used.
 	 */
-	if (!(flags & LOOKUP_FOLLOW)) {
-		/* We do, however, want to mount if someone wants to open or
-		 * create a file of any type under the mountpoint, wants to
-		 * traverse through the mountpoint or wants to open the mounted
-		 * directory.
-		 * Also, autofs may mark negative dentries as being automount
-		 * points.  These will need the attentions of the daemon to
-		 * instantiate them before they can be used.
-		 */
-		if (!(flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
-			     LOOKUP_OPEN | LOOKUP_CREATE)) &&
-		    path->dentry->d_inode)
-			return -EISDIR;
-	}
+	if (!(flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
+		     LOOKUP_OPEN | LOOKUP_CREATE)) &&
+	    path->dentry->d_inode)
+		return -EISDIR;
+
 	current->total_link_count++;
 	if (current->total_link_count >= 40)
 		return -ELOOP;
