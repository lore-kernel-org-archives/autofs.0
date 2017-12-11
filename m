From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/27] autofs-5.1.3 - fix symlink false negative in
 umount_multi()
Date: Mon, 11 Dec 2017 16:58:50 +0800
Message-ID: <151298273006.19722.14676783981342081068.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Using is_mounted() on a symlink will give a false negative for MNTS_ALL
since the kernel will return mounted true for a dentry within an autofs
mount point.

Just remove the check and rely on lstat().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG          |    1 +
 daemon/automount.c |    5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index d6016984..df87df49 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -45,6 +45,7 @@ xx/xx/2017 autofs-5.1.4
 - improve debug logging of lookup key.
 - fix typo in amd_parse.c.
 - add missing MODPREFIX to logging in amd parser.
+- fix symlink false negative in umount_multi().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index 6720bc23..d60a3d7b 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -636,10 +636,6 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 
 	debug(ap->logopt, "path %s incl %d", path, incl);
 
-	/* If path is a mount it can't be a symlink */
-	if (is_mounted(_PATH_MOUNTED, path, MNTS_ALL))
-		goto real_mount;
-
 	if (lstat(path, &st)) {
 		warn(ap->logopt,
 		     "failed to stat directory or symlink %s", path);
@@ -684,7 +680,6 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 		return 0;
 	}
 
-real_mount:
 	is_autofs_fs = 0;
 	if (master_find_submount(ap, path))
 		is_autofs_fs = 1;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
