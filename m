From: Ian Kent <raven@themaw.net>
Subject: [PATCH 17/27] autofs-5.1.3 - fix expandamdent() quote handling
Date: Mon, 11 Dec 2017 16:59:18 +0800
Message-ID: <151298275881.19722.162124131096804435.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

The amd map entry option value expansion isn't quite right.

It shouldn't be possible to get double quotes in a map entry option
value, only single quotes should be seen. And within single quotes
only expand ${} macros.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG        |    1 +
 lib/parse_subs.c |   23 ++++++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index b50158f9..5635c6a3 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -50,6 +50,7 @@ xx/xx/2017 autofs-5.1.4
 - fix amd defaults map entry handling.
 - refactor amd_parse.c.
 - fix amd parser double quote handling.
+- fix expandamdent() quote handling.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index fc9b6474..dd836464 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -1033,12 +1033,12 @@ static char *expand_slash_or_dot(char *str, unsigned int type)
  * $-expand an amd-style map entry and return the length of the entry.
  * If "dst" is NULL, just count the length.
  */
-/* TODO: how should quoting be handled? */
 int expandamdent(const char *src, char *dst, const struct substvar *svc)
 {
 	unsigned int flags = conf_amd_get_flags(NULL);
 	const struct substvar *sv;
 	const char *o_src = src;
+	unsigned int squote = 0;
 	int len, l;
 	const char *p;
 	char ch;
@@ -1109,7 +1109,7 @@ int expandamdent(const char *src, char *dst, const struct substvar *svc)
 			break;
 
 		case '\\':
-			if (!(flags & CONF_NORMALIZE_SLASHES)) {
+			if (squote || !(flags & CONF_NORMALIZE_SLASHES)) {
 				len++;
 				if (dst)
 					*dst++ = ch;
@@ -1129,7 +1129,7 @@ int expandamdent(const char *src, char *dst, const struct substvar *svc)
 			if (dst)
 				*dst++ = ch;
 
-			if (!(flags & CONF_NORMALIZE_SLASHES))
+			if (squote || !(flags & CONF_NORMALIZE_SLASHES))
 				break;
 
 			/* Double slash at start is allowed */
@@ -1143,23 +1143,12 @@ int expandamdent(const char *src, char *dst, const struct substvar *svc)
 				src++;
 			break;
 
-		case '"':
+		/* 39 is single quote */
+		case 39:
 			len++;
 			if (dst)
 				*dst++ = ch;
-
-			while (*src && *src != '"') {
-				len++;
-				if (dst)
-					*dst++ = *src;
-				src++;
-			}
-			if (*src) {
-				len++;
-				if (dst)
-					*dst++ = *src;
-				src++;
-			}
+			squote = !squote;
 			break;
 
 		default:

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
