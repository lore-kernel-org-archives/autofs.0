From: Jim Carter <jimc@math.ucla.edu>
Subject: [patch] buffer overflow, failure to auto-dismount, log file diarrhea
Date: Fri, 21 Nov 2003 10:56:10 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0311211053490.20421@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Here at UCLA-Mathnet we use the automounter extensively, and we have had
a couple of associated problems:

A.  Our NFS mounted filesystems invariably require submounts, and they
are not auto-dismounted.  Ever.  This proved to be due to a duplicated
slash between the main and sub mount points.  Once this was fixed,
auto-dismount started working.  There is a rumor that a related fix was
posted somewhere, but I couldn't find it.

B.  If the daemon is hit with SIGUSR1, it goes into an infinite loop
trying unsuccessfully to dismount eligible filesystems, spitting out
typically 1000 syslog messages over 2 seconds until item C (below)
supervenes.  I put in both a rate throttle (20/second) and a dynamic
limit on the number of dismounts.

C.  Upon auto-dismount or SIGUSR1 looping, st_prepare_shutdown is called
when ap.state != ST_READY and an assertion fails, killing the thread.
I changed it to die on ST_SHUTDOWN_PENDING, i.e. a recursive call.  I'm
not 100% sure that this is the correct contingency, but automount does
dismount the unused filesystems and does exit.

D.  It would appear that a maliciously constructed directory name could
overflow a buffer in several places, at least causing denial of service
and possibly allowing the execution of code.  Perhaps other O.S. limits
on the length of a filename (PATH_MAX) invariably protect the daemon
from this exposure, but defense in depth in this area seems both
warranted and not burdensome.  I changed sprintf to snprintf wherever
occurring, and the subroutine which joins the dirname and basename
checks the buffer size.

E.  There were a few cases where size_t and int were mixed together,
causing compiler warnings.  As there have been exploits against mixed
signed-unsigned variables, I took the opportunity to fix this issue.

On one machine we have been running the patched automount for a week,
and all Linux boxes have had it in production for 48 hours.  No peculiar
log messages or crashes have been seen.  In one test, various random NFS
filesystems were automounted and allowed to time out, with varying
numbers of filesystems simultaneously mounted.  Almost 500
mount-autodismount pairs were done; processes always exited when they
should, and no error messages appeared.  There's a pretty good chance
that this patch is working.

The patches follow.  They are against autofs-4.0.0pre10, which is the
version distributed with SuSE 8.2, the distro we are using.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)



diff -r -u autofs-4.0.0pre10.orig/daemon/automount.c autofs-4.0.0pre10/daemon/automount.c
--- autofs-4.0.0pre10.orig/daemon/automount.c	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10/daemon/automount.c	2003-11-19 13:39:39.000000000 -0800
@@ -30,6 +30,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syslog.h>
+#include <time.h>
 #include <unistd.h>
 #include <mntent.h>
 #include <sys/ioctl.h>
@@ -106,8 +107,8 @@
   int pipefd;		/* File descriptor for pipe */
   int ioctlfd;		/* File descriptor for ioctls */
   dev_t dev;		/* "Device" number assigned by kernel */
-  unsigned exp_timeout;	/* Timeout for expiring mounts */
-  unsigned exp_runfreq;	/* Frequency for polling for timeouts */
+  time_t exp_timeout;	/* Timeout for expiring mounts */
+  time_t exp_runfreq;	/* Frequency for polling for timeouts */
   volatile pid_t exp_process; /* Process that is currently expiring */
   volatile struct pending_mount *mounts; /* Pending mount queue */
   struct lookup_mod *lookup; /* Lookup module */
@@ -123,6 +124,50 @@
 static void cleanup_exit(int exit_code);
 static int handle_packet_expire(const struct autofs_packet_expire *pkt);

