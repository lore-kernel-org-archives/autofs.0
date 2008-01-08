From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Kernel patch to better support bind-mounts
Date: Tue, 08 Jan 2008 11:38:17 +0100
Message-ID: <1199788697.26268.24.camel@srss>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hi!

Ian, you made a patch for our problem here late laste year that didn't
quite work for all of our cases. I don't really understand the code in
the kernel module, but logic tells me that this patch should be safe.
Plus, it's solving our problems and is straightforward. Your patch was:

diff -up linux-2.6.21/fs/autofs4/root.c.lookup_access-intent linux-2.6.21/fs/autofs4/root.c
--- linux-2.6.21/fs/autofs4/root.c.lookup_access-intent 2007-10-11 16:32:07.000000000 +0800
+++ linux-2.6.21/fs/autofs4/root.c      2007-10-11 16:34:59.000000000 +0800
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
-       lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+       lookup_type = nd->flags & DIRECT_TRIGGER_FLAGS;
        if (oz_mode || !lookup_type)
                goto done;


This helps for a map like this:

eclipse-3.1 \
  /bin          -rw,nosuid,grpid          fileserver:/volumes/vol1/eclipse-3.1/bin.linx86
eclipse \
  /bin          -rw,nosuid,grpid          :/vol/eclipse-3.1/bin

Accessing /vol/eclipse/bin now works flawlessly. But given this map:

jdk-1.5.13 -rw,nosuid,grpid fileserver:/export/stud/vol/jdk-1.5.13/linx86
jdk-1.5    -rw,nosuid,grpid :/vol/jdk-1.5.13

accessing /vol/jdk-1.5 doesn't work always (ie only when /vol/jdk-1.5.13
was accessed first). I changed the patch to the one below, and this
problem is now also fixed.

Ian, can you comment on the sanity of this one? If it's OK, I'd like to
see it pushed upstream. We're building our own kernel anyway now (had
known large-scale linux was so damn difficult I bet I wouldn't have
started in the first plate), but it would be nice to see upstream.


-- 
Lukas


diff -ru linux-2.6-2.6.23-a/fs/autofs4/root.c linux-2.6-2.6.23/fs/autofs4/root.c
--- linux-2.6-2.6.23-a/fs/autofs4/root.c        2007-11-30 16:20:33.000000000 +0100
+++ linux-2.6-2.6.23/fs/autofs4/root.c  2007-11-30 16:22:24.000000000 +0100
@@ -19,6 +19,9 @@
 #include <linux/time.h>
 #include "autofs_i.h"

+#define DIRECT_TRIGGER_FLAGS (LOOKUP_CONTINUE|LOOKUP_DIRECTORY|LOOKUP_ACCESS)
+
+
 static int autofs4_dir_symlink(struct inode *,struct dentry *,const char *);
 static int autofs4_dir_unlink(struct inode *,struct dentry *);
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
@@ -291,7 +294,7 @@
                        return status;
                }
        /* Trigger mount for path component or follow link */
-       } else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
+       } else if (flags & DIRECT_TRIGGER_FLAGS ||
                        current->link_count) {
                DPRINTK("waiting for mount name=%.*s",
                        dentry->d_name.len, dentry->d_name.name);
@@ -335,7 +338,7 @@
                nd->flags);

        /* If it's our master or we shouldn't trigger a mount we're done */
-       lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+       lookup_type = nd->flags & DIRECT_TRIGGER_FLAGS;
        if (oz_mode || !lookup_type)
                goto done;
