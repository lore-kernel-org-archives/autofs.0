From: Bill Ryder <bill.ryder.nz@gmail.com>
Subject: [bryder_autofs_4.1.4_PATCH 6/8] Adds options to retry nfs
	mounts on certain nfs errors
Date: Wed, 12 Jan 2011 15:44:33 +1300
Message-ID: <61273cefd832a19f841da3657081b1fced3dd4aa.1294888163.git.bill.ryder.nz@gmail.com>
References: <cover.1294888163.git.bill.ryder.nz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <cover.1294888163.git.bill.ryder.nz@gmail.com>
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
To: 

---
 CHANGELOG           |   32 ++++++++++++++++
 daemon/automount.c  |   21 +++++++++--
 daemon/spawn.c      |   64 +++++++++++++++++++++++++++++++-
 include/automount.h |    7 ++++
 man/automount.8     |   45 +++++++++++++++++++++++
 modules/mount_nfs.c |  100 ++++++++++++++++++++++++++++++++++++++-------------
 6 files changed, 239 insertions(+), 30 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9b0a418..bbf4d3d 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,35 @@
+14/07/2010 autofs-4.1.4 - bryder p42
+------------------------------------
+ Adds retrying to nfs mounts. 
+
+ Originally written to handle overloaded fileservers which is common
+ for us.   It's better for us if the automounter takes a long time to
+ mount a mount point than to return a 'not found' error just because
+ the fileserver was too busy to respond in a small amount of time. 
+
+ As a convenience (so we don't have to use the 'insecure' option on
+ the NFS server) it  also retries if the number of local secure ports
+ is exhausted. Some  jobs we run will mount up 100 fileservers at once
+ which will usually  trigger this error. It is a transient error so
+ the retry succeeds.
+
+ It works by reading the error returned from mount. Some of
+ these errors may be actual permanent failures so it will take longer
+ before it fails. Use the options to control the retries.
+ 
+   "RPC: Remote system error - Connection refused", /* heavy fileserver load */
+   "RPC: Timed out", /* heavy fileserver load */
+   "RPC: Remote system error - Connection timed out", /* heavy fileserver load */
+   "Input/output error", /* too many mounts starting at once on a client  - centos 2.6.18 */
+   "can't read superblock", /* too many mounts starting at once on a client - 2.6.25.18 and others */ 
+   "nfs bindresvport: Address already in use", /* too many mounts starting at once  - see in ubuntu 7.04 2.6.25.18 */
+   "mount system call failed",  /* too many mounts starting at once on a client - seen in 2.6.31.12 */
+   "server down",  /* Seen on ubuntu 7 with massive overload on a test fileserver  */
+
+ The options are --max-nfs-mount-retries|-R  and --nfs-mount-retry-pause|-P options
+ 
+ The pause is chosen at random between 1 second and the retry-pause amount + 1
+
 01/07/2010 autofs-4.1.4 - bryder p41
 ---------------------------
  Adds the -I or --ignore-stupid-paths option.
diff --git a/daemon/automount.c b/daemon/automount.c
index 2509431..3567abf 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1424,6 +1424,7 @@ static void usage(void)
 	fprintf(stderr, "   -D|--dumpmap dumps out the maps read and exits\n");
 	fprintf(stderr, "   -u|--use-old-ldap-lookup instead of figuring out the schema once do it every single time a mount is requested. This is the old behaviour\n");
  	fprintf(stderr, "   -I|--ignore-stupid-paths will never lookup a requested path which contains the * character or which starts with a dot (.) \n");
+ 	fprintf(stderr, "   -R|--max-nfs-mount-retries <n> and -P|--nfs-mount-retry-pause <max secs> retres nfs mounts when certain error messages are seen. Default is no retry. pause is max seconds to wait (the pause is random from 1 to (pause+1) seconds\n");
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1718,6 +1719,8 @@ int main(int argc, char *argv[])
 		{"dumpmap", 0, 0, 'D'},
 		{"use-old-ldap-lookup", 0, 0, 'u'},
 		{"ignore-stupid-paths", 0, 0, 'I'},
+		{"max-nfs-mount-retries", 1, 0, 'R'},
+		{"nfs-mount-retry-pause", 1, 0, 'P'}, /* This is in fact the maximum pause - 1s (ie the code will randomly sleep between 1 and retry-pause +1 seconds) */
 		{0, 0, 0, 0}
 	};
 
