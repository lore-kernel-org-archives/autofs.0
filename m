From: Ian Kent <raven@themaw.net>
Subject: [PATCH 15/27] autofs-5.1.3 - refactor amd_parse.c
Date: Mon, 11 Dec 2017 16:59:07 +0800
Message-ID: <151298274725.19722.9326513428342350453.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Refactor some blocks of code into functions to allow later reuse.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 
 modules/amd_parse.y |  293 ++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 197 insertions(+), 97 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index c856f9cb..3ad8bd7e 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -48,6 +48,7 @@ xx/xx/2017 autofs-5.1.4
 - fix symlink false negative in umount_multi().
 - remove expand_selectors() on amd parser entry.
 - fix amd defaults map entry handling.
+- refactor amd_parse.c.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index 2a92d4a1..d7f4ef07 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -55,6 +55,11 @@ static int make_selector(char *name,
 			 unsigned int compare);
 static void add_selector(struct selector *selector);
 
+static int match_map_option_fs_type(char *map_option, char *type);
+static int match_map_option_map_type(char *map_option, char *type);
+static int match_map_option_cache_option(char *type);
+static int match_mnt_option_options(char *mnt_option, char *options);
+
 static struct amd_entry entry;
 static struct list_head *entries;
 static struct autofs_point *pap;
