From: Ian Kent <raven@themaw.net>
Subject: [PATCH 16/27] autofs-5.1.3 - fix amd parser double quote handling
Date: Mon, 11 Dec 2017 16:59:13 +0800
Message-ID: <151298275303.19722.5364113023443606857.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

While the natuaral usage of amd maps doesn't use double quotes
it is allowed to use them to enclose option values.

The options mount, umount and unmount usually require them to
preserve spaces in the option value.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 
 modules/amd_parse.y |  150 ++++++++++++++++++++++++++++++++++++++++++++-------
 modules/amd_tok.l   |    4 +
 3 files changed, 132 insertions(+), 23 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 3ad8bd7e..b50158f9 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -49,6 +49,7 @@ xx/xx/2017 autofs-5.1.4
 - remove expand_selectors() on amd parser entry.
 - fix amd defaults map entry handling.
 - refactor amd_parse.c.
+- fix amd parser double quote handling.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/amd_parse.y b/modules/amd_parse.y
index d7f4ef07..52509ca1 100644
--- a/modules/amd_parse.y
+++ b/modules/amd_parse.y
@@ -99,6 +99,7 @@ static int amd_fprintf(FILE *, char *, ...);
 %token CUT
 %token NOT_EQUAL
 %token COMMA
+%token QUOTE
 %token OPTION_ASSIGN
 %token LBRACKET
 %token RBRACKET
@@ -268,62 +269,114 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 	}
 	| MAP_OPTION OPTION_ASSIGN FS_OPT_VALUE
 	{
-		if (!strcmp($1, "fs"))
-			entry.fs = amd_strdup($3);
-		else if (!strcmp($1, "sublink"))
-			entry.sublink = amd_strdup($3);
-		else if (!strcmp($1, "pref")) {
-			if (!strcmp($3, "null"))
-				entry.pref = amd_strdup("");
-			else
-				entry.pref = amd_strdup($3);
+		/* Quoted value for type, maptype or cache assign */
+		if (!strcmp($1, "type")) {
+			if (!match_map_option_fs_type($1, $3))
+				YYABORT;
+		} else if (!strcmp($1, "maptype")) {
+			if (!match_map_option_map_type($1, $3))
+				YYABORT;
+		} else if (!strcmp($1, "cache")) {
+			if (!match_map_option_cache_option($3))
+				YYABORT;
 		} else {
-			amd_notify($1);
-			YYABORT;
+			char *fs_opt_val;
+
+			fs_opt_val = amd_strdup($3);
+			if (!fs_opt_val) {
+				amd_notify($3);
+				YYABORT;
+			}
+
+			if (!strcmp($1, "fs"))
+				entry.fs = fs_opt_val;
+			else if (!strcmp($1, "sublink")) {
+				entry.sublink = fs_opt_val;
+			} else if (!strcmp($1, "pref")) {
+				if (strcmp(fs_opt_val, "null"))
+					entry.pref = fs_opt_val;
+				else {
+					entry.pref = amd_strdup("");
+					if (!entry.pref) {
+						amd_notify($3);
+						free(fs_opt_val);
+						YYABORT;
+					}
+					free(fs_opt_val);
+				}
+			} else {
+				amd_notify($1);
+				free(fs_opt_val);
+				YYABORT;
+			}
 		}
 	}
 	| MAP_OPTION OPTION_ASSIGN
 	{
-		if (!strcmp($1, "fs"))
+		if (!strcmp($1, "fs")) {
 			entry.fs = amd_strdup("");
-		else {
+			if (!entry.fs) {
+				amd_notify($1);
+				YYABORT;
+			}
+		} else {
 			amd_notify($1);
 			YYABORT;
 		}
 	}
 	| FS_OPTION OPTION_ASSIGN FS_OPT_VALUE
 	{
+		char *fs_opt_val;
+
+		fs_opt_val = amd_strdup($3);
+		if (!fs_opt_val) {
+			amd_notify($1);
+			YYABORT;
+		}
+
 		if (!strcmp($1, "rhost"))
-			entry.rhost = amd_strdup($3);
+			entry.rhost = fs_opt_val;
 		else if (!strcmp($1, "rfs"))
-			entry.rfs = amd_strdup($3);
+			entry.rfs = fs_opt_val;
 		else if (!strcmp($1, "dev"))
-			entry.dev = amd_strdup($3);
+			entry.dev = fs_opt_val;
 		else if (!strcmp($1, "mount") ||
 			 !strcmp($1, "unmount") ||
 			 !strcmp($1, "umount")) {
 			amd_info("file system type program is not "
 				 "yet implemented, option ignored");
+			free(fs_opt_val);
 			YYABORT;
 		} else if (!strcmp($1, "delay") ||
 			   !strcmp($1, "cachedir")) {
 			sprintf(msg_buf, "option %s is not used by autofs", $1);
 			amd_info(msg_buf);
+			free(fs_opt_val);
 		} else {
 			amd_notify($1);
+			free(fs_opt_val);
 			YYABORT;
 		}
 	}
 	| FS_OPTION OPTION_ASSIGN
 	{
+		char *empty;
+
+		empty = amd_strdup("");
+		if (!empty) {
+			amd_notify($1);
+			YYABORT;
+		}
+
 		if (!strcmp($1, "rhost"))
-			entry.rhost = amd_strdup("");
+			entry.rhost = empty;
 		else if (!strcmp($1, "rfs"))
-			entry.rfs = amd_strdup("");
+			entry.rfs = empty;
 		else if (!strcmp($1, "dev"))
-			entry.dev = amd_strdup("");
+			entry.dev = empty;
 		else {
 			amd_notify($1);
+			free(empty);
 			YYABORT;
 		}
 	}
@@ -335,6 +388,14 @@ option_assignment: MAP_OPTION OPTION_ASSIGN FS_TYPE
 		}
 		memset(opts, 0, sizeof(opts));
 	}
