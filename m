From: Ian Kent <raven@themaw.net>
Subject: [PATCH 5/5] autofs-5.0.8 - fix options compare
Date: Tue, 24 Dec 2013 16:02:33 +0800
Message-ID: <20131224080233.8321.32758.stgit@perseus.fritz.box>
References: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=2sK1KDVk3jE9+ky3+/oguVfUrh4=; b=ZwEgkb3Tv0nQQGfOpOwn1J73YwF7
	vLe2KHv6E6umDBk/Q+T4KP5OMSwq5gLyMAb7TpaoCWaLrd4C07t3d1JmnGO/dC3u
	hhmDmdIJ/lca9yKN8z8g6omSvizs6d3rlZrS4vXI0WhMpuqmWwPeUbtkvdYzpY91
	Sq6tYHQ3O0zuPIc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=2sK1KDVk3jE9+ky3+/oguV
	fUrh4=; b=r1WpDAaLXqR8i1Ag0v/+KlZie0rlUUxJjXB0Y1FBs+g9v4i1kJHEAs
	TDmtdilH6ZqpROww0OGWaJ7Ma3kh++njCHFIF9+o1ThnKWHHS9xjDIfXQcc8hyvr
	dKqdPssLli6A4TYy0QD9L3GkDh84t8KH4abYNYY1mFbszZFOVuIUY=
