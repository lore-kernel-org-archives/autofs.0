From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 4/5] switch to new logging
Date: Fri, 11 Feb 2005 12:06:12 +0200
Message-ID: <200502111206.12250.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UOIDCq2AQNbWPDL"
In-Reply-To: <200502111203.58345.vda@port.imtp.ilyichevsk.odessa.ua>
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


--Boundary-00=_UOIDCq2AQNbWPDL
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Convert rest of code to new logging functions.
Use --stderr option to activate it.
--
vda

--Boundary-00=_UOIDCq2AQNbWPDL
Content-Type: text/x-diff;
  charset="koi8-r";
  name="414b1.34.syslog.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="414b1.34.syslog.patch"

diff -urpN autofs-4.1.4_beta1_3/daemon/automount.c autofs-4.1.4_beta1_4/daemon/automount.c
--- autofs-4.1.4_beta1_3/daemon/automount.c	Fri Feb 11 10:49:57 2005
+++ autofs-4.1.4_beta1_4/daemon/automount.c	Fri Feb 11 10:49:58 2005
@@ -39,7 +39,7 @@
 #include <linux/auto_fs4.h>
 
 #ifndef NDEBUG
-#define assert(x)	do { if (!(x)) { syslog(LOG_CRIT, __FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
+#define assert(x)	do { if (!(x)) { crit(__FILE__ ":%d: assertion failed: " #x, __LINE__); } } while(0)
 #else
 #define assert(x)	do { } while(0)
 #endif
