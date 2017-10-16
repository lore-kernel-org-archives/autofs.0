From: Ian Kent <raven@themaw.net>
Subject: [PATCH 35/35] autofs-5.1.3 - port option should not behave like
 nobind option
Date: Mon, 16 Oct 2017 13:09:41 +0800
Message-ID: <150813058107.25695.1848283423860530702.stgit@pluto.themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The "port=" option currently prevents bind mounting when the host
corresponds to localhost or a local interface.

But this interferes with cases where the "port" option needs to be
used and bind mounting of local mounts is also required.

So remove the age old hack of the "port" option preventing this in
favour of explicitly requiring the "nobind" option.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 man/auto.master.5.in |    6 +++---
 modules/mount_nfs.c  |   13 +------------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c0af0ff6..7134c805 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -33,6 +33,7 @@ xx/xx/2017 autofs-5.1.4
 - be silent about nis domain not set.
 - make map source reference message debug only.
 - improve description of mount_nfs_default_protocol.
+- the port option should not behave like nobind option.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/man/auto.master.5.in b/man/auto.master.5.in
index 4475186a..581fc966 100644
--- a/man/auto.master.5.in
+++ b/man/auto.master.5.in
@@ -179,9 +179,9 @@ entries to prevent bind mounting of local NFS filesystems. For direct
 mount maps the option is only effective if specified on the first direct
 map entry and is applied to all direct mount maps in the master map. It
 is ignored if given on subsequent direct map entries. It may be used
-on individual map entries of both types. Bind mounting of NFS file
-systems can also be prevented for specific map entrys by adding the
-"port=" mount option to the entries.
+on individual map entries of both types. Preventing bind mounts of NFS
+file systems can no longer be done by using the "port=" option, the
+nobind option must be used instead.
 .TP
 .I "symlink"
 This option makes bind mounting use a symlink instead of an actual bind
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 63f16b19..5245d960 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -68,7 +68,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	struct host *this, *hosts = NULL;
 	unsigned int mount_default_proto, vers;
 	char *nfsoptions = NULL;
-	const char *port_opt = NULL;
 	unsigned int flags = ap->flags &
 			(MOUNT_FLAG_RANDOM_SELECT | MOUNT_FLAG_USE_WEIGHT_ONLY);
 	int nobind = ap->flags & MOUNT_FLAG_NOBIND;
@@ -168,7 +167,6 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 					port = atoi(optport);
 					if (port < 0)
 						port = 0;
-					port_opt = cp;
 				} else if (_strncmp("proto=udp", cp, o_len) == 0 ||
 					   _strncmp("udp", cp, o_len) == 0) {
 					vers &= ~TCP_SUPPORTED;
@@ -286,22 +284,13 @@ dont_probe:
 	if (!status)
 		existed = 0;
 
-	/*
-	 * If any *port= option is specified, then we don't want
-	 * a bind mount. Use the "port" option if you want to
-	 * avoid attempting a local bind mount, such as when
-	 * tunneling NFS via localhost.
-	 */
-	if (nfsoptions && *nfsoptions && !port_opt)
-		port_opt = strstr(nfsoptions, "port=");
-
 	this = hosts;
 	while (this) {
 		char *loc;
 
 		/* Port option specified, don't try to bind */
 		if (!(nosymlink || nobind) &&
-		    !port_opt && this->proximity == PROXIMITY_LOCAL) {
+		    this->proximity == PROXIMITY_LOCAL) {
 			/* Local host -- do a "bind" */
 			const char *bind_options = ro ? "ro" : "";
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