In-Reply-To: <20131224075909.8321.95699.stgit@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Lan Yixun (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

When checking for options in mount locations incorrect matches
can occur when the length of the option string is not also used
for the check.
---
 include/automount.h    |    1 +
 lib/cat_path.c         |    9 +++++++++
 modules/mount_autofs.c |   12 ++++++------
 modules/mount_bind.c   |    2 +-
 modules/mount_ext2.c   |    2 +-
 modules/mount_nfs.c    |   34 +++++++++++++++++-----------------
 modules/parse_sun.c    |   20 ++++++++++----------
 7 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/include/automount.h b/include/automount.h
index 71787a5..396391c 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -335,6 +335,7 @@ size_t _strlen(const char *str, size_t max);
 int cat_path(char *buf, size_t len, const char *dir, const char *base);
 int ncat_path(char *buf, size_t len,
               const char *dir, const char *base, size_t blen);
+int _strncmp(const char *s1, const char *s2, size_t n);
 
 /* Core automount definitions */
 
diff --git a/lib/cat_path.c b/lib/cat_path.c
index 60669db..c386b33 100644
--- a/lib/cat_path.c
+++ b/lib/cat_path.c
@@ -87,3 +87,12 @@ int ncat_path(char *buf, size_t len,
 	return cat_path(buf, len, dir, name);
 }
 
+/* Compare first n bytes of s1 and s2 and that n == strlen(s1) */
+int _strncmp(const char *s1, const char *s2, size_t n)
+{
+	size_t len = strlen(s1);
+
+	if (n != len)
+		return n - len;
+	return strncmp(s1, s2, n);
+}
diff --git a/modules/mount_autofs.c b/modules/mount_autofs.c
index 319f2e4..61aec70 100644
--- a/modules/mount_autofs.c
+++ b/modules/mount_autofs.c
@@ -116,17 +116,17 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name,
 			while (*comma != '\0' && *comma != ',')
 				comma++;
 
-			if (strncmp(cp, "nobrowse", 8) == 0)
+			if (_strncmp(cp, "nobrowse", 8) == 0)
 				ghost = 0;
-			else if (strncmp(cp, "nobind", 6) == 0)
+			else if (_strncmp(cp, "nobind", 6) == 0)
 				nobind = 1;
-			else if (strncmp(cp, "browse", 6) == 0)
+			else if (_strncmp(cp, "browse", 6) == 0)
 				ghost = 1;
-			else if (strncmp(cp, "symlink", 7) == 0)
+			else if (_strncmp(cp, "symlink", 7) == 0)
 				symlnk = 1;
-			else if (strncmp(cp, "hosts", 5) == 0)
+			else if (_strncmp(cp, "hosts", 5) == 0)
 				hosts = 1;
-			else if (strncmp(cp, "timeout=", 8) == 0) {
+			else if (_strncmp(cp, "timeout=", 8) == 0) {
 				char *val = strchr(cp, '=');
 				unsigned tout;
 				if (val) {
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 2b70104..a70bf3a 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -107,7 +107,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 				end--;
 
 			o_len = end - cp + 1;
-			if (strncmp("symlink", cp, o_len) == 0)
+			if (_strncmp("symlink", cp, o_len) == 0)
 				symlnk = 1;
 		}
 	}
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index 1edf347..1bc429d 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -77,7 +77,7 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 	if (options && options[0]) {
 		for (p = options; (p1 = strchr(p, ',')); p = p1)
-			if (!strncmp(p, "ro", p1 - p) && ++p1 - p == sizeof("ro"))
+			if (!_strncmp(p, "ro", p1 - p) && ++p1 - p == sizeof("ro"))
 				ro = 1;
 		if (!strcmp(p, "ro"))
 			ro = 1;
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 5a582ef..315fc99 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -126,32 +126,32 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 			o_len = end - cp + 1;
 
-			if (strncmp("proto=rdma", cp, o_len) == 0 ||
-				   strncmp("rdma", cp, o_len) == 0)
+			if (_strncmp("proto=rdma", cp, o_len) == 0 ||
+				   _strncmp("rdma", cp, o_len) == 0)
 				rdma = 1;
 
-			if (strncmp("nosymlink", cp, o_len) == 0) {
+			if (_strncmp("nosymlink", cp, o_len) == 0) {
 				warn(ap->logopt, MODPREFIX
 				     "the \"nosymlink\" option is depricated "
 				     "and will soon be removed, "
 				     "use the \"nobind\" option instead");
 				nosymlink = 1;
-			} else if (strncmp("nobind", cp, o_len) == 0) {
+			} else if (_strncmp("nobind", cp, o_len) == 0) {
 				nobind = 1;
-			} else if (strncmp("no-use-weight-only", cp, o_len) == 0) {
+			} else if (_strncmp("no-use-weight-only", cp, o_len) == 0) {
 				flags &= ~MOUNT_FLAG_USE_WEIGHT_ONLY;
-			} else if (strncmp("use-weight-only", cp, o_len) == 0) {
+			} else if (_strncmp("use-weight-only", cp, o_len) == 0) {
 				flags |= MOUNT_FLAG_USE_WEIGHT_ONLY;
 			} else {
-				if (strncmp("vers=4", cp, o_len) == 0 ||
-				    strncmp("nfsvers=4", cp, o_len) == 0)
+				if (_strncmp("vers=4", cp, o_len) == 0 ||
+				    _strncmp("nfsvers=4", cp, o_len) == 0)
 					vers = NFS4_VERS_MASK | TCP_SUPPORTED;
-				else if (strncmp("vers=3", cp, o_len) == 0 ||
-					 strncmp("nfsvers=3", cp, o_len) == 0) {
+				else if (_strncmp("vers=3", cp, o_len) == 0 ||
+					 _strncmp("nfsvers=3", cp, o_len) == 0) {
 					vers &= ~(NFS4_VERS_MASK | NFS_VERS_MASK);
 					vers |= NFS3_REQUESTED;
-				} else if (strncmp("vers=2", cp, o_len) == 0 ||
-					 strncmp("nfsvers=2", cp, o_len) == 0) {
+				} else if (_strncmp("vers=2", cp, o_len) == 0 ||
+					 _strncmp("nfsvers=2", cp, o_len) == 0) {
 					vers &= ~(NFS4_VERS_MASK | NFS_VERS_MASK);
 					vers |= NFS2_REQUESTED;
 				} else if (strstr(cp, "port=") == cp &&
@@ -164,16 +164,16 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 					if (port < 0)
 						port = 0;
 					port_opt = cp;
-				} else if (strncmp("proto=udp", cp, o_len) == 0 ||
-					   strncmp("udp", cp, o_len) == 0) {
+				} else if (_strncmp("proto=udp", cp, o_len) == 0 ||
+					   _strncmp("udp", cp, o_len) == 0) {
 					vers &= ~TCP_SUPPORTED;
-				} else if (strncmp("proto=tcp", cp, o_len) == 0 ||
-					   strncmp("tcp", cp, o_len) == 0) {
+				} else if (_strncmp("proto=tcp", cp, o_len) == 0 ||
+					   _strncmp("tcp", cp, o_len) == 0) {
 					vers &= ~UDP_SUPPORTED;
 				}
 				/* Check for options that also make sense
 				   with bind mounts */
-				else if (strncmp("ro", cp, o_len) == 0)
+				else if (_strncmp("ro", cp, o_len) == 0)
 					ro = 1;
 				/* and jump over trailing white space */
 				memcpy(nfsp, cp, comma - cp + 1);
diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index e5a4def..9a877c8 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -511,29 +511,29 @@ static int sun_mount(struct autofs_point *ap, const char *root,
 			while (*comma != '\0' && *comma != ',')
 				comma++;
 
-			if (strncmp("fstype=", cp, 7) == 0) {
+			if (_strncmp("fstype=", cp, 7) == 0) {
 				int typelen = comma - (cp + 7);
 				fstype = alloca(typelen + 1);
 				memcpy(fstype, cp + 7, typelen);
 				fstype[typelen] = '\0';
-			} else if (strncmp("nonstrict", cp, 9) == 0) {
+			} else if (_strncmp("nonstrict", cp, 9) == 0) {
 				nonstrict = 1;
-			} else if (strncmp("strict", cp, 6) == 0) {
+			} else if (_strncmp("strict", cp, 6) == 0) {
 				nonstrict = 0;
-			} else if (strncmp("nobrowse", cp, 8) == 0 ||
-				   strncmp("browse", cp, 6) == 0 ||
-				   strncmp("timeout=", cp, 8) == 0) {
+			} else if (_strncmp("nobrowse", cp, 8) == 0 ||
+				   _strncmp("browse", cp, 6) == 0 ||
+				   _strncmp("timeout=", cp, 8) == 0) {
 				if (strcmp(fstype, "autofs") == 0 ||
 				    strstr(cp, "fstype=autofs")) {
 					memcpy(np, cp, comma - cp + 1);
 					np += comma - cp + 1;
 				}
-			} else if (strncmp("no-use-weight-only", cp, 18) == 0) {
+			} else if (_strncmp("no-use-weight-only", cp, 18) == 0) {
 				use_weight_only = -1;
-			} else if (strncmp("use-weight-only", cp, 15) == 0) {
+			} else if (_strncmp("use-weight-only", cp, 15) == 0) {
 				use_weight_only = MOUNT_FLAG_USE_WEIGHT_ONLY;
-			} else if (strncmp("bg", cp, 2) == 0 ||
-				   strncmp("nofg", cp, 4) == 0) {
+			} else if (_strncmp("bg", cp, 2) == 0 ||
+				   _strncmp("nofg", cp, 4) == 0) {
 				continue;
 			} else {
 				memcpy(np, cp, comma - cp + 1);