@@ -253,86 +258,13 @@ selection: SELECTOR IS_EQUAL SELECTOR_VALUE
 
 option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	{
-		if (!strcmp($3, "auto")) {
-			entry.flags |= AMD_MOUNT_TYPE_AUTO;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "nfs") ||
-			   !strcmp($3, "nfs4")) {
-			entry.flags |= AMD_MOUNT_TYPE_NFS;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "nfsl")) {
-			entry.flags |= AMD_MOUNT_TYPE_NFSL;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "link")) {
-			entry.flags |= AMD_MOUNT_TYPE_LINK;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "linkx")) {
-			entry.flags |= AMD_MOUNT_TYPE_LINKX;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "host")) {
-			entry.flags |= AMD_MOUNT_TYPE_HOST;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "lofs")) {
-			entry.flags |= AMD_MOUNT_TYPE_LOFS;
-			entry.type = amd_strdup("bind");
-		} else if (!strcmp($3, "xfs")) {
-			entry.flags |= AMD_MOUNT_TYPE_XFS;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "ext2") ||
-			   !strcmp($3, "ext3") ||
-			   !strcmp($3, "ext4")) {
-			entry.flags |= AMD_MOUNT_TYPE_EXT;
-			entry.type = amd_strdup($3);
-		} else if (!strcmp($3, "ufs")) {
-			entry.flags |= AMD_MOUNT_TYPE_UFS;
-			entry.type = conf_amd_get_linux_ufs_mount_type();
-		} else if (!strcmp($3, "cdfs")) {
-			entry.flags |= AMD_MOUNT_TYPE_CDFS;
-			entry.type = amd_strdup("iso9660");
-		} else if (!strcmp($3, "jfs") ||
-			   !strcmp($3, "nfsx") ||
-			   !strcmp($3, "program") ||
-			   !strcmp($3, "lustre") ||
-			   !strcmp($3, "direct")) {
-			sprintf(msg_buf, "file system type %s is "
-					 "not yet implemented", $3);
-			amd_msg(msg_buf);
-			YYABORT;
-		} else if (!strcmp($3, "cachefs")) {
-			sprintf(msg_buf, "file system %s is not "
-					 "supported by autofs, ignored", $3);
-			amd_msg(msg_buf);
-		} else {
-			amd_notify($1);
+		if (!match_map_option_fs_type($1, $3))
 			YYABORT;
-		}
 	}
 	| MAP_OPTION OPTION_ASSIGN MAP_TYPE
 	{
-		if (!strcmp($3, "file") ||
-		    !strcmp($3, "nis") ||
-		    !strcmp($3, "nisplus") ||
-		    !strcmp($3, "ldap") ||
-		    !strcmp($3, "hesiod"))
-			entry.map_type = amd_strdup($3);
-		else if (!strcmp($3, "exec"))
-			/* autofs uses "program" for "exec" map type */
-			entry.map_type = amd_strdup("program");
-		else if (!strcmp($3, "passwd")) {
-			sprintf(msg_buf, "map type %s is "
-					 "not yet implemented", $3);
-			amd_msg(msg_buf);
-			YYABORT;
-		} else if (!strcmp($3, "ndbm") ||
-			   !strcmp($3, "union")) {
-			sprintf(msg_buf, "map type %s is not "
-					 "supported by autofs", $3);
-			amd_msg(msg_buf);
-			YYABORT;
-		} else {
-			amd_notify($1);
+		if (!match_map_option_map_type($1, $3))
 			YYABORT;
-		}
 	}
 	| MAP_OPTION OPTION_ASSIGN FS_OPT_VALUE
 	{
@@ -397,13 +329,7 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	}
 	| MNT_OPTION OPTION_ASSIGN options
 	{
-		if (!strcmp($1, "opts"))
-			entry.opts = amd_strdup(opts);
-		else if (!strcmp($1, "addopts"))
-			entry.addopts = amd_strdup(opts);
-		else if (!strcmp($1, "remopts"))
-			entry.remopts = amd_strdup(opts);
-		else {
+		if (!match_mnt_option_options($1, $3)) {
 			amd_notify($1);
 			YYABORT;
 		}
@@ -412,27 +338,20 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	| MNT_OPTION OPTION_ASSIGN
 	{
 		memset(opts, 0, sizeof(opts));
-		if (!strcmp($1, "opts"))
-			entry.opts = amd_strdup("");
-		else if (!strcmp($1, "addopts"))
-			entry.addopts = amd_strdup("");
-		else if (!strcmp($1, "remopts"))
-			entry.remopts = amd_strdup("");
-		else {
+		if (!match_mnt_option_options($1, "")) {
 			amd_notify($1);
 			YYABORT;
 		}
 	}
 	| MAP_OPTION OPTION_ASSIGN CACHE_OPTION
 	{
-		if (strncmp($3, "inc", 3))
-			entry.cache_opts = AMD_CACHE_OPTION_INC;
-		else if (strncmp($3, "all", 3))
-			entry.cache_opts = AMD_CACHE_OPTION_ALL;
-		else if (strncmp($3, "re", 2))
-			entry.cache_opts = AMD_CACHE_OPTION_REGEXP;
-		if (strstr($3, "sync"))
-			entry.cache_opts |= AMD_CACHE_OPTION_SYNC;
+		if (!strcmp($1, "cache")) {
+			if (!match_map_option_cache_option($3))
+				YYABORT;
+		} else {
+			amd_notify($1);
+			YYABORT;
+		}
 	}
 	;
 
@@ -478,6 +397,186 @@ options: OPTION
 
 %%
 
+static int match_map_option_fs_type(char *map_option, char *type)
+{
+	char *fs_type;
+
+	fs_type = amd_strdup(type);
+	if (!fs_type) {
+		amd_notify(type);
+		return 0;
+	}
+
+	if (!strcmp(fs_type, "auto")) {
+		entry.flags |= AMD_MOUNT_TYPE_AUTO;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "nfs") ||
+		   !strcmp(fs_type, "nfs4")) {
+		entry.flags |= AMD_MOUNT_TYPE_NFS;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "nfsl")) {
+		entry.flags |= AMD_MOUNT_TYPE_NFSL;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "link")) {
+		entry.flags |= AMD_MOUNT_TYPE_LINK;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "linkx")) {
+		entry.flags |= AMD_MOUNT_TYPE_LINKX;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "host")) {
+		entry.flags |= AMD_MOUNT_TYPE_HOST;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "lofs")) {
+		entry.flags |= AMD_MOUNT_TYPE_LOFS;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "xfs")) {
+		entry.flags |= AMD_MOUNT_TYPE_XFS;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "ext2") ||
+		   !strcmp(fs_type, "ext3") ||
+		   !strcmp(fs_type, "ext4")) {
+		entry.flags |= AMD_MOUNT_TYPE_EXT;
+		entry.type = fs_type;
+	} else if (!strcmp(fs_type, "ufs")) {
+		entry.flags |= AMD_MOUNT_TYPE_UFS;
+		entry.type = conf_amd_get_linux_ufs_mount_type();
+		if (!entry.type) {
+			amd_msg("memory allocation error");
+			amd_notify(type);
+			free(fs_type);
+			return 0;
+		}
+		free(fs_type);
+	} else if (!strcmp(fs_type, "cdfs")) {
+		entry.flags |= AMD_MOUNT_TYPE_CDFS;
+		entry.type = amd_strdup("iso9660");
+		if (!entry.type) {
+			amd_msg("memory allocation error");
+			amd_notify(map_option);
+			free(fs_type);
+			return 0;
+		}
+		free(fs_type);
+	} else if (!strcmp(fs_type, "jfs") ||
+		   !strcmp(fs_type, "nfsx") ||
+		   !strcmp(fs_type, "program") ||
+		   !strcmp(fs_type, "lustre") ||
+		   !strcmp(fs_type, "direct")) {
+		sprintf(msg_buf, "file system type %s is "
+				 "not yet implemented", fs_type);
+		amd_msg(msg_buf);
+		free(fs_type);
+		return 0;
+	} else if (!strcmp(fs_type, "cachefs")) {
+		sprintf(msg_buf, "file system %s is not "
+				 "supported by autofs, ignored",
+				 fs_type);
+		amd_msg(msg_buf);
+		free(fs_type);
+	} else {
+		amd_notify(fs_type);
+		free(fs_type);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int match_map_option_map_type(char *map_option, char *type)
+{
+	char *map_type;
+
+	map_type = amd_strdup(type);
+	if (!map_type) {
+		amd_notify(type);
+		return 0;
+	}
+
+	if (!strcmp(map_type, "file") ||
+	    !strcmp(map_type, "nis") ||
+	    !strcmp(map_type, "nisplus") ||
+	    !strcmp(map_type, "ldap") ||
+	    !strcmp(map_type, "hesiod")) {
+		entry.map_type = map_type;
+	} else if (!strcmp(map_type, "exec")) {
+		/* autofs uses "program" for "exec" map type */
+		entry.map_type = amd_strdup("program");
+		if (!entry.map_type) {
+			amd_notify(type);
+			free(map_type);
+			return 0;
+		}
+		free(map_type);
+	} else if (!strcmp(map_type, "passwd")) {
+		sprintf(msg_buf, "map type %s is "
+				 "not yet implemented", map_type);
+		amd_msg(msg_buf);
+		free(map_type);
+		return 0;
+	} else if (!strcmp(map_type, "ndbm") ||
+		   !strcmp(map_type, "union")) {
+		sprintf(msg_buf, "map type %s is not "
+				 "supported by autofs", map_type);
+		amd_msg(msg_buf);
+		free(map_type);
+		return 0;
+	} else {
+		amd_notify(type);
+		free(map_type);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int match_map_option_cache_option(char *type)
+{
+	char *cache_opt;
+
+	cache_opt = amd_strdup(type);
+	if (!cache_opt) {
+		amd_notify(type);
+		return 0;
+	}
+
+	if (strncmp(cache_opt, "inc", 3))
+		entry.cache_opts = AMD_CACHE_OPTION_INC;
+	else if (strncmp(cache_opt, "all", 3))
+		entry.cache_opts = AMD_CACHE_OPTION_ALL;
+	else if (strncmp(cache_opt, "re", 2))
+		entry.cache_opts = AMD_CACHE_OPTION_REGEXP;
+	if (strstr(cache_opt, "sync"))
+		entry.cache_opts |= AMD_CACHE_OPTION_SYNC;
+	free(cache_opt);
+
+	return 1;
+}
+
+static int match_mnt_option_options(char *mnt_option, char *options)
+{
+	char *tmp;
+
+	if (!strcmp(mnt_option, "opts")) {
+		tmp = amd_strdup(options);
+		if (!tmp)
+			return 0;
+		entry.opts = tmp;
+	} else if (!strcmp(mnt_option, "addopts")) {
+		tmp = amd_strdup(options);
+		if (!tmp)
+			return 0;
+		entry.addopts = tmp;
+	} else if (!strcmp(mnt_option, "remopts")) {
+		tmp = amd_strdup(options);
+		if (!tmp)
+			return 0;
+		entry.remopts = tmp;
+	} else
+		return 0;
+
+	return 1;
+}
+
 static void prepend_opt(char *dest, char *opt)
 {
 	char new[MAX_OPTS_LEN];

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
