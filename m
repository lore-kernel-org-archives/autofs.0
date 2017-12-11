From: Ian Kent <raven@themaw.net>
Subject: [PATCH 24/27] autofs-5.1.3 - fix memory leak in
 umount_amd_ext_mount()
Date: Mon, 11 Dec 2017 17:00:07 +0800
Message-ID: <151298280732.19722.7835389839355918967.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Free allocated resources before returning success if mount is
found to be in use by another user.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    |    1 +
 lib/mounts.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index f3cdcd52..8a9fdb1f 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -57,6 +57,7 @@ xx/xx/2017 autofs-5.1.4
 - add function ext_mount_inuse().
 - add function construct_argv().
 - add amd mount type program mount support.
+- fix memory leak in umount_amd_ext_mount().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/mounts.c b/lib/mounts.c
index 8367a50e..6fa304aa 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2084,7 +2084,7 @@ int umount_amd_ext_mount(struct autofs_point *ap, struct amd_entry *entry)
 
 		if (!ext_mount_remove(&entry->ext_mount, entry->fs)) {
 			rv =0;
-			goto out;
+			goto out_free;
 		}
 
 		rv = spawnv(ap->logopt, prog, (const char * const *) argv);
@@ -2097,7 +2097,7 @@ int umount_amd_ext_mount(struct autofs_point *ap, struct amd_entry *entry)
 			      "umounted program mount at %s", entry->fs);
 			rmdir_path(ap, entry->fs, ap->dev);
 		}
-
+out_free:
 		free_argv(argc, (const char **) argv);
 		free(str);
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
