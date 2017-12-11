From: Ian Kent <raven@themaw.net>
Subject: [PATCH 18/27] autofs-5.1.3 - fix possible memory leak during amd
 parse
Date: Mon, 11 Dec 2017 16:59:24 +0800
Message-ID: <151298276479.19722.18311394288865668718.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

If an amd map entry option is given more than once subsequent assignment
could result in a memory leak.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/amd_parse.y |   92 +++++++++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 5635c6a3..453b59ee 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -51,6 +51,7 @@ xx/xx/2017 autofs-5.1.4
 - refactor amd_parse.c.
 - fix amd parser double quote handling.
 - fix expandamdent() quote handling.
+- fix possible memory leak during amd parse.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index 52509ca1..3820d1cb 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -41,6 +41,7 @@ extern int amd_lex(void);
 extern void amd_set_scan_buffer(const char *);
 
 static char *amd_strdup(char *);
+static void amd_set_value(char **, char *);
 static void local_init_vars(void);
 static void local_free_vars(void);
 
@@ -289,19 +290,22 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 			}
 
 			if (!strcmp($1, "fs"))
-				entry.fs = fs_opt_val;
+				amd_set_value(&entry.fs, fs_opt_val);
 			else if (!strcmp($1, "sublink")) {
-				entry.sublink = fs_opt_val;
+				amd_set_value(&entry.sublink, fs_opt_val);
 			} else if (!strcmp($1, "pref")) {
 				if (strcmp(fs_opt_val, "null"))
-					entry.pref = fs_opt_val;
+					amd_set_value(&entry.pref, fs_opt_val);
 				else {
-					entry.pref = amd_strdup("");
-					if (!entry.pref) {
+					char *empty;
+
+					empty = amd_strdup("");
+					if (!empty) {
 						amd_notify($3);
 						free(fs_opt_val);
 						YYABORT;
 					}
+					amd_set_value(&entry.pref, empty);
 					free(fs_opt_val);
 				}
 			} else {
@@ -314,11 +318,14 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	| MAP_OPTION OPTION_ASSIGN
 	{
 		if (!strcmp($1, "fs")) {
-			entry.fs = amd_strdup("");
-			if (!entry.fs) {
+			char *empty;
+
+			empty = amd_strdup("");
+			if (!empty) {
 				amd_notify($1);
 				YYABORT;
 			}
+			amd_set_value(&entry.fs, empty);
 		} else {
 			amd_notify($1);
 			YYABORT;
@@ -335,11 +342,11 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 		}
 
 		if (!strcmp($1, "rhost"))
-			entry.rhost = fs_opt_val;
+			amd_set_value(&entry.rhost, fs_opt_val);
 		else if (!strcmp($1, "rfs"))
-			entry.rfs = fs_opt_val;
+			amd_set_value(&entry.rfs, fs_opt_val);
 		else if (!strcmp($1, "dev"))
-			entry.dev = fs_opt_val;
+			amd_set_value(&entry.dev, fs_opt_val);
 		else if (!strcmp($1, "mount") ||
 			 !strcmp($1, "unmount") ||
 			 !strcmp($1, "umount")) {
@@ -369,11 +376,11 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 		}
 
 		if (!strcmp($1, "rhost"))
-			entry.rhost = empty;
+			amd_set_value(&entry.rhost, empty);
 		else if (!strcmp($1, "rfs"))
-			entry.rfs = empty;
+			amd_set_value(&entry.rfs, empty);
 		else if (!strcmp($1, "dev"))
-			entry.dev = empty;
+			amd_set_value(&entry.dev, empty);
 		else {
 			amd_notify($1);
 			free(empty);
@@ -468,36 +475,27 @@ static int match_map_option_fs_type(char *map_option, char *type)
 		return 0;
 	}
 
-	if (!strcmp(fs_type, "auto")) {
+	if (!strcmp(fs_type, "auto"))
 		entry.flags |= AMD_MOUNT_TYPE_AUTO;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "nfs") ||
-		   !strcmp(fs_type, "nfs4")) {
+	else if (!strcmp(fs_type, "nfs") ||
+		 !strcmp(fs_type, "nfs4"))
 		entry.flags |= AMD_MOUNT_TYPE_NFS;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "nfsl")) {
+	else if (!strcmp(fs_type, "nfsl"))
 		entry.flags |= AMD_MOUNT_TYPE_NFSL;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "link")) {
+	else if (!strcmp(fs_type, "link"))
 		entry.flags |= AMD_MOUNT_TYPE_LINK;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "linkx")) {
+	else if (!strcmp(fs_type, "linkx"))
 		entry.flags |= AMD_MOUNT_TYPE_LINKX;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "host")) {
+	else if (!strcmp(fs_type, "host"))
 		entry.flags |= AMD_MOUNT_TYPE_HOST;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "lofs")) {
+	else if (!strcmp(fs_type, "lofs"))
 		entry.flags |= AMD_MOUNT_TYPE_LOFS;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "xfs")) {
+	else if (!strcmp(fs_type, "xfs"))
 		entry.flags |= AMD_MOUNT_TYPE_XFS;
-		entry.type = fs_type;
-	} else if (!strcmp(fs_type, "ext2") ||
+	else if (!strcmp(fs_type, "ext2") ||
 		   !strcmp(fs_type, "ext3") ||
-		   !strcmp(fs_type, "ext4")) {
+		   !strcmp(fs_type, "ext4"))
 		entry.flags |= AMD_MOUNT_TYPE_EXT;
-		entry.type = fs_type;
 	} else if (!strcmp(fs_type, "ufs")) {
 		entry.flags |= AMD_MOUNT_TYPE_UFS;
 		entry.type = conf_amd_get_linux_ufs_mount_type();
@@ -508,6 +506,7 @@ static int match_map_option_fs_type(char *map_option, char *type)
 			return 0;
 		}
 		free(fs_type);
