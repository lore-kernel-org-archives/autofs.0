From: Ian Kent <raven@themaw.net>
Subject: [PATCH 19/27] autofs-5.1.3 - remove path restriction of amd
 external mount
Date: Mon, 11 Dec 2017 16:59:30 +0800
Message-ID: <151298277064.19722.2536194635930152183.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Remove the restriction that the external mount path must must be
within the configured external mounts directory.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG    |    1 +
 lib/mounts.c |   18 ------------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 453b59ee..22949785 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -52,6 +52,7 @@ xx/xx/2017 autofs-5.1.4
 - fix amd parser double quote handling.
 - fix expandamdent() quote handling.
 - fix possible memory leak during amd parse.
+- remove path restriction of amd external mount.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/mounts.c b/lib/mounts.c
index 93c53026..fdd35984 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -696,18 +696,9 @@ static struct ext_mount *ext_mount_lookup(const char *mountpoint)
 int ext_mount_add(struct list_head *entry, const char *path, unsigned int umount)
 {
 	struct ext_mount *em;
-	char *auto_dir;
 	u_int32_t hval;
 	int ret = 0;
 
-	/* Not a mount in the external mount directory */
-	auto_dir = conf_amd_get_auto_dir();
-	if (strncmp(path, auto_dir, strlen(auto_dir))) {
-		free(auto_dir);
-		return 0;
-	}
-	free(auto_dir);
-
 	pthread_mutex_lock(&ext_mount_hash_mutex);
 
 	em = ext_mount_lookup(path);
@@ -753,17 +744,8 @@ done:
 int ext_mount_remove(struct list_head *entry, const char *path)
 {
 	struct ext_mount *em;
-	char *auto_dir;
 	int ret = 0;
 
-	/* Not a mount in the external mount directory */
-	auto_dir = conf_amd_get_auto_dir();
-	if (strncmp(path, auto_dir, strlen(auto_dir))) {
-		free(auto_dir);
-		return 0;
-	}
-	free(auto_dir);
-
 	pthread_mutex_lock(&ext_mount_hash_mutex);
 
 	em = ext_mount_lookup(path);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
