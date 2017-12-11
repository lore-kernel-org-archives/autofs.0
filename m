From: Ian Kent <raven@themaw.net>
Subject: [PATCH 23/27] autofs-5.1.3 - add amd mount type program mount
 support
Date: Mon, 11 Dec 2017 16:59:54 +0800
Message-ID: <151298279458.19722.15032994158926200356.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add support for the amd mount type "program" and its option "mount",
and its mutually exclusive options "umount" or "unmount" for specifying
the program to be used to perform the mount and optionally also the
umount.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 
 README.amd-maps     |    6 +-
 include/parse_amd.h |    3 +
 lib/mounts.c        |   42 +++++++++++++++
 modules/amd_parse.y |   36 +++++++++----
 modules/parse_amd.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 216 insertions(+), 15 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a2e8fe52..f3cdcd52 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -56,6 +56,7 @@ xx/xx/2017 autofs-5.1.4
 - add function umount_amd_ext_mount().
 - add function ext_mount_inuse().
 - add function construct_argv().
+- add amd mount type program mount support.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/README.amd-maps b/README.amd-maps
index 386b0688..c7e22c8d 100644
--- a/README.amd-maps
+++ b/README.amd-maps
@@ -146,9 +146,9 @@ always used for available map sources.
 
 The regex map key matching feature is not implemented.
 
-Mount types lustre, nfsx, jfs, program and direct haven't been
-implemented and other mount types that aren't implemented in amd are
-also not available.
+Mount types lustre, nfsx, jfs and direct haven't been implemented
+and other mount types that aren't implemented in amd are also not
+available.
 
 How to find out more
 --------------------
diff --git a/include/parse_amd.h b/include/parse_amd.h
index 16649477..806d6589 100644
--- a/include/parse_amd.h
+++ b/include/parse_amd.h
@@ -30,6 +30,7 @@
 #define AMD_MOUNT_TYPE_JFS	0x00000800
 #define AMD_MOUNT_TYPE_CACHEFS	0x00001000
 #define AMD_MOUNT_TYPE_CDFS	0x00002000
+#define AMD_MOUNT_TYPE_PROGRAM	0x00004000
 #define AMD_MOUNT_TYPE_MASK	0x0000ffff
 
 #define AMD_ENTRY_CUT		0x00010000
