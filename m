From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH] semi-trivial patches
Date: Mon, 11 Apr 2005 11:01:13 +0300
Message-ID: <200504111101.13933.vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_J7iWC9FdkY1zWcU"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504102120390.14539@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
To: raven@themaw.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


--Boundary-00=_J7iWC9FdkY1zWcU
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 10 April 2005 16:38, raven@themaw.net wrote:
> 
> Hi all,
> 
> Here is autofs 4.1.4.

Please find three patches attached.

b.exec.patch makes it possible to rely on PATH
when exec'ing mount etc. If one wants to do this, he will
need to run configure like this:
OUNT="mount" \
UMOUNT="umount" \
E2FSCK="fsck.ext2" \
E3FSCK="fsck.ext3" \
./configure
but at least one wouldn't need to hack C source for that to work
as expected (.i.e., to search for binaries in the PATH).
'Classic' automount would be unaffected since it uses /abs/path/names,
and exec..p() does not search PATH in this case.

c.msg.patch removes usage of %m in messages (this can't work for
non-syslog directed messages). I need this for pending --stderr patch.
Also it removes tons of stray newlines.

d.close.patch fixes obscure bug when we can close one of standard
descriptors.

Was run tested before, rediffed against 4.1.4 and compile tested.

Please apply.
--
vda

--Boundary-00=_J7iWC9FdkY1zWcU
Content-Type: text/x-diff;
  charset="koi8-r";
  name="b.exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="b.exec.patch"

