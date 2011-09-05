From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH] vfs: automount should ignore LOOKUP_FOLLOW
Date: Mon, 05 Sep 2011 19:02:00 +0200
Message-ID: <87hb4q9b3r.fsf@tucsk.pomaz.szeredi.hu>
References: <87liu37z3x.fsf@tucsk.pomaz.szeredi.hu>
	<17416.1315240659@redhat.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yG8TW71mho+DHWVJ31vjI0V28dVG4wJ0kvSeIv1NNiw=;
        b=IaGq/3dJ1X+9RnNyXYsMK+pi5NoRdkHuvDpkZfLSJAV65AkSs6hpYxzS4UgrQ0GOpu
         7DCWt9M1OPOl9fWfQ43eFHg48/hsY3enyrvyqWVQEmQEr3cWteMm11HUruXRUEExoMKf
         NUsSpmRi6v7gH5Y2YdRhV6Q0z690GX9d5QTNk=
In-Reply-To: <17416.1315240659@redhat.com> (David Howells's message of "Mon,
	05 Sep 2011 17:37:39 +0100")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Leonardo Chiquitto <leonardo.lists@gmail.com>, Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, autofs@linux.kernel.org

David Howells <dhowells@redhat.com> writes:

> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
>> After 2.6.38, with the introduction of the ->d_automount()
>> infrastructure, stat(2) and others would start triggering automount
>> while lstat(2), etc. still would not.  This is a regression and a
>> userspace ABI change.
>
> It doesn't necessarily mean it's wrong.  The main class of program that needs
> to be prevented from automounting are things that do bulk stat'ing (e.g. ls) -
> and they should probably be doing lstat() anyway.

Yeah, some of those uses are probably minor bugs in userspace, but there are
probably many of them (Leonardo reported that for example Nautilus also
triggers all child automounts in a directory).  So I don't think it's OK to
just change the behavior here.

If automounting on lstat(2) is the correct behavior (is it?  why?)  then at
least it should be enabled by a global switch or mount option, IMO.

>
>> +	/* We don't want to mount if someone's just doing a stat -
>> +	 * unless they're stat'ing a directory and appended a '/' to
>> +	 * the name.
>
> Btw, line length is 80 chars.  This comment could easily use one fewer line.
>
> If you use emacs you can do:
>
> 	ESC 7 9 C-x f
>
> to set the right margin and then:
>
> 	M-q
>
> whilst the cursor is in the comment paragraph to be rearranged and it will
> 'fill' the paragraph to 79 characters.

Cool.  Updated patch below.

Thanks,
Miklos
----


Subject: vfs: automount should ignore LOOKUP_FOLLOW

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
 fs/namei.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

Index: linux-2.6/fs/namei.c
===================================================================
--- linux-2.6.orig/fs/namei.c	2011-09-05 18:01:59.000000000 +0200
+++ linux-2.6/fs/namei.c	2011-09-05 18:51:25.000000000 +0200
@@ -727,25 +727,21 @@ static int follow_automount(struct path
 	if ((flags & LOOKUP_NO_AUTOMOUNT) && !(flags & LOOKUP_PARENT))
 		return -EISDIR; /* we actually want to stop here */
 
-	/*
-	 * We don't want to mount if someone's just doing a stat and they've
-	 * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
-	 * appended a '/' to the name.
+	/* We don't want to mount if someone's just doing a stat - unless
+	 * they're stat'ing a directory and appended a '/' to the name.
+	 *
+	 * We do, however, want to mount if someone wants to open or create a
+	 * file of any type under the mountpoint, wants to traverse through the
+	 * mountpoint or wants to open the mounted directory.  Also, autofs may
+	 * mark negative dentries as being automount points.  These will need
+	 * the attentions of the daemon to instantiate them before they can be
+	 * used.
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
