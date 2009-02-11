From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/13] autofs-5.0.4 - use CLOEXEC flag for setmntent
Date: Thu, 12 Feb 2009 00:48:31 +0900
Message-ID: <20090211154830.12526.86345.stgit@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs mailing list <autofs@linux.kernel.org>

Update use of CLOEXEC functionality to cover setmntent(3)
calls as well.
---

 CHANGELOG           |    1 +
 include/automount.h |   20 ++++++++++++++++++++
 lib/mounts.c        |    8 ++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index af77b55..eb4a189 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -8,6 +8,7 @@
 - make hash table scale to thousands of entries (Paul Wankadia,
   Valerie Aurora Henson).
 - clear the quoted flag after each character from program map input.
+- use CLOEXEC flag for setmntent also.
 
 4/11/2008 autofs-5.0.4
 -----------------------
diff --git a/include/automount.h b/include/automount.h
index 005d209..46cb6c6 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -581,5 +581,25 @@ static inline FILE *open_fopen_r(const char *path)
 	return f;
 }
 
+static inline FILE *open_setmntent_r(const char *table)
+{
+	FILE *tab;
+
+#if defined(O_CLOEXEC) && defined(SOCK_CLOEXEC)
+	if (cloexec_works != -1) {
+		tab = setmntent(table, "re");
+		if (tab != NULL) {
+			check_cloexec(fileno(tab));
+			return tab;
+		}
+	}
+#endif
+	tab = fopen(table, "r");
+	if (tab == NULL)
+		return NULL;
+	check_cloexec(fileno(tab));
+	return tab;
+}
+
 #endif
 
diff --git a/lib/mounts.c b/lib/mounts.c
index ce4691b..b98e1a4 100644
--- a/lib/mounts.c
+++ b/lib/mounts.c
@@ -218,7 +218,7 @@ struct mnt_list *get_mnt_list(const char *table, const char *path, int include)
 	if (!path || !pathlen || pathlen > PATH_MAX)
 		return NULL;
 
-	tab = setmntent(table, "r");
+	tab = open_setmntent_r(table);
 	if (!tab) {
 		char *estr = strerror_r(errno, buf, PATH_MAX - 1);
 		logerr("setmntent: %s", estr);
@@ -415,7 +415,7 @@ static int table_is_mounted(const char *table, const char *path, unsigned int ty
 	if (!path || !pathlen || pathlen >= PATH_MAX)
 		return 0;
 
-	tab = setmntent(table, "r");
+	tab = open_setmntent_r(table);
 	if (!tab) {
 		char *estr = strerror_r(errno, buf, PATH_MAX - 1);
 		logerr("setmntent: %s", estr);
@@ -489,7 +489,7 @@ int has_fstab_option(const char *opt)
 	if (!opt)
 		return 0;
 
-	tab = setmntent(_PATH_MNTTAB, "r");
+	tab = open_setmntent_r(_PATH_MNTTAB);
 	if (!tab) {
 		char *estr = strerror_r(errno, buf, PATH_MAX - 1);
 		logerr("setmntent: %s", estr);
@@ -668,7 +668,7 @@ struct mnt_list *tree_make_mnt_tree(const char *table, const char *path)
 	size_t plen;
 	int eq;
 
-	tab = setmntent(table, "r");
+	tab = open_setmntent_r(table);
 	if (!tab) {
 		char *estr = strerror_r(errno, buf, PATH_MAX - 1);
 		logerr("setmntent: %s", estr);
