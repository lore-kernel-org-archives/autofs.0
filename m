From: Ian Kent <raven@themaw.net>
Subject: [PATCH 28/35] autofs-5.1.3 - revert fix argc off by one in
 mount_autofs.c
Date: Mon, 16 Oct 2017 13:08:53 +0800
Message-ID: <150813053361.25695.9000419344987484939.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Commit 6a44f715cf to fix an off by one error in the arguments calculation
when mounting an autofs submount actually introduced an off by one error
instead of fixing one.

Revert the change.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG              |    1 +
 modules/mount_autofs.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 1ab2e966..6ac29220 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -26,6 +26,7 @@ xx/xx/2017 autofs-5.1.4
 - make spawn_bind_mount() use mount_wait as well.
 - document ghost option in auto.master man page.
 - only take master map mutex for master map update.
+- revert fix argc off by one in mount_autofs.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 076ab855..cd0631b8 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -181,11 +181,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	if (options) {
 		char *t = options;
-		while ((t = strchr(t, ',')) != NULL) {
+		do {
 			argc++;
 			if (*t == ',')
 				t++;
-		}
+		} while ((t = strchr(t, ',')) != NULL);
 	}
 	argv = (const char **) alloca((argc + 1) * sizeof(char *));
 
@@ -213,13 +213,13 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 
 	if (options) {
 		p = options;
-		while ((p = strchr(p, ',')) != NULL) {
+		do {
 			if (*p == ',') {
 				*p = '\0';
 				p++;
 			}
 			argv[argc++] = p;
-		}
+		} while ((p = strchr(p, ',')) != NULL);
 	}
 	argv[argc] = NULL;
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