@@ -1730,8 +1733,8 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgDuI", long_options, NULL)) != EOF) {
-		switch (opt) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdVgDuIR:P:", long_options, NULL)) != EOF) {
+	  switch (opt) {
 		case 'h':
 			usage();
 			exit(0);
@@ -1769,13 +1772,25 @@ int main(int argc, char *argv[])
 		case 'I':
 			ap.ignore_stupid_paths = 1;
 			break;
+
+		case 'R':
+			ap.max_nfs_mount_retries =  getnumopt(optarg, opt);
+			break;
+
+		case 'P':
+			ap.nfs_mount_retry_pause =  getnumopt(optarg, opt);
+			break;
+
 		case '?':
 		case ':':
 			printf("%s: Ambiguous or unknown options\n", program);
 			exit(1);
 		}
 	}
-
+	/* Set this to a sane value even if it isn't used */
+	if (ap.nfs_mount_retry_pause <= 0){
+		ap.nfs_mount_retry_pause = 1;
+	}
 	if (geteuid() != 0) {
 		fprintf(stderr, "%s: This program must be run by root.\n", program);
 		exit(1);
diff --git a/daemon/spawn.c b/daemon/spawn.c
index f763cc7..12b3d5a 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -199,6 +199,60 @@ out:
 
 #define ERRBUFSIZ 2047		/* Max length of error string excl \0 */
 
+/*
+ * this is horrible. I need to evaluate the error from a failed mount request
+ * to see if it's a retryably NFS error
+ * But spawnv is called by spawn_mount and it's the only place that deals with the 
+ * error string that was returned by mount.
+ *
+ * the smallest change therefore is to run any error messages through retry_error_p and set a 
+ * gasp flag that says an error was returned that was retryable.
+ *
+ * This means I actually have nfs code in spawn.c which will never get past any maintainer because it 
+ * breaks the whole idea of separate modules.
+ *
+ * However - this approach won't break anything that doesn't use it and I won't have to introduce new argumenst
+ * and propogate them everywhere.
+ *
+ * how embarrassing.
+ */
+
+int found_retryable_error = 0  ; /* This is the variable we set. - it is defined as extern (obviously) in mount_nfs.c */
+
+
+/* These are the errors that can occur on a overloaded or if too many mounts are started up at once on a client */
+/* It's a substring match */
+static char *retryable_errors[] = {
+	"RPC: Remote system error - Connection refused", /* heavy fileserver load */
+	"RPC: Timed out", /* heavy fileserver load */
+	"RPC: Remote system error - Connection timed out", /* heavy fileserver load */
+	"Input/output error", /* too many mounts starting at once on a client  - centos 2.6.18 */
+	"can't read superblock", /* too many mounts starting at once on a client - 2.6.25.18 and others */ 
+	"nfs bindresvport: Address already in use", /* too many mounts starting at once  - see in ubuntu 7.04 2.6.25.18 */
+	"mount system call failed",  /* too many mounts starting at once on a client - seen in 2.6.31.12 */
+	"server is down",  /* Massively overloaded fileserver - seen on kubuntu 7 */
+};
+
+
+/*
+ * retry_error_p returns a string which the error message matched if that error is retryable.
+ * if it returns NULL then the error is not retryable. 
+ */
+char *retry_error_p(char *error_mesg) /* _p means predicate - is it's a test - old LISP  naming */
+{ /* retry_error_p */
+	int i;
+	
+	for (i = 0; i < (sizeof(retryable_errors)/sizeof(char *)) ; i++){
+		if (strstr(error_mesg,retryable_errors[i]) != NULL){
+			debug("spawn.c:%s: Found a retryable error %s", __func__, retryable_errors[i]) ;
+			return(retryable_errors[i]);
+		}
+	}
+
+	return NULL;
+	  
+} /* retry_error_p */
+
 static int do_spawn(int logpri, int use_lock, const char *prog, const char *const *argv)
 {
 	pid_t f;
@@ -247,6 +301,8 @@ static int do_spawn(int logpri, int use_lock, const char *prog, const char *cons
 			return -1;
 		}
 
+		found_retryable_error = 0;
+
 		errp = 0;
 		do {
 			while ((errn =
@@ -257,10 +313,14 @@ static int do_spawn(int logpri, int use_lock, const char *prog, const char *cons
 				errp += errn;
 
 				sp = errbuf;
+
+				if((ap.max_nfs_mount_retries > 0) &&  retry_error_p(errbuf))
+				   found_retryable_error = 1 ;
+
 				while (errp && (p = memchr(sp, '\n', errp))) {
 					*p++ = '\0';
 					if (sp[0])	/* Don't output empty lines */
-						syslog(logpri, ">> %s", sp);
+					  syslog(logpri, "%s 1 >> %s", __func__, sp);
 					errp -= (p - sp);
 					sp = p;
 				}
@@ -271,7 +331,7 @@ static int do_spawn(int logpri, int use_lock, const char *prog, const char *cons
 				if (errp >= ERRBUFSIZ) {
 					/* Line too long, split */
 					errbuf[errp] = '\0';
-					syslog(logpri, ">> %s", errbuf);
+					syslog(logpri, "%s 2 >> %s", __func__, errbuf);
 					errp = 0;
 				}
 			}
diff --git a/include/automount.h b/include/automount.h
index 46bc504..b09dd78 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -119,6 +119,13 @@ struct autofs_point {
 					 * See automount.c:is_path_stupid for details
 					 */
  
+
+	unsigned max_nfs_mount_retries; /* number of times to retry a failed nfs mount if it 
+					 * returns specified error messages (see mount_nfs.c for the errors 
+					 */
+	unsigned nfs_mount_retry_pause; /* Time in seconds to pause between retrying nfs mounts */
+        
+
 };
 
 extern struct autofs_point ap; 
diff --git a/man/automount.8 b/man/automount.8
index d242f58..f96390b 100644
--- a/man/automount.8
+++ b/man/automount.8
@@ -64,6 +64,51 @@ which typically do not exist in the root of an automount tree to help
 increase browse speed at the top of large trees of mount points.
 It will also ignore paths containing 'autmount(pid'. This is to stop
 lookups when samba asks for these paths which do not exist of course.
+.TP
+.I "\-R, \-\-max\-nfs\-mount\-retries <n>"
+If set automount will retry 
+.B "n"
+times waiting between 1 and the argument to nfs-mount-retry-pause seconds
+(+1) between mounts 
+if one of the following errors is seen:
+.RS
+.P
+.I "RPC: Remote system error - Connection refused" 
+- usually caused by heavy fileserver load
+.P
+.I "RPC: Timed out"
+- usually caused by heavy fileserver load 
+.P
+.I "RPC: Remote system error - Connection timed out"
+ - usually caused by heavy fileserver load
+.P
+.I "Input/output error"
+- sometimes caused by  too many mounts starting at
+once on a client  - seen on centos 5.4 with kernel  2.6.18
+.P
+.I "can't read superblock"
+-  too many mounts starting at once on a client
+.P
+.I "nfs bindresvport: Address already in use"
+-  too many mounts starting at once
+.P
+.I "mount system call failed"
+- too many mounts starting at once on a client
+.P
+.I "server is down"
+-  Massively overloaded fileserve
+.P
+.I "nfs can't read superblock"
+-  too many mounts starting at once on a client
+.RE
+.TP
+.I "\-R, \-\-nfs\-mount\-retry\-pause <secs>"
+The amount of time to pause between retries. In fact it sets the
+upperbound on the number of seconds before retrying (1s is added to
+this argument). So it will pause a random number of seconds between 1
+and nfs-mount-retry-pause+1 between retries.
+
+
 .SH ARGUMENTS
 \fBautomount\fP takes at least three arguments.  Mandatory arguments 
 include \fImount-point\fP, \fImap-type\fP, and \fImap\fP.  Both mandatory
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 998c5ba..a3135de 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -310,6 +310,19 @@ int get_best_mount(char *what, const char *original, int longtimeout, int skiplo
 	return local;
 }
 
+/*
+ * Note - I've done a hideous hack to spawn.c to handle retryable errors in the mount
+ *
+ * unfortunately the error message is not propagated back to the mount_mount from the spwan_mount.
+ *
+ *  But to decide if a retry is necessary the error message has to be examined.
+ *
+ *  The hack involves checking the error message in spawn.c:spawnv and propagating the result
+ *  via the following variable:
+ */
+extern int found_retryable_error;
+
+
 int mount_mount(const char *root, const char *name, int name_len,
 		const char *what, const char *fstype, const char *options,
 		void *context)
@@ -320,6 +333,7 @@ int mount_mount(const char *root, const char *name, int name_len,
 	int local, err;
 	int nosymlink = 0;
 	int ro = 0;            /* Set if mount bind should be read-only */
+	int mount_attempts = 0; 
 
 	debug(MODPREFIX "root=%s name=%s what=%s, fstype=%s, options=%s",
 	      root, name, what, fstype, options);
@@ -445,33 +459,69 @@ int mount_mount(const char *root, const char *name, int name_len,
 			return 0;
 		}
 
-		if (nfsoptions && *nfsoptions) {
-			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
-			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
-
-			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", SLOPPYOPT "-o", nfsoptions,
-				     whatstr, fullpath, NULL);
-		} else {
-			debug(MODPREFIX "calling mount -t nfs %s %s",
-			      whatstr, fullpath);
-			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", whatstr, fullpath, NULL);
-		}
+		/*  Retry the mount if the error is retryable and the max_nfs-mount_retries > 0 . */
+		mount_attempts = 0;
 
-		if (err) {
-			if ((!ap.ghost && name_len) || !existed)
-				rmdir_path(name);
+		do {
+			if (nfsoptions && *nfsoptions) {
+				debug(MODPREFIX "calling mount -t nfs " SLOPPY 
+				      " -o %s %s %s", nfsoptions, whatstr, fullpath);
 
-			error(MODPREFIX "nfs: mount failure %s on %s",
-			      whatstr, fullpath);
-			return 1;
-		} else {
-			debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
-			return 0;
-		}
+				err = spawnll(LOG_NOTICE,
+					      PATH_MOUNT, PATH_MOUNT, "-t",
+					      "nfs", SLOPPYOPT "-o", nfsoptions,
+					      whatstr, fullpath, NULL);
+			} else {
+				debug(MODPREFIX "calling mount -t nfs %s %s",
+				      whatstr, fullpath);
+				err = spawnll(LOG_NOTICE,
+					      PATH_MOUNT, PATH_MOUNT, "-t",
+					      "nfs", whatstr, fullpath, NULL);
+			}
+			mount_attempts++;
+			if (err) {
+
+				/*
+				 * found_retryable_error is set in spawn.c - I kid you not. It's the least invasive hack bryder could make 
+				 * since the error message from a failed mount is not passed back. 
+				 * The flag is true of one of a set of retryable error messages were seen.
+				 */
+				if (found_retryable_error && (mount_attempts <= ap.max_nfs_mount_retries)){
+					error(MODPREFIX "nfs: mount failure %s on %s - trying %d more times", whatstr, fullpath, (ap.max_nfs_mount_retries - mount_attempts)+1);
+					if (ap.nfs_mount_retry_pause > 0 ){
+						int fd = open("/dev/urandom", O_RDONLY);
+						if (fd < 0) {
+							srand(time(NULL));
+						} 
+						else  {
+							unsigned int seed;
+							read(fd, &seed, sizeof(seed));
+							srand(seed);
+							close(fd);
+						}
+
+						/* Randomise the sleep time  - between 1s and the max (+1s)*/
+						useconds_t sleep_usecs = 1000000 + (int)(((float)ap.nfs_mount_retry_pause * 1000000 ) * (((float)rand() / (float)RAND_MAX)));
+						debug(MODPREFIX "nfs: mount failed - sleeping %d microsecs before retry",(unsigned int)sleep_usecs); 
+						usleep(sleep_usecs);
+					}
+					continue; 
+				} else {
+					if ((!ap.ghost && name_len) || !existed)
+						rmdir_path(name);
+
+					error(MODPREFIX "nfs: mount failure %s on %s",
+					      whatstr, fullpath);
+					return 1;
+				}
+			} else {
+				break; /* good mount - get out of the loop and return */
+			}
+		} while (mount_attempts <= ap.max_nfs_mount_retries ); /* loop is also exited via a couple of breaks  and returns */
+
+			
+		debug(MODPREFIX "%s: mounted %s on %s after %d attempts", __func__, whatstr, fullpath, mount_attempts );
+		return 0;
 	}
 }
 
-- 
1.7.3.3
