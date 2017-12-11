From: Ian Kent <raven@themaw.net>
Subject: [PATCH 22/27] autofs-5.1.3 - add function construct_argv()
Date: Mon, 11 Dec 2017 16:59:48 +0800
Message-ID: <151298278888.19722.6098298542503573738.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Add a function to decompose a string into a program path and an
arguments vector ready for an execv(3) invocation.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG            |    1 +
 include/parse_subs.h |    1 +
 lib/parse_subs.c     |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/CHANGELOG b/CHANGELOG
index 80a6a5c7..a2e8fe52 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -55,6 +55,7 @@ xx/xx/2017 autofs-5.1.4
 - remove path restriction of amd external mount.
 - add function umount_amd_ext_mount().
 - add function ext_mount_inuse().
+- add function construct_argv().
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/include/parse_subs.h b/include/parse_subs.h
index 1e877167..e2212021 100644
--- a/include/parse_subs.h
+++ b/include/parse_subs.h
@@ -125,6 +125,7 @@ char *sanitize_path(const char *, int, unsigned int, unsigned int);
 char *merge_options(const char *, const char *);
 int expandamdent(const char *, char *, const struct substvar *);
 int expand_selectors(struct autofs_point *, const char *, char **, struct substvar *);
+int construct_argv(char *, char **, char ***);
 void free_map_type_info(struct map_type_info *);
 struct map_type_info *parse_map_type_info(const char *);
 
diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index dd836464..6bb86d3a 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -1196,6 +1196,86 @@ int expand_selectors(struct autofs_point *ap,
 	return len;
 }
 
+/* Get next space seperated argument, arguments containing
+ * space characters may be single quoted.
+ */
+static char *next_arg(char *str, char **next)
+{
+	char *start;
+	char *ptr;
+
+	if (!*str)
+		return NULL;
+
+	start = ptr = str;
+
+	/* The amd map format parser should ensure there
+	 * are matching single quotes.
+	 */
+	if (*start == 39) {
+		start++;
+		ptr++;
+		while (*ptr && *ptr != 39)
+			ptr++;
+	} else {
+		while (*ptr && *ptr != ' ')
+			ptr++;
+	}
+
+	if (*ptr)
+		*ptr++ = 0;
+	*next = ptr;
+
+	return start;
+}
+
+/* Construct program path name plus argument array for use with
+ * execv(3).
+ */
+int construct_argv(char *str, char **prog, char ***argv)
+{
+	char *program = NULL;
+	char *start, *next;
+	char **args, *arg;
+	int argc;
+
+	start = str;
+
+	args = malloc(sizeof(char *));
+	if (!args)
+		return -1;
+
+	args[0] = NULL;
+	argc = 0;
+
+	next = NULL;
+	program = next_arg(str, &next);
+	if (!program) {
+		free(args);
+		return -1;
+	}
+
+	start = next;
+
+	while (1) {
+		if (!*next)
+			break;
+		arg = next_arg(start, &next);
+		if (arg) {
+			argc++;
+			args = add_argv(argc, args, arg);
+			if (!args)
+				return -1;
+		}
+		start = next;
+	}
+
+	*prog = program;
+	*argv = args;
+
+	return argc;
+}
+
 void free_map_type_info(struct map_type_info *info)
 {
 	if (info->type)

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
