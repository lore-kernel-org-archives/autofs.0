From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/5] autofs-5.0.3 - don't abuse the ap->ghost field
	on NFS	mount
Date: Thu, 12 Jun 2008 13:04:45 +0800
Message-ID: <20080612050445.27161.71736.stgit@raven.themaw.net>
References: <20080612045519.27161.92549.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612045519.27161.92549.stgit@raven.themaw.net>
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

autofs-5.0.3-dont-abuse-ap-ghost-field.patch

Using the ap->ghost field in the autofs mount point struct, to prevent
the mount point directory from being removed, when attempting a bind
mount when an NFS mount is local may lead to incorrectly reading and
ghosting the map. This can happen if a mount request comes in during
a map re-read when the autofs map doesn't have the browse option set.
This patch corrects that by using the existence check in the bind mount
module instead of the hack of changing the struct field.

---

 modules/mount_bind.c |    2 +-
 modules/mount_nfs.c  |   11 -----------
 2 files changed, 1 insertions(+), 12 deletions(-)


diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index ef973e1..e4a04d0 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -144,7 +144,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			if (ap->type != LKP_INDIRECT)
 				return 1;
 
-			if ((!ap->ghost && name_len) || !existed)
+			if ((!ap->ghost && name_len) && !existed)
 				rmdir_path(ap, fullpath, ap->dev);
 
 			return err;
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 0e7aebe..6b612d9 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -62,7 +62,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 {
 	char *fullpath, buf[MAX_ERR_BUF];
 	struct host *this, *hosts = NULL;
-	unsigned int save_ghost = ap->ghost;
 	unsigned int vers;
 	char *nfsoptions = NULL;
 	int len, rlen, status, err, existed = 1;
@@ -186,13 +185,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	if (!status)
 		existed = 0;
 
-	/*
-	 * We need to stop the bind mount module from removing the
-	 * mount point directory if a bind attempt fails so abuse
-	 * the ap->ghost field for this.
-	 */
-	ap->ghost = 1;
-
 	this = hosts;
 	while (this) {
 		char *loc, *port_opt = NULL;
@@ -229,7 +221,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			/* Success - we're done */
 			if (!err) {
 				free_host_list(&hosts);
-				ap->ghost = save_ghost;
 				return 0;
 			}
 
@@ -271,7 +262,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			info(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
 			free(loc);
 			free_host_list(&hosts);
-			ap->ghost = save_ghost;
 			return 0;
 		}
 
@@ -281,7 +271,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 forced_fail:
 	free_host_list(&hosts);
-	ap->ghost = save_ghost;
 
 	/* If we get here we've failed to complete the mount */
