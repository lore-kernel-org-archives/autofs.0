From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 5/5]
Date: Fri, 11 Feb 2005 12:09:25 +0200
Message-ID: <200502111209.25527.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111206.12250.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VRIDC92o4ldvpy9"
In-Reply-To: <200502111206.12250.vda@port.imtp.ilyichevsk.odessa.ua>
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
To: autofs@linux.kernel.org


--Boundary-00=_VRIDC92o4ldvpy9
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Replace %m with %s + strerror(errno) because stderr logging
do not support %m.

While we're at it, fix lots of places with stray newlines.

I run tested all these patches applied on top of 4.1.4_beta1,
in order.
--
vda

--Boundary-00=_VRIDC92o4ldvpy9
Content-Type: text/x-diff;
  charset="koi8-r";
  name="414b1.45.msg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="414b1.45.msg.patch"

diff -urpN autofs-4.1.4_beta1_4/daemon/automount.c autofs-4.1.4_beta1_5/daemon/automount.c
--- autofs-4.1.4_beta1_4/daemon/automount.c	Fri Feb 11 10:49:58 2005
+++ autofs-4.1.4_beta1_5/daemon/automount.c	Fri Feb 11 11:46:11 2005
@@ -320,7 +320,7 @@ static int do_umount_autofs(void)
 			    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		if (rv & MTAB_NOTUPDATED) {
 			info("umount %s succeeded: "
-			     "mtab not updated, retrying to clean\n",
+			     "mtab not updated, retrying to clean",
 			      ap.path);
 			rv = spawnll(debug,
 				    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
@@ -484,7 +484,7 @@ static int mount_autofs(char *path)
 static void nextstate(enum states next)
 {
 	if (write(ap.state_pipe[1], &next, sizeof(next)) != sizeof(next))
-		error("nextstate: write failed %m");
+		error("nextstate: write failed %s", strerror(errno));
 }
 
 /* Deal with all the signal-driven events in the state machine */
@@ -532,7 +532,7 @@ static int send_ready(unsigned int wait_
 		return 0;
 	debug("send_ready: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_READY, wait_queue_token) < 0) {
-		error("AUTOFS_IOC_READY: %m");
+		error("AUTOFS_IOC_READY: %s", strerror(errno));
 		return 1;
 	}
 	return 0;
@@ -544,7 +544,7 @@ static int send_fail(unsigned int wait_q
 		return 0;
 	debug("send_fail: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_FAIL, wait_queue_token) < 0) {
-		error("AUTOFS_IOC_FAIL: %m");
+		error("AUTOFS_IOC_FAIL: %s", strerror(errno));
 		return 1;
 	}
 	return 0;
@@ -792,7 +792,7 @@ static enum expire expire_proc(int now)
 		exit(0);
 
 	case -1:
-		error("expire: fork failed: %m");
+		error("expire: fork failed: %s", strerror(errno));
 		sigprocmask(SIG_SETMASK, &old, NULL);
 		return EXP_ERROR;
 
@@ -809,7 +809,7 @@ static int st_readmap(void)
 
 	status = ap.lookup->lookup_ghost(ap.path, ap.ghost, 0, ap.lookup->context);
 
-	debug("st_readmap: status %d\n", status);
+	debug("st_readmap: status %d", status);
 
 	/* If I don't exist in the map any more then exit */
 	if (status == LKP_FAIL)
@@ -822,7 +822,7 @@ static int st_prepare_shutdown(void)
 {
 	int exp;
 
-	info("prep_shutdown: state = %d\n", ap.state);
+	info("prep_shutdown: state = %d", ap.state);
 
 	assert(ap.state == ST_READY || ap.state == ST_EXPIRE);
 
@@ -1045,7 +1045,7 @@ static int handle_packet_missing(const s
 			junk_mounts = junk_mounts->next;
 		} else {
 			if (!(mt = malloc(sizeof(struct pending_mount)))) {
-				error("handle_packet_missing: malloc: %m");
+				error("handle_packet_missing: malloc failure");
 				send_fail(pkt->wait_queue_token);
 				return 1;
 			}
@@ -1071,7 +1071,7 @@ static int handle_packet_missing(const s
 		f = fork();
 		if (f == -1) {
 			sigprocmask(SIG_SETMASK, &oldsig, NULL);
-			error("handle_packet_missing: fork: %m");
+			error("handle_packet_missing: fork: %s", strerror(errno));
 
 			send_fail(pkt->wait_queue_token);
 			free(mt);
@@ -1196,7 +1196,7 @@ static int handle_expire(const char *nam
 	} else {
 		if (!(mt = malloc(sizeof(struct pending_mount)))) {
 			sigprocmask(SIG_SETMASK, &olds, NULL);
-			error("handle_expire: malloc: %m");
+			error("handle_expire: malloc failure");
 			return 1;
 		}
 	}
@@ -1204,7 +1204,7 @@ static int handle_expire(const char *nam
 	f = fork();
 	if (f == -1) {
 		sigprocmask(SIG_SETMASK, &olds, NULL);
-		error("handle_expire: fork: %m");
+		error("handle_expire: fork: %", strerror(errno));
 		free(mt);
 
 		return 1;
@@ -1310,7 +1310,7 @@ static void become_daemon(void)
 	   perform the mount.  A pgrp is also useful for controlling all the
 	   child processes we generate. */
 	if (!submount && setpgrp()) {
-		crit("setpgrp: %m");
+		crit("setpgrp: %s", strerror(errno));
 		exit(1);
 	}
 	my_pgrp = getpgrp();
@@ -1344,7 +1344,8 @@ static void cleanup_exit(const char *pat
 
 	if ((!ap.ghost || !submount) && (*(path + 1) != '-') && ap.dir_created)
 		if (rmdir(path) == -1)
-			warn("failed to remove dir %s: %m", path);
+			warn("failed to remove dir %s: %s",
+				path, strerror(errno));
 
 	exit(exit_code);
 }
@@ -1558,7 +1559,7 @@ int handle_mounts(char *path)
 	if (!ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOVER, &kproto_version)) {
 		/* If this ioctl() doesn't work, kernel does not support ghosting */
 		if (ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOSUBVER, &kproto_sub_version)) {
-			debug("kproto sub: %m");
+			debug("kproto sub: %s", strerror(errno));
 			kproto_sub_version = 0;
 			if (ap.ghost) {
 				ap.ghost = 0;
@@ -1566,7 +1567,7 @@ int handle_mounts(char *path)
 			}
 		}
 	} else {
-		debug("kproto: %m");
+		debug("kproto: %s", strerror(errno));
 		kproto_version = 2;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/daemon/module.c autofs-4.1.4_beta1_5/daemon/module.c
--- autofs-4.1.4_beta1_4/daemon/module.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.4_beta1_5/daemon/module.c	Fri Feb 11 11:46:11 2005
@@ -37,7 +37,7 @@ struct lookup_mod *open_lookup(const cha
 	mod = malloc(sizeof(struct lookup_mod));
 	if (!mod) {
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%smalloc failure", err_prefix);
 		return NULL;
 	}
 
@@ -46,7 +46,7 @@ struct lookup_mod *open_lookup(const cha
 	if (!fnbuf) {
 		free(mod);
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%salloca failure", err_prefix);
 		return NULL;
 	}
 	snprintf(fnbuf, size_fnbuf, "%s/lookup_%s.so", AUTOFS_LIB_DIR, name);
@@ -114,7 +114,7 @@ struct parse_mod *open_parse(const char 
 	mod = malloc(sizeof(struct parse_mod));
 	if (!mod) {
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%smalloc failure", err_prefix);
 		return NULL;
 	}
 
@@ -123,7 +123,7 @@ struct parse_mod *open_parse(const char 
 	if (!fnbuf) {
 		free(mod);
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%salloca failure", err_prefix);
 		return NULL;
 	}
 	snprintf(fnbuf, size_fnbuf, "%s/parse_%s.so", AUTOFS_LIB_DIR, name);
@@ -189,7 +189,7 @@ struct mount_mod *open_mount(const char 
 	mod = malloc(sizeof(struct mount_mod));
 	if (!mod) {
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%smalloc failure", err_prefix);
 		return NULL;
 	}
 
@@ -198,7 +198,7 @@ struct mount_mod *open_mount(const char 
 	if (!fnbuf) {
 		free(mod);
 		if (err_prefix)
-			crit("%s%m", err_prefix);
+			crit("%salloca failure", err_prefix);
 		return NULL;
 	}
 	snprintf(fnbuf, size_fnbuf, "%s/mount_%s.so", AUTOFS_LIB_DIR, name);
diff -urpN autofs-4.1.4_beta1_4/lib/cache.c autofs-4.1.4_beta1_5/lib/cache.c
--- autofs-4.1.4_beta1_4/lib/cache.c	Mon Jan 24 16:10:19 2005
+++ autofs-4.1.4_beta1_5/lib/cache.c	Fri Feb 11 11:46:11 2005
@@ -436,8 +436,8 @@ int cache_ghost(const char *root, int gh
 				if (stat(fullpath, &st) == -1 && errno == ENOENT) {
 					if (mkdir_path(fullpath, 0555) < 0)
 						warn("cache_ghost: mkdir_path %s "
-						     "failed: %m",
-						      fullpath);
+						     "failed: %s",
+						      fullpath, strerror(errno));
 				}
 				break;
 
diff -urpN autofs-4.1.4_beta1_4/lib/mounts.c autofs-4.1.4_beta1_5/lib/mounts.c
--- autofs-4.1.4_beta1_4/lib/mounts.c	Mon Jan 17 17:09:28 2005
+++ autofs-4.1.4_beta1_5/lib/mounts.c	Fri Feb 11 11:46:11 2005
@@ -22,6 +22,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdio.h>
+#include <errno.h>
 
 #include "automount.h"
 
@@ -43,7 +44,7 @@ struct mnt_list *get_mnt_list(const char
 
 	tab = setmntent(table, "r");
 	if (!tab) {
-		error("get_mntlist: setmntent: %m");
+		error("get_mntlist: setmntent: %s", strerror(errno));
 		return NULL;
 	}
 
@@ -261,7 +262,7 @@ static int find_mntent(const char *table
 
 	tab = setmntent(table, "r");
 	if (!tab) {
-		error("find_mntent: setmntent: %m");
+		error("find_mntent: setmntent: %s", strerror(errno));
 		return 0;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_file.c autofs-4.1.4_beta1_5/modules/lookup_file.c
--- autofs-4.1.4_beta1_4/modules/lookup_file.c	Wed Jan 26 07:31:38 2005
+++ autofs-4.1.4_beta1_5/modules/lookup_file.c	Fri Feb 11 11:46:11 2005
@@ -57,7 +57,7 @@ int lookup_init(const char *mapfmt, int 
 	struct stat st;
 
 	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_hesiod.c autofs-4.1.4_beta1_5/modules/lookup_hesiod.c
--- autofs-4.1.4_beta1_4/modules/lookup_hesiod.c	Fri Feb 11 10:49:58 2005
+++ autofs-4.1.4_beta1_5/modules/lookup_hesiod.c	Fri Feb 11 11:46:11 2005
@@ -42,7 +42,7 @@ int lookup_init(const char *mapfmt, int 
 	/* If we can't build a context, bail. */
 	if ((*context = ctxt = (struct lookup_context *)
 	     malloc(sizeof(struct lookup_context))) == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_ldap.c autofs-4.1.4_beta1_5/modules/lookup_ldap.c
--- autofs-4.1.4_beta1_4/modules/lookup_ldap.c	Wed Jan 26 09:21:21 2005
+++ autofs-4.1.4_beta1_5/modules/lookup_ldap.c	Fri Feb 11 11:46:11 2005
@@ -106,7 +106,7 @@ int lookup_init(const char *mapfmt, int 
 	ctxt = (struct lookup_context *) malloc(sizeof(struct lookup_context));
 	*context = ctxt;
 	if (ctxt == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 	memset(ctxt, 0, sizeof(struct lookup_context));
@@ -207,7 +207,7 @@ static int read_one_map(const char *root
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
@@ -396,7 +396,7 @@ static int lookup_one(const char *root, 
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
@@ -504,7 +504,7 @@ static int lookup_wild(const char *root,
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_multi.c autofs-4.1.4_beta1_5/modules/lookup_multi.c
--- autofs-4.1.4_beta1_4/modules/lookup_multi.c	Fri Dec 31 08:30:08 2004
+++ autofs-4.1.4_beta1_5/modules/lookup_multi.c	Fri Feb 11 11:46:11 2005
@@ -107,7 +107,7 @@ int lookup_init(const char *my_mapfmt, i
 	return 0;
 
       nomem:
-	crit(MODPREFIX "malloc: %m");
+	crit(MODPREFIX "malloc failure");
 	return 1;
 }
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_nisplus.c autofs-4.1.4_beta1_5/modules/lookup_nisplus.c
--- autofs-4.1.4_beta1_4/modules/lookup_nisplus.c	Fri Dec 31 08:30:08 2004
+++ autofs-4.1.4_beta1_5/modules/lookup_nisplus.c	Fri Feb 11 11:46:11 2005
@@ -36,13 +36,14 @@ int lookup_init(const char *mapfmt, int 
 {
 	struct lookup_context *ctxt;
 
-	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "%m");
+	*context = ctxt = malloc(sizeof(struct lookup_context));
+	if (!ctxt) {
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
 	if (argc < 1) {
-		crit(MODPREFIX "No map name");
+		crit(MODPREFIX "no map name");
 		return 1;
 	}
 	ctxt->mapname = argv[0];
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_program.c autofs-4.1.4_beta1_5/modules/lookup_program.c
--- autofs-4.1.4_beta1_4/modules/lookup_program.c	Fri Feb 11 10:49:53 2005
+++ autofs-4.1.4_beta1_5/modules/lookup_program.c	Fri Feb 11 11:46:11 2005
@@ -48,7 +48,7 @@ int lookup_init(const char *mapfmt, int 
 	struct lookup_context *ctxt;
 
 	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
@@ -103,7 +103,7 @@ int lookup_mount(const char *root, const
 
 	mapent = (char *)malloc(MAPENT_MAX_LEN + 1);
 	if (!mapent) {
-		error(MODPREFIX "malloc: %s\n", strerror(errno));
+		error(MODPREFIX "malloc: %s", strerror(errno));
 		return 1;
 	}
 
@@ -114,7 +114,7 @@ int lookup_mount(const char *root, const
 	 */
 
 	if (pipe(pipefd)) {
-		error(MODPREFIX "pipe: %m");
+		error(MODPREFIX "pipe: %s", strerror(errno));
 		goto out_free;
 	}
 	if (pipe(epipefd)) {
@@ -129,7 +129,7 @@ int lookup_mount(const char *root, const
 		close(pipefd[1]);
 		close(epipefd[0]);
 		close(epipefd[1]);
-		error(MODPREFIX "fork: %m");
+		error(MODPREFIX "fork: %s", strerror(errno));
 		goto out_free;
 	} else if (f == 0) {
 		reset_signals();
@@ -204,7 +204,7 @@ int lookup_mount(const char *root, const
 						       ++alloci));
 					if (!tmp) {
 						alloci--;
-						error(MODPREFIX "realloc: %s\n",
+						error(MODPREFIX "realloc: %s",
 						      strerror(errno));
 						break;
 					}
@@ -264,7 +264,7 @@ int lookup_mount(const char *root, const
 	close(epipefd[0]);
 
 	if (waitpid(f, &status, 0) != f) {
-		error(MODPREFIX "waitpid: %m");
+		error(MODPREFIX "waitpid: %s", strerror(errno));
 		goto out_free;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_userhome.c autofs-4.1.4_beta1_5/modules/lookup_userhome.c
--- autofs-4.1.4_beta1_4/modules/lookup_userhome.c	Fri Dec 31 08:30:09 2004
+++ autofs-4.1.4_beta1_5/modules/lookup_userhome.c	Fri Feb 11 11:46:11 2005
@@ -15,6 +15,7 @@
  * ----------------------------------------------------------------------- */
 
 #include <stdio.h>
+#include <string.h>	/* strerror() */
 #include <malloc.h>
 #include <errno.h>
 #include <pwd.h>
@@ -56,12 +57,12 @@ int lookup_mount(const char *root, const
 
 	/* Create the appropriate symlink */
 	if (chdir(root)) {
-		error(MODPREFIX "chdir failed: %m");
+		error(MODPREFIX "chdir failed: %s", strerror(errno));
 		return 1;
 	}
 
 	if (symlink(pw->pw_dir, name) && errno != EEXIST) {
-		error(MODPREFIX "symlink failed: %m");
+		error(MODPREFIX "symlink failed: %s", strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/lookup_yp.c autofs-4.1.4_beta1_5/modules/lookup_yp.c
--- autofs-4.1.4_beta1_4/modules/lookup_yp.c	Fri Feb 11 10:49:58 2005
+++ autofs-4.1.4_beta1_5/modules/lookup_yp.c	Fri Feb 11 11:46:11 2005
@@ -55,13 +55,14 @@ int lookup_init(const char *mapfmt, int 
 	struct lookup_context *ctxt;
 	int err;
 
-	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "%m");
+	*context = ctxt = malloc(sizeof(struct lookup_context));
+	if (!ctxt) {
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
 	if (argc < 1) {
-		crit(MODPREFIX "No map name");
+		crit(MODPREFIX "no map name");
 		return 1;
 	}
 	ctxt->mapname = argv[0];
diff -urpN autofs-4.1.4_beta1_4/modules/mount_autofs.c autofs-4.1.4_beta1_5/modules/mount_autofs.c
--- autofs-4.1.4_beta1_4/modules/mount_autofs.c	Fri Feb 11 10:49:53 2005
+++ autofs-4.1.4_beta1_5/modules/mount_autofs.c	Fri Feb 11 11:46:11 2005
@@ -45,7 +45,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	sprintf(fullpath, "%s/%s", root, name);
@@ -53,7 +53,7 @@ int mount_mount(const char *root, const 
 	if (c_options) {
 		options = alloca(strlen(c_options) + 1);
 		if (!options) {
-			error(MODPREFIX "alloca: %m");
+			error(MODPREFIX "alloca failure");
 			return 1;
 		}
 		strcpy(options, c_options);
@@ -64,7 +64,8 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if (mkdir_path(fullpath, 0555) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", name);
+		error(MODPREFIX "mkdir_path %s failed: %s",
+			name, strerror(errno));
 		return 1;
 	}
 
@@ -155,7 +156,7 @@ int mount_mount(const char *root, const 
 
 	slave = fork();
 	if (slave < 0) {
-		error(MODPREFIX "fork: %m");
+		error(MODPREFIX "fork: %s", strerror(errno));
 		goto error;
 	} else if (slave == 0) {
 		/* Slave process */
@@ -163,9 +164,11 @@ int mount_mount(const char *root, const 
 		_exit(255);
 	}
 
-	while ((wp = waitpid(slave, &status, WUNTRACED)) == -1 && errno == EINTR);
+	while ((wp = waitpid(slave, &status, WUNTRACED)) == -1 && errno == EINTR)
+		/* do nothing */;
+
 	if (wp != slave) {
-		error(MODPREFIX "waitpid: %m");
+		error(MODPREFIX "waitpid: %s", strerror(errno));
 		goto error;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/mount_bind.c autofs-4.1.4_beta1_5/modules/mount_bind.c
--- autofs-4.1.4_beta1_4/modules/mount_bind.c	Fri Feb 11 11:12:18 2005
+++ autofs-4.1.4_beta1_5/modules/mount_bind.c	Fri Feb 11 11:46:11 2005
@@ -91,7 +91,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -114,7 +114,8 @@ int mount_mount(const char *root, const 
 
 		status = mkdir_path(fullpath, 0555);
 		if (status && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+			error(MODPREFIX "mkdir_path %s failed: %s", fullpath,
+				strerror(errno));
 			return 1;
 		}
 
@@ -163,8 +164,8 @@ int mount_mount(const char *root, const 
 		} else {
 			debug(MODPREFIX "calling mkdir_path %s", basepath);
 			if (mkdir_path(basepath, 0555) && errno != EEXIST) {
-				error(MODPREFIX "mkdir_path %s failed: %m",
-				      basepath);
+				error(MODPREFIX "mkdir_path %s failed: %s",
+				      basepath, strerror(errno));
 				return 1;
 			}
 		}
diff -urpN autofs-4.1.4_beta1_4/modules/mount_changer.c autofs-4.1.4_beta1_5/modules/mount_changer.c
--- autofs-4.1.4_beta1_4/modules/mount_changer.c	Fri Feb 11 11:13:04 2005
+++ autofs-4.1.4_beta1_5/modules/mount_changer.c	Fri Feb 11 11:46:12 2005
@@ -57,7 +57,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -79,7 +79,8 @@ int mount_mount(const char *root, const 
 
 	status = mkdir_path(fullpath, 0555);
 	if (status && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s", fullpath,
+			strerror(errno));
 		return 1;
 	}
 
@@ -140,7 +141,7 @@ int swapCD(const char *device, const cha
 	/* open device */
 	fd = open(device, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		error(MODPREFIX "Opening device %s failed : %s",
+		error(MODPREFIX "Opening device %s failed: %s",
 		      device, strerror(errno));
 		return 1;
 	}
@@ -149,7 +150,7 @@ int swapCD(const char *device, const cha
 	total_slots_available = ioctl(fd, CDROM_CHANGER_NSLOTS);
 	if (total_slots_available <= 1) {
 		error(MODPREFIX
-		      "Device %s is not an ATAPI compliant CD changer.\n",
+		      "Device %s is not an ATAPI compliant CD changer",
 		      device);
 		return 1;
 	}
diff -urpN autofs-4.1.4_beta1_4/modules/mount_ext2.c autofs-4.1.4_beta1_5/modules/mount_ext2.c
--- autofs-4.1.4_beta1_4/modules/mount_ext2.c	Fri Feb 11 11:45:49 2005
+++ autofs-4.1.4_beta1_5/modules/mount_ext2.c	Fri Feb 11 11:46:12 2005
@@ -49,7 +49,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -62,7 +62,8 @@ int mount_mount(const char *root, const 
 
 	status = mkdir_path(fullpath, 0555);
 	if (status && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s", fullpath,\
+			strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/mount_generic.c autofs-4.1.4_beta1_5/modules/mount_generic.c
--- autofs-4.1.4_beta1_4/modules/mount_generic.c	Fri Feb 11 11:12:46 2005
+++ autofs-4.1.4_beta1_5/modules/mount_generic.c	Fri Feb 11 11:46:12 2005
@@ -48,7 +48,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -61,7 +61,8 @@ int mount_mount(const char *root, const 
 
 	status = mkdir_path(fullpath, 0555);
 	if (status && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s", fullpath,
+			strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_4/modules/mount_nfs.c autofs-4.1.4_beta1_5/modules/mount_nfs.c
--- autofs-4.1.4_beta1_4/modules/mount_nfs.c	Fri Feb 11 10:49:58 2005
+++ autofs-4.1.4_beta1_5/modules/mount_nfs.c	Fri Feb 11 11:46:12 2005
@@ -75,7 +75,7 @@ int is_local_addr(const char *host, cons
 
 	sock = socket(AF_INET, SOCK_DGRAM, udpproto);
 	if (sock < 0) {
-		error(MODPREFIX "socket creation failed: %m");
+		error(MODPREFIX "socket creation failed: %s", strerror(errno));
 		return -1;
 	}
 
@@ -85,14 +85,15 @@ int is_local_addr(const char *host, cons
 
 	ret = connect(sock, (struct sockaddr *) &src_addr, src_len);
 	if (ret < 0 ) {
-		error(MODPREFIX "connect failed for %s: %m", host);
+		error(MODPREFIX "connect failed for %s: %s",
+			host, strerror(errno));
 		close(sock);
 		return 0;
 	}
 
 	ret = getsockname(sock, (struct sockaddr *) &local_addr, &local_len);
 	if (ret < 0) {
-		error(MODPREFIX "getsockname failed: %m");
+		error(MODPREFIX "getsockname failed: %s", strerror(errno));
 		close(sock);
 		return 0;
 	}
@@ -335,7 +336,7 @@ int mount_mount(const char *root, const 
 
 	whatstr = alloca(strlen(what) + 1);
 	if (!whatstr) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	strcpy(whatstr, what);
@@ -375,7 +376,7 @@ int mount_mount(const char *root, const 
 
 #if 0
 			debug(MODPREFIX "*comma=%x %c  comma=%p %s cp=%p %s "
-			      "nfsoptions=%p nfsp=%p end=%p used=%d len=%d\n",
+			      "nfsoptions=%p nfsp=%p end=%p used=%d len=%d",
 			      *comma, *comma, comma, comma, cp, cp,
 			      nfsoptions, nfsp, nfsoptions + len,
 			      nfsp - nfsoptions, len);
@@ -414,7 +415,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -441,7 +442,8 @@ int mount_mount(const char *root, const 
 
 		status = mkdir_path(fullpath, 0555);
 		if (status && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+			error(MODPREFIX "mkdir_path %s failed: %s", fullpath,
+				strerror(errno));
 			return 1;
 		}
 
diff -urpN autofs-4.1.4_beta1_4/modules/parse_sun.c autofs-4.1.4_beta1_5/modules/parse_sun.c
--- autofs-4.1.4_beta1_4/modules/parse_sun.c	Sun Jan 23 16:47:40 2005
+++ autofs-4.1.4_beta1_5/modules/parse_sun.c	Fri Feb 11 11:46:12 2005
@@ -367,7 +367,7 @@ int parse_init(int argc, const char *con
 	/* Set up context and escape chain */
 
 	if (!(ctxt = (struct parse_context *) malloc(sizeof(struct parse_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 	*context = (void *) ctxt;
@@ -384,7 +384,7 @@ int parse_init(int argc, const char *con
 			case 'D':
 				sv = malloc(sizeof(struct substvar));
 				if (!sv) {
-					error(MODPREFIX "malloc: %m");
+					error(MODPREFIX "malloc failure");
 					break;
 				}
 				if (argv[i][2])
@@ -397,7 +397,7 @@ int parse_init(int argc, const char *con
 				}
 
 				if (!sv->def) {
-					error(MODPREFIX "strdup: %m");
+					error(MODPREFIX "strdup failure");
 					free(sv);
 				} else {
 					sv->val = strchr(sv->def, '=');
@@ -462,7 +462,7 @@ int parse_init(int argc, const char *con
 			}
 			if (!noptstr) {
 				kill_context(ctxt);
-				crit(MODPREFIX "%m");
+				crit(MODPREFIX "malloc failure");
 				return 1;
 			}
 			ctxt->optstr = noptstr;
@@ -546,7 +546,7 @@ static char *concat_options(char *left, 
 	ret = malloc(strlen(left) + strlen(right) + 2);
 
 	if (ret == NULL) {
-		error(MODPREFIX "concat_options malloc: %m");
+		error(MODPREFIX "concat_options malloc failure");
 		return NULL;
 	}
 
@@ -658,7 +658,7 @@ static int sun_mount(const char *root, c
 	}
 
 	debug(MODPREFIX
-	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s\n",
+	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s",
 	    root, mountpoint, what, fstype, options);
 
 	if (!strcmp(fstype, "nfs")) {
@@ -756,7 +756,7 @@ int parse_mount(const char *root, const 
 	mapent_len = expandsunent(mapent, NULL, name, ctxt->subst, ctxt->slashify_colons);
 	pmapent = alloca(mapent_len + 1);
 	if (!pmapent) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -766,7 +766,7 @@ int parse_mount(const char *root, const 
 
 	options = strdup(ctxt->optstr ? ctxt->optstr : "");
 	if (!options) {
-		error(MODPREFIX "strdup: %m");
+		error(MODPREFIX "strdup failure");
 		return 1;
 	}
 	optlen = strlen(options);
@@ -782,7 +782,8 @@ int parse_mount(const char *root, const 
 			options = concat_options(options, noptions);
 
 			if (options == NULL) {
-				error(MODPREFIX "concat_options: %m");
+				error(MODPREFIX
+					"concat_options malloc failure");
 				return 1;
 			}
 			p = skipspace(p);
@@ -798,7 +799,7 @@ int parse_mount(const char *root, const 
 
 		multi_root = alloca(strlen(root) + name_len + 2);
 		if (!multi_root) {
-			error(MODPREFIX "alloca: %m");
+			error(MODPREFIX "alloca failure");
 			free(options);
 			return 1;
 		}
@@ -813,7 +814,7 @@ int parse_mount(const char *root, const 
 			char *path, *loc;
 
 			if (myoptions == NULL) {
-				error(MODPREFIX "multi strdup: %m");
+				error(MODPREFIX "multi strdup failure");
 				free(options);
 				multi_free_list(head);
 				return 1;
@@ -841,7 +842,7 @@ int parse_mount(const char *root, const 
 
 					if (myoptions == NULL) {
 						error(MODPREFIX
-						    "multi concat_options: %m");
+						    "multi concat_options malloc_failure");
 						free(options);
 						free(path);
 						multi_free_list(head);

--Boundary-00=_VRIDC92o4ldvpy9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_VRIDC92o4ldvpy9--

