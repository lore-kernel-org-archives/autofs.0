From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH] make automounter runnable in foreground and add stderr
	logging
Date: Sat, 9 Oct 2004 23:27:59 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200410092327.59766.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PnEaBPtAx9u+38d"
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
To: autofs@linux.kernel.org


--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[resend due to "your mail is being held until the list moderator
can review it for approval. The reason it is being held:
Message has a suspicious header]

1.exec.patch
=9A=9A=9A=9A=9A=9A=9A=9AUse PATH-honouring execXXX() variant

2.fg.patch
=9A=9A=9A=9A=9A=9A=9A=9AAdd "-f --foreground do not daemonize" option
=9A=9A=9A=9A=9A=9A=9A=9Aand code.

4.syslog.patch
=9A=9A=9A=9A=9A=9A=9A=9AAdd "-s --stderr log to stderr instead of syslog"
=9A=9A=9A=9A=9A=9A=9A=9Aoption and code, rework code to never use syslog()
=9A=9A=9A=9A=9A=9A=9A=9Adirectly, only thru the crit() etc.
=9A=9A=9A=9A=9A=9A=9A=9A
5.msg.patch
=9A=9A=9A=9A=9A=9A=9A=9AGet rid of %m and trailing \n in messages.

Run tested.
=2D-
vda

--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/x-diff;
  charset="koi8-r";
  name="1.exec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="1.exec.patch"

diff -urpN autofs-4.1.3.orig/daemon/spawn.c autofs-4.1.3_1.exec/daemon/spawn.c
--- autofs-4.1.3.orig/daemon/spawn.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_1.exec/daemon/spawn.c	Thu Oct  7 18:05:20 2004
@@ -169,7 +169,7 @@ int spawnv(int logpri, const char *lockf
 				retries--;
 			}
 		}
-		execv(prog, (char *const *) argv);
+		execvp(prog, (char *const *) argv);
 		_exit(255);	/* execv() failed */
 	} else {
 		/* Careful here -- if we enable SIGCHLD yet we may not receive the
diff -urpN autofs-4.1.3.orig/modules/lookup_program.c autofs-4.1.3_1.exec/modules/lookup_program.c
--- autofs-4.1.3.orig/modules/lookup_program.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_1.exec/modules/lookup_program.c	Thu Oct  7 18:05:09 2004
@@ -131,7 +131,7 @@ int lookup_mount(const char *root, const
 		dup2(epipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 		close(epipefd[1]);
-		execl(ctxt->mapname, ctxt->mapname, name, NULL);
+		execlp(ctxt->mapname, ctxt->mapname, name, NULL);
 		_exit(255);	/* execl() failed */
 	}
 	close(pipefd[1]);
diff -urpN autofs-4.1.3.orig/modules/mount_autofs.c autofs-4.1.3_1.exec/modules/mount_autofs.c
--- autofs-4.1.3.orig/modules/mount_autofs.c	Sun Mar  7 14:17:54 2004
+++ autofs-4.1.3_1.exec/modules/mount_autofs.c	Thu Oct  7 18:04:41 2004
@@ -154,7 +154,7 @@ int mount_mount(const char *root, const 
 		goto error;
 	} else if (slave == 0) {
 		/* Slave process */
-		execv(PATH_AUTOMOUNT, argv);
+		execvp(PATH_AUTOMOUNT, argv);
 		_exit(255);
 	}
 

--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/x-diff;
  charset="koi8-r";
  name="5.msg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="5.msg.patch"

