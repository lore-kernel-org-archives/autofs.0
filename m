From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/27] autofs-5.1.3 - fix symlink option passthrough in
 mount_nfs.c
Date: Mon, 11 Dec 2017 16:57:27 +0800
Message-ID: <151298264715.19722.8314291247447160116.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If an NFS mount is seen as local and bind mounting isn't desired
the symlink pseudo-option should be able to be used but it isn't
passed to the bind mount module by the NFS mount module.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/mount_nfs.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3a1e4a6a..48f0b67c 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -36,6 +36,7 @@ xx/xx/2017 autofs-5.1.4
 - improve description of mount_nfs_default_protocol.
 - the port option should not behave like nobind option.
 - handle additional nfs versions in mount_nfs.c.
+- fix symlink option passthrough in mount_nfs.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index d3ebd923..bf712a93 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -70,6 +70,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	char *nfsoptions = NULL;
 	unsigned int flags = ap->flags &
 			(MOUNT_FLAG_RANDOM_SELECT | MOUNT_FLAG_USE_WEIGHT_ONLY);
+	int symlink = (*name != '/' && (ap->flags & MOUNT_FLAG_SYMLINK));
 	int nobind = ap->flags & MOUNT_FLAG_NOBIND;
 	int len, status, err, existed = 1;
 	int nosymlink = 0;
@@ -140,6 +141,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				     "and will soon be removed, "
 				     "use the \"nobind\" option instead");
 				nosymlink = 1;
+			} else if (_strncmp("symlink", cp, o_len) == 0) {
+				if (*name != '/')
+					symlink = 1;
 			} else if (_strncmp("nobind", cp, o_len) == 0) {
 				nobind = 1;
 			} else if (_strncmp("no-use-weight-only", cp, o_len) == 0) {
@@ -293,12 +297,14 @@ dont_probe:
 		if (!(nosymlink || nobind) &&
 		    this->proximity == PROXIMITY_LOCAL) {
 			/* Local host -- do a "bind" */
-			const char *bind_options = ro ? "ro" : "";
+			const char *bind_options;
 
 			debug(ap->logopt,
 			      MODPREFIX "%s is local, attempt bind mount",
 			      name);
 
+			bind_options = symlink ? "symlink" : ro ? "ro" : "";
+
 			err = mount_bind->mount_mount(ap, root, name, name_len,
 					       this->path, "bind", bind_options,
 					       mount_bind->context);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
