From: Ian Kent <raven@themaw.net>
Subject: [PATCH 32/37] autofs-5.1.2 - include amd mount section mounts in
 master mounts list
Date: Tue, 25 Oct 2016 09:20:16 +0800
Message-ID: <20161025012015.7778.59245.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=QvsYYsWm9Ba4tpU0HSYJ6mV9ePQ=; b=OWGDN4rF1K4fEtPjqs
        C2OA08D9czfwnK1amChuIX+mZ+J7vz7MWKfG1SB9JOjvFK7VB+TfLxc1XZ0IfCkp
        rBZt+4+UATAb51TVRP6DWS54XQjtqkPwgLVNTs4YrBgF0gFbX+q67gccm4xZSo/c
        xjsEtd6M8PZDvWc/wWYew5JnE=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=QvsYYsWm9Ba4tpU0HSYJ6m
        V9ePQ=; b=ewlfYIIjOYjVxGZ4TjM/x3gCUqa8V6LbU+mQvV1wkj9Sdgl0+5Ac4B
        uKJsYxAxw/GZvfcmzGRgDTU2NAEQlqY3Vz67yftaSKYjyc0+yrcDTqSJtNQkX0Zw
        Jso2VfwVEov6RHaGRfTGnAwwX2To+Bu8L5mknGF33SgjuGjhl0kwM=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs mailing list <autofs@vger.kernel.org>

Currently a master map entry is required for amd format maps and
top level amd mount path configuration sections can only used to
provide additional per-mount configuration.

But being able to use the top level amd format mount path
configuration sections alone allows potentially incompatible
master map entries to not be included in the master map.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG       |    1 +
 README.amd-maps |   49 +++++++++++++++++++++----
 lib/master.c    |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+), 7 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 0853484..3a1b534 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -29,6 +29,7 @@ xx/xx/2016 autofs-5.1.3
 - add support for amd browsable option.
 - add function conf_amd_get_map_name().
 - add function conf_amd_get_mount_paths().
+- include amd mount sections mounts in master mounts list.
 
 15/06/2016 autofs-5.1.2
 =======================
diff --git a/README.amd-maps b/README.amd-maps
index 4f1d58d..386b068 100644
--- a/README.amd-maps
+++ b/README.amd-maps
@@ -9,8 +9,10 @@ How to use amd maps in autofs
 
 To add amd map parsing to autofs a new "format" module has been added.
 
-To use this new map format module the existing master map syntax is
-used as described below.
+There are two ways to use this new map format module. First, the existing
+master map syntax can be used as described below, and second, sections that
+use the top level mount path may be added to the autofs configuration below
+the "amd" section in much the same way as is done with amd.
 
 The master map entry syntax is:
 
@@ -21,8 +23,22 @@ For amd format maps this becomes:
 /amd/mp   file,amd:amd.mp
 
 which will use file as the map source and the amd format parser for
-the map. But see the section below on configuration for how to
-eliminate the need to specify "map-type,format" in the master map.
+the map.
+
+In order to use nsswitch to specify the map source an amd per-mount
+section needs to be added to the autofs configuration so autofs
+knows the master map entry is an amd format mount.
+
+If an amd-per-mount section is added to the autofs configuration a
+corresponding master map entry is optional. If both are present the
+map name given in the master map entry will override a "map_name"
+option in the amd per-mount section.
+
+If an amd per-mount section is used alone then not giving the "map_type"
+option will alow the use of nsswicth for map selection.
+
+See below for an example of an amd per-mount configuration entry.
+
 
 Configuration sub-system changes
 --------------------------------
@@ -56,12 +72,19 @@ avoid the need to specify the "type,format" part of the master map
 entry. This allows them to use the nsswitch map source functionality
 in the same way autofs master map entries do.
 
+If amd per-mount sections are present in the autofs configuration
+their corresponding master map entries are optional. This allows
+amd maps to be used without adding incompatible entries to the autofs
+master map in shared infrastructure environments.
+
 If a section for an amd mount is added below the global amd section
 using the mount point path (as is done in amd.conf) then autofs will
 know the map format is amd (it doesn't matter if there are no other
-configuration options in the mount point section). Since the map must
-be given in the master map entry the map_name option is not mandatory
-as it is in amd and will no be used.
+configuration options in the mount point section).
+
+If there is a corresponding master map entry the map given in the
+master map entry will be used over the map_name option if it is
+present in an amd per-mount section.
 
 If a mount point is present in the master map and the source of the
 map is nis then it is sufficient to use (for example):
