From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 5/8] Added option to ignore
	some highly unlikely paths before forking daemon
Date: Mon, 10 Jan 2011 14:27:27 +1300
Message-ID: <9493c308c18a0b41143fda34f1d6882592a5f825.1295972820.git.bill.ryder.nz@gmail.com>
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
 CHANGELOG           |   35 +++++++++++++++++++++++++++++++++++
 daemon/automount.c  |   51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 include/automount.h |    5 +++++
 man/automount.8     |   10 ++++++++++
 4 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 04043c5..9b0a418 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,38 @@
+01/07/2010 autofs-4.1.4 - bryder p41
+---------------------------
+ Adds the -I or --ignore-stupid-paths option.
+ 
+ The kernel nicely formats the path to mount up so that there are no extraneous dots or anything in it.
+ And it's just the part relative to the top level automount that gets passed to the daemon.
+ 
+ The -I option makes the automount daemon  return a fail to the kernel for any path with a '*' in it or 
+ if the path begins with a dot or if the path matches 'automount(pid'. 
+
+ It does this before it forks so it's very fast.
+
+ The odds are very good that no legimate path will be ignored. It's definitely true for my case but
+ YMMV.
+
+ The '*' paths are bad when you use ldap because it will match a lot of mount 
+ points and the first entry returned by the ldap search will be mounted  as /toplevelthing/*. 
+ 
+ The .blahblah paths are excluded because when serving NFS out to OSX and Windows via SAMBA 
+ we've found that OSX in particular will try to open a .directoryname for every directoryname 
+ in a mountpoint when browsing. This can be slow  when ghosting is on and you have a lot of 
+ mount points. Using this option it takes 0.001s more or less  to return a fail, without 
+ it it takes around 0.04s on the machine I tested. Mainly because the autmounter  forks before 
+ looking up the path. So 140 directories will delay you around 6s when a finder 
+ visits that top level automounter with that many entries. The 5.x automounter daemon doesn't fork so 
+ this is no such a big problem.
+
+ The 'automount(pid' path was added because samba will look for this path when it tries to get 
+ quotas on mount points.  I know I should fix samba but for now I'm adding it to the hacks 
+ I've already done for stupid paths. 
+
+ Ideally the automounter would have a list of regexes to ignore passed by command line option or config file 
+ but this patch hardcodes them.
+
+ 
 29/06/2010 autofs-4.1.4-p40
 ---------------------------
   Reinstates the jmoyer ldap-cleanup.patch from 4.1.3 which does cleaner LDAP schema handling. 
diff --git a/daemon/automount.c b/daemon/automount.c
index 0ef9cbb..2509431 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1013,6 +1013,34 @@ static int get_pkt(int fd, union autofs_packet_union *pkt)
 	}
 }
 
+static int is_path_stupid(const char *name)
+{ 
+	/* Returns 1 if the path contains a '*' or starts with a '.' */
+	if (strchr(name,'*')){ /* Any * in the ldap search will match - at least for our servers - DO NOT WANT! */
+		debug("%s: path: %s matches '*' - ignoring it",
+		      __func__,name);
+		return(1);
+	}
+	else if (name[0] == '.'){
+		debug("%s: path: %s starts with a dot (.)  - ignoring it",
+		      __func__,name);
+		return(1);
+	}
+	else if (strstr(name,"automount(pid")){
+		/* Samba has a habit of trying to mount up /mp/automount(pidNNNNN) - which of course fails */
+		/* It does this because it sees autmount(pidNNNN) /mp autofs etc etc in /etc/mtab and tries to get quota info for it */
+		/* I know I should fix samba but this is easier  for now */
+		debug("%s: path: %s contains 'automount(pid' - ignoring it",
+		      __func__,name);
+		return(1);
+
+		
+	}
+	else {
+		return(0);
+	}
+}
+
 static int handle_packet_missing(const struct autofs_packet_missing *pkt)
 {
 	struct stat st;
@@ -1020,8 +1048,8 @@ static int handle_packet_missing(const struct autofs_packet_missing *pkt)
 	pid_t f;
 	struct pending_mount *mt = NULL;
 
-	debug("handle_packet_missing: token %ld, name %s\n",
-		(unsigned long) pkt->wait_queue_token, pkt->name);
+	debug("handle_packet_missing: token %ld, mp %s name %s\n",
+	      (unsigned long) pkt->wait_queue_token, ap.path, pkt->name);
 
 	/* Ignore packet if we're trying to shut down */
 	if (ap.state == ST_SHUTDOWN_PENDING || ap.state == ST_SHUTDOWN) {
@@ -1029,6 +1057,18 @@ static int handle_packet_missing(const struct autofs_packet_missing *pkt)
 		return 0;
 	}
 
+	/* 
+	   Optionally ignore stupid path names.
+	   This will prevent silly ldap lookups like '*' which will mount up the first
+	   thing found. And MACS and PC's love .something directories. We NEVER create at the automount level these 
+	   and they waste time as automounter forks just to find out the path doesn't exist.
+	*/
+
+	if (ap.ignore_stupid_paths && is_path_stupid(pkt->name) ){
+		send_fail(pkt->wait_queue_token);
+		return 1;
+	}
+
 	chdir(ap.path);
 	if (lstat(pkt->name, &st) == -1 ||
 	   (S_ISDIR(st.st_mode) && st.st_dev == ap.dev)) {
@@ -1383,6 +1423,7 @@ static void usage(void)
 	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
 	fprintf(stderr, "   -D|--dumpmap dumps out the maps read and exits\n");
 	fprintf(stderr, "   -u|--use-old-ldap-lookup instead of figuring out the schema once do it every single time a mount is requested. This is the old behaviour\n");
+ 	fprintf(stderr, "   -I|--ignore-stupid-paths will never lookup a requested path which contains the * character or which starts with a dot (.) \n");
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1676,6 +1717,7 @@ int main(int argc, char *argv[])
 		{"submount", 0, &submount, 1},
 		{"dumpmap", 0, 0, 'D'},
 		{"use-old-ldap-lookup", 0, 0, 'u'},
+		{"ignore-stupid-paths", 0, 0, 'I'},
 		{0, 0, 0, 0}
 	};
 
@@ -1688,7 +1730,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgDu", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgDuI", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1724,6 +1766,9 @@ int main(int argc, char *argv[])
 		case 'u':
 			ap.use_old_ldap_lookup = 1;
 			break;
+		case 'I':
+			ap.ignore_stupid_paths = 1;
+			break;
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
diff --git a/include/automount.h b/include/automount.h
index fa97764..46bc504 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -114,6 +114,11 @@ struct autofs_point {
 	unsigned dir_created;		/* Was a directory created for this
 					   mount? */
 	unsigned use_old_ldap_lookup;   /* query all schemas every time instead of sticking with the first one found */
+	unsigned ignore_stupid_paths;   /* Ignores mount keys that will never occur at my site and which slow
+                                         * everything down or lead to 'interesting' results 
+					 * See automount.c:is_path_stupid for details
+					 */
+ 
 };
 
 extern struct autofs_point ap; 
diff --git a/man/automount.8 b/man/automount.8
index 5dc597b..d242f58 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -54,6 +54,16 @@ the original rfc2307 schema. It only checks once for each mount point
 and remembers the schema for the rest of the automount invocation.
 If you set this flag it will do it the old way which involves looking
 for the schema every time a mount is requested.
+.TP
+.I "\-I, \-\-ignore\-stupid\-paths"
+The automounter will return 'not found' for any key which contains '*' or
+starts with a dot. Ignoring '*' stops undefined results being returned when
+you use ldap. Ignoring the leading '.' is
+useful for macs and Windows when they look for metadata directories
+which typically do not exist in the root of an automount tree to help
+increase browse speed at the top of large trees of mount points.
+It will also ignore paths containing 'autmount(pid'. This is to stop
+lookups when samba asks for these paths which do not exist of course.
 .SH ARGUMENTS
 \fBautomount\fP takes at least three arguments.  Mandatory arguments 
 include \fImount-point\fP, \fImap-type\fP, and \fImap\fP.  Both mandatory
-- 
1.7.3.4
