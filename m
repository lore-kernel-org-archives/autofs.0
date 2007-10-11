From: Ian Kent <raven@themaw.net>
Subject: Re: nested automounts: bind and nfs
Date: Thu, 11 Oct 2007 16:45:41 +0800
Message-ID: <1192092341.3114.38.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
	<1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192034852.3151.21.camel@raven.themaw.net>
	<1192035764.20253.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192035764.20253.5.camel@localhost>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Wed, 2007-10-10 at 19:02 +0200, Lukas Kolbe wrote:
> Hello Ian,
> 
> > Sure, this may not be the only problem but, having been involved in
> > discussions about this a few times over the last year I'm pretty sure
> > there is also a race in the NFS client kernel code of the kernel you are
> > using.
> > 
> > I'll have a look at the log and the map your using and try and reproduce
> > what your seeing.
> 
> Thank you very much, I look forward to your findings. If you think it's
> a bug in either the kernel or util-linux or nfs-utils, I'll ponder the
> distributor from now on.

Congratulations Lucas you've managed to create an autofs map that the
current autofs4 kernel module can't handle, well done.

I'll try to explain, but I can't be sure I'll be very clear.

First a little history.

Over time a mechanism of VFS operation intents has been added to the
kernel VFS. During the version 5 development (and in particular the
direct and offset mounts, the mount triggers you see mounted in the log)
I felt that I would need to handle these but in the end it appeared I
could do everything I needed without checking for them.

Now the problem.

To deal with the case we have here I need to check for the LOOKUP_ACCESS
intent in the kernel module method that deals with catching mount
requests for the mount triggers during path lookup.

The solution is fairly simple, as you can see from the patch below but
it begs the question "will this also catch stuff that it shouldn't
catch" so I need to continue testing it. 

The patch below should apply ok to most kernels you're using as there
haven't been changes in this area for quite a while. It would be good if
you could test this out and see if you observe any other side effects.

Ian

---
diff -up linux-2.6.21/fs/autofs4/root.c.lookup_access-intent linux-2.6.21/fs/autofs4/root.c
--- linux-2.6.21/fs/autofs4/root.c.lookup_access-intent	2007-10-11 16:32:07.000000000 +0800
+++ linux-2.6.21/fs/autofs4/root.c	2007-10-11 16:34:59.000000000 +0800
@@ -20,6 +20,8 @@
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
+#define DIRECT_TRIGGER_FLAGS (LOOKUP_CONTINUE|LOOKUP_DIRECTORY|LOOKUP_ACCESS)
+
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
@@ -336,7 +338,7 @@ static void *autofs4_follow_link(struct 
 		nd->flags);
 
 	/* If it's our master or we shouldn't trigger a mount we're done */
-	lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+	lookup_type = nd->flags & DIRECT_TRIGGER_FLAGS;
 	if (oz_mode || !lookup_type)
 		goto done;