@@ -86,6 +109,18 @@ or
 [ /amd/mp ]
 map_type = nis
 
+An example of an amd per-mount configuration entry is:
+
+[ amd ]
+...
+
+[ /test ]
+map_name = /etc/amd.test
+#map_type = file
+#search_path =			/etc
+#browsable_dirs =		yes | no
+browsable_dirs =		yes
+
 
 amd map options that can be used
 --------------------------------
diff --git a/lib/master.c b/lib/master.c
index fceb5dd..ba48d1b 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -911,6 +911,114 @@ struct master *master_new(const char *name, unsigned int timeout, unsigned int g
 	return master;
 }
 
+static void master_add_amd_mount_section_mounts(struct master *master, time_t age)
+{
+	unsigned int m_logopt = master->logopt;
+	struct master_mapent *entry;
+	struct map_source *source;
+	unsigned int loglevel;
+	unsigned int logopt;
+	unsigned int flags;
+	char *argv[2];
+	char **paths;
+	int ret;
+	int i;
+
+	loglevel = conf_amd_get_log_options();
+
+	paths = conf_amd_get_mount_paths();
+	if (!paths)
+		return;
+
+	i = 0;
+	while (paths[i]) {
+		const char *path = paths[i];
+		unsigned int ghost = 0;
+		char *type = NULL;
+		char *map = NULL;
+
+		entry = master_find_mapent(master, path);
+		if (entry) {
+			info(m_logopt,
+			     "ignoring duplicate amd section mount %s",
+			     path);
+			goto next;
+		}
+
+		map = conf_amd_get_map_name(path);
+		if (!map) {
+			error(m_logopt,
+			      "failed to get map name for amd section mount %s",
+			      path);
+			goto next;
+		}
+
+		entry = master_new_mapent(master, path, age);
+		if (!entry) {
+			error(m_logopt,
+			      "failed to allocate new amd section mount %s",
+			      path);
+			goto next;
+		}
+
+		logopt = m_logopt;
+		if (loglevel <= LOG_DEBUG && loglevel > LOG_INFO)
+			logopt = LOGOPT_DEBUG;
+		else if (loglevel <= LOG_INFO && loglevel > LOG_ERR)
+			logopt = LOGOPT_VERBOSE;
+
+		/* It isn't possible to provide the fullybrowsable amd
+		 * browsing functionality within the autofs framework.
+		 * This flag will not be set if browsable_dirs = full
+		 * in the configuration or fullybrowsable is present as
+		 * an option.
+		 */
+		flags = conf_amd_get_flags(path);
+		if (flags & CONF_BROWSABLE_DIRS)
+			ghost = 1;
+
+		ret = master_add_autofs_point(entry, logopt, 0, ghost, 0);
+		if (!ret) {
+			error(m_logopt, "failed to add autofs_point");
+			master_free_mapent(entry);
+			goto next;
+		}
+
+		type = conf_amd_get_map_type(path);
+		argv[0] = map;
+		argv[1] = NULL;
+
+		source = master_add_map_source(entry, type, "amd",
+					       age, 1, (const char **) argv);
+		if (!source) {
+			error(m_logopt,
+			      "failed to add source for amd section mount %s",
+			      path);
+			master_free_mapent(entry);
+			goto next;
+		}
+
+		source->exp_timeout = conf_amd_get_dismount_interval(path);
+		source->master_line = 0;
+
+		entry->age = age;
+		entry->current = NULL;
+
+		master_add_mapent(master, entry);
+next:
+		if (type)
+			free(type);
+		if (map)
+			free(map);
+		i++;
+	}
+
+	i = 0;
+	while (paths[i])
+		free(paths[i++]);
+	free(paths);
+}
+
 int master_read_master(struct master *master, time_t age, int readall)
 {
 	unsigned int logopt = master->logopt;
@@ -939,6 +1047,7 @@ int master_read_master(struct master *master, time_t age, int readall)
 	master_init_scan();
 	lookup_nss_read_master(master, age);
 	cache_unlock(nc);
+	master_add_amd_mount_section_mounts(master, age);
 	master_mutex_unlock();
 
 	if (!master->read_fail)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
