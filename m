From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] autofs 4.1.4 no-unlink patch
Date: Mon, 11 Jul 2005 14:43:02 -0500
Message-ID: <42D2CBC6.200@redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070408020101080807050006"
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
To: autofs@linux.kernel.org, Ian McLeod <imcleod@redhat.com>

This is a multi-part message in MIME format.
--------------070408020101080807050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian,

We've been hearing some reports of autofs removing entire home directories 
when mounts expire.  It appears that this could be some sort of race condition 
in the walk_tree code, where when the function starts the directory is 
unmounted and then autofs unlinks files in the the directory that is supposed 
to be umounted.  I've attached a patch to the rm_unwanted_fn which adds some 
additional checks before we unlink anything, and it prevents autofs from 
unlinking files (since I'm pretty sure that autofs never creates a regular 
file).  Let me know what you think.

Thanks,
Chris

--------------070408020101080807050006
Content-Type: text/plain;
 name="autofs-4.1.4-no-unlink-upstream"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autofs-4.1.4-no-unlink-upstream"

--- autofs-4.1.4/daemon/automount.c.no-unlink	2005-07-11 13:28:57.000000000 -0500
+++ autofs-4.1.4/daemon/automount.c	2005-07-11 13:50:46.000000000 -0500
@@ -216,16 +216,38 @@ static int walk_tree(const char *base, i
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
+		crit ("rm_unwanted: unable to stat file, possible race "
+		      "condition.");
+		return 0;
+	}
+
+	if (newst.st_dev != ap.dev) {
+		crit ("rm_unwanted: file %s has the wrong device, possible "
+		      "race condition.",file);
+		return 0;
+	}
+
+	if (S_ISDIR(newst.st_mode)) {
+		if (rmdir(file)) {
+			info ("rm_unwanted: unable to remove directory"
+			      " %s", file);
+			return 0;
+		}
+	} else if (S_ISREG(newst.st_mode)) {
+		crit ("rm_unwanted: attempting to remove files from a mounted "
+		      "directory.");
+		return 0;
+	} else if (S_ISLNK(newst.st_mode) && rmsymlink) {
+		unlink(file);
 	}
 
 	return 1;

--------------070408020101080807050006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------070408020101080807050006--

