From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 1/8] Added the dumpmap option
	and updated manpage
Date: Tue, 14 Dec 2010 13:44:52 +1300
Message-ID: <a73be8799c7b7a33d6376b4ead68d112f61c2e93.1295972820.git.bill.ryder.nz@gmail.com>
References: <cover.1295972820.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1295972820.git.bill.ryder.nz@gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

---
 CHANGELOG           |    8 ++++++++
 daemon/automount.c  |   21 +++++++++++++++++++--
 include/automount.h |    3 +++
 lib/cache.c         |   10 ++++++++++
 man/automount.8     |    3 +++
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index e9dbb63..467e90a 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,11 @@
+16/6/2010 autofs-4.1.4 - bryder p37
+-------------------------
+Moved the autofs-4.1.3 version of the dump map patch to 4.1.4 (without the lookup_files hack)
+It adds the --dumpmap or -D argument to dump maps read by the daemon - then the daemon exits. 
+Also help to the automount.c command for this option and updated the man page.
+Only tested with LDAP.
+
+
 11/4/2005 autofs-4.1.4
 ----------------------
 - add /proc/modules check to Debian init script.
diff --git a/daemon/automount.c b/daemon/automount.c
index bbcab6a..93e3ff7 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -55,6 +55,7 @@ static char *pid_file = NULL;	/* File in which to keep pid */
 
 int kproto_version;		/* Kernel protocol version used */
 int kproto_sub_version = 0;	/* Kernel protocol version used */
+int dumpmap = 0;		/* cmdline arg to dump map contents */
 
 static int submount = 0;
 
@@ -1380,6 +1381,8 @@ static unsigned long getnumopt(char *str, char option)
 static void usage(void)
 {
 	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
+	fprintf(stderr, "   -D|--dumpmap dumps out the maps read and exits\n");
+
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1671,6 +1674,7 @@ int main(int argc, char *argv[])
 		{"version", 0, 0, 'V'},
 		{"ghost", 0, 0, 'g'},
 		{"submount", 0, &submount, 1},
+		{"dumpmap", 0, 0, 'D'},
 		{0, 0, 0, 0}
 	};
 
@@ -1683,7 +1687,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgD", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1713,6 +1717,9 @@ int main(int argc, char *argv[])
 			ap.ghost = LKP_GHOST;
 			break;
 
+		case 'D':
+			dumpmap = 1;
+			break;
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
@@ -1734,7 +1741,8 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	become_daemon();
+	if (!dumpmap)
+		become_daemon();
 
 	path = argv[0];
 	map = argv[1];
@@ -1762,6 +1770,15 @@ int main(int argc, char *argv[])
 	if (!(ap.lookup = open_lookup(map, "", mapfmt, mapargc, mapargv)))
 		cleanup_exit(path, 1);
 
+	if (dumpmap) {
+		int ret;
+		ret = ap.lookup->lookup_ghost(ap.path, ap.ghost,
+					      0, ap.lookup->context);
+		if (ret & LKP_FAIL)
+			exit(ret);
+		exit(0);
+	}
+
 	if (!strncmp(path, "/-", 2)) {
 		supervisor(path);
 	} else {
diff --git a/include/automount.h b/include/automount.h
index d2f5d70..64ff83d 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -286,6 +286,9 @@ int allow_owner_mount(const char *);
 extern int do_verbose;
 extern int do_debug;
 
+/* command line option to print out included map contents */
+extern int dumpmap;
+
 #define info(msg, args...) 		\
 if (do_verbose || do_debug) 		\
 	syslog(LOG_INFO, msg, ##args);
diff --git a/lib/cache.c b/lib/cache.c
index 781c980..5a01079 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -169,6 +169,11 @@ int cache_add(const char *root, const char *key, const char *mapent, time_t age)
 	char *pkey, *pent;
 	unsigned int hashval = hash(key);
 
+	if (dumpmap) {
+		fprintf(stdout, "%s %s\n", key, mapent);
+		return CHE_OK;
+	}
+
 	me = (struct mapent_cache *) malloc(sizeof(struct mapent_cache));
 	if (!me)
 		return CHE_FAIL;
@@ -221,6 +226,11 @@ int cache_update(const char *root, const char *key, const char *mapent, time_t a
 	char *pent;
 	int ret = CHE_OK;
 
+	if (dumpmap) {
+		fprintf(stdout, "%s %s\n", key, mapent);
+		return CHE_OK;
+	}
+
 	for (s = mapent_hash[hash(key)]; s != NULL; s = s->next)
 		if (strcmp(key, s->key) == 0)
 			me = s;
diff --git a/man/automount.8 b/man/automount.8
index 2b63959..e640656 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -43,6 +43,9 @@ until accesssed. The wildcard map is not ghosted.
 .TP
 .I "\-V, \-\-version"
 Display the version number, then exit.
+.TP
+.I "\-D, \-\-dumpmap"
+Dumps the maps read and exits.
 .SH ARGUMENTS
 \fBautomount\fP takes at least three arguments.  Mandatory arguments 
 include \fImount-point\fP, \fImap-type\fP, and \fImap\fP.  Both mandatory
-- 
1.7.3.4
