From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/10] autofs4 - use lookup intent flags to trigger
	mounts
Date: Thu, 12 Jun 2008 12:51:25 +0800
Message-ID: <20080612045125.25151.37880.stgit@raven.themaw.net>
References: <20080612044425.25151.58126.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612044425.25151.58126.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>

When an open(2) call is made on an autofs mount point directory that
already exists and the O_DIRECTORY flag is not used the needed mount
callback to the daemon is not done. This leads to the path walk
continuing resulting in a callback to the daemon with an incorrect
key. open(2) is called without O_DIRECTORY by the "find" utility but
this should be handled properly anyway.

This happens because autofs needs to use the lookup flags to decide
when to callback to the daemon to perform a mount to prevent mount
storms. For example, an autofs indirect mount map that has the "browse"
option will have the mount point directories are pre-created and the
stat(2) call made by a color ls against each directory will cause all
these directories to be mounted. It is unfortunate we need to resort
to this but mount maps can be quite large. Additionally, if a user
manually umounts an autofs indirect mount the directory isn't removed
which also leads to this situation.

To resolve this autofs needs to use the lookup intent flags to enable
it to make this decision. This patch adds this check and triggers a
call back if any of the lookup intent flags are set as all these calls
warrant a mount attempt be requested.

I know that external VFS code which uses the lookup flags is something
that the VFS would like to eliminate but I have no choice as I can't
see any other way to do this. A VFS dentry or inode operation callback
which returns the lookup "type" (requires a definition) would be
sufficient. But this change is needed now and I'm not aware of the form
that coming VFS changes will take so I'm not willing to propose anything
along these lines.

If anyone can provide an alternate method I would be happy to use it.

Signed-off-by: Ian Kent <raven@themaw.net>

---

 fs/autofs4/root.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)


diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 8a94717..2c878e5 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -31,6 +31,9 @@ static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t fil
 static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
 static void *autofs4_follow_link(struct dentry *, struct nameidata *);
 
+#define TRIGGER_FLAGS   (LOOKUP_CONTINUE | LOOKUP_DIRECTORY)
+#define TRIGGER_INTENTS (LOOKUP_OPEN | LOOKUP_ACCESS | LOOKUP_CREATE)
+
 const struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
@@ -291,7 +294,7 @@ static int try_to_fill_dentry(struct dentry *dentry, int flags)
 			return status;
 		}
 	/* Trigger mount for path component or follow link */
-	} else if (flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY) ||
+	} else if (flags & (TRIGGER_FLAGS | TRIGGER_INTENTS) ||
 			current->link_count) {
 		DPRINTK("waiting for mount name=%.*s",
 			dentry->d_name.len, dentry->d_name.name);
@@ -335,7 +338,7 @@ static void *autofs4_follow_link(struct dentry *dentry, struct nameidata *nd)
 		nd->flags);
 
 	/* If it's our master or we shouldn't trigger a mount we're done */
-	lookup_type = nd->flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY);
+	lookup_type = nd->flags & (TRIGGER_FLAGS | TRIGGER_INTENTS);
 	if (oz_mode || !lookup_type)
 		goto done;
