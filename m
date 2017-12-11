From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/27] autofs-5.1.3 - add missing MODPREFIX to logging in
 amd parser
Date: Mon, 11 Dec 2017 16:58:44 +0800
Message-ID: <151298272422.19722.10381894417698896918.stgit@pluto.themaw.net>
References: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151298256987.19722.18421086447160152668.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Some of the logging in the amd parser is missing the log identifier
MODPREFIX so add it.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG           |    1 +
 modules/parse_amd.c |   25 ++++++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index a7903875..d6016984 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -44,6 +44,7 @@ xx/xx/2017 autofs-5.1.4
 - serialize calls to open_xxxx() functions.
 - improve debug logging of lookup key.
 - fix typo in amd_parse.c.
+- add missing MODPREFIX to logging in amd parser.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/modules/parse_amd.c b/modules/parse_amd.c
index 2ff43fa8..f2332b15 100644
--- a/modules/parse_amd.c
+++ b/modules/parse_amd.c
@@ -245,7 +245,7 @@ static int match_my_name(unsigned int logopt, const char *name, struct substvar
 	}
 
 	if (!v || !v->val) {
-		error(logopt, "error: ${host} not set");
+		error(logopt, MODPREFIX "error: ${host} not set");
 		goto out;
 	}
 
@@ -259,7 +259,7 @@ static int match_my_name(unsigned int logopt, const char *name, struct substvar
 	/* Get host canonical name */
 	ret = getaddrinfo(v->val, NULL, &hints, &cni);
 	if (ret) {
-		error(logopt,
+		error(logopt, MODPREFIX
 		      "hostname lookup failed: %s\n", gai_strerror(ret));
 		goto out;
 	}
@@ -269,7 +269,7 @@ static int match_my_name(unsigned int logopt, const char *name, struct substvar
 	/* Resolve comparison name to its names and compare */
 	ret = getaddrinfo(name, NULL, &hints, &ni);
 	if (ret) {
-		error(logopt,
+		error(logopt, MODPREFIX
 		      "hostname lookup failed: %s\n", gai_strerror(ret));
 		freeaddrinfo(cni);
 		goto out;
@@ -282,7 +282,7 @@ static int match_my_name(unsigned int logopt, const char *name, struct substvar
 				  numeric, sizeof(numeric), NULL, 0,
 				  NI_NUMERICHOST);
 		if (ret) {
-			error(logopt,
+			error(logopt, MODPREFIX
 			      "host address info lookup failed: %s\n",
 			      gai_strerror(ret));
 			goto next;
@@ -292,7 +292,7 @@ static int match_my_name(unsigned int logopt, const char *name, struct substvar
 		ret = getnameinfo(haddr->ai_addr, haddr->ai_addrlen,
 				  host, NI_MAXHOST, NULL, 0, 0);
 		if (ret) {
-			error(logopt,
+			error(logopt, MODPREFIX
 			      "host address info lookup failed: %s\n",
 			      gai_strerror(ret));
 			goto next;
@@ -328,7 +328,8 @@ static int eval_selector(unsigned int logopt,
 	case SEL_FLAG_MACRO:
 		v = macro_findvar(sv, s->sel->name, strlen(s->sel->name));
 		if (!v) {
-			error(logopt, "failed to get selector %s", s->sel->name);
+			error(logopt, MODPREFIX
+			      "failed to get selector %s", s->sel->name);
 			return 0;
 		}
 
@@ -497,7 +498,7 @@ static int eval_selector(unsigned int logopt,
 				else
 					v = macro_findvar(sv, "hostd", 5);
 				if (!v || !*v->val) {
-					error(logopt,
+					error(logopt, MODPREFIX
 					     "failed to get value of ${host}");
 					break;
 				}
@@ -664,7 +665,8 @@ static char *normalize_hostname(unsigned int logopt, const char *host,
 
 		ret = getaddrinfo(host, NULL, &hints, &ni);
 		if (ret) {
-			error(logopt, "hostname lookup failed: %s", gai_strerror(ret));
+			error(logopt, MODPREFIX
+			      "hostname lookup failed: %s", gai_strerror(ret));
 			return NULL;
 		}
 		name = strdup(ni->ai_canonname);
@@ -1300,7 +1302,7 @@ static unsigned int validate_generic_options(unsigned int logopt,
 			 * Can't use entry->type as the mount type to reprot
 			 * the error since entry->type == "bind" not "lofs".
 			 */
-			error(logopt, "lofs: mount device not given");
+			error(logopt, MODPREFIX "lofs: mount device not given");
 			return 0;
 		} else if (!*entry->rfs)
 			return 0;
@@ -1573,7 +1575,7 @@ static int match_selectors(unsigned int logopt,
 
 	/* No selectors, always match */
 	if (!s) {
-		debug(logopt, "no selectors found in location");
+		debug(logopt, MODPREFIX "no selectors found in location");
 		return 1;
 	}
 
@@ -1998,7 +2000,8 @@ int parse_mount(struct autofs_point *ap, const char *name,
 	free_amd_entry(cur_defaults);
 
 	if (rv)
-		debug(ap->logopt, "no more locations to try, returning fail");
+		debug(ap->logopt, MODPREFIX
+		      "no more locations to try, returning fail");
 done:
 	free_amd_entry_list(&entries);
 	free_amd_entry(defaults_entry);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
