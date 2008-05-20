From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Kernel Patch to support nested bind mounts
Date: Tue, 20 May 2008 16:24:53 +0200
Message-ID: <1211293493.5073.17.camel@srss>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian, list,

this is just a ping to remind you of this little patch. It still applies
to the latest kernel source, and it still fixes our problems we have
with nested mount maps such as (taken from the map for /vol/):


eclipse-3.2 \
  /bin          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/bin/linx86 \
  /include      -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/include \
  /lib          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/lib/linx86 \
  /man          -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/man \
  /share        -rw,nosuid          fileserver:/export/stud/vol/eclipse-3.2/share

eclipse \
  /bin          -rw,nosuid          :/vol/eclipse-3.2/bin \
  /include      -rw,nosuid          :/vol/eclipse-3.2/include \
  /lib          -rw,nosuid          :/vol/eclipse-3.2/lib \
  /man          -rw,nosuid          :/vol/eclipse-3.2/man \
  /share        -rw,nosuid          :/vol/eclipse-3.2/share \

and:

jdk             -rw,nosuid          :/vol/jdk-1.6
jdk-1.6         -rw,nosuid          :/vol/jdk-1.6.6
jdk-1.6.6       -rw,nosuid          fileserver:/export/stud/vol/jdk-1.6.6/linx86


We're running this since quite a while, and have not encountered any
serious problems since then. Home's and volumes get unmounted as they
should, and (even more important) accessing /vol/jdk or /vol/eclipse/bin
now actually works (it did _not_ without the patch).

I'm just tired of constantly rebuilding distribution kerneles :)

-- 
Lukas


patch:

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
