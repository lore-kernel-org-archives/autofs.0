From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Sun, 27 Aug 2006 15:52:46 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608271549370.21043@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
	<Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251506180.25004@raven.themaw.net>
	<Pine.LNX.4.64.0608251917030.30523@raven.themaw.net>
	<Pine.LNX.4.64.0608251407560.14075@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608251417500.14075@frank.dcs.qmul.ac.uk>
	<1156516669.30971.43.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1156516669.30971.43.camel@raven.themaw.net>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 25 Aug 2006, Ian Kent wrote:

> On Fri, 2006-08-25 at 14:22 +0100, Matt Bernstein wrote:
> > At 14:09 +0100 Matt Bernstein wrote:
> > 
> > > At 19:18 +0800 Ian Kent wrote:
> > >
> > >> Could you try this patch please.
> > >
> > > Thanks.. now my messages are slightly different (though it still fails).
> > >
> > > Aug 25 14:07:19 laurel automount[17416]: attempting to mount entry /homes/mb
> > > Aug 25 14:07:19 laurel automount[17416]: mount(nfs): nfs: mount failure :/home/cream/home71/mb on /homes/mb
> > > Aug 25 14:07:19 laurel automount[17416]: failed to mount /homes/mb
> > 
> > Actually, this only happens when the target isn't already mounted. It does 
> > perform a bind mount if there's something to bind to. Now what we need to 
> > do (I think) is tickle the target in case it's another automount point, a 
> > la our-bad-patch-for-autofs4.
> 
> Shouldn't need to do that.
> This my be due to changes in the lookup flags in the kernel over time.
> I haven't reviewed that for some time now.

And that seems OK.

Can you try this patch in addition to the previous patch please.

Ian

-- 

