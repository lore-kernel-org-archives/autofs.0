From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] try to avoid removing regular files
Date: Wed, 01 Nov 2006 19:20:21 -0500
Message-ID: <x497iye66nu.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi,

There have been cases where broken kernels resulted in autofs removing
regular files on non-autofs file systems.  This should be avoided at all
costs.  This patch adds some paranoia checks to the rm_unwanted_fn.

Comments are welcome.

-Jeff

diff --git a/daemon/automount.c b/daemon/automount.c
index 348b499..eb0cdd3 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -262,16 +262,42 @@ static int walk_tree(const char *base, i
 static int rm_unwanted_fn(const char *file, const struct stat *st, int when, void *arg)
 {
 	int rmsymlink = *(int *) arg;
+	struct stat newst;
 
 	if (when == 0) {
 		if (st->st_dev != ap.dev)
 			return 0;
-	} else {
-		info("rm_unwanted: %s\n", file);
-		if (S_ISDIR(st->st_mode))
-			rmdir(file);
-		else if (!S_ISLNK(st->st_mode) || rmsymlink)
-			unlink(file);
+		return 1;
+	}
+
+	if (lstat(file, &newst)) {
+		crit("rm_unwanted: unable to stat file, possible race "
+		      "condition: %s", strerror(errno));
+		return 0;
+	}
+
+	if (newst.st_dev != ap.dev) {
+		crit("rm_unwanted: file %s has the wrong device, possible "
+		     "race condition.", file);
+		return 0;
+	}
+
+	if (S_ISDIR(newst.st_mode)) {
+		if (rmdir(file)) {
+			info("rm_unwanted: unable to remove directory: "
+			     " %s, error: %s", file, strerror(errno));
+			return 0;
+		}
+	} else if (S_ISREG(newst.st_mode)) {
+		crit ("rm_unwanted: attempting to remove files from a mounted "
+		      "directory.");
+		return 0;
+	} else if (S_ISLNK(newst.st_mode) && rmsymlink) {
+		if (unlink(file)) {
+			crit ("rm_unwanted: unable to remove link: %s, error: "
+			      "%s", file, strerror(errno));
+			return 0;
+		}
 	}
 
 	return 1;
