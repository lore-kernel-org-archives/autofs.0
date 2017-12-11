From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/27] autofs-5.1.3 - handle additional nfs versions in
 mount_nfs.c
Date: Mon, 11 Dec 2017 16:57:05 +0800
Message-ID: <151298262571.19722.2895089225787451346.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Since NFSv4 can now have a subversion it needs to be allowed for.

It's enough to check for an options string starting with "vers=4" or
"nfsvers=4" because it's used only to set a flag used for special
casing the availibility probe for any NFS version 4 version.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/mount_nfs.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 2da2cdc9..3a1e4a6a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -35,6 +35,7 @@ xx/xx/2017 autofs-5.1.4
 - make map source reference message debug only.
 - improve description of mount_nfs_default_protocol.
 - the port option should not behave like nobind option.
+- handle additional nfs versions in mount_nfs.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 5245d960..d3ebd923 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -147,8 +147,9 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 			} else if (_strncmp("use-weight-only", cp, o_len) == 0) {
 				flags |= MOUNT_FLAG_USE_WEIGHT_ONLY;
 			} else {
-				if (_strncmp("vers=4", cp, o_len) == 0 ||
-				    _strncmp("nfsvers=4", cp, o_len) == 0)
+				/* Is any version of NFSv4 in the options */
+				if (_strncmp("vers=4", cp, 6) == 0 ||
+				    _strncmp("nfsvers=4", cp, 9) == 0)
 					vers = NFS4_VERS_MASK | TCP_SUPPORTED;
 				else if (_strncmp("vers=3", cp, o_len) == 0 ||
 					 _strncmp("nfsvers=3", cp, o_len) == 0) {

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