diff -urpN autofs-4.1.4.a.orig/daemon/spawn.c autofs-4.1.4.b.exec/daemon/spawn.c
--- autofs-4.1.4.a.orig/daemon/spawn.c	Thu Feb 10 14:56:53 2005
+++ autofs-4.1.4.b.exec/daemon/spawn.c	Mon Apr 11 10:20:27 2005
@@ -228,8 +228,8 @@ static int do_spawn(int logpri, int use_
 		dup2(pipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 
-		execv(prog, (char *const *) argv);
-		_exit(255);	/* execv() failed */
+		execvp(prog, (char *const *) argv);
+		_exit(255);	/* exec() failed */
 	} else {
 		/* Careful here -- if we enable SIGCHLD yet we may not receive the
 		   waitpid() at the end */
diff -urpN autofs-4.1.4.a.orig/modules/lookup_program.c autofs-4.1.4.b.exec/modules/lookup_program.c
--- autofs-4.1.4.a.orig/modules/lookup_program.c	Fri Dec 31 08:30:09 2004
+++ autofs-4.1.4.b.exec/modules/lookup_program.c	Mon Apr 11 10:20:27 2005
@@ -139,8 +139,8 @@ int lookup_mount(const char *root, const
 		dup2(epipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 		close(epipefd[1]);
-		execl(ctxt->mapname, ctxt->mapname, name, NULL);
-		_exit(255);	/* execl() failed */
+		execlp(ctxt->mapname, ctxt->mapname, name, NULL);
+		_exit(255);	/* exec() failed */
 	}
 	close(pipefd[1]);
 	close(epipefd[1]);
diff -urpN autofs-4.1.4.a.orig/modules/mount_autofs.c autofs-4.1.4.b.exec/modules/mount_autofs.c
--- autofs-4.1.4.a.orig/modules/mount_autofs.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4.b.exec/modules/mount_autofs.c	Mon Apr 11 10:20:27 2005
@@ -159,7 +159,7 @@ int mount_mount(const char *root, const 
 		goto error;
 	} else if (slave == 0) {
 		/* Slave process */
-		execv(PATH_AUTOMOUNT, argv);
+		execvp(PATH_AUTOMOUNT, argv);
 		_exit(255);
 	}
 

--Boundary-00=_J7iWC9FdkY1zWcU
Content-Type: text/x-diff;
  charset="koi8-r";
  name="d.close.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="d.close.patch"

diff -urpN autofs-4.1.4.c.messages/daemon/automount.c autofs-4.1.4.d.close/daemon/automount.c
--- autofs-4.1.4.c.messages/daemon/automount.c	Mon Apr 11 10:42:39 2005
+++ autofs-4.1.4.d.close/daemon/automount.c	Mon Apr 11 10:42:20 2005
@@ -1322,12 +1322,13 @@ static void become_daemon(void)
 		exit(1);
 	}
 
-	if (dup2(nullfd, STDIN_FILENO) < 0 ||
-	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
+	if (dup2(nullfd, STDIN_FILENO) < 0
+	 || dup2(nullfd, STDOUT_FILENO) < 0
+	 || dup2(nullfd, STDERR_FILENO) < 0) {
 		crit("redirecting file descriptors failed: %s", strerror(errno));
 		exit(1);
 	}
-	close(nullfd);
+	if (nullfd > 2) close(nullfd);
 
 	/* Write pid file if requested */
 	if (pid_file) {

--Boundary-00=_J7iWC9FdkY1zWcU
Content-Type: text/x-diff;
  charset="koi8-r";
  name="c.msg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="c.msg.patch"

diff -urpN autofs-4.1.4.b.exec/daemon/automount.c autofs-4.1.4.c.messages/daemon/automount.c
--- autofs-4.1.4.b.exec/daemon/automount.c	Sun Mar  6 11:43:55 2005
+++ autofs-4.1.4.c.messages/daemon/automount.c	Mon Apr 11 10:42:39 2005
@@ -221,7 +221,7 @@ static int rm_unwanted_fn(const char *fi
 		if (st->st_dev != ap.dev)
 			return 0;
 	} else {
-		info("rm_unwanted: %s\n", file);
+		info("rm_unwanted: %s", file);
 		if (S_ISDIR(st->st_mode))
 			rmdir(file);
 		else if (!S_ISLNK(st->st_mode) || rmsymlink)
@@ -254,7 +254,7 @@ static int umount_multi(const char *path
 	struct mnt_list *mntlist = NULL;
 	struct mnt_list *mptr;
 
-	debug("umount_multi: path=%s incl=%d\n", path, incl);
+	debug("umount_multi: path=%s incl=%d", path, incl);
 
 	mntlist = get_mnt_list(_PATH_MOUNTED, path, incl);
 
@@ -266,7 +266,7 @@ static int umount_multi(const char *path
 
 	left = 0;
 	for (mptr = mntlist; mptr != NULL; mptr = mptr->next) {
-		debug("umount_multi: unmounting dir=%s\n", mptr->path);
+		debug("umount_multi: unmounting dir=%s", mptr->path);
 		if (umount_ent("", mptr->path, mptr->fs_type)) {
 			left++;
 		}
@@ -317,7 +317,7 @@ static int do_umount_autofs(void)
 			    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		if (rv & MTAB_NOTUPDATED) {
 			info("umount %s succeeded: "
-			     "mtab not updated, retrying to clean\n",
+			     "mtab not updated, retrying to clean",
 			      ap.path);
 			rv = spawnll(LOG_DEBUG,
 				    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
@@ -329,16 +329,16 @@ static int do_umount_autofs(void)
 			break;
 		}
 		if (i < retries - 1) {
-			info("umount %s failed: retrying...\n", ap.path);
+			info("umount %s failed: retrying...", ap.path);
 			sleep(1);
 		}
 	}
 	if (rv != 0 || i == retries) {
-		error("can't unmount %s\n", ap.path);
+		error("can't unmount %s", ap.path);
 		DB(kill(0, SIGSTOP));
 	} else {
 		if (i != 0)
-			info("umount %s succeeded\n", ap.path);
+			info("umount %s succeeded", ap.path);
 
 		if (submount)
 			rm_unwanted(ap.path, 1, 1);
@@ -481,7 +481,7 @@ static int mount_autofs(char *path)
 static void nextstate(enum states next)
 {
 	if (write(ap.state_pipe[1], &next, sizeof(next)) != sizeof(next))
-		error("nextstate: write failed %m");
+		error("nextstate: write failed %s", strerror(errno));
 }
 
 /* Deal with all the signal-driven events in the state machine */
@@ -527,9 +527,9 @@ static int send_ready(unsigned int wait_
 {
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_ready: token=%d\n", wait_queue_token);
+	debug("send_ready: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_READY, wait_queue_token) < 0) {
-		error("AUTOFS_IOC_READY: %m");
+		error("AUTOFS_IOC_READY: %s", strerror(errno));
 		return 1;
 	}
 	return 0;
@@ -539,9 +539,9 @@ static int send_fail(unsigned int wait_q
 {
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_fail: token=%d\n", wait_queue_token);
+	debug("send_fail: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_FAIL, wait_queue_token) < 0) {
-		syslog(LOG_ERR, "AUTOFS_IOC_FAIL: %m");
+		error("AUTOFS_IOC_FAIL: %s", strerror(errno));
 		return 1;
 	}
 	return 0;
@@ -559,7 +559,7 @@ static enum states handle_child(int hang
 	while ((pid = waitpid(-1, &status, hang ? 0 : WNOHANG)) > 0) {
 		struct pending_mount volatile *mt, *volatile *mtp;
 
-		debug("handle_child: got pid %d, sig %d (%d), stat %d\n",
+		debug("handle_child: got pid %d, sig %d (%d), stat %d",
 			pid, WIFSIGNALED(status),
 			WTERMSIG(status), WEXITSTATUS(status));
 
@@ -673,7 +673,7 @@ static void sig_child(int sig)
 
 static int st_ready(void)
 {
-	debug("st_ready(): state = %d\n", ap.state);
+	debug("st_ready(): state = %d", ap.state);
 
 	ap.state = ST_READY;
 	sigprocmask(SIG_UNBLOCK, &lock_sigs, NULL);
@@ -783,13 +783,13 @@ static enum expire expire_proc(int now)
 		 * words) the umounts are done by the time we reach here
 		 */
 		if ((count = count_mounts(ap.path))) {
-			debug("expire_proc: %d remaining in %s\n", count, ap.path);
+			debug("expire_proc: %d remaining in %s", count, ap.path);
 			exit(1);
 		}
 		exit(0);
 
 	case -1:
-		error("expire: fork failed: %m");
+		error("expire: fork failed: %s", strerror(errno));
 		sigprocmask(SIG_SETMASK, &old, NULL);
 		return EXP_ERROR;
 
@@ -806,7 +806,7 @@ static int st_readmap(void)
 
 	status = ap.lookup->lookup_ghost(ap.path, ap.ghost, 0, ap.lookup->context);
 
-	debug("st_readmap: status %d\n", status);
+	debug("st_readmap: status %d", status);
 
 	/* If I don't exist in the map any more then exit */
 	if (status == LKP_FAIL)
@@ -819,7 +819,7 @@ static int st_prepare_shutdown(void)
 {
 	int exp;
 
-	info("prep_shutdown: state = %d\n", ap.state);
+	info("prep_shutdown: state = %d", ap.state);
 
 	assert(ap.state == ST_READY || ap.state == ST_EXPIRE);
 
@@ -838,7 +838,7 @@ static int st_prepare_shutdown(void)
 	/* Unmount everything */
 	exp = expire_proc(1);
 
-	debug("prep_shutdown: expire returns %d\n", exp);
+	debug("prep_shutdown: expire returns %d", exp);
 
 	switch (exp) {
 	case EXP_ERROR:
@@ -862,7 +862,7 @@ static int st_prepare_shutdown(void)
 
 static int st_prune(void)
 {
-	debug("st_prune(): state = %d\n", ap.state);
+	debug("st_prune(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -890,7 +890,7 @@ static int st_prune(void)
 
 static int st_expire(void)
 {
-	debug("st_expire(): state = %d\n", ap.state);
+	debug("st_expire(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -947,7 +947,7 @@ static int get_pkt(int fd, union autofs_
 		if (poll(fds, 2, -1) == -1) {
 			if (errno == EINTR)
 				continue;
-			syslog(LOG_ERR, "get_pkt: poll failed: %m");
+			error("get_pkt: poll failed: %s", strerror(errno));
 			return -1;
 		}
 
@@ -1042,7 +1042,7 @@ static int handle_packet_missing(const s
 			junk_mounts = junk_mounts->next;
 		} else {
 			if (!(mt = malloc(sizeof(struct pending_mount)))) {
-				error("handle_packet_missing: malloc: %m");
+				error("handle_packet_missing: malloc failure");
 				send_fail(pkt->wait_queue_token);
 				return 1;
 			}
@@ -1068,7 +1068,7 @@ static int handle_packet_missing(const s
 		f = fork();
 		if (f == -1) {
 			sigprocmask(SIG_SETMASK, &oldsig, NULL);
-			error("handle_packet_missing: fork: %m");
+			error("handle_packet_missing: fork: %s", strerror(errno));
 
 			send_fail(pkt->wait_queue_token);
 			free(mt);
@@ -1169,7 +1169,7 @@ static void do_expire(const char *name, 
 		chdir("/");
 
 		if (ret)
-			error("failed to recover from partial expiry of %s\n",
+			error("failed to recover from partial expiry of %s",
 			       buf);
 	}
 }
@@ -1193,7 +1193,7 @@ static int handle_expire(const char *nam
 	} else {
 		if (!(mt = malloc(sizeof(struct pending_mount)))) {
 			sigprocmask(SIG_SETMASK, &olds, NULL);
-			error("handle_expire: malloc: %m");
+			error("handle_expire: malloc failure");
 			return 1;
 		}
 	}
@@ -1201,7 +1201,7 @@ static int handle_expire(const char *nam
 	f = fork();
 	if (f == -1) {
 		sigprocmask(SIG_SETMASK, &olds, NULL);
-		error("handle_expire: fork: %m");
+		error("handle_expire: fork: %s", strerror(errno));
 		free(mt);
 
 		return 1;
@@ -1256,7 +1256,7 @@ static int handle_packet(void)
 	if (get_pkt(ap.pipefd, &pkt))
 		return -1;
 
-	debug("handle_packet: type = %d\n", pkt.hdr.type);
+	debug("handle_packet: type = %d", pkt.hdr.type);
 
 	switch (pkt.hdr.type) {
 	case autofs_ptype_missing:
@@ -1268,7 +1268,7 @@ static int handle_packet(void)
 	case autofs_ptype_expire_multi:
 		return handle_packet_expire_multi(&pkt.expire_multi);
 	}
-	error("handle_packet: unknown packet type %d\n", pkt.hdr.type);
+	error("handle_packet: unknown packet type %d", pkt.hdr.type);
 	return -1;
 }
 
@@ -1311,20 +1311,20 @@ static void become_daemon(void)
 	 * signals. This call also sets us as the process group leader.
 	 */
 	if (!submount && (setsid() == -1)) {
-		crit("setsid: %m");
+		crit("setsid: %s", strerror(errno));
 		exit(1);
 	}
 	my_pgrp = getpgrp();
 
 	/* Redirect all our file descriptors to /dev/null */
 	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
-		crit("cannot open /dev/null: %m");
+		crit("cannot open /dev/null: %s", strerror(errno));
 		exit(1);
 	}
 
 	if (dup2(nullfd, STDIN_FILENO) < 0 ||
 	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
-		crit("redirecting file descriptors failed: %m");
+		crit("redirecting file descriptors failed: %s", strerror(errno));
 		exit(1);
 	}
 	close(nullfd);
@@ -1335,7 +1335,8 @@ static void become_daemon(void)
 			fprintf(pidfp, "%lu\n", (unsigned long) my_pid);
 			fclose(pidfp);
 		} else {
-			warn("failed to write pid file %s: %m", pid_file);
+			warn("failed to write pid file %s: %s", pid_file,
+				strerror(errno));
 			pid_file = NULL;
 		}
 	}
@@ -1357,7 +1358,8 @@ static void cleanup_exit(const char *pat
 
 	if ((!ap.ghost || !submount) && (*(path + 1) != '-') && ap.dir_created)
 		if (rmdir(path) == -1)
-			warn("failed to remove dir %s: %m", path);
+			warn("failed to remove dir %s: %s",
+				path, strerror(errno));
 
 	exit(exit_code);
 }
@@ -1558,7 +1560,7 @@ int handle_mounts(char *path)
 	if (!ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOVER, &kproto_version)) {
 		/* If this ioctl() doesn't work, kernel does not support ghosting */
 		if (ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOSUBVER, &kproto_sub_version)) {
-			debug("kproto sub: %m");
+			debug("kproto sub: %s", strerror(errno));
 			kproto_sub_version = 0;
 			if (ap.ghost) {
 				ap.ghost = 0;
@@ -1566,7 +1568,7 @@ int handle_mounts(char *path)
 			}
 		}
 	} else {
-		debug("kproto: %m");
+		debug("kproto: %s", strerror(errno));
 		kproto_version = 2;
 	}
 
@@ -1721,7 +1723,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "%s: This program must be run by root.\n", program);
+		fprintf(stderr, "%s: This program must be run by root\n", program);
 		exit(1);
 	}
 
diff -urpN autofs-4.1.4.b.exec/daemon/module.c autofs-4.1.4.c.messages/daemon/module.c
--- autofs-4.1.4.b.exec/daemon/module.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.4.c.messages/daemon/module.c	Mon Apr 11 10:29:18 2005
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
diff -urpN autofs-4.1.4.b.exec/lib/cache.c autofs-4.1.4.c.messages/lib/cache.c
--- autofs-4.1.4.b.exec/lib/cache.c	Sun Feb  6 08:00:53 2005
+++ autofs-4.1.4.c.messages/lib/cache.c	Mon Apr 11 10:29:18 2005
@@ -437,8 +437,8 @@ int cache_ghost(const char *root, int gh
 				if (stat(fullpath, &st) == -1 && errno == ENOENT) {
 					if (mkdir_path(fullpath, 0555) < 0)
 						warn("cache_ghost: mkdir_path %s "
-						     "failed: %m",
-						      fullpath);
+						     "failed: %s",
+						      fullpath, strerror(errno));
 				}
 				break;
 
diff -urpN autofs-4.1.4.b.exec/lib/mounts.c autofs-4.1.4.c.messages/lib/mounts.c
--- autofs-4.1.4.b.exec/lib/mounts.c	Mon Jan 17 17:09:28 2005
+++ autofs-4.1.4.c.messages/lib/mounts.c	Mon Apr 11 10:29:18 2005
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
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_file.c autofs-4.1.4.c.messages/modules/lookup_file.c
--- autofs-4.1.4.b.exec/modules/lookup_file.c	Wed Apr  6 18:14:23 2005
+++ autofs-4.1.4.c.messages/modules/lookup_file.c	Mon Apr 11 10:29:18 2005
@@ -57,7 +57,7 @@ int lookup_init(const char *mapfmt, int 
 	struct stat st;
 
 	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_hesiod.c autofs-4.1.4.c.messages/modules/lookup_hesiod.c
--- autofs-4.1.4.b.exec/modules/lookup_hesiod.c	Fri Dec 31 08:30:08 2004
+++ autofs-4.1.4.c.messages/modules/lookup_hesiod.c	Mon Apr 11 10:29:18 2005
@@ -42,7 +42,7 @@ int lookup_init(const char *mapfmt, int 
 	/* If we can't build a context, bail. */
 	if ((*context = ctxt = (struct lookup_context *)
 	     malloc(sizeof(struct lookup_context))) == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
@@ -82,7 +82,7 @@ int lookup_mount(const char *root, const
 	hes_result = hes_resolve(name, "filsys");
 
 	if (!hes_result || !hes_result[0]) {
-		warn(MODPREFIX "entry \"%s\" not found in map\n", name);
+		warn(MODPREFIX "entry \"%s\" not found in map", name);
 		return 1;
 	}
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_ldap.c autofs-4.1.4.c.messages/modules/lookup_ldap.c
--- autofs-4.1.4.b.exec/modules/lookup_ldap.c	Sun Feb 27 07:37:14 2005
+++ autofs-4.1.4.c.messages/modules/lookup_ldap.c	Mon Apr 11 10:29:18 2005
@@ -114,7 +114,7 @@ int lookup_init(const char *mapfmt, int 
 	ctxt = (struct lookup_context *) malloc(sizeof(struct lookup_context));
 	*context = ctxt;
 	if (ctxt == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 	memset(ctxt, 0, sizeof(struct lookup_context));
@@ -215,7 +215,7 @@ static int read_one_map(const char *root
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
@@ -404,7 +404,7 @@ static int lookup_one(const char *root, 
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
@@ -512,7 +512,7 @@ static int lookup_wild(const char *root,
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_multi.c autofs-4.1.4.c.messages/modules/lookup_multi.c
--- autofs-4.1.4.b.exec/modules/lookup_multi.c	Thu Feb 10 14:31:29 2005
+++ autofs-4.1.4.c.messages/modules/lookup_multi.c	Mon Apr 11 10:29:18 2005
@@ -107,7 +107,7 @@ int lookup_init(const char *my_mapfmt, i
 	return 0;
 
       nomem:
-	crit(MODPREFIX "malloc: %m");
+	crit(MODPREFIX "malloc failure");
 	return 1;
 }
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_nisplus.c autofs-4.1.4.c.messages/modules/lookup_nisplus.c
--- autofs-4.1.4.b.exec/modules/lookup_nisplus.c	Fri Dec 31 08:30:08 2004
+++ autofs-4.1.4.c.messages/modules/lookup_nisplus.c	Mon Apr 11 10:29:18 2005
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
diff -urpN autofs-4.1.4.b.exec/modules/lookup_program.c autofs-4.1.4.c.messages/modules/lookup_program.c
--- autofs-4.1.4.b.exec/modules/lookup_program.c	Mon Apr 11 10:20:27 2005
+++ autofs-4.1.4.c.messages/modules/lookup_program.c	Mon Apr 11 10:44:21 2005
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
+		error(MODPREFIX "malloc failure");
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
@@ -204,8 +204,7 @@ int lookup_mount(const char *root, const
 						       ++alloci));
 					if (!tmp) {
 						alloci--;
-						error(MODPREFIX "realloc: %s\n",
-						      strerror(errno));
+						error(MODPREFIX "realloc failure");
 						break;
 					}
 					mapent = tmp;
@@ -264,7 +263,7 @@ int lookup_mount(const char *root, const
 	close(epipefd[0]);
 
 	if (waitpid(f, &status, 0) != f) {
-		error(MODPREFIX "waitpid: %m");
+		error(MODPREFIX "waitpid: %s", strerror(errno));
 		goto out_free;
 	}
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_userhome.c autofs-4.1.4.c.messages/modules/lookup_userhome.c
--- autofs-4.1.4.b.exec/modules/lookup_userhome.c	Fri Dec 31 08:30:09 2004
+++ autofs-4.1.4.c.messages/modules/lookup_userhome.c	Mon Apr 11 10:29:18 2005
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
 
diff -urpN autofs-4.1.4.b.exec/modules/lookup_yp.c autofs-4.1.4.c.messages/modules/lookup_yp.c
--- autofs-4.1.4.b.exec/modules/lookup_yp.c	Thu Feb 10 12:59:59 2005
+++ autofs-4.1.4.c.messages/modules/lookup_yp.c	Mon Apr 11 10:29:18 2005
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
@@ -69,7 +70,7 @@ int lookup_init(const char *mapfmt, int 
 	/* This should, but doesn't, take a const char ** */
 	err = yp_get_default_domain((char **) &ctxt->domainname);
 	if (err) {
-		crit(MODPREFIX "map %s: %s\n", ctxt->mapname,
+		crit(MODPREFIX "map %s: %s", ctxt->mapname,
 		       yperr_string(err));
 		return 1;
 	}
diff -urpN autofs-4.1.4.b.exec/modules/mount_autofs.c autofs-4.1.4.c.messages/modules/mount_autofs.c
--- autofs-4.1.4.b.exec/modules/mount_autofs.c	Mon Apr 11 10:20:27 2005
+++ autofs-4.1.4.c.messages/modules/mount_autofs.c	Mon Apr 11 10:29:18 2005
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
 
diff -urpN autofs-4.1.4.b.exec/modules/mount_bind.c autofs-4.1.4.c.messages/modules/mount_bind.c
--- autofs-4.1.4.b.exec/modules/mount_bind.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4.c.messages/modules/mount_bind.c	Mon Apr 11 10:47:30 2005
@@ -68,7 +68,7 @@ int mount_init(void **context)
 		bind_works = 1;
 	}
 
-	debug(MODPREFIX "bind_works = %d\n", bind_works);
+	debug(MODPREFIX "bind_works = %d", bind_works);
 	spawnl(LOG_DEBUG,
 	       PATH_UMOUNT, PATH_UMOUNT, "-n", tmp2, NULL);
 
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
diff -urpN autofs-4.1.4.b.exec/modules/mount_changer.c autofs-4.1.4.c.messages/modules/mount_changer.c
--- autofs-4.1.4.b.exec/modules/mount_changer.c	Sun Jan  9 11:16:43 2005
+++ autofs-4.1.4.c.messages/modules/mount_changer.c	Mon Apr 11 10:29:18 2005
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
@@ -164,7 +165,7 @@ int swapCD(const char *device, const cha
 	/* close device */
 	status = close(fd);
 	if (status != 0) {
-		error(MODPREFIX "close failed for `%s': %s\n",
+		error(MODPREFIX "close failed for `%s': %s",
 		      device, strerror(errno));
 		return 1;
 	}
diff -urpN autofs-4.1.4.b.exec/modules/mount_ext2.c autofs-4.1.4.c.messages/modules/mount_ext2.c
--- autofs-4.1.4.b.exec/modules/mount_ext2.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4.c.messages/modules/mount_ext2.c	Mon Apr 11 10:29:18 2005
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
 
diff -urpN autofs-4.1.4.b.exec/modules/mount_generic.c autofs-4.1.4.c.messages/modules/mount_generic.c
--- autofs-4.1.4.b.exec/modules/mount_generic.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4.c.messages/modules/mount_generic.c	Mon Apr 11 10:29:18 2005
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
 
diff -urpN autofs-4.1.4.b.exec/modules/mount_nfs.c autofs-4.1.4.c.messages/modules/mount_nfs.c
--- autofs-4.1.4.b.exec/modules/mount_nfs.c	Tue Apr  5 15:42:42 2005
+++ autofs-4.1.4.c.messages/modules/mount_nfs.c	Mon Apr 11 10:29:18 2005
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
@@ -326,7 +327,7 @@ int mount_mount(const char *root, const 
 
 	whatstr = alloca(strlen(what) + 1);
 	if (!whatstr) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	strcpy(whatstr, what);
@@ -366,7 +367,7 @@ int mount_mount(const char *root, const 
 
 #if 0
 			debug(MODPREFIX "*comma=%x %c  comma=%p %s cp=%p %s "
-			      "nfsoptions=%p nfsp=%p end=%p used=%d len=%d\n",
+			      "nfsoptions=%p nfsp=%p end=%p used=%d len=%d",
 			      *comma, *comma, comma, comma, cp, cp,
 			      nfsoptions, nfsp, nfsoptions + len,
 			      nfsp - nfsoptions, len);
@@ -405,7 +406,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -432,7 +433,8 @@ int mount_mount(const char *root, const 
 
 		status = mkdir_path(fullpath, 0555);
 		if (status && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+			error(MODPREFIX "mkdir_path %s failed: %s", fullpath,
+				strerror(errno));
 			return 1;
 		}
 
diff -urpN autofs-4.1.4.b.exec/modules/parse_sun.c autofs-4.1.4.c.messages/modules/parse_sun.c
--- autofs-4.1.4.b.exec/modules/parse_sun.c	Tue Apr  5 15:42:42 2005
+++ autofs-4.1.4.c.messages/modules/parse_sun.c	Mon Apr 11 10:29:18 2005
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
 
@@ -677,7 +677,7 @@ static int sun_mount(const char *root, c
 	}
 
 	debug(MODPREFIX
-	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s\n",
+	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s",
 	    root, mountpoint, what, fstype, options);
 
 	if (!strcmp(fstype, "nfs")) {
@@ -819,7 +819,7 @@ int parse_mount(const char *root, const 
 	mapent_len = expandsunent(mapent, NULL, name, ctxt->subst, ctxt->slashify_colons);
 	pmapent = alloca(mapent_len + 1);
 	if (!pmapent) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	pmapent[mapent_len] = '\0';
@@ -830,7 +830,7 @@ int parse_mount(const char *root, const 
 
 	options = strdup(ctxt->optstr ? ctxt->optstr : "");
 	if (!options) {
-		error(MODPREFIX "strdup: %m");
+		error(MODPREFIX "strdup failure");
 		return 1;
 	}
 	optlen = strlen(options);
@@ -846,7 +846,8 @@ int parse_mount(const char *root, const 
 			options = concat_options(options, noptions);
 
 			if (options == NULL) {
-				error(MODPREFIX "concat_options: %m");
+				error(MODPREFIX
+					"concat_options malloc failure");
 				return 1;
 			}
 			p = skipspace(p);
@@ -862,7 +863,7 @@ int parse_mount(const char *root, const 
 
 		multi_root = alloca(strlen(root) + name_len + 2);
 		if (!multi_root) {
-			error(MODPREFIX "alloca: %m");
+			error(MODPREFIX "alloca failure");
 			free(options);
 			return 1;
 		}
@@ -877,7 +878,7 @@ int parse_mount(const char *root, const 
 			char *path, *loc;
 
 			if (myoptions == NULL) {
-				error(MODPREFIX "multi strdup: %m");
+				error(MODPREFIX "multi strdup failure");
 				free(options);
 				multi_free_list(head);
 				return 1;
@@ -905,7 +906,7 @@ int parse_mount(const char *root, const 
 
 					if (myoptions == NULL) {
 						error(MODPREFIX
-						    "multi concat_options: %m");
+						    "multi concat_options malloc_failure");
 						free(options);
 						free(path);
 						multi_free_list(head);

--Boundary-00=_J7iWC9FdkY1zWcU--

