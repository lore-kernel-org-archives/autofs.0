From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/19] autofs-5.1.3 - fix a couple of compiler warnings
Date: Wed, 02 Aug 2017 10:18:10 +0800
Message-ID: <150164029020.6106.18205535569416167847.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Fix a few compiler warnings that have been around far too long.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG               |    1 +
 daemon/spawn.c          |   20 ++++++++++++++++----
 lib/master_tok.l        |    2 ++
 lib/parse_subs.c        |    2 +-
 modules/base64.c        |    2 +-
 modules/lookup_file.c   |    4 ----
 modules/lookup_hesiod.c |    3 ---
 7 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 6492fab3..823b0832 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -10,6 +10,7 @@ xx/xx/2017 autofs-5.1.4
 - fix typos in autofs man pages.
 - use pkg-config to search for libtirpc to fix cross-compilation.
 - fix incorrect status return in get_nfs_info().
+- fix a couple of compiler warnings.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 4515607b..b931d678 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -195,8 +195,14 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 			 * program group to trigger mount
 			 */
 			if (euid) {
-				seteuid(euid);
-				setegid(egid);
+				if (seteuid(euid) == -1)
+					fprintf(stderr,
+						"warning: seteuid: %s\n",
+						strerror(errno));
+				if (setegid(egid) == -1)
+					fprintf(stderr,
+						"warning: setegid: %s\n",
+						strerror(errno));
 			}
 			setpgrp();
 
@@ -212,8 +218,14 @@ static int do_spawn(unsigned logopt, unsigned int wait,
 			if (fd != -1)
 				close(fd);
 
-			seteuid(0);
-			setegid(0);
+			if (seteuid(0) == -1)
+				fprintf(stderr,
+					"warning: seteuid: %s\n",
+					strerror(errno));
+			if (setegid(0) == -1)
+				fprintf(stderr,
+					"warning: setegid: %s\n",
+					strerror(errno));
 			if (pgrp >= 0)
 				setpgid(0, pgrp);
 
diff --git a/lib/master_tok.l b/lib/master_tok.l
index b32918d1..63dab50d 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -475,7 +475,9 @@ void master_set_scan_buffer(const char *buffer)
 	line_lim = line + strlen(buffer) + 1;
 }
 
+#ifndef min
 #define min(a,b) (((a) < (b)) ? (a) : (b))
+#endif
 
 int my_yyinput(char *buffer, int max_size)
 {
diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index 80383c20..fc9b6474 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -795,7 +795,7 @@ char *sanitize_path(const char *path, int origlen, unsigned int type, unsigned i
 	unsigned int seen_slash = 0, quote = 0, dquote = 0;
 
 	if (type & (LKP_INDIRECT | LKP_DIRECT)) {
-		char *tmp = path;
+		const char *tmp = path;
 
 		if (*tmp == '"')
 			tmp++;
diff --git a/modules/base64.c b/modules/base64.c
index 0bb356a2..3e9406ff 100644
--- a/modules/base64.c
+++ b/modules/base64.c
@@ -12,7 +12,7 @@ static const char *BASE64_CHARS =
  * @param triple three bytes that should be encoded
  * @param result buffer of four characters where the result is stored
  */
-static void _base64_encode_triple(char triple[3], char result[4])
+static void _base64_encode_triple(unsigned char triple[3], char result[4])
 {
 	int tripleValue, i;
 
diff --git a/modules/lookup_file.c b/modules/lookup_file.c
index b548ac35..e2d248e0 100644
--- a/modules/lookup_file.c
+++ b/modules/lookup_file.c
@@ -1092,13 +1092,9 @@ static int map_update_needed(struct autofs_point *ap,
 			     struct map_source *source,
 			     struct lookup_context *ctxt)
 {
-	struct mapent_cache *mc;
-	struct mapent *me;
 	struct stat st;
 	int ret = 1;
 
-	mc = source->mc;
-
 	/*
 	 * We can skip the map lookup and cache update altogether
 	 * if we know the map hasn't been modified since it was
diff --git a/modules/lookup_hesiod.c b/modules/lookup_hesiod.c
index 3bd62008..298ebc75 100644
--- a/modules/lookup_hesiod.c
+++ b/modules/lookup_hesiod.c
@@ -363,7 +363,6 @@ done:
 int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *context)
 {
 	struct lookup_context *ctxt = (struct lookup_context *) context;
-	struct mapent_cache *mc;
 	char buf[MAX_ERR_BUF];
 	struct map_source *source;
 	struct mapent *me;
@@ -378,8 +377,6 @@ int lookup_mount(struct autofs_point *ap, const char *name, int name_len, void *
 	ap->entry->current = NULL;
 	master_source_current_signal(ap->entry);
 
-	mc = source->mc;
-
 	debug(ap->logopt,
 	      MODPREFIX "looking up root=\"%s\", name=\"%s\"",
 	      ap->path, name);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
