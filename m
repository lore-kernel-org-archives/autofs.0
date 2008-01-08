From: Ian Kent <raven@themaw.net>
Subject: Re: Kernel patch to better support bind-mounts
Date: Tue, 08 Jan 2008 22:21:48 +0900
Message-ID: <1199798508.3155.48.camel@raven.themaw.net>
References: <1199788697.26268.24.camel@srss>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1199788697.26268.24.camel@srss>
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


On Tue, 2008-01-08 at 11:38 +0100, Lukas Kolbe wrote:
> Hi!
> 
> Ian, you made a patch for our problem here late laste year that didn't
> quite work for all of our cases. I don't really understand the code in
> the kernel module, but logic tells me that this patch should be safe.
> Plus, it's solving our problems and is straightforward. Your patch was:

Sure, but you'll need to give me a while to re-familiarize myself with
the history and think about it for a while.

The only real issue here is the question of whether we will trigger
mounts when they shouldn't be. Which can lead to mount storms in
unexpected ways, but then I seem to remember that this change was needed
due to changes in the way the kernel does it's lookups.

> 
> diff -up linux-2.6.21/fs/autofs4/root.c.lookup_access-intent linux-2.6.21/fs/autofs4/root.c
> --- linux-2.6.21/fs/autofs4/root.c.lookup_access-intent 2007-10-11 16:32:07.000000000 +0800
> +++ linux-2.6.21/fs/autofs4/root.c      2007-10-11 16:34:59.000000000 +0800
> @@ -20,6 +20,8 @@
>  #include <linux/smp_lock.h>
>  #include "autofs_i.h"
>  
> +#define DIRECT_TRIGGER_FLAGS (LOOKUP_CONTINUE|LOOKUP_DIRECTORY|LOOKUP_ACCESS)
> +
>  static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
>  static int autofs4_dir_unlink(struct inode *,struct dentry *);
>  static int autofs4_dir_rmdir(struct inode *,struct dentry *);
> @@ -336,7 +338,7 @@ static void *autofs4_follow_link(struct 
>                 nd->flags);
>  
>         /* If it's our master or we shouldn't trigger a mount we're done */
> -       lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
> +       lookup_type = nd->flags & DIRECT_TRIGGER_FLAGS;
>         if (oz_mode || !lookup_type)
>                 goto done;
> 
> 
> This helps for a map like this:
> 
> eclipse-3.1 \
>   /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86
> eclipse \
>   /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin

Mounts for these multiple offsets are triggered in the same way as
direct mounts, they are triggered when autofs4_follow_link is called by
the VFS.

> 
> Accessing /vol/eclipse/bin now works flawlessly. But given this map:
> 
> jdk-1.5.13 -rw,nosuid,grpid fileserver:/export/stud/vol/jdk-1.5.13/linx86
> jdk-1.5    -rw,nosuid,grpid :/vol/jdk-1.5.13

But these are indirect mounts and they are triggered by calling either
autofs4_lookup or autofs4_revalidate and then indirectly
try_to_fill_dentry, which is where you added the change I think.

What kernel version is this patch against?

Ian