diff -urpN autofs-4.1.3_4.syslog/daemon/automount.c autofs-4.1.3_5.msg/daemon/automount.c
--- autofs-4.1.3_4.syslog/daemon/automount.c	Sat Oct  9 23:05:32 2004
+++ autofs-4.1.3_5.msg/daemon/automount.c	Fri Oct  8 09:43:44 2004
@@ -224,7 +224,7 @@ static int rm_unwanted_fn(const char *fi
 		if (st->st_dev != ap.dev)
 			return 0;
 	} else {
-		info("rm_unwanted: %s\n", file);
+		info("rm_unwanted: %s", file);
 		if (S_ISDIR(st->st_mode))
 			rmdir(file);
 		else if (!S_ISLNK(st->st_mode) || rmsymlink)
@@ -253,13 +253,13 @@ static int umount_multi(const char *path
 	} *mntlist = NULL, *mptr;
 	size_t pathlen = strlen(path);
 
-	debug("umount_multi: path=%s incl=%d\n", path, incl);
+	debug("umount_multi: path=%s incl=%d", path, incl);
 
 	wait_for_lock();
 	mtab = setmntent(_PATH_MOUNTED, "r");
 	if (!mtab) {
+		error("umount_multi: setmntent: %s", strerror(errno));
 		unlink(AUTOFS_LOCK);
-		error("umount_multi: setmntent: %m");
 		return -1;
 	}
 
@@ -301,7 +301,7 @@ static int umount_multi(const char *path
 
 	left = 0;
 	for (mptr = mntlist; mptr != NULL; mptr = mptr->next) {
-		debug("umount_multi: unmounting dir=%s\n", mptr->path);
+		debug("umount_multi: unmounting dir=%s", mptr->path);
 		if (umount_ent("", mptr->path, mptr->fs_type)) {
 			left++;
 		}
@@ -370,16 +370,16 @@ static int do_umount_autofs(void)
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
@@ -503,7 +503,7 @@ static int mount_autofs(char *path)
 static void nextstate(enum states next)
 {
 	if (write(ap.state_pipe[1], &next, sizeof(next)) != sizeof(next))
-		error("nextstate: write failed %m");
+		error("nextstate: write failed %s", strerror(errno));
 }
 
 /* Deal with all the signal-driven events in the state machine */
@@ -549,9 +549,9 @@ static int send_ready(unsigned int wait_
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
@@ -561,9 +561,9 @@ static int send_fail(unsigned int wait_q
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
@@ -581,7 +581,7 @@ static enum states handle_child(int hang
 	while ((pid = waitpid(-1, &status, hang ? 0 : WNOHANG)) > 0) {
 		struct pending_mount volatile *mt, *volatile *mtp;
 
-		debug("handle_child: got pid %d, sig %d (%d), stat %d\n",
+		debug("handle_child: got pid %d, sig %d (%d), stat %d",
 			pid, WIFSIGNALED(status),
 			WTERMSIG(status), WEXITSTATUS(status));
 
@@ -693,7 +693,7 @@ static void sig_child(int sig)
 
 static int st_ready(void)
 {
-	debug("st_ready(): state = %d\n", ap.state);
+	debug("st_ready(): state = %d", ap.state);
 
 	ap.state = ST_READY;
 	sigprocmask(SIG_UNBLOCK, &lock_sigs, NULL);
@@ -803,13 +803,13 @@ static enum expire expire_proc(int now)
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
 
@@ -840,7 +840,7 @@ static int st_prepare_shutdown(void)
 	/* Unmount everything */
 	exp = expire_proc(1);
 
-	debug("prep_shutdown: expire returns %d\n", exp);
+	debug("prep_shutdown: expire returns %d", exp);
 
 	switch (exp) {
 	case EXP_ERROR:
@@ -864,7 +864,7 @@ static int st_prepare_shutdown(void)
 
 static int st_prune(void)
 {
-	debug("st_prune(): state = %d\n", ap.state);
+	debug("st_prune(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -888,7 +888,7 @@ static int st_prune(void)
 
 static int st_expire(void)
 {
-	debug("st_expire(): state = %d\n", ap.state);
+	debug("st_expire(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -917,7 +917,7 @@ static int st_readmap(void)
 
 	status = ap.lookup->lookup_ghost(ap.path, ap.ghost, ap.lookup->context);
 
-	debug("st_readmap: status %d\n", status);
+	debug("st_readmap: status %d", status);
 
 	/* If I don't exist in the map any more then exit */
 	if (status == LKP_FAIL)
@@ -1033,7 +1033,7 @@ static int handle_packet_missing(const s
 	sigset_t oldsig;
 	pid_t f;
 
-	debug("handle_packet_missing: token %ld, name %s\n",
+	debug("handle_packet_missing: token %ld, name %s",
 		pkt->wait_queue_token, pkt->name);
 
 	/* Ignore packet if we're trying to shut down */
@@ -1056,7 +1056,7 @@ static int handle_packet_missing(const s
 		if ((mt = (struct pending_mount *) junk_mounts)) {
 			junk_mounts = junk_mounts->next;
 		} else if (!(mt = malloc(sizeof(struct pending_mount)))) {
-			error("handle_packet_missing: malloc: %m");
+			error("handle_packet_missing: malloc failure");
 			send_fail(pkt->wait_queue_token);
 			return 1;
 		}
@@ -1078,7 +1078,8 @@ static int handle_packet_missing(const s
 		f = fork();
 		if (f == -1) {
 			sigprocmask(SIG_SETMASK, &oldsig, NULL);
-			error("handle_packet_missing: fork: %m");
+			error("handle_packet_missing: fork: %s",
+				strerror(errno));
 			send_fail(pkt->wait_queue_token);
 			return 1;
 		} else if (!f) {
@@ -1169,7 +1170,7 @@ static void do_expire(const char *name, 
 		ret = ap.lookup->lookup_mount(ap.path, 
 					name, namelen, ap.lookup->context);
 		if (ret)
-			error("failed to recover from partial expiry of %s\n",
+			error("failed to recover from partial expiry of %s",
 			       buf);
 	}
 }
@@ -1192,14 +1193,14 @@ static int handle_expire(const char *nam
 		junk_mounts = junk_mounts->next;
 	} else if (!(mt = malloc(sizeof(struct pending_mount)))) {
 		sigprocmask(SIG_SETMASK, &olds, NULL);
-		error("handle_expire: malloc: %m");
+		error("handle_expire: malloc failure");
 		return 1;
 	}
 
 	f = fork();
 	if (f == -1) {
 		sigprocmask(SIG_SETMASK, &olds, NULL);
-		error("handle_expire: fork: %m");
+		error("handle_expire: fork: %s", strerror(errno));
 		return 1;
 	}
 	if (f > 0) {
@@ -1234,7 +1235,7 @@ static int handle_packet_expire_multi(co
 {
 	int ret;
 
-	debug("handle_packet_expire_multi: token %ld, name %s\n",
+	debug("handle_packet_expire_multi: token %ld, name %s",
 		  pkt->wait_queue_token, pkt->name);
 
 	ret = handle_expire(pkt->name, pkt->len, pkt->wait_queue_token);
@@ -1251,7 +1252,7 @@ static int handle_packet(void)
 	if (get_pkt(ap.pipefd, &pkt))
 		return -1;
 
-	debug("handle_packet: type = %d\n", pkt.hdr.type);
+	debug("handle_packet: type = %d", pkt.hdr.type);
 
 	switch (pkt.hdr.type) {
 	case autofs_ptype_missing:
@@ -1263,7 +1264,7 @@ static int handle_packet(void)
 	case autofs_ptype_expire_multi:
 		return handle_packet_expire_multi(&pkt.expire_multi);
 	}
-	error("handle_packet: unknown packet type %d\n", pkt.hdr.type);
+	error("handle_packet: unknown packet type %d", pkt.hdr.type);
 	return -1;
 }
 
@@ -1302,7 +1303,7 @@ static void become_daemon(void)
 	   perform the mount.  A pgrp is also useful for controlling all the
 	   child processes we generate. */
 	if (!submount && setpgrp()) {
-		crit("setpgrp: %m");
+		crit("setpgrp: %s", strerror(errno));
 		exit(1);
 	}
 	my_pgrp = getpgrp();
@@ -1336,7 +1337,8 @@ static void cleanup_exit(const char *pat
 
 	if ((!ap.ghost || !submount) && *(path + 1) != '-')
 		if (rmdir(path) == -1)
-			warn("failed to remove dir %s: %m", path);
+			warn("failed to remove dir %s: %s",
+				path, strerror(errno));
 
 	exit(exit_code);
 }
@@ -1548,7 +1550,7 @@ int handle_mounts(char *path)
 	if (!ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOVER, &kproto_version)) {
 		/* If this ioctl() doesn't work, kernel does not support ghosting */
 		if (ioctl(ap.ioctlfd, AUTOFS_IOC_PROTOSUBVER, &kproto_sub_version)) {
-			debug("kproto sub: %m");
+			debug("kproto sub: %s", strerror(errno));
 			kproto_sub_version = 0;
 			if (ap.ghost) {
 				ap.ghost = 0;
@@ -1556,7 +1558,7 @@ int handle_mounts(char *path)
 			}
 		}
 	} else {
-		debug("kproto: %m");
+		debug("kproto: %s", strerror(errno));
 		kproto_version = 2;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/daemon/module.c autofs-4.1.3_5.msg/daemon/module.c
--- autofs-4.1.3_4.syslog/daemon/module.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_5.msg/daemon/module.c	Fri Oct  8 09:43:44 2004
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
diff -urpN autofs-4.1.3_4.syslog/lib/cache.c autofs-4.1.3_5.msg/lib/cache.c
--- autofs-4.1.3_4.syslog/lib/cache.c	Sun Mar  7 14:17:54 2004
+++ autofs-4.1.3_5.msg/lib/cache.c	Fri Oct  8 09:43:44 2004
@@ -370,8 +370,8 @@ int cache_ghost(const char *root, int gh
 				if (stat(fullpath, &st) == -1 && errno == ENOENT) {
 					if (mkdir_path(fullpath, 0555) < 0)
 						warn("cache_ghost: mkdir_path %s "
-						     "failed: %m",
-						      fullpath);
+						     "failed: %s",
+						      fullpath, strerror(errno));
 				}
 				break;
 
@@ -411,8 +411,8 @@ int is_mounted(const char *path)
 	wait_for_lock();
 	mtab = setmntent(_PATH_MOUNTED, "r");
 	if (!mtab) {
+		error("is_mounted: setmntent: %s", strerror(errno));
 		unlink(AUTOFS_LOCK);
-		error("is_mounted: setmntent: %m");
 		return -1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_file.c autofs-4.1.3_5.msg/modules/lookup_file.c
--- autofs-4.1.3_4.syslog/modules/lookup_file.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_5.msg/modules/lookup_file.c	Fri Oct  8 09:43:44 2004
@@ -56,7 +56,7 @@ int lookup_init(const char *mapfmt, int 
 	struct lookup_context *ctxt;
 
 	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_hesiod.c autofs-4.1.3_5.msg/modules/lookup_hesiod.c
--- autofs-4.1.3_4.syslog/modules/lookup_hesiod.c	Sat Oct  9 23:08:21 2004
+++ autofs-4.1.3_5.msg/modules/lookup_hesiod.c	Fri Oct  8 09:43:44 2004
@@ -41,7 +41,7 @@ int lookup_init(const char *mapfmt, int 
 	/* If we can't build a context, bail. */
 	if ((*context = ctxt = (struct lookup_context *)
 	     malloc(sizeof(struct lookup_context))) == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
@@ -79,7 +79,7 @@ int lookup_mount(const char *root, const
 	hes_result = hes_resolve(name, "filsys");
 
 	if (!hes_result) {
-		warn(MODPREFIX "entry \"%s\" not found in map\n", name);
+		warn(MODPREFIX "entry \"%s\" not found in map", name);
 		return 1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_ldap.c autofs-4.1.3_5.msg/modules/lookup_ldap.c
--- autofs-4.1.3_4.syslog/modules/lookup_ldap.c	Sat Apr  3 10:14:33 2004
+++ autofs-4.1.3_5.msg/modules/lookup_ldap.c	Fri Oct  8 09:43:44 2004
@@ -52,7 +52,7 @@ int lookup_init(const char *mapfmt, int 
 	ctxt = (struct lookup_context *) malloc(sizeof(struct lookup_context));
 	*context = ctxt;
 	if (ctxt == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 	memset(ctxt, 0, sizeof(struct lookup_context));
@@ -174,7 +174,7 @@ static int read_one_map(const char *root
 
 	query = alloca(l);
 	if (query == NULL) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 0;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_multi.c autofs-4.1.3_5.msg/modules/lookup_multi.c
--- autofs-4.1.3_4.syslog/modules/lookup_multi.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_5.msg/modules/lookup_multi.c	Fri Oct  8 09:43:44 2004
@@ -107,7 +107,7 @@ int lookup_init(const char *my_mapfmt, i
 	return 0;
 
       nomem:
-	crit(MODPREFIX "malloc: %m");
+	crit(MODPREFIX "malloc failure");
 	return 1;
 }
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_nisplus.c autofs-4.1.3_5.msg/modules/lookup_nisplus.c
--- autofs-4.1.3_4.syslog/modules/lookup_nisplus.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_5.msg/modules/lookup_nisplus.c	Fri Oct  8 09:43:44 2004
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
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_program.c autofs-4.1.3_5.msg/modules/lookup_program.c
--- autofs-4.1.3_4.syslog/modules/lookup_program.c	Thu Oct  7 18:05:09 2004
+++ autofs-4.1.3_5.msg/modules/lookup_program.c	Fri Oct  8 09:43:44 2004
@@ -48,7 +48,7 @@ int lookup_init(const char *mapfmt, int 
 	struct lookup_context *ctxt;
 
 	if (!(*context = ctxt = malloc(sizeof(struct lookup_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 
@@ -106,7 +106,7 @@ int lookup_mount(const char *root, const
 	 */
 
 	if (pipe(pipefd)) {
-		error(MODPREFIX "pipe: %m");
+		error(MODPREFIX "pipe: %s", strerror(errno));
 		return 1;
 	}
 	if (pipe(epipefd)) {
@@ -121,7 +121,7 @@ int lookup_mount(const char *root, const
 		close(pipefd[1]);
 		close(epipefd[0]);
 		close(epipefd[1]);
-		error(MODPREFIX "fork: %m");
+		error(MODPREFIX "fork: %s", strerror(errno));
 		return 1;
 	} else if (f == 0) {
 		reset_signals();
@@ -232,7 +232,7 @@ int lookup_mount(const char *root, const
 	close(epipefd[0]);
 
 	if (waitpid(f, &status, 0) != f) {
-		error(MODPREFIX "waitpid: %m");
+		error(MODPREFIX "waitpid: %s", strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_userhome.c autofs-4.1.3_5.msg/modules/lookup_userhome.c
--- autofs-4.1.3_4.syslog/modules/lookup_userhome.c	Thu Jan 29 18:01:22 2004
+++ autofs-4.1.3_5.msg/modules/lookup_userhome.c	Fri Oct  8 09:43:44 2004
@@ -56,12 +56,12 @@ int lookup_mount(const char *root, const
 
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
 
diff -urpN autofs-4.1.3_4.syslog/modules/lookup_yp.c autofs-4.1.3_5.msg/modules/lookup_yp.c
--- autofs-4.1.3_4.syslog/modules/lookup_yp.c	Thu Oct  7 21:55:19 2004
+++ autofs-4.1.3_5.msg/modules/lookup_yp.c	Fri Oct  8 09:43:44 2004
@@ -62,13 +62,14 @@ int lookup_init(const char *mapfmt, int 
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
diff -urpN autofs-4.1.3_4.syslog/modules/mount_autofs.c autofs-4.1.3_5.msg/modules/mount_autofs.c
--- autofs-4.1.3_4.syslog/modules/mount_autofs.c	Thu Oct  7 18:04:41 2004
+++ autofs-4.1.3_5.msg/modules/mount_autofs.c	Fri Oct  8 09:43:44 2004
@@ -47,7 +47,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	sprintf(fullpath, "%s/%s", root, name);
@@ -55,7 +55,7 @@ int mount_mount(const char *root, const 
 	if (c_options) {
 		options = alloca(strlen(c_options) + 1);
 		if (!options) {
-			error(MODPREFIX "alloca: %m");
+			error(MODPREFIX "alloca failure");
 			return 1;
 		}
 		strcpy(options, c_options);
@@ -66,7 +66,8 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if (mkdir_path(fullpath, 0555) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", name);
+		error(MODPREFIX "mkdir_path %s failed: %s",
+			name, strerror(errno));
 		return 1;
 	}
 
@@ -150,7 +151,7 @@ int mount_mount(const char *root, const 
 
 	slave = fork();
 	if (slave < 0) {
-		error(MODPREFIX "fork: %m");
+		error(MODPREFIX "fork: %s", strerror(errno));
 		goto error;
 	} else if (slave == 0) {
 		/* Slave process */
@@ -158,9 +159,11 @@ int mount_mount(const char *root, const 
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
 
diff -urpN autofs-4.1.3_4.syslog/modules/mount_bind.c autofs-4.1.3_5.msg/modules/mount_bind.c
--- autofs-4.1.3_4.syslog/modules/mount_bind.c	Thu Oct  7 20:23:13 2004
+++ autofs-4.1.3_5.msg/modules/mount_bind.c	Fri Oct  8 09:43:44 2004
@@ -93,7 +93,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -112,7 +112,8 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 		if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+			error(MODPREFIX "mkdir_path %s failed: %s",
+				fullpath, strerror(errno));
 			return 1;
 		}
 
@@ -156,8 +157,8 @@ int mount_mount(const char *root, const 
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
diff -urpN autofs-4.1.3_4.syslog/modules/mount_changer.c autofs-4.1.3_5.msg/modules/mount_changer.c
--- autofs-4.1.3_4.syslog/modules/mount_changer.c	Sat Oct  9 23:02:59 2004
+++ autofs-4.1.3_5.msg/modules/mount_changer.c	Fri Oct  8 09:43:44 2004
@@ -58,7 +58,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -81,7 +81,8 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s",
+			fullpath, strerror(errno));
 		return 1;
 	}
 
@@ -141,7 +142,7 @@ int swapCD(const char *device, const cha
 	/* open device */
 	fd = open(device, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
-		error(MODPREFIX "Opening device %s failed : %s",
+		error(MODPREFIX "Opening device %s failed: %s",
 		      device, strerror(errno));
 		return 1;
 	}
@@ -150,7 +151,7 @@ int swapCD(const char *device, const cha
 	total_slots_available = ioctl(fd, CDROM_CHANGER_NSLOTS);
 	if (total_slots_available <= 1) {
 		error(MODPREFIX
-		      "Device %s is not an ATAPI compliant CD changer.\n",
+		      "Device %s is not an ATAPI compliant CD changer",
 		      device);
 		return 1;
 	}
@@ -165,7 +166,7 @@ int swapCD(const char *device, const cha
 	/* close device */
 	status = close(fd);
 	if (status != 0) {
-		error(MODPREFIX "close failed for `%s': %s\n",
+		error(MODPREFIX "close failed for `%s': %s",
 		      device, strerror(errno));
 		return 1;
 	}
diff -urpN autofs-4.1.3_4.syslog/modules/mount_ext2.c autofs-4.1.3_5.msg/modules/mount_ext2.c
--- autofs-4.1.3_4.syslog/modules/mount_ext2.c	Thu Oct  7 19:50:36 2004
+++ autofs-4.1.3_5.msg/modules/mount_ext2.c	Fri Oct  8 09:43:44 2004
@@ -52,7 +52,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -64,7 +64,8 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s",
+			fullpath, strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/mount_generic.c autofs-4.1.3_5.msg/modules/mount_generic.c
--- autofs-4.1.3_4.syslog/modules/mount_generic.c	Thu Oct  7 19:51:27 2004
+++ autofs-4.1.3_5.msg/modules/mount_generic.c	Fri Oct  8 09:43:44 2004
@@ -50,7 +50,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -62,7 +62,8 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		error(MODPREFIX "mkdir_path %s failed: %s",
+			fullpath, strerror(errno));
 		return 1;
 	}
 
diff -urpN autofs-4.1.3_4.syslog/modules/mount_nfs.c autofs-4.1.3_5.msg/modules/mount_nfs.c
--- autofs-4.1.3_4.syslog/modules/mount_nfs.c	Thu Oct  7 19:50:53 2004
+++ autofs-4.1.3_5.msg/modules/mount_nfs.c	Fri Oct  8 09:43:44 2004
@@ -77,7 +77,7 @@ int is_local_addr(const char *host, cons
 
 	sock = socket(AF_INET, SOCK_DGRAM, udpproto);
 	if (sock < 0) {
-		error(MODPREFIX "socket creation failed: %m");
+		error(MODPREFIX "socket creation failed: %s", strerror(errno));
 		return -1;
 	}
 
@@ -87,14 +87,15 @@ int is_local_addr(const char *host, cons
 
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
@@ -339,7 +340,7 @@ int mount_mount(const char *root, const 
 
 	whatstr = alloca(strlen(what) + 1);
 	if (!whatstr) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 	strcpy(whatstr, what);
@@ -414,7 +415,7 @@ int mount_mount(const char *root, const 
 
 	fullpath = alloca(strlen(root) + name_len + 2);
 	if (!fullpath) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -436,7 +437,8 @@ int mount_mount(const char *root, const 
 
 		debug(MODPREFIX "calling mkdir_path %s", fullpath);
 		if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+			error(MODPREFIX "mkdir_path %s failed: %s",
+				fullpath, strerror(errno));
 			return 1;
 		}
 
diff -urpN autofs-4.1.3_4.syslog/modules/parse_sun.c autofs-4.1.3_5.msg/modules/parse_sun.c
--- autofs-4.1.3_4.syslog/modules/parse_sun.c	Tue May 18 15:22:40 2004
+++ autofs-4.1.3_5.msg/modules/parse_sun.c	Fri Oct  8 09:43:44 2004
@@ -338,7 +338,7 @@ int parse_init(int argc, const char *con
 	/* Set up context and escape chain */
 
 	if (!(ctxt = (struct parse_context *) malloc(sizeof(struct parse_context)))) {
-		crit(MODPREFIX "malloc: %m");
+		crit(MODPREFIX "malloc failure");
 		return 1;
 	}
 	*context = (void *) ctxt;
@@ -355,7 +355,7 @@ int parse_init(int argc, const char *con
 			case 'D':
 				sv = malloc(sizeof(struct substvar));
 				if (!sv) {
-					error(MODPREFIX "malloc: %m");
+					error(MODPREFIX "malloc failure");
 					break;
 				}
 				if (argv[i][2])
@@ -368,7 +368,7 @@ int parse_init(int argc, const char *con
 				}
 
 				if (!sv->def) {
-					error(MODPREFIX "strdup: %m");
+					error(MODPREFIX "strdup failure");
 					free(sv);
 				} else {
 					sv->val = strchr(sv->def, '=');
@@ -421,7 +421,7 @@ int parse_init(int argc, const char *con
 			}
 			if (!noptstr) {
 				kill_context(ctxt);
-				crit(MODPREFIX "%m");
+				crit(MODPREFIX "malloc failure");
 				return 1;
 			}
 			ctxt->optstr = noptstr;
@@ -501,7 +501,7 @@ static char *concat_options(char *left, 
 	ret = malloc(strlen(left) + strlen(right) + 2);
 
 	if (ret == NULL) {
-		error(MODPREFIX "concat_options malloc: %m");
+		error(MODPREFIX "concat_options malloc failure");
 		return NULL;
 	}
 
@@ -627,7 +627,7 @@ int parse_mount(const char *root, const 
 	mapent_len = expandsunent(mapent, NULL, name, ctxt->subst, ctxt->slashify_colons);
 	pmapent = alloca(mapent_len + 1);
 	if (!pmapent) {
-		error(MODPREFIX "alloca: %m");
+		error(MODPREFIX "alloca failure");
 		return 1;
 	}
 
@@ -637,7 +637,7 @@ int parse_mount(const char *root, const 
 
 	options = strdup(ctxt->optstr ? ctxt->optstr : "");
 	if (!options) {
-		error(MODPREFIX "strdup: %m");
+		error(MODPREFIX "strdup failure");
 		return 1;
 	}
 	optlen = strlen(options);
@@ -653,7 +653,8 @@ int parse_mount(const char *root, const 
 			options = concat_options(options, noptions);
 
 			if (options == NULL) {
-				error(MODPREFIX "concat_options: %m");
+				error(MODPREFIX
+					"concat_options malloc failure");
 				return 1;
 			}
 			p = skipspace(p);
@@ -668,7 +669,7 @@ int parse_mount(const char *root, const 
 
 		multi_root = alloca(strlen(root) + name_len + 2);
 		if (!multi_root) {
-			error(MODPREFIX "alloca: %m");
+			error(MODPREFIX "alloca failure");
 			free(options);
 			return 1;
 		}
@@ -684,7 +685,7 @@ int parse_mount(const char *root, const 
 			int pathlen, loclen;
 
 			if (myoptions == NULL) {
-				error(MODPREFIX "multi strdup: %m");
+				error(MODPREFIX "multi strdup failure");
 				free(options);
 				return 1;
 			}
@@ -705,7 +706,7 @@ int parse_mount(const char *root, const 
 
 					if (myoptions == NULL) {
 						error(MODPREFIX
-						    "multi concat_options: %m");
+						    "multi concat_options malloc_failure");
 						free(options);
 						free(path);
 						return 1;

--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/x-diff;
  charset="koi8-r";
  name="4.syslog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="4.syslog.patch"

diff -urpN autofs-4.1.3_2.fg/daemon/automount.c autofs-4.1.3_4.syslog/daemon/automount.c
--- autofs-4.1.3_2.fg/daemon/automount.c	Thu Oct  7 20:28:27 2004
+++ autofs-4.1.3_4.syslog/daemon/automount.c	Sat Oct  9 23:05:32 2004
@@ -40,7 +40,7 @@
 #include <linux/auto_fs4.h>
 
 #ifndef NDEBUG
-#define assert(x)	do { if (!(x)) { syslog(LOG_CRIT, __FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
+#define assert(x)	do { if (!(x)) { crit(__FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
 #else
 #define assert(x)	do { } while(0)
 #endif
@@ -63,6 +63,8 @@ int do_verbose = 0;		/* Verbose feedback
 int do_debug = 0;		/* Enable full debug output */
 int daemonize = 1;		/* Shall we daemonize? */
 
+int log_stderr;			/* Use stderr instead of syslog? */
+
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
 sigset_t sigchld_mask;
@@ -159,7 +161,7 @@ static int umount_ent(const char *root, 
 
 		if (umount_ok || is_smbfs) {
 			wait_for_lock();
-			rv = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+			rv = spawnl(debug, MOUNTED_LOCK,
 				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
 			unlink(AUTOFS_LOCK);
 		}
@@ -351,13 +353,13 @@ static int do_umount_autofs(void)
 		int ret;
 
 		wait_for_lock();
-		rv = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+		rv = spawnl(debug, MOUNTED_LOCK,
 			    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		if (rv & MTAB_NOTUPDATED) {
 			info("umount %s succeeded: "
 			     "mtab not updated, retrying to clean\n",
 			      ap.path);
-			rv = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+			rv = spawnl(debug, MOUNTED_LOCK,
 				    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		}
 		unlink(AUTOFS_LOCK);
@@ -467,7 +469,7 @@ static int mount_autofs(char *path)
 	our_name[len] = '\0';
 
 	wait_for_lock();
-	if (spawnl(LOG_DEBUG, MOUNTED_LOCK, PATH_MOUNT, PATH_MOUNT,
+	if (spawnl(debug, MOUNTED_LOCK, PATH_MOUNT, PATH_MOUNT,
 		   "-t", "autofs", "-o", options, our_name, path, NULL) != 0) {
 		crit("failed to mount autofs path %s", ap.path);
 		unlink(AUTOFS_LOCK);
@@ -823,7 +825,7 @@ static int st_prepare_shutdown(void)
 {
 	int exp;
 
-	DB(syslog(LOG_INFO, "prep_shutdown: state = %d\n", ap.state));
+	DB(info("prep_shutdown: state = %d", ap.state));
 
 	assert(ap.state == ST_READY || ap.state == ST_EXPIRE);
 
@@ -958,7 +960,7 @@ static int get_pkt(int fd, union autofs_
 		if (poll(fds, 2, -1) == -1) {
 			if (errno == EINTR)
 				continue;
-			syslog(LOG_ERR, "get_pkt: poll failed: %m");
+			error("get_pkt: poll failed: %s", strerror(errno));
 			return -1;
 		}
 
@@ -1269,7 +1271,6 @@ static void become_daemon(void)
 {
 	FILE *pidfp;
 	pid_t pid;
-	int nullfd;
 
 	/* Don't BUSY any directories unnecessarily */
 	chdir("/");
@@ -1285,9 +1286,12 @@ static void become_daemon(void)
 			exit(1);
 		}
 	}
-
-	/* Open syslog */
-	openlog("automount", LOG_PID, LOG_DAEMON);
+	/* Initialize logging subsystem */
+	if(!log_stderr) {
+		log_to_syslog();
+	} else {
+		log_to_stderr();
+	}
 
 	/* Initialize global data */
 	my_pid = getpid();
@@ -1303,26 +1307,14 @@ static void become_daemon(void)
 	}
 	my_pgrp = getpgrp();
 
-	/* Redirect all our file descriptors to /dev/null */
-	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
-		crit("cannot open /dev/null: %m");
-		exit(1);
-	}
-
-	if (dup2(nullfd, STDIN_FILENO) < 0 ||
-	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
-		crit("redirecting file descriptors failed: %m");
-		exit(1);
-	}
-	if (nullfd > 2) close(nullfd);
-
 	/* Write pid file if requested */
 	if (pid_file) {
 		if ((pidfp = fopen(pid_file, "wt"))) {
 			fprintf(pidfp, "%lu\n", (unsigned long) my_pid);
 			fclose(pidfp);
 		} else {
-			warn("failed to write pid file %s: %m", pid_file);
+			warn("failed to write pid file %s: %s", pid_file,
+				strerror(errno));
 			pid_file = NULL;
 		}
 	}
@@ -1372,6 +1364,7 @@ static void usage(void)
 		"	-p --pid-file f	write process id to file f\n"
 		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
 		"	-f --foreground	do not daemonize\n"
+		"	-s --stderr	log to stderr instead of syslog\n"
 		"	-v --verbose	be verbose\n"
 		"	-d --debug	be even more verbose\n"
 		"	-V --version	print version and exit\n"
@@ -1664,6 +1657,7 @@ int main(int argc, char *argv[])
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
 		{"foreground", 0, 0, 'f'},
+		{"stderr", 0, 0, 's'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1680,7 +1674,7 @@ int main(int argc, char *argv[])
 	ap.type = LKP_INDIRECT;
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fsvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1698,6 +1692,10 @@ int main(int argc, char *argv[])
 			daemonize = 0;
 			break;
 
+		case 's':
+			log_stderr = 1;
+			break;
+
 		case 'v':
 			do_verbose = 1;
 			break;
@@ -1722,7 +1720,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "%s: This program must be run by root.\n", program);
+		fprintf(stderr, "%s: This program must be run by root\n", program);
 		exit(1);
 	}
 
@@ -1749,9 +1747,9 @@ int main(int argc, char *argv[])
 #ifdef DEBUG
 	if (mapargc) {
 		int i;
-		syslog(LOG_DEBUG, "Map argc = %d", mapargc);
+		debug("Map argc = %d", mapargc);
 		for (i = 0; i < mapargc; i++)
-			syslog(LOG_DEBUG, "Map argv[%d] = %s", i, mapargv[i]);
+			debug("Map argv[%d] = %s", i, mapargv[i]);
 	}
 #endif
 
diff -urpN autofs-4.1.3_2.fg/daemon/spawn.c autofs-4.1.3_4.syslog/daemon/spawn.c
--- autofs-4.1.3_2.fg/daemon/spawn.c	Thu Oct  7 18:05:20 2004
+++ autofs-4.1.3_4.syslog/daemon/spawn.c	Thu Oct  7 19:48:17 2004
@@ -130,7 +130,7 @@ void wait_for_lock(void)
 
 #define ERRBUFSIZ 2047		/* Max length of error string excl \0 */
 
-int spawnv(int logpri, const char *lockf, const char *prog, const char *const *argv)
+int spawnv(logger* log, const char *lockf, const char *prog, const char *const *argv)
 {
 	pid_t f;
 	int status, pipefd[2];
@@ -201,7 +201,7 @@ int spawnv(int logpri, const char *lockf
 				while (errp && (p = memchr(sp, '\n', errp))) {
 					*p++ = '\0';
 					if (sp[0])	/* Don't output empty lines */
-						syslog(logpri, ">> %s", sp);
+						log(">> %s", sp);
 					errp -= (p - sp);
 					sp = p;
 				}
@@ -212,7 +212,7 @@ int spawnv(int logpri, const char *lockf
 				if (errp >= ERRBUFSIZ) {
 					/* Line too long, split */
 					errbuf[errp] = '\0';
-					syslog(logpri, ">> %s", errbuf);
+					log(">> %s", errbuf);
 					errp = 0;
 				}
 			}
@@ -222,7 +222,7 @@ int spawnv(int logpri, const char *lockf
 		if (errp > 0) {
 			/* End of file without \n */
 			errbuf[errp] = '\0';
-			syslog(logpri, ">> %s", errbuf);
+			log(">> %s", errbuf);
 		}
 
 		if (waitpid(f, &status, 0) != f)
@@ -234,7 +234,7 @@ int spawnv(int logpri, const char *lockf
 	}
 }
 
-int spawnl(int logpri, const char *lockf, const char *prog, ...)
+int spawnl(logger* log, const char *lockf, const char *prog, ...)
 {
 	va_list arg;
 	int argc;
@@ -252,5 +252,5 @@ int spawnl(int logpri, const char *lockf
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return spawnv(logpri, lockf, prog, (const char **) argv);
+	return spawnv(log, lockf, prog, (const char **) argv);
 }
diff -urpN autofs-4.1.3_2.fg/include/automount.h autofs-4.1.3_4.syslog/include/automount.h
--- autofs-4.1.3_2.fg/include/automount.h	Tue May 18 15:20:08 2004
+++ autofs-4.1.3_4.syslog/include/automount.h	Thu Oct  7 19:56:28 2004
@@ -113,11 +113,28 @@ struct autofs_point {
 	int state_pipe[2];
 };
 
+/* log notification */
+
+extern int do_verbose;
+extern int do_debug;
+
+typedef void logger(const char* msg, ...);
+
+extern void (*info)(const char* msg, ...);
+extern void (*notice)(const char* msg, ...);
+extern void (*warn)(const char* msg, ...);
+extern void (*error)(const char* msg, ...);
+extern void (*crit)(const char* msg, ...);
+extern void (*debug)(const char* msg, ...);
+
+void log_to_syslog();
+void log_to_stderr();
+
 /* Standard function used by daemon or modules */
 
 void wait_for_lock(void);
-int spawnl(int logpri, const char *lockf, const char *prog, ...);
-int spawnv(int logpri, const char *lockf, const char *prog, const char *const *argv);
+int spawnl(logger* log, const char *lockf, const char *prog, ...);
+int spawnv(logger* log, const char *lockf, const char *prog, const char *const *argv);
 void reset_signals(void);
 void ignore_signals(void);
 void discard_pending(int sig);
@@ -252,24 +269,5 @@ int rpc_time(const char *host, 
 	     unsigned int ping_vers, unsigned int ping_proto,
 	     long seconds, long micros, double *result);
 
-/* log notification */
-extern int do_verbose;
-extern int do_debug;
-
-#define info(msg, args...) 		\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_INFO, msg, ##args);
-
-#define warn(msg, args...) 			\
-if (do_verbose || do_debug) 		\
-	syslog(LOG_WARNING, msg, ##args);
-
-#define error(msg, args...)	syslog(LOG_ERR, msg, ##args);
-
-#define crit(msg, args...)	syslog(LOG_CRIT, msg, ##args);
-
-#define debug(msg, args...) 		\
-if (do_debug) 				\
-	syslog(LOG_DEBUG, msg, ##args);
 
 #endif
diff -urpN autofs-4.1.3_2.fg/lib/Makefile autofs-4.1.3_4.syslog/lib/Makefile
--- autofs-4.1.3_2.fg/lib/Makefile	Sun Mar  7 14:17:54 2004
+++ autofs-4.1.3_4.syslog/lib/Makefile	Thu Oct  7 18:56:39 2004
@@ -11,7 +11,7 @@ RANLIB = /usr/bin/ranlib
 
 SRCS = cache.c listmount.c cat_path.c rpc_subs.c
 RPCS = mount.h mount_clnt.c mount_xdr.c
-OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o cat_path.o rpc_subs.o
+OBJS = cache.o mount_clnt.o mount_xdr.o listmount.o cat_path.o rpc_subs.o log.o
 
 LIB = autofs.a
 
@@ -46,6 +46,10 @@ mount_xdr.o: mount_xdr.c
 listmount.o: listmount.c
 	$(CC) $(CFLAGS) -o listmount.o -c listmount.c
 	$(STRIP) listmount.o
+
+log.o: log.c
+	$(CC) $(CFLAGS) -o log.o -c log.c
+	$(STRIP) log.o
 
 install: all
 
diff -urpN autofs-4.1.3_2.fg/lib/log.c autofs-4.1.3_4.syslog/lib/log.c
--- autofs-4.1.3_2.fg/lib/log.c	Thu Jan  1 03:00:00 1970
+++ autofs-4.1.3_4.syslog/lib/log.c	Thu Oct  7 22:05:42 2004
@@ -0,0 +1,116 @@
+#include <stdarg.h>
+#include <stdio.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <fcntl.h>	/* open() */
+#include <stdlib.h>	/* exit() */
+
+#include "automount.h"
+
+static void null(const char *msg, ...)
+{
+}
+
+void (*info)(const char* msg, ...) = null;
+void (*notice)(const char* msg, ...) = null;
+void (*warn)(const char* msg, ...) = null;
+void (*error)(const char* msg, ...) = null;
+void (*crit)(const char* msg, ...) = null;
+void (*debug)(const char* msg, ...) = null;
+
+static void syslog_debug(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_DEBUG, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_info(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_INFO, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_notice(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_NOTICE, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_warn(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_WARNING, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_err(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_ERR, msg, ap);
+	va_end(ap);
+}
+
+static void syslog_crit(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_CRIT, msg, ap);
+	va_end(ap);
+}
+
+static void to_stderr(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	vfprintf(stderr, msg, ap);
+	fputc('\n',stderr);
+	va_end(ap);
+}
+
+void log_to_syslog()
+{
+	int nullfd;
+
+	openlog("automount", LOG_PID, LOG_DAEMON);
+	if (do_debug) debug = syslog_debug;
+	if (do_verbose || do_debug) {
+		info = syslog_info;
+		notice = syslog_notice;
+		warn = syslog_warn;
+	}
+	error = syslog_err;
+	crit = syslog_crit;
+
+	/* Redirect all our file descriptors to /dev/null */
+	nullfd = open("/dev/null", O_RDWR);
+	if (nullfd < 0) {
+		crit("cannot open /dev/null: %m");
+		exit(1);
+	}
+	if (dup2(nullfd, STDIN_FILENO) < 0 ||
+	    dup2(nullfd, STDOUT_FILENO) < 0 || dup2(nullfd, STDERR_FILENO) < 0) {
+		crit("redirecting file descriptors failed: %m");
+		exit(1);
+	}
+	if (nullfd > 2) close(nullfd);
+}
+
+void log_to_stderr()
+{
+	if (do_debug) debug = to_stderr;
+	if (do_verbose || do_debug) {
+		info = to_stderr;
+		notice = to_stderr;
+		warn = to_stderr;
+	}
+	error = to_stderr;
+	crit = to_stderr;
+}
diff -urpN autofs-4.1.3_2.fg/modules/lookup_yp.c autofs-4.1.3_4.syslog/modules/lookup_yp.c
--- autofs-4.1.3_2.fg/modules/lookup_yp.c	Mon May 10 15:44:30 2004
+++ autofs-4.1.3_4.syslog/modules/lookup_yp.c	Thu Oct  7 21:55:19 2004
@@ -76,7 +76,7 @@ int lookup_init(const char *mapfmt, int 
 	/* This should, but doesn't, take a const char ** */
 	err = yp_get_default_domain((char **) &ctxt->domainname);
 	if (err) {
-		crit(MODPREFIX "map %s: %s\n", ctxt->mapname,
+		crit(MODPREFIX "map %s: %s", ctxt->mapname,
 		       yperr_string(err));
 		return 1;
 	}
diff -urpN autofs-4.1.3_2.fg/modules/mount_bind.c autofs-4.1.3_4.syslog/modules/mount_bind.c
--- autofs-4.1.3_2.fg/modules/mount_bind.c	Mon May 10 15:44:30 2004
+++ autofs-4.1.3_4.syslog/modules/mount_bind.c	Thu Oct  7 20:23:13 2004
@@ -61,7 +61,7 @@ int mount_init(void **context)
 	if (lstat(tmp1, &st1) == -1)
 		goto out;
 
-	err = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+	err = spawnl(debug, MOUNTED_LOCK,
 	    	     PATH_MOUNT, PATH_MOUNT, "-n", "--bind", tmp1, tmp2, NULL);
 
 	if (err == 0 &&
@@ -70,8 +70,8 @@ int mount_init(void **context)
 		bind_works = 1;
 	}
 
-	debug(MODPREFIX "bind_works = %d\n", bind_works);
-	spawnl(LOG_DEBUG, MOUNTED_LOCK,
+	debug(MODPREFIX "bind_works = %d", bind_works);
+	spawnl(debug, MOUNTED_LOCK,
 	       PATH_UMOUNT, PATH_UMOUNT, "-n", tmp2, NULL);
 
       out:
@@ -124,7 +124,7 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount --bind %s %s", what, fullpath);
 
 		wait_for_lock();
-		err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+		err = spawnl(notice, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "--bind",
 			     what, fullpath, NULL);
 		unlink(AUTOFS_LOCK);
diff -urpN autofs-4.1.3_2.fg/modules/mount_changer.c autofs-4.1.3_4.syslog/modules/mount_changer.c
--- autofs-4.1.3_2.fg/modules/mount_changer.c	Mon May 10 15:44:30 2004
+++ autofs-4.1.3_4.syslog/modules/mount_changer.c	Sat Oct  9 23:02:59 2004
@@ -70,7 +70,7 @@ int mount_mount(const char *root, const 
 	debug(MODPREFIX "calling umount %s", what);
 
 	wait_for_lock();
-	err = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+	err = spawnl(debug, MOUNTED_LOCK,
 		     PATH_UMOUNT, PATH_UMOUNT, what, NULL);
 	unlink(AUTOFS_LOCK);
 	if (err) {
@@ -98,14 +98,14 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		    fstype, options, what, fullpath);
 
-		err = spawnl(LOG_DEBUG, MOUNTED_LOCK,
+		err = spawnl(debug, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 			  fstype, what, fullpath);
 
-		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, PATH_MOUNT, PATH_MOUNT,
+		err = spawnl(debug, MOUNTED_LOCK, PATH_MOUNT, PATH_MOUNT,
 			     "-t", fstype, what, fullpath, NULL);
 	}
 	unlink(AUTOFS_LOCK);
diff -urpN autofs-4.1.3_2.fg/modules/mount_ext2.c autofs-4.1.3_4.syslog/modules/mount_ext2.c
--- autofs-4.1.3_2.fg/modules/mount_ext2.c	Mon May 10 15:44:30 2004
+++ autofs-4.1.3_4.syslog/modules/mount_ext2.c	Thu Oct  7 19:50:36 2004
@@ -91,10 +91,10 @@ int mount_mount(const char *root, const 
 #endif
 	if (ro) {
 		debug(MODPREFIX "calling %s -n %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-n", what, NULL);
+		err = spawnl(debug, MOUNTED_LOCK, fsck_prog, fsck_prog, "-n", what, NULL);
 	} else {
 		debug(MODPREFIX "calling %s -p %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, MOUNTED_LOCK, fsck_prog, fsck_prog, "-p", what, NULL);
+		err = spawnl(debug, MOUNTED_LOCK, fsck_prog, fsck_prog, "-p", what, NULL);
 	}
 
 	if (err & ~6) {
@@ -107,13 +107,13 @@ int mount_mount(const char *root, const 
 	if (options) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
-		err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+		err = spawnl(notice, MOUNTED_LOCK,
 		             PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+		err = spawnl(notice, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.3_2.fg/modules/mount_generic.c autofs-4.1.3_4.syslog/modules/mount_generic.c
--- autofs-4.1.3_2.fg/modules/mount_generic.c	Mon May 10 15:44:30 2004
+++ autofs-4.1.3_4.syslog/modules/mount_generic.c	Thu Oct  7 19:51:27 2004
@@ -76,13 +76,13 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
 
-		err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+		err = spawnl(notice, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+		err = spawnl(notice, MOUNTED_LOCK,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.3_2.fg/modules/mount_nfs.c autofs-4.1.3_4.syslog/modules/mount_nfs.c
--- autofs-4.1.3_2.fg/modules/mount_nfs.c	Tue May 18 15:20:08 2004
+++ autofs-4.1.3_4.syslog/modules/mount_nfs.c	Thu Oct  7 19:50:53 2004
@@ -450,14 +450,14 @@ int mount_mount(const char *root, const 
 			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
 			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
 
-			err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+			err = spawnl(notice, MOUNTED_LOCK,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", SLOPPYOPT "-o", nfsoptions,
 				     whatstr, fullpath, NULL);
 		} else {
 			debug(MODPREFIX "calling mount -t nfs %s %s",
 			      whatstr, fullpath);
-			err = spawnl(LOG_NOTICE, MOUNTED_LOCK,
+			err = spawnl(notice, MOUNTED_LOCK,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", whatstr, fullpath, NULL);
 		}

--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.fg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.fg.patch"

diff -urpN autofs-4.1.3_1.exec/daemon/automount.c autofs-4.1.3_2.fg/daemon/automount.c
--- autofs-4.1.3_1.exec/daemon/automount.c	Mon Apr  5 16:14:10 2004
+++ autofs-4.1.3_2.fg/daemon/automount.c	Thu Oct  7 20:28:27 2004
@@ -61,6 +61,7 @@ static int submount = 0;
 
 int do_verbose = 0;		/* Verbose feedback option */
 int do_debug = 0;		/* Enable full debug output */
+int daemonize = 1;		/* Shall we daemonize? */
 
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
@@ -1274,7 +1275,7 @@ static void become_daemon(void)
 	chdir("/");
 
 	/* Detach from foreground process */
-	if (!submount) {
+	if (!submount && daemonize) {
 		pid = fork();
 		if (pid > 0)
 			exit(0);
@@ -1292,7 +1293,7 @@ static void become_daemon(void)
 	my_pid = getpid();
 
 	/* Make our own process group for "magic" reason: processes that share
-	   our pgrp see the raw filesystem behine the magic.  So if we are a 
+	   our pgrp see the raw filesystem behind the magic.  So if we are a 
 	   submount, don't change -- otherwise we won't be able to actually
 	   perform the mount.  A pgrp is also useful for controlling all the
 	   child processes we generate. */
@@ -1313,7 +1314,7 @@ static void become_daemon(void)
 		crit("redirecting file descriptors failed: %m");
 		exit(1);
 	}
-	close(nullfd);
+	if (nullfd > 2) close(nullfd);
 
 	/* Write pid file if requested */
 	if (pid_file) {
@@ -1365,7 +1366,19 @@ static unsigned long getnumopt(char *str
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
+	fprintf(stderr,
+		"Usage: %s [options] path map_type [args...]\n"
+		"	-h --help	this text\n"
+		"	-p --pid-file f	write process id to file f\n"
+		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
+		"	-f --foreground	do not daemonize\n"
+		"	-v --verbose	be verbose\n"
+		"	-d --debug	be even more verbose\n"
+		"	-V --version	print version and exit\n"
+		/* "	-g --ghost	\n" */
+		/* "	--submount	\n" */
+		, program
+	);
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1650,6 +1663,7 @@ int main(int argc, char *argv[])
 		{"help", 0, 0, 'h'},
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
+		{"foreground", 0, 0, 'f'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1666,7 +1680,7 @@ int main(int argc, char *argv[])
 	ap.type = LKP_INDIRECT;
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1678,6 +1692,10 @@ int main(int argc, char *argv[])
 
 		case 't':
 			ap.exp_timeout = getnumopt(optarg, opt);
+			break;
+
+		case 'f':
+			daemonize = 0;
 			break;
 
 		case 'v':

--Boundary-00=_PnEaBPtAx9u+38d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_PnEaBPtAx9u+38d--