+		fs_type = NULL;
 	} else if (!strcmp(fs_type, "cdfs")) {
 		entry.flags |= AMD_MOUNT_TYPE_CDFS;
 		entry.type = amd_strdup("iso9660");
@@ -518,6 +517,7 @@ static int match_map_option_fs_type(char *map_option, char *type)
 			return 0;
 		}
 		free(fs_type);
+		fs_type = NULL;
 	} else if (!strcmp(fs_type, "jfs") ||
 		   !strcmp(fs_type, "nfsx") ||
 		   !strcmp(fs_type, "program") ||
@@ -534,12 +534,16 @@ static int match_map_option_fs_type(char *map_option, char *type)
 				 fs_type);
 		amd_msg(msg_buf);
 		free(fs_type);
+		fs_type = NULL;
 	} else {
 		amd_notify(fs_type);
 		free(fs_type);
 		return 0;
 	}
 
+	if (fs_type)
+		amd_set_value(&entry.type, fs_type);
+
 	return 1;
 }
 
@@ -558,15 +562,18 @@ static int match_map_option_map_type(char *map_option, char *type)
 	    !strcmp(map_type, "nisplus") ||
 	    !strcmp(map_type, "ldap") ||
 	    !strcmp(map_type, "hesiod")) {
-		entry.map_type = map_type;
+		amd_set_value(&entry.map_type, map_type);
 	} else if (!strcmp(map_type, "exec")) {
 		/* autofs uses "program" for "exec" map type */
-		entry.map_type = amd_strdup("program");
-		if (!entry.map_type) {
+		char * tmp;
+
+		tmp = amd_strdup("program");
+		if (!tmp) {
 			amd_notify(type);
 			free(map_type);
 			return 0;
 		}
+		amd_set_value(&entry.map_type, tmp);
 		free(map_type);
 	} else if (!strcmp(map_type, "passwd")) {
 		sprintf(msg_buf, "map type %s is "
@@ -621,17 +628,17 @@ static int match_mnt_option_options(char *mnt_option, char *options)
 		tmp = amd_strdup(options);
 		if (!tmp)
 			return 0;
-		entry.opts = tmp;
+		amd_set_value(&entry.opts, tmp);
 	} else if (!strcmp(mnt_option, "addopts")) {
 		tmp = amd_strdup(options);
 		if (!tmp)
 			return 0;
-		entry.addopts = tmp;
+		amd_set_value(&entry.addopts, tmp);
 	} else if (!strcmp(mnt_option, "remopts")) {
 		tmp = amd_strdup(options);
 		if (!tmp)
 			return 0;
-		entry.remopts = tmp;
+		amd_set_value(&entry.remopts, tmp);
 	} else
 		return 0;
 
@@ -715,6 +722,13 @@ done:
 	return tmp;
 }
 
+static void amd_set_value(char **field, char *value)
+{
+	if (*field)
+		free(*field);
+	*field = value;
+}
+
 static int amd_error(const char *s)
 {
 	if (strcmp(s, "syntax"))

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