diff --git a/daemon/direct.c b/daemon/direct.c
index 9a1cd59..cfa13ad 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -273,8 +273,7 @@ static int unlink_mount_tree(struct auto
 			continue;
 
 		if (strcmp(mnt->fs_type, "autofs"))
-			rv = spawnll(log_debug,
-			     PATH_UMOUNT, PATH_UMOUNT, "-l", mnt->path, NULL);
+			rv = spawn_umount(log_debug, "-l", mnt->path, NULL);
 		else
 			rv = umount2(mnt->path, MNT_DETACH);
 		if (rv == -1) {
diff --git a/daemon/indirect.c b/daemon/indirect.c
index 38d0b7a..9ceb015 100644
--- a/daemon/indirect.c
+++ b/daemon/indirect.c
@@ -95,8 +95,7 @@ static int unlink_mount_tree(struct auto
 		}
 
 		if (strcmp(this->fs_type, "autofs"))
-			rv = spawnll(log_debug,
-			    PATH_UMOUNT, PATH_UMOUNT, "-l", this->path, NULL);
+			rv = spawn_umount(log_debug, "-l", this->path, NULL);
 		else
 			rv = umount2(this->path, MNT_DETACH);
 		if (rv == -1) {
diff --git a/daemon/spawn.c b/daemon/spawn.c
index 7dc4a81..84df3b9 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -20,6 +20,7 @@ #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <sys/types.h>
+#include <dirent.h>
 #include <unistd.h>
 #include <time.h>
 #include <sys/wait.h>
@@ -27,9 +28,11 @@ #include <sys/stat.h>
 
 #include "automount.h"
 
-#ifdef ENABLE_MOUNT_LOCKING
 static pthread_mutex_t spawn_mutex = PTHREAD_MUTEX_INITIALIZER;
-#endif
+
+#define SPAWN_OPT_NONE		0x0000
+#define SPAWN_OPT_LOCK		0x0001
+#define SPAWN_OPT_OPENDIR	0x0002
 
 inline void dump_core(void)
 {
@@ -83,26 +86,15 @@ void reset_signals(void)
 
 #define ERRBUFSIZ 2047		/* Max length of error string excl \0 */
 
-#ifdef ENABLE_MOUNT_LOCKING
-void spawn_unlock(void *arg)
-{
-	int *use_lock = (int *) arg;
-
-	if (*use_lock) {
-		if (pthread_mutex_unlock(&spawn_mutex))
-			warn(LOGOPT_NONE, "failed to unlock spawn_mutex");
-	}
-	return;
-}
-#endif
-
-static int do_spawn(logger *log, int use_lock, const char *prog, const char *const *argv)
+static int do_spawn(logger *log, unsigned int options, const char *prog, const char *const *argv)
 {
 	pid_t f;
 	int status, pipefd[2];
 	char errbuf[ERRBUFSIZ + 1], *p, *sp;
 	int errp, errn;
 	int cancel_state;
+	unsigned int use_lock = options & SPAWN_OPT_LOCK;
+	unsigned int use_opendir = options & SPAWN_OPT_OPENDIR;
 	sigset_t allsigs, tmpsig, oldsig;
 
 	if (pipe(pipefd))
@@ -113,16 +105,11 @@ static int do_spawn(logger *log, int use
 	sigfillset(&allsigs);
 	pthread_sigmask(SIG_BLOCK, &allsigs, &oldsig);
 
-#ifdef ENABLE_MOUNT_LOCKING
 	if (use_lock) {
-		if (pthread_mutex_lock(&spawn_mutex)) {
-			log(LOGOPT_ANY, "failed to lock spawn_mutex");
-			pthread_sigmask(SIG_SETMASK, &oldsig, NULL);
-			pthread_setcancelstate(cancel_state, NULL);
-			return -1;
-		}
+		status = pthread_mutex_lock(&spawn_mutex);
+		if (status)
+			fatal(status);
 	}
-#endif
 
 	f = fork();
 	if (f == 0) {
@@ -132,6 +119,26 @@ #endif
 		dup2(pipefd[1], STDERR_FILENO);
 		close(pipefd[1]);
 
+		/* Bind mount - check target exists */
+		if (use_opendir) {
+			char **pargv = (char **) argv;
+			int argc = 0;
+			pid_t pgrp = getpgrp();
+			DIR *dfd;
+
+			/* what to mount must always be second last */
+			while (*pargv++)
+				argc++;
+			argc -= 2;
+
+			/* Set non-autofs program group to trigger mount */
+			setpgrp();
+			if ((dfd = opendir(argv[argc])) == NULL)
+				_exit(errno);
+			closedir(dfd);
+			setpgid(0, pgrp);
+		}
+
 		execv(prog, (char *const *) argv);
 		_exit(255);	/* execv() failed */
 	} else {
@@ -144,10 +151,12 @@ #endif
 
 		if (f < 0) {
 			close(pipefd[0]);
+			if (use_lock) {
+				status = pthread_mutex_unlock(&spawn_mutex);
+				if (status)
+					fatal(status);
+			}
 			pthread_sigmask(SIG_SETMASK, &oldsig, NULL);
-#ifdef ENABLE_MOUNT_LOCKING
-			spawn_unlock(&use_lock);
-#endif
 			pthread_setcancelstate(cancel_state, NULL);
 			return -1;
 		}
@@ -193,10 +202,12 @@ #endif
 		if (waitpid(f, &status, 0) != f)
 			status = -1;	/* waitpid() failed */
 
+		if (use_lock) {
+			status = pthread_mutex_unlock(&spawn_mutex);
+			if (status)
+				fatal(status);
+		}
 		pthread_sigmask(SIG_SETMASK, &oldsig, NULL);
-#ifdef ENABLE_MOUNT_LOCKING
-		spawn_unlock(&use_lock);
-#endif
 		pthread_setcancelstate(cancel_state, NULL);
 
 		return status;
@@ -205,7 +216,7 @@ #endif
 
 int spawnv(logger *log, const char *prog, const char *const *argv)
 {
-	return do_spawn(log, 0, prog, argv);
+	return do_spawn(log, SPAWN_OPT_NONE, prog, argv);
 }
 
 int spawnl(logger *log, const char *prog, ...)
@@ -226,28 +237,114 @@ int spawnl(logger *log, const char *prog
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(log, 0, prog, (const char **) argv);
+	return do_spawn(log, SPAWN_OPT_NONE, prog, (const char **) argv);
 }
 
+int spawn_mount(logger *log, ...)
+{
+	va_list arg;
+	int argc;
+	char **argv, **p;
+	char prog[] = PATH_MOUNT;
+	char arg0[] = PATH_MOUNT;
+	unsigned int options;
+
+	/* If we use mount locking we can't validate the location */
 #ifdef ENABLE_MOUNT_LOCKING
-int spawnll(logger *log, const char *prog, ...)
+	options = SPAWN_OPT_LOCK;
+#else
+	options = SPAWN_OPT_NONE;
+#endif
+
+	va_start(arg, log);
+	for (argc = 1; va_arg(arg, char *); argc++);
+	va_end(arg);
+
+	if (!(argv = alloca(sizeof(char *) * argc + 1)))
+		return -1;
+
+	argv[0] = arg0;
+
+	va_start(arg, log);
+	p = argv + 1;
+	while ((*p++ = va_arg(arg, char *)));
+	va_end(arg);
+
+	return do_spawn(log, options, prog, (const char **) argv);
+}
+
+/*
+ * For bind mounts that depend on the target being mounted (possibly
+ * itself an automount) we attempt to mount the target using an opendir
+ * call. For this to work the location must be the second last arg.
+ *
+ * NOTE: If mount locking is enabled this type of recursive mount cannot
+ *	 work.
+ */
+int spawn_bind_mount(logger *log, ...)
 {
 	va_list arg;
 	int argc;
 	char **argv, **p;
+	char prog[] = PATH_MOUNT;
+	char arg0[] = PATH_MOUNT;
+	char bind[] = "--bind";
+	unsigned int options;
 
-	va_start(arg, prog);
+	/* If we use mount locking we can't validate the location */
+#ifdef ENABLE_MOUNT_LOCKING
+	options = SPAWN_OPT_LOCK;
+#else
+	options = SPAWN_OPT_OPENDIR;
+#endif
+
+	va_start(arg, log);
 	for (argc = 1; va_arg(arg, char *); argc++);
 	va_end(arg);
 
-	if (!(argv = alloca(sizeof(char *) * argc)))
+	if (!(argv = alloca(sizeof(char *) * argc + 2)))
 		return -1;
 
-	va_start(arg, prog);
-	p = argv;
+	argv[0] = arg0;
+	argv[1] = bind;
+
+	va_start(arg, log);
+	p = argv + 2;
 	while ((*p++ = va_arg(arg, char *)));
 	va_end(arg);
 
-	return do_spawn(log, 1, prog, (const char **) argv);
+	return do_spawn(log, options, prog, (const char **) argv);
 }
+
+int spawn_umount(logger *log, ...)
+{
+	va_list arg;
+	int argc;
+	char **argv, **p;
+	char prog[] = PATH_UMOUNT;
+	char arg0[] = PATH_UMOUNT;
+	unsigned int options;
+
+#ifdef ENABLE_MOUNT_LOCKING
+	options = SPAWN_OPT_LOCK;
+#else
+	options = SPAWN_OPT_NONE;
 #endif
+
+	va_start(arg, log);
+	for (argc = 1; va_arg(arg, char *); argc++);
+	va_end(arg);
+
+	if (!(argv = alloca(sizeof(char *) * argc + 1)))
+		return -1;
+
+	argv[0] = arg0;
+
+	va_start(arg, log);
+	p = argv + 1;
+	while ((*p++ = va_arg(arg, char *)));
+	va_end(arg);
+
+	return do_spawn(log, options, prog, (const char **) argv);
+}
+
diff --git a/include/automount.h b/include/automount.h
index 1f4fc6b..9c2de00 100644
--- a/include/automount.h
+++ b/include/automount.h
@@ -195,12 +195,10 @@ inline void dump_core(void);
 int aquire_lock(void);
 void release_lock(void);
 int spawnl(logger *log, const char *prog, ...);
-#ifdef ENABLE_MOUNT_LOCKING
-int spawnll(logger *log, const char *prog, ...);
-#else
-#define spawnll	spawnl
-#endif
 int spawnv(logger *log, const char *prog, const char *const *argv);
+int spawn_mount(logger *log, ...);
+int spawn_bind_mount(logger *log, ...);
+int spawn_umount(logger *log, ...);
 void reset_signals(void);
 int do_mount(struct autofs_point *ap, const char *root, const char *name,
 	     int name_len, const char *what, const char *fstype,
diff --git a/lib/parse_subs.c b/lib/parse_subs.c
index b584250..a6a6f18 100644
--- a/lib/parse_subs.c
+++ b/lib/parse_subs.c
@@ -304,9 +304,9 @@ int umount_ent(struct autofs_point *ap, 
 	 * and EBADSLT relates to CD changer not responding.
 	 */
 	if (!status && (S_ISDIR(st.st_mode) && st.st_dev != ap->dev)) {
-		rv = spawnll(log_debug, PATH_UMOUNT, PATH_UMOUNT, path, NULL);
+		rv = spawn_mount(log_debug, path, NULL);
 	} else if (is_smbfs && (sav_errno == EIO || sav_errno == EBADSLT)) {
-		rv = spawnll(log_debug, PATH_UMOUNT, PATH_UMOUNT, path, NULL);
+		rv = spawn_umount(log_debug, path, NULL);
 	}
 
 	/* We are doing a forced shutcwdown down so unlink busy mounts */
@@ -324,7 +324,7 @@ int umount_ent(struct autofs_point *ap, 
 
 		if (ap->state == ST_SHUTDOWN_FORCE) {
 			msg("forcing umount of %s", path);
-			rv = spawnll(log_debug, PATH_UMOUNT, PATH_UMOUNT, "-l", path, NULL);
+			rv = spawn_umount(log_debug, "-l", path, NULL);
 		}
 
 		/*
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 96ca29b..1cdb1c6 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -56,9 +56,7 @@ int mount_init(void **context)
 	if (lstat(tmp1, &st1) == -1)
 		goto out;
 
-	err = spawnl(log_debug,
-	    	     PATH_MOUNT, PATH_MOUNT, "-n", "--bind", tmp1, tmp2, NULL);
-
+	err = spawn_mount(log_debug, "-n", "--bind", tmp1, tmp2, NULL);
 	if (err == 0 &&
 	    lstat(tmp2, &st2) == 0 &&
 	    st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino) {
@@ -67,8 +65,7 @@ int mount_init(void **context)
 
 	debug(LOGOPT_NONE, MODPREFIX "bind_works = %d", bind_works);
 
-	spawnl(log_debug,
-	       PATH_UMOUNT, PATH_UMOUNT, "-n", tmp2, NULL);
+	spawn_umount(log_debug, "-n", tmp2, NULL);
 
       out:
 	rmdir(tmp2);
@@ -149,10 +146,8 @@ int mount_mount(struct autofs_point *ap,
 		      "calling mount --bind " SLOPPY " -o %s %s %s",
 		      options, what, fullpath);
 
-		err = spawnll(log_debug,
-			     PATH_MOUNT, PATH_MOUNT, "--bind",
-			     SLOPPYOPT "-o", options,
-			     what, fullpath, NULL);
+		err = spawn_bind_mount(log_debug,
+			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 
 		if (err) {
 			if (ap->type != LKP_INDIRECT)
diff --git a/modules/mount_changer.c b/modules/mount_changer.c
index eb29c8c..b817d36 100644
--- a/modules/mount_changer.c
+++ b/modules/mount_changer.c
@@ -80,8 +80,7 @@ int mount_mount(struct autofs_point *ap,
 
 	debug(ap->logopt, MODPREFIX "calling umount %s", what);
 
-	err = spawnll(log_debug,
-		     PATH_UMOUNT, PATH_UMOUNT, what, NULL);
+	err = spawn_umount(log_debug, what, NULL);
 	if (err) {
 		error(ap->logopt,
 		      MODPREFIX
@@ -116,16 +115,14 @@ int mount_mount(struct autofs_point *ap,
 		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
 
-		err = spawnll(log_debug,
-			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
+		err = spawn_mount(log_debug, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
 
-		err = spawnll(log_debug, PATH_MOUNT, PATH_MOUNT,
-			     "-t", fstype, what, fullpath, NULL);
+		err = spawn_mount(log_debug, "-t", fstype, what, fullpath, NULL);
 	}
 
 	if (err) {
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index 7774adf..45f0615 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -132,16 +132,13 @@ #endif
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
-		err = spawnll(log_debug,
-		             PATH_MOUNT, PATH_MOUNT, "-t", fstype,
+		err = spawn_mount(log_debug, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(log_debug,
-			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
-			     what, fullpath, NULL);
+		err = spawn_mount(log_debug, "-t", fstype, what, fullpath, NULL);
 	}
 
 	if (err) {
diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index ad726e7..1f43baa 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -93,15 +93,12 @@ int mount_mount(struct autofs_point *ap,
 		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
 		      fstype, options, what, fullpath);
 
-		err = spawnll(log_debug,
-			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
+		err = spawn_mount(log_debug, "-t", fstype,
 			     SLOPPYOPT "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt, MODPREFIX "calling mount -t %s %s %s",
 		      fstype, what, fullpath);
-		err = spawnll(log_debug,
-			     PATH_MOUNT, PATH_MOUNT, "-t", fstype,
-			     what, fullpath, NULL);
+		err = spawn_mount(log_debug, "-t", fstype, what, fullpath, NULL);
 	}
 
 	if (err) {
diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 8b4ddac..55e4f98 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -225,17 +225,15 @@ int mount_mount(struct autofs_point *ap,
 			      MODPREFIX "calling mount -t nfs " SLOPPY 
 			      "-o %s %s %s", nfsoptions, loc, fullpath);
 
-			err = spawnll(log_debug,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", SLOPPYOPT "-o", nfsoptions,
-				     loc, fullpath, NULL);
+			err = spawn_mount(log_debug,
+					  "-t", "nfs", SLOPPYOPT "-o",
+					  nfsoptions, loc, fullpath, NULL);
 		} else {
 			debug(ap->logopt,
 			      MODPREFIX "calling mount -t nfs %s %s",
 			      loc, fullpath);
-			err = spawnll(log_debug,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", loc, fullpath, NULL);
+			err = spawn_mount(log_debug,
+					  "-t", "nfs", loc, fullpath, NULL);
 		}
 
 		if (!err) {