@@ -162,7 +162,7 @@ static int umount_ent(const char *root, 
 			umount_ok = 1;
 
 		if (umount_ok || is_smbfs) {
-			rv = spawnll(LOG_DEBUG, 
+			rv = spawnll(debug,
 				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
 		}
 	}
@@ -224,7 +224,7 @@ static int rm_unwanted_fn(const char *fi
 		if (st->st_dev != ap.dev)
 			return 0;
 	} else {
-		info("rm_unwanted: %s\n", file);
+		info("rm_unwanted: %s", file);
 		if (S_ISDIR(st->st_mode))
 			rmdir(file);
 		else if (!S_ISLNK(st->st_mode) || rmsymlink)
@@ -257,7 +257,7 @@ static int umount_multi(const char *path
 	struct mnt_list *mntlist = NULL;
 	struct mnt_list *mptr;
 
-	debug("umount_multi: path=%s incl=%d\n", path, incl);
+	debug("umount_multi: path=%s incl=%d", path, incl);
 
 	mntlist = get_mnt_list(_PATH_MOUNTED, path, incl);
 
@@ -269,7 +269,7 @@ static int umount_multi(const char *path
 
 	left = 0;
 	for (mptr = mntlist; mptr != NULL; mptr = mptr->next) {
-		debug("umount_multi: unmounting dir=%s\n", mptr->path);
+		debug("umount_multi: unmounting dir=%s", mptr->path);
 		if (umount_ent("", mptr->path, mptr->fs_type)) {
 			left++;
 		}
@@ -316,13 +316,13 @@ static int do_umount_autofs(void)
 		struct stat st;
 		int ret;
 
-		rv = spawnll(LOG_DEBUG,
+		rv = spawnll(debug,
 			    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		if (rv & MTAB_NOTUPDATED) {
 			info("umount %s succeeded: "
 			     "mtab not updated, retrying to clean\n",
 			      ap.path);
-			rv = spawnll(LOG_DEBUG,
+			rv = spawnll(debug,
 				    PATH_UMOUNT, PATH_UMOUNT, ap.path, NULL);
 		}
 		ret = stat(ap.path, &st);
@@ -332,16 +332,16 @@ static int do_umount_autofs(void)
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
@@ -452,7 +452,7 @@ static int mount_autofs(char *path)
         }
 	our_name[len] = '\0';
 
-	if (spawnll(LOG_DEBUG, PATH_MOUNT, PATH_MOUNT,
+	if (spawnll(debug, PATH_MOUNT, PATH_MOUNT,
 		   "-t", "autofs", "-o", options, our_name, path, NULL) != 0) {
 		crit("failed to mount autofs path %s", ap.path);
 		rmdir_path(ap.path);
@@ -530,7 +530,7 @@ static int send_ready(unsigned int wait_
 {
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_ready: token=%d\n", wait_queue_token);
+	debug("send_ready: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_READY, wait_queue_token) < 0) {
 		error("AUTOFS_IOC_READY: %m");
 		return 1;
@@ -542,9 +542,9 @@ static int send_fail(unsigned int wait_q
 {
 	if (wait_queue_token == 0)
 		return 0;
-	debug("send_fail: token=%d\n", wait_queue_token);
+	debug("send_fail: token=%d", wait_queue_token);
 	if (ioctl(ap.ioctlfd, AUTOFS_IOC_FAIL, wait_queue_token) < 0) {
-		syslog(LOG_ERR, "AUTOFS_IOC_FAIL: %m");
+		error("AUTOFS_IOC_FAIL: %m");
 		return 1;
 	}
 	return 0;
@@ -562,7 +562,7 @@ static enum states handle_child(int hang
 	while ((pid = waitpid(-1, &status, hang ? 0 : WNOHANG)) > 0) {
 		struct pending_mount volatile *mt, *volatile *mtp;
 
-		debug("handle_child: got pid %d, sig %d (%d), stat %d\n",
+		debug("handle_child: got pid %d, sig %d (%d), stat %d",
 			pid, WIFSIGNALED(status),
 			WTERMSIG(status), WEXITSTATUS(status));
 
@@ -676,7 +676,7 @@ static void sig_child(int sig)
 
 static int st_ready(void)
 {
-	debug("st_ready(): state = %d\n", ap.state);
+	debug("st_ready(): state = %d", ap.state);
 
 	ap.state = ST_READY;
 	sigprocmask(SIG_UNBLOCK, &lock_sigs, NULL);
@@ -786,7 +786,7 @@ static enum expire expire_proc(int now)
 		 * words) the umounts are done by the time we reach here
 		 */
 		if ((count = count_mounts(ap.path))) {
-			debug("expire_proc: %d remaining in %s\n", count, ap.path);
+			debug("expire_proc: %d remaining in %s", count, ap.path);
 			exit(1);
 		}
 		exit(0);
@@ -841,7 +841,7 @@ static int st_prepare_shutdown(void)
 	/* Unmount everything */
 	exp = expire_proc(1);
 
-	debug("prep_shutdown: expire returns %d\n", exp);
+	debug("prep_shutdown: expire returns %d", exp);
 
 	switch (exp) {
 	case EXP_ERROR:
@@ -865,7 +865,7 @@ static int st_prepare_shutdown(void)
 
 static int st_prune(void)
 {
-	debug("st_prune(): state = %d\n", ap.state);
+	debug("st_prune(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -893,7 +893,7 @@ static int st_prune(void)
 
 static int st_expire(void)
 {
-	debug("st_expire(): state = %d\n", ap.state);
+	debug("st_expire(): state = %d", ap.state);
 
 	assert(ap.state == ST_READY);
 
@@ -950,7 +950,7 @@ static int get_pkt(int fd, union autofs_
 		if (poll(fds, 2, -1) == -1) {
 			if (errno == EINTR)
 				continue;
-			syslog(LOG_ERR, "get_pkt: poll failed: %m");
+			error("get_pkt: poll failed: %s", strerror(errno));
 			return -1;
 		}
 
@@ -1022,7 +1022,7 @@ static int handle_packet_missing(const s
 	pid_t f;
 	struct pending_mount *mt = NULL;
 
-	debug("handle_packet_missing: token %ld, name %s\n",
+	debug("handle_packet_missing: token %ld, name %s",
 		pkt->wait_queue_token, pkt->name);
 
 	/* Ignore packet if we're trying to shut down */
@@ -1172,7 +1172,7 @@ static void do_expire(const char *name, 
 		chdir("/");
 
 		if (ret)
-			error("failed to recover from partial expiry of %s\n",
+			error("failed to recover from partial expiry of %s",
 			       buf);
 	}
 }
@@ -1242,7 +1242,7 @@ static int handle_packet_expire_multi(co
 {
 	int ret;
 
-	debug("handle_packet_expire_multi: token %ld, name %s\n",
+	debug("handle_packet_expire_multi: token %ld, name %s",
 		  pkt->wait_queue_token, pkt->name);
 
 	ret = handle_expire(pkt->name, pkt->len, pkt->wait_queue_token);
@@ -1259,7 +1259,7 @@ static int handle_packet(void)
 	if (get_pkt(ap.pipefd, &pkt))
 		return -1;
 
-	debug("handle_packet: type = %d\n", pkt.hdr.type);
+	debug("handle_packet: type = %d", pkt.hdr.type);
 
 	switch (pkt.hdr.type) {
 	case autofs_ptype_missing:
@@ -1271,7 +1271,7 @@ static int handle_packet(void)
 	case autofs_ptype_expire_multi:
 		return handle_packet_expire_multi(&pkt.expire_multi);
 	}
-	error("handle_packet: unknown packet type %d\n", pkt.hdr.type);
+	error("handle_packet: unknown packet type %d", pkt.hdr.type);
 	return -1;
 }
 
@@ -1294,7 +1294,6 @@ static void become_daemon(void)
 			exit(1);
 		}
 	}
-
 	/* Initialize logging subsystem */
 	if(!log_stderr) {
 		log_to_syslog();
@@ -1322,7 +1321,8 @@ static void become_daemon(void)
 			fprintf(pidfp, "%lu\n", (unsigned long) my_pid);
 			fclose(pidfp);
 		} else {
-			warn("failed to write pid file %s: %m", pid_file);
+			warn("failed to write pid file %s: %s", pid_file,
+				strerror(errno));
 			pid_file = NULL;
 		}
 	}
@@ -1731,7 +1731,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "%s: This program must be run by root.\n", program);
+		fprintf(stderr, "%s: This program must be run by root\n", program);
 		exit(1);
 	}
 
@@ -1758,9 +1758,9 @@ int main(int argc, char *argv[])
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
 
diff -urpN autofs-4.1.4_beta1_3/daemon/spawn.c autofs-4.1.4_beta1_4/daemon/spawn.c
--- autofs-4.1.4_beta1_3/daemon/spawn.c	Fri Feb 11 10:49:53 2005
+++ autofs-4.1.4_beta1_4/daemon/spawn.c	Fri Feb 11 10:49:58 2005
@@ -196,7 +196,7 @@ out:
 
 #define ERRBUFSIZ 2047		/* Max length of error string excl \0 */
 
-static int do_spawn(int logpri, int use_lock, const char *prog, const char *const *argv)
+static int do_spawn(logger* log, int use_lock, const char *prog, const char *const *argv)
 {
 	pid_t f;
 	int status, pipefd[2];
@@ -257,7 +257,7 @@ static int do_spawn(int logpri, int use_
 				while (errp && (p = memchr(sp, '\n', errp))) {
 					*p++ = '\0';
 					if (sp[0])	/* Don't output empty lines */
-						syslog(logpri, ">> %s", sp);
+						log(">> %s", sp);
 					errp -= (p - sp);
 					sp = p;
 				}
@@ -268,7 +268,7 @@ static int do_spawn(int logpri, int use_
 				if (errp >= ERRBUFSIZ) {
 					/* Line too long, split */
 					errbuf[errp] = '\0';
-					syslog(logpri, ">> %s", errbuf);
+					log(">> %s", errbuf);
 					errp = 0;
 				}
 			}
@@ -278,7 +278,7 @@ static int do_spawn(int logpri, int use_
 		if (errp > 0) {
 			/* End of file without \n */
 			errbuf[errp] = '\0';
-			syslog(logpri, ">> %s", errbuf);
+			log(">> %s", errbuf);
 		}
 
 		if (waitpid(f, &status, 0) != f)
@@ -293,12 +293,12 @@ static int do_spawn(int logpri, int use_
 	}
 }
 
-int spawnv(int logpri, const char *prog, const char *const *argv)
+int spawnv(logger* log, const char *prog, const char *const *argv)
 {
-	return do_spawn(logpri, 0, prog, argv);
+	return do_spawn(log, 0, prog, argv);
 }
 
-int spawnl(int logpri, const char *prog, ...)
+int spawnl(logger* log, const char *prog, ...)
 {
 	va_list arg;
 	int argc;
@@ -316,10 +316,10 @@ int spawnl(int logpri, const char *prog,
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(logpri, 0, prog, (const char **) argv);
+	return do_spawn(log, 0, prog, (const char **) argv);
 }
 
-int spawnll(int logpri, const char *prog, ...)
+int spawnll(logger* log, const char *prog, ...)
 {
 	va_list arg;
 	int argc;
@@ -337,5 +337,5 @@ int spawnll(int logpri, const char *prog
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(logpri, 1, prog, (const char **) argv);
+	return do_spawn(log, 1, prog, (const char **) argv);
 }
diff -urpN autofs-4.1.4_beta1_3/include/automount.h autofs-4.1.4_beta1_4/include/automount.h
--- autofs-4.1.4_beta1_3/include/automount.h	Fri Feb 11 11:42:54 2005
+++ autofs-4.1.4_beta1_4/include/automount.h	Fri Feb 11 10:59:20 2005
@@ -117,13 +117,29 @@ struct autofs_point {
 
 extern struct autofs_point ap; 
 
+/* log notification */
+extern int do_verbose;
+extern int do_debug;
+
+extern void (*info)(const char* msg, ...);
+extern void (*notice)(const char* msg, ...);
+extern void (*warn)(const char* msg, ...);
+extern void (*error)(const char* msg, ...);
+extern void (*crit)(const char* msg, ...);
+extern void (*debug)(const char* msg, ...);
+
+typedef void logger(const char* msg, ...);
+
+void log_to_syslog();
+void log_to_stderr();
+
 /* Standard function used by daemon or modules */
 
 int aquire_lock(void);
 void release_lock(void);
-int spawnll(int logpri, const char *prog, ...);
-int spawnl(int logpri, const char *prog, ...);
-int spawnv(int logpri, const char *prog, const char *const *argv);
+int spawnll(logger* log, const char *prog, ...);
+int spawnl(logger* log, const char *prog, ...);
+int spawnv(logger* log, const char *prog, const char *const *argv);
 void reset_signals(void);
 void ignore_signals(void);
 void discard_pending(int sig);
@@ -282,20 +298,4 @@ int is_mounted(const char *table, const 
 int has_fstab_option(const char *path, const char *opt);
 int allow_owner_mount(const char *);
 
-/* log notification */
-extern int do_verbose;
-extern int do_debug;
-
-extern void (*info)(const char* msg, ...);
-extern void (*notice)(const char* msg, ...);
-extern void (*warn)(const char* msg, ...);
-extern void (*error)(const char* msg, ...);
-extern void (*crit)(const char* msg, ...);
-extern void (*debug)(const char* msg, ...);
-
-void log_to_syslog();
-void log_to_stderr();
-
-
 #endif
-
diff -urpN autofs-4.1.4_beta1_3/lib/log.c autofs-4.1.4_beta1_4/lib/log.c
--- autofs-4.1.4_beta1_3/lib/log.c	Fri Feb 11 10:49:57 2005
+++ autofs-4.1.4_beta1_4/lib/log.c	Fri Feb 11 10:49:58 2005
@@ -11,6 +11,13 @@ static void null(const char *msg, ...)
 {
 }
 
+void (*info)(const char* msg, ...) = null;
+void (*notice)(const char* msg, ...) = null;
+void (*warn)(const char* msg, ...) = null;
+void (*error)(const char* msg, ...) = null;
+void (*crit)(const char* msg, ...) = null;
+void (*debug)(const char* msg, ...) = null;
+
 static void syslog_debug(const char *msg, ...)
 {
 	va_list ap;
@@ -27,6 +34,14 @@ static void syslog_info(const char *msg,
 	va_end(ap);
 }
 
+static void syslog_notice(const char *msg, ...)
+{
+	va_list ap;
+	va_start(ap, msg);
+	syslog(LOG_NOTICE, msg, ap);
+	va_end(ap);
+}
+
 static void syslog_warn(const char *msg, ...)
 {
 	va_list ap;
@@ -56,6 +71,7 @@ static void to_stderr(const char *msg, .
 	va_list ap;
 	va_start(ap, msg);
 	vfprintf(stderr, msg, ap);
+	fputc('\n',stderr);
 	va_end(ap);
 }
 
@@ -67,13 +83,15 @@ void log_to_syslog()
 	if (do_debug) debug = syslog_debug;
 	if (do_verbose || do_debug) {
 		info = syslog_info;
+		notice = syslog_notice;
 		warn = syslog_warn;
 	}
 	error = syslog_err;
 	crit = syslog_crit;
 
 	/* Redirect all our file descriptors to /dev/null */
-	if ((nullfd = open("/dev/null", O_RDWR)) < 0) {
+	nullfd = open("/dev/null", O_RDWR);
+	if (nullfd < 0) {
 		crit("cannot open /dev/null: %m");
 		exit(1);
 	}
@@ -90,14 +108,9 @@ void log_to_stderr()
 	if (do_debug) debug = to_stderr;
 	if (do_verbose || do_debug) {
 		info = to_stderr;
+		notice = to_stderr;
 		warn = to_stderr;
 	}
 	error = to_stderr;
 	crit = to_stderr;
 }
-
-void (*info)(const char* msg, ...) = null;
-void (*warn)(const char* msg, ...) = null;
-void (*error)(const char* msg, ...) = null;
-void (*crit)(const char* msg, ...) = null;
-void (*debug)(const char* msg, ...) = null;
diff -urpN autofs-4.1.4_beta1_3/modules/lookup_hesiod.c autofs-4.1.4_beta1_4/modules/lookup_hesiod.c
--- autofs-4.1.4_beta1_3/modules/lookup_hesiod.c	Fri Dec 31 08:30:08 2004
+++ autofs-4.1.4_beta1_4/modules/lookup_hesiod.c	Fri Feb 11 10:49:58 2005
@@ -82,7 +82,7 @@ int lookup_mount(const char *root, const
 	hes_result = hes_resolve(name, "filsys");
 
 	if (!hes_result || !hes_result[0]) {
-		warn(MODPREFIX "entry \"%s\" not found in map\n", name);
+		warn(MODPREFIX "entry \"%s\" not found in map", name);
 		return 1;
 	}
 
diff -urpN autofs-4.1.4_beta1_3/modules/lookup_yp.c autofs-4.1.4_beta1_4/modules/lookup_yp.c
--- autofs-4.1.4_beta1_3/modules/lookup_yp.c	Wed Jan 26 09:21:21 2005
+++ autofs-4.1.4_beta1_4/modules/lookup_yp.c	Fri Feb 11 10:49:58 2005
@@ -69,7 +69,7 @@ int lookup_init(const char *mapfmt, int 
 	/* This should, but doesn't, take a const char ** */
 	err = yp_get_default_domain((char **) &ctxt->domainname);
 	if (err) {
-		crit(MODPREFIX "map %s: %s\n", ctxt->mapname,
+		crit(MODPREFIX "map %s: %s", ctxt->mapname,
 		       yperr_string(err));
 		return 1;
 	}
diff -urpN autofs-4.1.4_beta1_3/modules/mount_bind.c autofs-4.1.4_beta1_4/modules/mount_bind.c
--- autofs-4.1.4_beta1_3/modules/mount_bind.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4_beta1_4/modules/mount_bind.c	Fri Feb 11 11:12:18 2005
@@ -59,7 +59,7 @@ int mount_init(void **context)
 	if (lstat(tmp1, &st1) == -1)
 		goto out;
 
-	err = spawnl(LOG_DEBUG,
+	err = spawnl(debug,
 	    	     PATH_MOUNT, PATH_MOUNT, "-n", "--bind", tmp1, tmp2, NULL);
 
 	if (err == 0 &&
@@ -68,8 +68,8 @@ int mount_init(void **context)
 		bind_works = 1;
 	}
 
-	debug(MODPREFIX "bind_works = %d\n", bind_works);
-	spawnl(LOG_DEBUG,
+	debug(MODPREFIX "bind_works = %d", bind_works);
+	spawnl(debug,
 	       PATH_UMOUNT, PATH_UMOUNT, "-n", tmp2, NULL);
 
       out:
@@ -131,7 +131,7 @@ int mount_mount(const char *root, const 
 		      "calling mount --bind " SLOPPY " -o %s %s %s",
 		      options, what, fullpath);
 
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "--bind",
 			     SLOPPYOPT "-o", options,
 			     what, fullpath, NULL);
diff -urpN autofs-4.1.4_beta1_3/modules/mount_changer.c autofs-4.1.4_beta1_4/modules/mount_changer.c
--- autofs-4.1.4_beta1_3/modules/mount_changer.c	Sun Jan  9 11:16:43 2005
+++ autofs-4.1.4_beta1_4/modules/mount_changer.c	Fri Feb 11 11:13:04 2005
@@ -68,7 +68,7 @@ int mount_mount(const char *root, const 
 
 	debug(MODPREFIX "calling umount %s", what);
 
-	err = spawnll(LOG_DEBUG,
+	err = spawnll(debug,
 		     PATH_UMOUNT, PATH_UMOUNT, what, NULL);
 	if (err) {
 		error(MODPREFIX "umount of %s failed (all may be unmounted)",
@@ -98,14 +98,14 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		    fstype, options, what, fullpath);
 
-		err = spawnll(LOG_DEBUG,
+		err = spawnll(debug,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 			  fstype, what, fullpath);
 
-		err = spawnll(LOG_DEBUG, PATH_MOUNT, PATH_MOUNT,
+		err = spawnll(debug, PATH_MOUNT, PATH_MOUNT,
 			     "-t", fstype, what, fullpath, NULL);
 	}
 
@@ -164,7 +164,7 @@ int swapCD(const char *device, const cha
 	/* close device */
 	status = close(fd);
 	if (status != 0) {
-		error(MODPREFIX "close failed for `%s': %s\n",
+		error(MODPREFIX "close failed for `%s': %s",
 		      device, strerror(errno));
 		return 1;
 	}
diff -urpN autofs-4.1.4_beta1_3/modules/mount_ext2.c autofs-4.1.4_beta1_4/modules/mount_ext2.c
--- autofs-4.1.4_beta1_3/modules/mount_ext2.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4_beta1_4/modules/mount_ext2.c	Fri Feb 11 11:45:49 2005
@@ -93,10 +93,10 @@ int mount_mount(const char *root, const 
 #endif
 	if (ro) {
 		debug(MODPREFIX "calling %s -n %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-n", what, NULL);
+		err = spawnl(debug, fsck_prog, fsck_prog, "-n", what, NULL);
 	} else {
 		debug(MODPREFIX "calling %s -p %s", fsck_prog, what);
-		err = spawnl(LOG_DEBUG, fsck_prog, fsck_prog, "-p", what, NULL);
+		err = spawnl(debug, fsck_prog, fsck_prog, "-p", what, NULL);
 	}
 
 	if (err & ~6) {
@@ -108,13 +108,13 @@ int mount_mount(const char *root, const 
 	if (options) {
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 		             PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.4_beta1_3/modules/mount_generic.c autofs-4.1.4_beta1_4/modules/mount_generic.c
--- autofs-4.1.4_beta1_3/modules/mount_generic.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4_beta1_4/modules/mount_generic.c	Fri Feb 11 11:12:46 2005
@@ -77,13 +77,13 @@ int mount_mount(const char *root, const 
 		debug(MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
 
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(LOG_NOTICE,
+		err = spawnll(notice,
 			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
 			     what, fullpath, NULL);
 	}
diff -urpN autofs-4.1.4_beta1_3/modules/mount_nfs.c autofs-4.1.4_beta1_4/modules/mount_nfs.c
--- autofs-4.1.4_beta1_3/modules/mount_nfs.c	Mon Jan 10 15:28:29 2005
+++ autofs-4.1.4_beta1_4/modules/mount_nfs.c	Fri Feb 11 10:49:58 2005
@@ -458,14 +458,14 @@ int mount_mount(const char *root, const 
 			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
 			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
 
-			err = spawnll(LOG_NOTICE,
+			err = spawnll(notice,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", SLOPPYOPT "-o", nfsoptions,
 				     whatstr, fullpath, NULL);
 		} else {
 			debug(MODPREFIX "calling mount -t nfs %s %s",
 			      whatstr, fullpath);
-			err = spawnll(LOG_NOTICE,
+			err = spawnll(notice,
 				     PATH_MOUNT, PATH_MOUNT, "-t",
 				     "nfs", whatstr, fullpath, NULL);
 		}

--Boundary-00=_UOIDCq2AQNbWPDL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_UOIDCq2AQNbWPDL--

