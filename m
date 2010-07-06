From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Making "verbose" mode a little less verbose
Date: Tue, 6 Jul 2010 15:11:15 -0300
Message-ID: <20100706181115.GA23693@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=hyVfFdUG5Dpuo0EWIAxP+ecYk4IpsvI9L/Zy2ilXOSk=;
	b=fDuOJX0PElWFUTHvsdqxlnQZe4pZwpNp10PRcGTEc8eenlyKdVw3DWlFaEdwv5T3dt
	LMSYAQqLkskz4l+Kh2cJTqJ4uwKEZFdy+AIGJRJXgHipvUoTR0XUF5QZzfDWa6eHKFAk
	BshHj1dEoH9IAuy4EWH0Hbb4ZbWse0MeclI9k=
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello AutoFS developers,

I'm trying to improve the usefulness of "verbose" logs for a customer.
The problem they currently face can be summarized as: they need some
messages that are only logged with DEFAULT_LOGGING="verbose" (or debug),
but enabling the verbose mode on busy servers (hundreds of users and
AutoFS mount points) causes a significant traffic increase on their
syslog infrastructure.

My first idea was to introduce a new log level ("normal") and move the
most important messages from "verbose" to "normal", but I realized later
that this would require some redesign to allow some info() messages to
be printed only on "verbose" mode. Since this would be more intrusive,
I decided to go with a simpler proposal: move some "verbose" messages
to "debug" level. Here are some examples of messages that would be
demoted to debug (prefixed with -):

Successful mount:

  14:49:13 n1 automount[1013]: attempting to mount entry /v/temp
 -14:49:13 n1 automount[1013]: mount(nfs): mounted libre:/temp on /v/temp
  14:49:13 n1 automount[1013]: mounted /v/temp

Invalid map:

  14:51:15 n1 automount[1013]: attempting to mount entry /v/no
 -14:51:15 n1 automount[1013]: key "no" not found in map source(s).
  14:51:15 n1 automount[1013]: failed to mount /v/no

Expiring mount:

  15:00:23 lotus automount[1013]: expiring path /v/temp
 -15:00:23 lotus automount[1013]: unmounting dir = /v/temp
  15:00:23 lotus automount[1013]: expired /v/temp

Please, could you consider the patch below for upstream inclusion?

Thanks,
Leonardo

Index: autofs/daemon/lookup.c
===================================================================
--- autofs.orig/daemon/lookup.c
+++ autofs/daemon/lookup.c
@@ -688,7 +688,7 @@ static int lookup_name_file_source_insta
 	char *type, *format;
 
 	if (stat(map->argv[0], &st) == -1) {
-		warn(ap->logopt, "file map not found");
+		debug(ap->logopt, "file map not found");
 		return NSS_STATUS_NOTFOUND;
 	}
 
@@ -826,8 +826,8 @@ static void update_negative_cache(struct
 		 */
 		cache_unlock(me->mc);
 	else {
-		/* Notify only once after fail */
-		logmsg("key \"%s\" not found in map source(s).", name);
+		debug(ap->logopt,
+		      "key \"%s\" not found in map source(s).", name);
 
 		/* Doesn't exist in any source, just add it somewhere */
 		if (source)
Index: autofs/daemon/automount.c
===================================================================
--- autofs.orig/daemon/automount.c
+++ autofs/daemon/automount.c
@@ -512,7 +512,7 @@ static int umount_subtree_mounts(struct
 	 * it already to ensure it's ok to remove any offset triggers.
 	 */
 	if (!is_mm_root && is_mounted(_PATH_MOUNTED, path, MNTS_REAL)) {
-		info(ap->logopt, "unmounting dir = %s", path);
+		debug(ap->logopt, "unmounting dir = %s", path);
 		if (umount_ent(ap, path)) {
 			warn(ap->logopt, "could not umount dir %s", path);
 			left++;
Index: autofs/modules/mount_changer.c
===================================================================
--- autofs.orig/modules/mount_changer.c
+++ autofs/modules/mount_changer.c
@@ -129,7 +129,7 @@ int mount_mount(struct autofs_point *ap,
 
 		return 1;
 	} else {
-		info(ap->logopt, MODPREFIX "mounted %s type %s on %s",
+		debug(ap->logopt, MODPREFIX "mounted %s type %s on %s",
 		    what, fstype, fullpath);
 		return 0;
 	}
Index: autofs/modules/mount_ext2.c
===================================================================
--- autofs.orig/modules/mount_ext2.c
+++ autofs/modules/mount_ext2.c
@@ -140,7 +140,7 @@ int mount_mount(struct autofs_point *ap,
 
 		return 1;
 	} else {
-		info(ap->logopt,
+		debug(ap->logopt,
 		      MODPREFIX "mounted %s type %s on %s",
 		      what, fstype, fullpath);
 		return 0;
Index: autofs/modules/mount_generic.c
===================================================================
--- autofs.orig/modules/mount_generic.c
+++ autofs/modules/mount_generic.c
@@ -122,7 +122,7 @@ int mount_mount(struct autofs_point *ap,
 
 		return 1;
 	} else {
-		info(ap->logopt, MODPREFIX "mounted %s type %s on %s",
+		debug(ap->logopt, MODPREFIX "mounted %s type %s on %s",
 		     loc, fstype, fullpath);
 		free(loc);
 		return 0;
Index: autofs/modules/mount_nfs.c
===================================================================
--- autofs.orig/modules/mount_nfs.c
+++ autofs/modules/mount_nfs.c
@@ -251,7 +251,7 @@ int mount_mount(struct autofs_point *ap,
 		}
 
 		if (!err) {
-			info(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
+			debug(ap->logopt, MODPREFIX "mounted %s on %s", loc, fullpath);
 			free(loc);
 			free_host_list(&hosts);
 			return 0;
