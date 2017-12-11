From: Ian Kent <raven@themaw.net>
Subject: [PATCH 20/27] autofs-5.1.3 - add function umount_amd_ext_mount()
Date: Mon, 11 Dec 2017 16:59:36 +0800
Message-ID: <151298277649.19722.1143397865585189410.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Refactor amd external umount code, move the code into its own
function.

Later amd umounting of program mounts with a custom command will
be added.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 daemon/automount.c  |   22 ++--------------------
 include/mounts.h    |    1 +
 lib/mounts.c        |   17 +++++++++++++++++
 modules/parse_amd.c |    3 +--
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 22949785..66b82074 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -53,6 +53,7 @@ xx/xx/2017 autofs-5.1.4
 - fix expandamdent() quote handling.
 - fix possible memory leak during amd parse.
 - remove path restriction of amd external mount.
+- add function umount_amd_ext_mount().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/automount.c b/daemon/automount.c
index d60a3d7b..6ae44475 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -610,16 +610,7 @@ static int umount_subtree_mounts(struct autofs_point *ap, const char *path, unsi
 		}
 		list_del(&entry->entries);
 		mounts_mutex_unlock(ap);
-		if (ext_mount_remove(&entry->ext_mount, entry->fs)) {
-			if (umount_ent(ap, entry->fs))
-				debug(ap->logopt,
-				      "failed to umount external mount %s",
-				      entry->fs);
-			else
-				debug(ap->logopt,
-				      "umounted external mount %s",
-				      entry->fs);
-		}
+		umount_amd_ext_mount(ap, entry);
 		free_amd_entry(entry);
 	}
 done:
@@ -666,16 +657,7 @@ int umount_multi(struct autofs_point *ap, const char *path, int incl)
 		}
 		list_del(&entry->entries);
 		mounts_mutex_unlock(ap);
-		if (ext_mount_remove(&entry->ext_mount, entry->fs)) {
-			if (umount_ent(ap, entry->fs))
-				debug(ap->logopt,
-				      "failed to umount external mount %s",
-				      entry->fs);
-			else
-				debug(ap->logopt,
-				      "umounted external mount %s",
-				      entry->fs);
-		}
+		umount_amd_ext_mount(ap, entry);
 		free_amd_entry(entry);
 		return 0;
 	}
diff --git a/include/mounts.h b/include/mounts.h
index 031e2a3b..d6ddc0e1 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -118,6 +118,7 @@ int try_remount(struct autofs_point *, struct mapent *, unsigned int);
 void set_indirect_mount_tree_catatonic(struct autofs_point *);
 void set_direct_mount_tree_catatonic(struct autofs_point *, struct mapent *);
 int umount_ent(struct autofs_point *, const char *);
+int umount_amd_ext_mount(struct autofs_point *, struct amd_entry *);
 int mount_multi_triggers(struct autofs_point *, struct mapent *, const char *, unsigned int, const char *);
 int umount_multi_triggers(struct autofs_point *, struct mapent *, char *, const char *);
 int clean_stale_multi_triggers(struct autofs_point *, struct mapent *, char *, const char *);
diff --git a/lib/mounts.c b/lib/mounts.c
index fdd35984..0ca86962 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2043,6 +2043,23 @@ int umount_ent(struct autofs_point *ap, const char *path)
 	return rv;
 }
 
+int umount_amd_ext_mount(struct autofs_point *ap, struct amd_entry *entry)
+{
+	int rv = 1;
+
+	if (ext_mount_remove(&entry->ext_mount, entry->fs)) {
+		rv = umount_ent(ap, entry->fs);
+		if (rv)
+			error(ap->logopt,
+			      "failed to umount external mount %s", entry->fs);
+		else
+			debug(ap->logopt,
+			      "umounted external mount %s", entry->fs);
+	}
+
+	return rv;
+}
+
 static int do_mount_autofs_offset(struct autofs_point *ap,
 				  struct mapent *oe, const char *root,
 				  char *offset)
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 8030b271..eeb74d41 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -980,8 +980,7 @@ symlink:
 
 	if (entry->sublink) {
 		/* failed to complete sublink mount */
-		if (ext_mount_remove(&entry->ext_mount, entry->fs))
-			umount_ent(ap, entry->fs);
+		umount_amd_ext_mount(ap, entry);
 	}
 out:
 	return ret;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
