From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] do extra sanity checking around calls to
 rmdir and unlink
Date: Tue, 23 May 2006 15:50:19 -0400
Message-ID: <x49k68ced1g.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi, Ian,

I've seen a couple of bug reports where autofs would walk into mounted file
systems and start removing files and directories there.  To address this,
I've put together a few patches which try to harden up the code in various
places that could lead to inconsistencies between what is actually mounted
on the system and what the automounter will see.

This is the first patch in the series (well, the second, really; I already
sent the patch that checks the return code for e2fsck properly).  Review
and comments are greatly appreciated.  This applies cleanly to 4.1.4.

Thanks,

Jeff

--- autofs-4.1.3/daemon/automount.c.orig	2006-05-17 16:36:42.000000000 -0400
+++ autofs-4.1.3/daemon/automount.c	2006-05-17 16:37:00.000000000 -0400
@@ -150,6 +150,7 @@ int rmdir_path(const char *path)
 	char *buf = alloca(len + 1);
 	char *cp;
 	int first = 1;
+	struct stat st;
 
 	strcpy(buf, path);
 	cp = buf + len;
@@ -157,10 +158,54 @@ int rmdir_path(const char *path)
 	do {
 		*cp = '\0';
 
-		/* Last element of path may be non-dir;
-		   all others are directories */
-		if (rmdir(buf) == -1 && (!first || unlink(buf) == -1))
+		/*
+		 *  Before removing anything, perform some sanity checks to
+		 *  ensure that we are looking at files in the automount
+		 *  file system.
+		 */
+		memset(&st, 0, sizeof(st));
+		if (lstat(buf, &st) != 0) {
+			crit("rmdir_path: lstat of %s failed.\n", buf);
 			return -1;
+		}
+
+		if (st.st_dev != ap.dev) {
+			crit("rmdir_path: attempt to remove files from a "
+			     "mounted file system!\n");
+			crit("ap.dev == %llu, \"%s\" dev == %llu\n", ap.dev,
+			     buf, st.st_dev);
+			return -1;
+		}
+
+		/*
+		 * Last element of path may be a symbolic link; all others
+		 * are directories (and the last directory element is
+		 * processed first, hence the variable name)
+		 */
+		if (rmdir(buf) == -1) {
+			if (first && errno == ENOTDIR) {
+				/*
+				 *  Ensure that we will only remove
+				 *  symbolic links.
+				 */
+				if (S_ISLNK(st.st_mode)) {
+					if (unlink(buf) == -1)
+						return -1;
+				} else {
+					crit("rmdir_path: file \"%s\" is "
+					     "neither a directory nor a "
+					     "symbolic link.  mode %d\n",
+					     buf, st.st_mode);
+					return -1;
+				}
+			}
+
+			/*
+			 *  If we fail to remove a directory for any reason,
+			 *  we need to return an error.
+			 */
+			return -1;
+		}
 
 		first = 0;
 	} while ((cp = strrchr(buf, '/')) != NULL && cp != buf);
@@ -175,12 +220,16 @@ static int umount_ent(const char *root, 
 	int sav_errno;
 	int is_smbfs = (strcmp(type, "smbfs") == 0);
 	int status;
-	int rv = 0;
+	int rv;
 
 	sprintf(path_buf, "%s/%s", root, name);
-	status =  lstat(path_buf, &st);
+	rv = status = lstat(path_buf, &st);
 	sav_errno = errno;
 
+	if (status < 0)
+		warn("umount_ent: lstat of %s failed with %d\n", path_buf,
+		     status);
+
 	/* EIO appears to correspond to an smb mount that has gone away */
 	if (!status ||
 	    (is_smbfs && (sav_errno == EIO || sav_errno == EBADSLT))) {
@@ -195,6 +244,24 @@ static int umount_ent(const char *root, 
 				    PATH_UMOUNT, PATH_UMOUNT, path_buf, NULL);
 			unlink(AUTOFS_LOCK);
 		}
+
+		/*
+		 * Verify that we actually unmounted the thing.  This is a
+		 * belt and suspenders approach to not eating user data.
+		 * We have seen cases where umount succeeds, but there is
+		 * still a file system mounted on the mount point.  How
+		 * this happens has not yet been determined, but we want to
+		 * make sure to return failure here, if that is the case,
+		 * so that we do not try to call rmdir_path on the
+		 * directory.
+		 */
+		if (!rv && is_mounted(path_buf)) {
+			crit("umount_ent: the umount binary reported that "
+			     "%s was unmounted, but there is still something "
+			     "mounted on this path.\n", path_buf);
+			rv = -1;
+		}
+
 	}
 	return rv;
 }
@@ -277,7 +344,7 @@ static int rm_unwanted_fn(const char *fi
 		}
 	} else if (S_ISREG(newst.st_mode)) {
 		crit ("rm_unwanted: attempting to remove files from a mounted "
-		      "directory.");
+		      "directory.  file %s\n", file);
 		return 0;
 	} else if (S_ISLNK(newst.st_mode) && rmsymlink) {
 		if (unlink(file)) {
