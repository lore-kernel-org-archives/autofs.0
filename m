From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount errors under high load
Date: Fri, 03 Nov 2006 19:15:58 -0500
Message-ID: <x49zmb8ysld.fsf@segfault.boston.devel.redhat.com>
References: <200611032327.kA3NRBRG018474@cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200611032327.kA3NRBRG018474@cs.utexas.edu> (Fletcher Mattox's
	message of "Fri, 3 Nov 2006 15:22:46 -0600")
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
To: Fletcher Mattox <fletcher+autofs@cs.utexas.edu>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] automount errors under high load; "Fletcher Mattox" <fletcher+autofs@cs.utexas.edu> adds:

fletcher> Hi,
fletcher> Under high load (100 mount/sec) automount will fail with either
fletcher> of these error messages from mount.

fletcher>     mount: filer3:/vol/vol2/v2q017: can't read superblock
fletcher>     mount: RPC: Authentication error; why = Client credential too weak

fletcher> I find these error messages suspicious, and do not believe either of
fletcher> them represent the true problem.  I have appended the debug output in
fletcher> case that is useful.  I notice that it seems to try the mount seven
fletcher> times each, before giving up with one of the above errors (usually
fletcher> it is the superblock error).

The mount program performs the retries.  What errors are reported in the
server logs?  This really feels like more of an NFS problem than an autofs
one.

fletcher> I have also noticed corruption of /etc/mtab.  Sometimes static
fletcher> mounts just disappear from it during busy times.  I assume this
fletcher> is some type of race condition where file locking fails.  I do
fletcher> not know if this is the same problem or a different problem, but
fletcher> I thought I would mention it.

I posted one method for fixing that problem to the list some time ago.  The
idea is to simply use /proc/mounts instead aof /etc/mtab.  That way we
avoid the whole lock-file mess.  I've attached the patch, here, but I
didn't try to apply it to 4.1.4, so it may need some massaging.  (I'll post
a proper patch later on, but I have to work through my backlog first.)

I don't think the corruption of /etc/mtab will cause the problems you are
seeing, but I could be wrong.

fletcher> I do not know what causes such a high load of mount requests.
fletcher> But I see them in the accounting files.  Nothing obvious is going
fletcher> on when the errors occur.  They happen for several seconds at a
fletcher> time, 6-8 times per day.

fletcher> The NFS client is ubuntu 6.06 (dapper), kernel 2.6.17.4,
fletcher> automount 4.1.4.  The NFS server is a Network Appliances filer.

-Jeff

--- autofs-4.1.3/daemon/automount.c.orig	2006-05-22 10:55:31.000000000 -0400
+++ autofs-4.1.3/daemon/automount.c	2006-05-22 10:55:43.000000000 -0400
@@ -379,7 +379,7 @@ static int umount_multi(const char *path
 	debug("umount_multi: path=%s incl=%d\n", path, incl);
 
 	wait_for_lock();
-	mtab = setmntent(_PATH_MOUNTED, "r");
+	mtab = setmntent(path_mounted, "r");
 	if (!mtab) {
 		unlink(AUTOFS_LOCK);
 		error("umount_multi: setmntent: %m");
@@ -1886,6 +1886,16 @@ int handle_mounts(char *path)
 	return 0;
 }
 
+void init_path_mounted(void)
+{
+	struct stat st;
+
+	if (stat(PROC_MOUNTS, &st) == 0)
+		path_mounted = PROC_MOUNTS;
+	else
+		path_mounted = _PATH_MOUNTED;
+}
+
 int main(int argc, char *argv[])
 {
 	char *path, *map, *mapfmt;
@@ -1965,6 +1975,8 @@ int main(int argc, char *argv[])
 
 	become_daemon();
 
+	init_path_mounted();
+
 	path = argv[0];
 	map = argv[1];
 	mapargv = (const char **) &argv[2];
--- autofs-4.1.3/include/automount.h.orig	2006-05-22 10:55:31.000000000 -0400
+++ autofs-4.1.3/include/automount.h	2006-05-22 10:55:43.000000000 -0400
@@ -38,6 +38,7 @@
 #endif
 
 #define DEFAULT_TIMEOUT (5*60)			/* 5 minutes */
+#define PROC_MOUNTS	"/proc/mounts"
 #define AUTOFS_LOCK	"/var/lock/autofs"	/* To serialize access to mount */
 #define MOUNTED_LOCK	_PATH_MOUNTED "~"	/* mounts' lock file */
 #define MTAB_NOTUPDATED 0x1000			/* mtab succeded but not updated */
@@ -119,6 +120,7 @@ struct autofs_point {
 };
 
 extern struct autofs_point ap; 
+const char *path_mounted;
 
 /* Standard function used by daemon or modules */
 
--- autofs-4.1.3/lib/cache.c.orig	2006-05-22 10:55:54.000000000 -0400
+++ autofs-4.1.3/lib/cache.c	2006-05-22 10:56:01.000000000 -0400
@@ -475,7 +475,7 @@ int is_mounted(const char *path)
 		return ret;
 
 	wait_for_lock();
-	mtab = setmntent(_PATH_MOUNTED, "r");
+	mtab = setmntent(path_mounted, "r");
 	if (!mtab) {
 		unlink(AUTOFS_LOCK);
 		error("is_mounted: setmntent: %m");