+/*  sum = "dir/base" with attention to buffer overflows, and multiple slashes
+    at the joint are avoided. */
+static void cat_path(char* sum, size_t szsum, const char* dir, const char* base)
+{
+	const char* parts[3] = {dir, "", base};
+	const char* part;
+	size_t len;
+	int i, nsl;
+	for (i = 0; i < 3; ++i) {
+		part = parts[i];
+		len = strlen(part) + 1;
+		if (len > szsum)
+			len = szsum;
+		strncpy(sum, part, len);
+		if (len > 1) {
+			sum += len-1;
+			szsum -= len-1;
+		}
+			/* Suppress the duplicate slash(es) between parts */
+		if (i == 0) {
+			nsl = (sum[-1] == '/') + (base[0] == '/');
+			if (nsl == 0) {
+				parts[1] = "/";	/*No slashes, insert one*/
+			} else if (nsl > 1) {
+				parts[2]++;	/*Too  many slashes, lose one*/
+			}
+		}
+	}
+	if (! szsum > 0)
+		sum[-1] = '\0';	/*Should come from base, but it was truncated*/
+}
+
+/*  sum = "dir/base" with attention to buffer overflows, and multiple slashes
+    at the joint are avoided.  The length of base is specified explicitly. */
+static void ncat_path(char* sum, size_t szsum, const char* dir,
+	const char* base, size_t szbase)
+{
+	char pktname[PATH_MAX+1];
+	int namelen = ((PATH_MAX < szbase) ? PATH_MAX : szbase)+1;
+	strncpy(pktname, base, namelen);
+	pktname[namelen-1] = '\0';
+	cat_path(sum, szsum, dir, pktname);
+}
+
 int mkdir_path(const char *path, mode_t mode)
 {
 	char *buf = alloca(strlen(path)+1);
@@ -185,7 +230,7 @@
   struct stat st;
   int rv = 0;

-  sprintf(path_buf, "%s/%s", root, name);
+  cat_path(path_buf, sizeof(path_buf), root, name);
   if ( !lstat(path_buf,&st) ) {
     if ( S_ISDIR(st.st_mode) ) {
       if ( st.st_dev != ap.dev ) {
@@ -222,7 +267,7 @@
 				    strcmp(de->d_name, "..") == 0)
 					continue;

-				sprintf(buf, "%s/%s", base, de->d_name);
+				cat_path(buf, sizeof(buf), base, de->d_name);
 				if (walk_tree(buf, fn, 1, arg)) {
 					closedir(dir);
 					return -1;
@@ -271,7 +316,7 @@
 	  const char *path;
 	  struct mntlist *next;
   } *mntlist = NULL, *mptr;
-  int pathlen = strlen(path);
+  size_t pathlen = strlen(path);

   DB(syslog(LOG_INFO, "umount_multi: path=%s incl=%d\n", path, incl));

@@ -284,7 +329,7 @@
   /* Construct a list of eligible dirs ordered longest->shortest
      so that umount will work */
   while((mnt = getmntent(mtab)) != NULL) {
-    int len = strlen(mnt->mnt_dir);
+    size_t len = strlen(mnt->mnt_dir);
     struct mntlist *m, **prev;
     char *p;

@@ -432,9 +477,10 @@
     return -1;
   }

-  sprintf(options, "fd=%d,pgrp=%u,minproto=2,maxproto=%d", pipefd[1],
+  snprintf(options, sizeof(options),
+	  "fd=%d,pgrp=%u,minproto=2,maxproto=%d", pipefd[1],
 	  (unsigned)my_pgrp, AUTOFS_MAX_PROTO_VERSION);
-  sprintf(our_name, "automount(pid%u)", (unsigned)my_pid);
+  snprintf(our_name, sizeof(our_name), "automount(pid%u)", (unsigned)my_pid);

   if (spawnl(LOG_DEBUG, PATH_MOUNT, PATH_MOUNT, "-t", "autofs", "-o",
 	     options, our_name, path, NULL) != 0) {
@@ -728,14 +774,17 @@
 		close(ap.state_pipe[0]);
 		close(ap.state_pipe[1]);

-		/* Generate expire messages until there's
-		   nothing more to expire */
-		while(ioctl(ap.ioctlfd, AUTOFS_IOC_EXPIRE_MULTI, &now) == 0)
-			;
-
-		/* EXPIRE_MULTI is synchronous, so we can
-                   be sure the umounts are done by the time we reach
-                   here */
+                /* Generate expire messages until there's nothing more to
+		   expire.  If a bug prevents unmounting, limit attempts to
+		   20/second and a few more than the known number of mounts. */
+		count = count_mounts(ap.path) + 3;
+		while(ioctl(ap.ioctlfd, AUTOFS_IOC_EXPIRE_MULTI, &now) == 0 && --count > 0) {
+			struct timespec nap = { 0, 50000000 }; /*5e-2 seconds*/
+			nanosleep(&nap, NULL);	/*Don't care if it ends early*/
+		}
+
+                /* EXPIRE_MULTI is synchronous, so we can be sure (famous last
+                   words) the umounts are done by the time we reach here */
 		if ((count = count_mounts(ap.path))) {
 			DB(syslog(LOG_INFO,
 				  "expire_proc: %d remaining in %s\n",
@@ -764,7 +813,7 @@
 	DB(syslog(LOG_INFO, "prep_shutdown: state = %d\n",
 		  ap.state));

-	assert(ap.state == ST_READY);
+	assert(ap.state != ST_SHUTDOWN_PENDING);

 	/* Turn off timeouts */
 	alarm(0);
@@ -858,7 +907,7 @@
 	char *buf = (char *)ptr;

 	while(len > 0) {
-		size_t r = read(fd, buf, len);
+		ssize_t r = read(fd, buf, len);

 		if (r == -1) {
 			if (errno == EINTR)
@@ -942,9 +991,10 @@
   struct stat st;
   sigset_t oldsig;
   pid_t f;
+  char buf[PATH_MAX+1];

   DB(syslog(LOG_INFO, "handle_packet_missing: token %d, name %s\n",
-	    pkt->wait_queue_token, pkt->name));
+	    (int)pkt->wait_queue_token, pkt->name));

   /* Ignore packet if we're trying to shut down */
   if (ap.state == ST_SHUTDOWN_PENDING ||
@@ -971,8 +1021,8 @@
     }
     sigprocmask(SIG_UNBLOCK, &sigchld_mask, NULL);

-    syslog(LOG_INFO, "attempting to mount entry %s/%s",
-	   ap.path, pkt->name);
+    ncat_path(buf, sizeof(buf), ap.path, pkt->name, pkt->len);
+    syslog(LOG_INFO, "attempting to mount entry %s", buf);

     sigprocmask(SIG_BLOCK, &lock_sigs, &oldsig);

@@ -984,7 +1034,6 @@
       return 1;
     } else if ( !f ) {
       int err;
-      char buf[PATH_MAX+1];

       ignore_signals();		/* Set up a sensible signal environment */
       close(ap.pipefd);
@@ -995,7 +1044,7 @@
       err = ap.lookup->lookup_mount(ap.path, pkt->name, pkt->len,
 				    ap.lookup->context);

-      sprintf(buf, "%s/%.*s", ap.path, pkt->len, pkt->name);
+      ncat_path(buf, sizeof(buf), ap.path, pkt->name, pkt->len);

       /* If at first you don't succeed, hide all evidence you ever tried */
       if (err) {
@@ -1031,7 +1080,7 @@
 {
   char buf[PATH_MAX];

-  sprintf(buf, "%s/%.*s", ap.path, namelen, name);
+  ncat_path(buf, sizeof(buf), ap.path, name, namelen);
   syslog(LOG_DEBUG, "running expiration on path %s", buf);

   if ( umount_multi(buf, 1) == 0 ) {
@@ -1112,7 +1161,7 @@
 	int ret;

 	DB(syslog(LOG_INFO, "handle_packet_expire_multi: token %d, name %s\n",
-		  pkt->wait_queue_token, pkt->name));
+		  (int)(pkt->wait_queue_token), pkt->name));

 	ret = handle_expire(pkt->name, pkt->len, pkt->wait_queue_token);

@@ -1423,14 +1472,14 @@
     ap.exp_timeout = ap.exp_runfreq = 0;
     syslog(LOG_INFO, "kernel does not support timeouts");
   } else {
-    unsigned long timeout;
+    time_t timeout;

     ap.exp_runfreq = (ap.exp_timeout+CHECK_RATIO-1) / CHECK_RATIO;

     timeout = ap.exp_timeout;

     syslog(LOG_INFO, "using timeout %d seconds; freq %d secs",
-	   timeout, ap.exp_runfreq);
+	   (int)timeout, (int)ap.exp_runfreq);

     ioctl(ap.ioctlfd, AUTOFS_IOC_SETTIMEOUT, &timeout);

diff -r -u autofs-4.0.0pre10.orig/daemon/module.c autofs-4.0.0pre10/daemon/module.c
--- autofs-4.0.0pre10.orig/daemon/module.c	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10/daemon/module.c	2003-11-13 11:45:54.000000000 -0800
@@ -26,6 +26,7 @@
 {
   struct lookup_mod *mod;
   char *fnbuf;
+  size_t szfnbuf;
   void *dh;
   int *ver;

@@ -34,13 +35,14 @@
     if ( err_prefix ) syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  fnbuf = alloca(strlen(name) + strlen(AUTOFS_LIB_DIR) + 13);
+  szfnbuf = strlen(name) + strlen(AUTOFS_LIB_DIR) + 13;
+  fnbuf = alloca(szfnbuf);
   if ( !fnbuf ) {
     free(mod);
     if ( err_prefix ) syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  sprintf(fnbuf, "%s//lookup_%s.so", AUTOFS_LIB_DIR, name);
+  snprintf(fnbuf, szfnbuf, "%s//lookup_%s.so", AUTOFS_LIB_DIR, name);

   if ( !(dh = dlopen(fnbuf, RTLD_NOW)) ) {
     if ( err_prefix )
@@ -91,6 +93,7 @@
 {
   struct parse_mod *mod;
   char *fnbuf;
+  size_t szfnbuf;
   void *dh;
   int *ver;

@@ -99,13 +102,14 @@
     if ( err_prefix ) syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  fnbuf = alloca(strlen(name) + strlen(AUTOFS_LIB_DIR) + 12);
+  szfnbuf = strlen(name) + strlen(AUTOFS_LIB_DIR) + 12;
+  fnbuf = alloca(szfnbuf);
   if ( !fnbuf ) {
     free(mod);
     if ( err_prefix ) syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  sprintf(fnbuf, "%s//parse_%s.so", AUTOFS_LIB_DIR, name);
+  snprintf(fnbuf, szfnbuf, "%s//parse_%s.so", AUTOFS_LIB_DIR, name);

   if ( !(dh = dlopen(fnbuf, RTLD_NOW)) ) {
     if ( err_prefix )
@@ -155,6 +159,7 @@
 {
   struct mount_mod *mod;
   char *fnbuf;
+  size_t szfnbuf;
   void *dh;
   int *ver;

@@ -163,14 +168,15 @@
     if ( err_prefix ) syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  fnbuf = alloca(strlen(name) + strlen(AUTOFS_LIB_DIR) + 12);
+  szfnbuf = strlen(name) + strlen(AUTOFS_LIB_DIR) + 12;
+  fnbuf = alloca(szfnbuf);
   if ( !fnbuf ) {
     free(mod);
     if ( err_prefix )
       syslog(LOG_CRIT, "%s%m", err_prefix);
     return NULL;
   }
-  sprintf(fnbuf, "%s//mount_%s.so", AUTOFS_LIB_DIR, name);
+  snprintf(fnbuf, szfnbuf, "%s//mount_%s.so", AUTOFS_LIB_DIR, name);

   if ( !(dh = dlopen(fnbuf, RTLD_NOW)) ) {
     if ( err_prefix )
diff -r -u autofs-4.0.0pre10.orig/daemon/mount.c autofs-4.0.0pre10/daemon/mount.c
--- autofs-4.0.0pre10.orig/daemon/mount.c	2001-03-27 21:08:23.000000000 -0800
+++ autofs-4.0.0pre10/daemon/mount.c	2003-11-14 11:50:16.000000000 -0800
@@ -21,6 +21,7 @@

 #include <syslog.h>
 #include <stdlib.h>
+#include <string.h>
 #include "automount.h"

 /* These filesystems are known not to work with the "generic" module */