@@ -60,6 +61,8 @@ struct amd_entry {
 	char *addopts;
 	char *remopts;
 	char *sublink;
+	char *mount;
+	char *umount;
 	struct selector *selector;
 	struct list_head list;
 	struct list_head entries;
diff --git a/lib/mounts.c b/lib/mounts.c
index 29c8a8f5..8367a50e 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -2064,6 +2064,46 @@ int umount_amd_ext_mount(struct autofs_point *ap, struct amd_entry *entry)
 {
 	int rv = 1;
 
+	if (entry->umount) {
+		char *prog, *str;
+		char **argv;
+		int argc = -1;
+
+		str = strdup(entry->umount);
+		if (!str)
+			goto out;
+
+		prog = NULL;
+		argv = NULL;
+
+		argc = construct_argv(str, &prog, &argv);
+		if (argc == -1) {
+			free(str);
+			goto out;
+		}
+
+		if (!ext_mount_remove(&entry->ext_mount, entry->fs)) {
+			rv =0;
+			goto out;
+		}
+
+		rv = spawnv(ap->logopt, prog, (const char * const *) argv);
+		if (rv == -1 || (WIFEXITED(rv) && WEXITSTATUS(rv)))
+			error(ap->logopt,
+			     "failed to umount program mount at %s", entry->fs);
+		else {
+			rv = 0;
+			debug(ap->logopt,
+			      "umounted program mount at %s", entry->fs);
+			rmdir_path(ap, entry->fs, ap->dev);
+		}
+
+		free_argv(argc, (const char **) argv);
+		free(str);
+
+		goto out;
+	}
+
 	if (ext_mount_remove(&entry->ext_mount, entry->fs)) {
 		rv = umount_ent(ap, entry->fs);
 		if (rv)
@@ -2073,7 +2113,7 @@ int umount_amd_ext_mount(struct autofs_point *ap, struct amd_entry *entry)
 			debug(ap->logopt,
 			      "umounted external mount %s", entry->fs);
 	}
-
+out:
 	return rv;
 }
 
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index 3820d1cb..1d72f190 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -347,13 +347,18 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 			amd_set_value(&entry.rfs, fs_opt_val);
 		else if (!strcmp($1, "dev"))
 			amd_set_value(&entry.dev, fs_opt_val);
-		else if (!strcmp($1, "mount") ||
-			 !strcmp($1, "unmount") ||
+		else if (!strcmp($1, "mount"))
+			amd_set_value(&entry.mount, fs_opt_val);
+		else if (!strcmp($1, "unmount") ||
 			 !strcmp($1, "umount")) {
-			amd_info("file system type program is not "
-				 "yet implemented, option ignored");
-			free(fs_opt_val);
-			YYABORT;
+			if (entry.umount) {
+				sprintf(msg_buf,
+				    "unmount or umount may only be used once");
+				amd_info(msg_buf);
+				free(fs_opt_val);
+				YYABORT;
+			}
+			entry.umount = fs_opt_val;
 		} else if (!strcmp($1, "delay") ||
 			   !strcmp($1, "cachedir")) {
 			sprintf(msg_buf, "option %s is not used by autofs", $1);
@@ -381,7 +386,14 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 			amd_set_value(&entry.rfs, empty);
 		else if (!strcmp($1, "dev"))
 			amd_set_value(&entry.dev, empty);
-		else {
+		else if (!strcmp($1, "mount")) {
+			amd_set_value(&entry.mount, NULL);
+			free(empty);
+		} else if (!strcmp($1, "umount") ||
+			   !strcmp($1, "unmount")) {
+			amd_set_value(&entry.umount, NULL);
+			free(empty);
+		} else {
 			amd_notify($1);
 			free(empty);
 			YYABORT;
@@ -426,8 +438,7 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 options: OPTION
 	{
 		if (!strcmp($1, "fullybrowsable") ||
-		    !strcmp($1, "nounmount") ||
-		    !strcmp($1, "unmount")) {
+		    !strcmp($1, "nounmount")) {
 			sprintf(msg_buf, "option %s is not currently "
 					 "implemented, ignored", $1);
 			amd_info(msg_buf);
@@ -496,7 +507,9 @@ static int match_map_option_fs_type(char *map_option, char *type)
 		   !strcmp(fs_type, "ext3") ||
 		   !strcmp(fs_type, "ext4"))
 		entry.flags |= AMD_MOUNT_TYPE_EXT;
-	} else if (!strcmp(fs_type, "ufs")) {
+	else if (!strcmp(fs_type, "program"))
+		entry.flags |= AMD_MOUNT_TYPE_PROGRAM;
+	else if (!strcmp(fs_type, "ufs")) {
 		entry.flags |= AMD_MOUNT_TYPE_UFS;
 		entry.type = conf_amd_get_linux_ufs_mount_type();
 		if (!entry.type) {
@@ -520,7 +533,6 @@ static int match_map_option_fs_type(char *map_option, char *type)
 		fs_type = NULL;
 	} else if (!strcmp(fs_type, "jfs") ||
 		   !strcmp(fs_type, "nfsx") ||
-		   !strcmp(fs_type, "program") ||
 		   !strcmp(fs_type, "lustre") ||
 		   !strcmp(fs_type, "direct")) {
 		sprintf(msg_buf, "file system type %s is "
@@ -880,6 +892,8 @@ static int add_location(void)
 	new->addopts = entry.addopts;
 	new->remopts = entry.remopts;
 	new->sublink = entry.sublink;
+	new->mount = entry.mount;
+	new->umount = entry.umount;
 	new->selector = entry.selector;
 	list_add_tail(&new->list, entries);
 	memset(&entry, 0, sizeof(struct amd_entry));
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index eeb74d41..0b2440ea 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -788,6 +788,35 @@ next:
 		sv = macro_addvar(sv, "remopts", 7, entry->remopts);
 	}
 
+	if (entry->mount) {
+		if (!expand_selectors(ap, entry->mount, &expand, sv)) {
+			free(entry->mount);
+			if (entry->umount)
+				free(entry->umount);
+			entry->mount = NULL;
+			entry->umount = NULL;
+			goto done;
+		}
+		debug(logopt, MODPREFIX
+		      "mount expand(\"%s\") -> %s", entry->mount, expand);
+		free(entry->mount);
+		entry->mount = expand;
+		sv = macro_addvar(sv, "mount", 5, entry->mount);
+	}
+
+	if (entry->umount) {
+		if (!expand_selectors(ap, entry->umount, &expand, sv)) {
+			free(entry->umount);
+			entry->umount = NULL;
+			goto done;
+		}
+		debug(logopt, MODPREFIX
+		      "umount expand(\"%s\") -> %s", entry->umount, expand);
+		free(entry->umount);
+		entry->umount = expand;
+		sv = macro_addvar(sv, "umount", 5, entry->umount);
+	}
+done:
 	return sv;
 }
 
@@ -1222,6 +1251,91 @@ out:
 	return ret;
 }
 
+static int do_program_mount(struct autofs_point *ap,
+			    struct amd_entry *entry, const char *name)
+{
+	char *prog, *str;
+	char **argv;
+	int argc = -1;
+	int rv = 1;
+
+	str = strdup(entry->mount);
+	if (!str)
+		goto out;
+
+	prog = NULL;
+	argv = NULL;
+
+	argc = construct_argv(str, &prog, &argv);
+	if (argc == -1) {
+		error(ap->logopt, MODPREFIX
+		      "%s: error creating mount arguments", entry->type);
+		free(str);
+		goto out;
+	}
+
+	/* The am-utils documentation doesn't actually say that the
+	 * mount (and umount, if given) command need to use ${fs} as
+	 * the mount point in the command.
+	 *
+	 * For program mounts there's no way to know what the mount
+	 * point is so ${fs} must be used in the mount (and umount,
+	 * if given) in order to create the mount point directory
+	 * before executing the mount command and removing it at
+	 * umount.
+	 */
+	if (ext_mount_inuse(entry->fs)) {
+		rv = 0;
+		ext_mount_add(&entry->ext_mount, entry->fs, 1);
+	} else {
+		rv = mkdir_path(entry->fs, 0555);
+		if (rv && errno != EEXIST) {
+			char *buf[MAX_ERR_BUF];
+			char * estr;
+
+			estr = strerror_r(errno, buf, MAX_ERR_BUF);
+			error(ap->logopt,
+			      MODPREFIX "%s: mkdir_path %s failed: %s",
+			      entry->type, entry->fs, estr);
+			goto do_free;
+		}
+
+		rv = spawnv(ap->logopt, prog, (const char * const *) argv);
+		if (WIFEXITED(rv) && !WEXITSTATUS(rv)) {
+			rv = 0;
+			ext_mount_add(&entry->ext_mount, entry->fs, 1);
+			debug(ap->logopt, MODPREFIX
+			      "%s: mounted %s", entry->type, entry->fs);
+		} else {
+			if (!ext_mount_inuse(entry->fs))
+				rmdir_path(ap, entry->fs, ap->dev);
+			error(ap->logopt, MODPREFIX
+			     "%s: failed to mount using: %s",
+			     entry->type, entry->mount);
+		}
+	}
+do_free:
+	free_argv(argc, (const char **) argv);
+	free(str);
+
+	if (rv)
+		goto out;
+
+	rv = do_link_mount(ap, name, entry, 0);
+	if (!rv)
+		goto out;
+
+	if (umount_amd_ext_mount(ap, entry)) {
+		if (!ext_mount_inuse(entry->fs))
+			rmdir_path(ap, entry->fs, ap->dev);
+		debug(ap->logopt, MODPREFIX
+		      "%s: failed to umount external mount at %s",
+		      entry->type, entry->fs);
+	}
+out:
+	return rv;
+}
+
 static unsigned int validate_auto_options(unsigned int logopt,
 					  struct amd_entry *entry)
 {
@@ -1348,6 +1462,29 @@ static unsigned int validate_host_options(unsigned int logopt,
 	return 1;
 }
 
+static unsigned int validate_program_options(unsigned int logopt,
+					     struct amd_entry *entry)
+{
+	/*
+	 * entry->mount will be NULL if there is a problem expanding
+	 * ${} macros in expandamdent().
+	 */
+	if (!entry->mount) {
+		error(logopt, MODPREFIX
+		      "%s: mount program invalid or not set", entry->type);
+		return 0;
+	}
+
+	if (!entry->fs && !*entry->fs) {
+		error(logopt, MODPREFIX
+		    "%s: ${fs} must be used as the mount point but is not set",
+		    entry->type);
+		return 0;
+	}
+
+	return 1;
+}
+
 static int amd_mount(struct autofs_point *ap, const char *name,
 		     struct amd_entry *entry, struct map_source *source,
 		     struct substvar *sv, unsigned int flags,
@@ -1413,6 +1550,12 @@ static int amd_mount(struct autofs_point *ap, const char *name,
 		ret = do_host_mount(ap, name, entry, source, flags);
 		break;
 
+	case AMD_MOUNT_TYPE_PROGRAM:
+		if (!validate_program_options(ap->logopt, entry))
+			return 1;
+		ret = do_program_mount(ap, entry, name);
+		break;
+
 	default:
 		info(ap->logopt,
 		     MODPREFIX "unknown file system type %x", fstype);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