+	| MNT_OPTION OPTION_ASSIGN QUOTE options QUOTE
+	{
+		if (!match_mnt_option_options($1, $4)) {
+			amd_notify($1);
+			YYABORT;
+		}
+		memset(opts, 0, sizeof(opts));
+	}
 	| MNT_OPTION OPTION_ASSIGN
 	{
 		memset(opts, 0, sizeof(opts));
@@ -601,11 +662,56 @@ static int amd_fprintf(FILE *f, char *msg, ...)
 
 static char *amd_strdup(char *str)
 {
+	unsigned int quoted, len;
 	char *tmp;
 
-	tmp = strdup(str);
-	if (!tmp)
-		amd_error("memory allocation error");
+	len = strlen(str);
+	quoted = 0;
+
+	if (*str == '"') {
+		quoted = 1;
+		len -= 2;
+	}
+
+	tmp = strdup(str + quoted);
+	if (!tmp) {
+		amd_msg("memory allocation error");
+		return NULL;
+	} else {
+		unsigned int squote;
+		char *ptr;
+
+		if (quoted) {
+			if (tmp[len] != '"') {
+				sprintf(msg_buf,
+					"unmatched double quote near: %s", str);
+				amd_info(msg_buf);
+				free(tmp);
+				return NULL;
+			}
+			tmp[len] = 0;
+		}
+
+		/* Check for matching single quotes */
+		if (!strchr(tmp, 39))
+			goto done;
+
+		ptr = tmp;
+		squote = 0;
+		while (*ptr) {
+			if (*ptr == 39)
+				squote = !squote;
+			ptr++;
+		}
+		if (squote) {
+			sprintf(msg_buf,
+				"unmatched single quote near: %s", str);
+			amd_info(msg_buf);
+			free(tmp);
+			return NULL;
+		}
+	}
+done:
 	return tmp;
 }
 
diff --git a/modules/amd_tok.l b/modules/amd_tok.l
index 2eac5cb2..cb1ebf77 100644
--- a/modules/amd_tok.l
+++ b/modules/amd_tok.l
@@ -94,7 +94,7 @@ IP6ADDR		((([A-Fa-f0-9]{1,4}\:\:?){1,7}[A-Fa-f0-9]{1,4})|(\:\:1))
 V6MASK		(12[0-8]|1[0-1][0-9]|[1-9][0-9]|[1-9])
 
 FOPT		(({QSTR}|{FSTR}|{MACRO})+)
-OPTS		({OSTR}(=({VSTR}|{QSTR}|{MACRO})+)?)
+OPTS		({OSTR}(=({VSTR}|{MACRO})+)?)
 SOPT		(({SSTR}|{QSTR}|{MACRO})+)
 NOPT		({SSTR}|(({IP4ADDR}(\/{V4MASK})?)|({IP6ADDR}(\/{V6MASK})?)))
 
@@ -288,6 +288,8 @@ CUTSEP		(\|\||\/)
 
 	,+ { return COMMA; }
 
+	"\"" { return QUOTE; }
+
 	{OPTS} {
 		amd_copy_buffer();
 		return OPTION;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
