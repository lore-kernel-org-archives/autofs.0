From: Chris Feist <cfeist@redhat.com>
Subject: [PATCH] No-rmdir-patch
Date: Mon, 24 Jan 2005 11:35:47 -0600
Message-ID: <41F531F3.2040509@redhat.com>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030507020706010006000907"
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------030507020706010006000907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When you specify a directory where a map will be mounted in auto.master, 
if it does not exist, autofs will create it upon startup and remove the 
directory when it shuts down.  However, if the directory already exists, 
autofs will still remove it when you shut down.  I've attached a patch 
to autofs-4.1.3 which will prevent autofs from removing previously 
exisiting directories.

If you have any questions, let me know!

Thanks,
Chris




--------------030507020706010006000907
Content-Type: text/plain;
 name="no-rmdir-patch-vanilla"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-rmdir-patch-vanilla"

--- autofs-4.1.3/daemon/automount.c.orig	2004-04-05 08:14:10.000000000 -0500
+++ autofs-4.1.3/daemon/automount.c	2005-01-24 11:30:37.013417216 -0600
@@ -426,9 +426,17 @@ static int mount_autofs(char *path)
 	ap.pipefd = ap.ioctlfd = -1;
 
 	/* In case the directory doesn't exist, try to mkdir it */
-	if (mkdir_path(path, 0555) < 0 && errno != EEXIST && errno != EROFS) {
-		crit("failed to create iautofs directory %s", ap.path);
-		return -1;
+	if (mkdir_path(path, 0555) < 0) {
+		if (errno != EEXIST && errno != EROFS) {
+			crit("failed to create iautofs directory %s", ap.path);
+			return -1;
+		}
+		/* If we recieve an error, and it's EEXIST or EROFS we know
+		   the directory was not created. */
+		ap.dir_created = 0;
+	} else {
+		/* No errors so the directory was successfully created */
+		ap.dir_created = 1;
 	}
 
 	/* Pipe for kernel communications */
@@ -1341,7 +1349,7 @@ static void cleanup_exit(const char *pat
 
 	closelog();
 
-	if ((!ap.ghost || !submount) && *(path + 1) != '-')
+	if ((!ap.ghost || !submount) && (*(path + 1) != '-') && ap.dir_created)
 		if (rmdir(path) == -1)
 			warn("failed to remove dir %s: %m", path);
 
@@ -1664,6 +1672,7 @@ int main(int argc, char *argv[])
 	ap.exp_timeout = DEFAULT_TIMEOUT;
 	ap.ghost = DEFAULT_GHOST_MODE;
 	ap.type = LKP_INDIRECT;
+	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
 	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
--- autofs-4.1.3/include/automount.h.orig	2004-05-18 07:20:08.000000000 -0500
+++ autofs-4.1.3/include/automount.h	2005-01-24 11:30:37.014417200 -0600
@@ -111,6 +111,8 @@ struct autofs_point {
 	struct lookup_mod *lookup;		/* Lookup module */
 	enum states state;
 	int state_pipe[2];
+	unsigned dir_created;		/* Was a directory created for this
+					   mount? */
 };
 
 /* Standard function used by daemon or modules */

--------------030507020706010006000907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------030507020706010006000907--

