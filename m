From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/19] autofs-5.1.3 - fix unset tsd group name handling
Date: Wed, 02 Aug 2017 10:17:15 +0800
Message-ID: <150164023526.6106.17582507413814713044.stgit@pluto.themaw.net>
References: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <150164013844.6106.10264212633586462386.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Commit 1a64a6bbc5 changed set_tsd_user_vars() to set thread specific
values even if the group name could not be obtained.

But the structure holding the values was not initialized on allocation
so the group field might not be NULL when no group name is available.

Also the macro addition and removal functions didn't properly handle a
macro value of NULL.

Signed-off-by: Ian Kent <raven@themaw.net>
Reported-by: Donald Buczek <buczek@molgen.mpg.de>
---
 CHANGELOG    |    1 +
 lib/macros.c |    8 +++++---
 lib/mounts.c |    1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index e796fb36..8d79bd60 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,5 +1,6 @@
 xx/xx/2017 autofs-5.1.4
 - fix spec file url.
+- fix unset tsd group name handling.
 
 24/05/2017 autofs-5.1.3
 =======================
diff --git a/lib/macros.c b/lib/macros.c
index ff9ba899..dfdca857 100644
--- a/lib/macros.c
+++ b/lib/macros.c
@@ -281,18 +281,20 @@ macro_addvar(struct substvar *table, const char *str, int len, const char *value
 	}
 
 	if (lv) {
-		char *this = malloc(strlen(value) + 1);
+		const char *val = value ? value : "";
+		char *this = malloc(strlen(val) + 1);
 		if (!this) {
 			lv = table;
 			goto done;
 		}
-		strcpy(this, value);
+		strcpy(this, val);
 		free(lv->val);
 		lv->val = this;
 		if (lv != table)
 			lv = table;
 	} else {
 		struct substvar *new;
+		const char *this = value ? value : "";
 		char *def, *val;
 
 		def = strdup(str);
@@ -302,7 +304,7 @@ macro_addvar(struct substvar *table, const char *str, int len, const char *value
 		}
 		def[len] = '\0';
 
-		val = strdup(value);
+		val = strdup(this);
 		if (!val) {
 			lv = table;
 			free(def);
diff --git a/lib/mounts.c b/lib/mounts.c
index ce6a60a7..0b38bd86 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -1463,6 +1463,7 @@ void set_tsd_user_vars(unsigned int logopt, uid_t uid, gid_t gid)
 		error(logopt, "failed alloc tsv storage");
 		return;
 	}
+	memset(tsv, 0, sizeof(struct thread_stdenv_vars));
 
 	tsv->uid = uid;
 	tsv->gid = gid;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
