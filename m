From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Kernel patch to better support bind-mounts
Date: Tue, 04 Mar 2008 13:47:52 +0100
Message-ID: <1204634872.11825.79.camel@srss>
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

Hi Ian!

Ping? :)

We use this patch now for several servers and clients (debian etch with
2.6.18, ubuntu feisty with 2.6.20 and some test systems with 2.6.23),
and have seen no regression so far, only working automounts :)
I'd love to see this change upstream, so that I don't have to worry
about constantly patching my own kernel anymore :)

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
