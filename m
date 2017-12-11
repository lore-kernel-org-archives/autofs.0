From: Ian Kent <raven@themaw.net>
Subject: [PATCH 21/27] autofs-5.1.3 - add function ext_mount_inuse()
Date: Mon, 11 Dec 2017 16:59:42 +0800
Message-ID: <151298278234.19722.14417124723830136226.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add function to check if a path is an amd externally managed mount.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 +
 include/mounts.h |    1 +
 lib/mounts.c     |   17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 66b82074..80a6a5c7 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -54,6 +54,7 @@ xx/xx/2017 autofs-5.1.4
 - fix possible memory leak during amd parse.
 - remove path restriction of amd external mount.
 - add function umount_amd_ext_mount().
+- add function ext_mount_inuse().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/mounts.h b/include/mounts.h
index d6ddc0e1..74b23db6 100644
--- a/include/mounts.h
+++ b/include/mounts.h
@@ -98,6 +98,7 @@ char *make_options_string(char *path, int kernel_pipefd, const char *extra);
 char *make_mnt_name_string(char *path);
 int ext_mount_add(struct list_head *, const char *, unsigned int);
 int ext_mount_remove(struct list_head *, const char *);
+int ext_mount_inuse(const char *);
 struct mnt_list *get_mnt_list(const char *table, const char *path, int include);
 struct mnt_list *reverse_mnt_list(struct mnt_list *list);
 void free_mnt_list(struct mnt_list *list);
diff --git a/lib/mounts.c b/lib/mounts.c
index 0ca86962..29c8a8f5 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -770,6 +770,23 @@ done:
 	return ret;
 }
 
+int ext_mount_inuse(const char *path)
+{
+	struct ext_mount *em;
+	int ret = 0;
+
+	pthread_mutex_lock(&ext_mount_hash_mutex);
+	em = ext_mount_lookup(path);
+	if (!em)
+		goto done;
+
+	if (!list_empty(&em->mounts))
+		ret = 1;
+done:
+	pthread_mutex_unlock(&ext_mount_hash_mutex);
+	return ret;
+}
+
 /*
  * Get list of mounts under path in longest->shortest order
  */

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
