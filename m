From: raven@themaw.net
Subject: Please help
Date: Sun, 2 May 2004 22:13:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

The recent post regarding replicated server mounts has caused me a bit of 
work.

Basically, I broke the functionality a bit when I merged the patch I 
received from Michael Blandford.

I believe the included patch fixes this.

Additionally, while fixing it I stumbled on the "BUG: dir already mounted" 
message that has been annoying us for so long.

I think I've fixed that as well. It's only about my third attempt at it 
so I'm not expecting it's final. Maybe third time lucky.

Anyway, since the change is a bit more than straight forward I'd like 
as many people as can to test it out before I commit and release it in 
4.1.3. I've probably broken something else.

The patch:

diff -Nur autofs-4.1.3.orig/modules/mount_bind.c autofs-4.1.3/modules/mount_bind.c
--- autofs-4.1.3.orig/modules/mount_bind.c	2004-01-30 00:01:22.000000000 +0800
+++ autofs-4.1.3/modules/mount_bind.c	2004-05-02 20:47:53.000000000 +0800
@@ -125,8 +125,8 @@
 		unlink(AUTOFS_LOCK);
 
 		if (err) {
-			if (!ap.ghost || (ap.ghost && !status))
-				rmdir_path(fullpath);
+			if (!ap.ghost && !(*name == '/' && strlen(name)))
+				rmdir_path(name);
 			return 1;
 		} else {
 			debug(MODPREFIX "mounted %s type %s on %s",
diff -Nur autofs-4.1.3.orig/modules/mount_changer.c autofs-4.1.3/modules/mount_changer.c
--- autofs-4.1.3.orig/modules/mount_changer.c	2004-03-07 20:17:54.000000000 +0800
+++ autofs-4.1.3/modules/mount_changer.c	2004-05-02 20:50:53.000000000 +0800
@@ -106,8 +106,8 @@
 	}
 	unlink(AUTOFS_LOCK);
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && !(*name == '/' && strlen(name) == 1))
+			rmdir_path(name);
 
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
diff -Nur autofs-4.1.3.orig/modules/mount_ext2.c autofs-4.1.3/modules/mount_ext2.c
--- autofs-4.1.3.orig/modules/mount_ext2.c	2004-04-22 22:39:08.000000000 +0800
+++ autofs-4.1.3/modules/mount_ext2.c	2004-05-02 20:53:00.000000000 +0800
@@ -116,8 +116,8 @@
 	unlink(AUTOFS_LOCK);
 
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && !(*name == '/' && strlen(name) == 1))
+			rmdir_path(name);
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
 		return 1;
diff -Nur autofs-4.1.3.orig/modules/mount_generic.c autofs-4.1.3/modules/mount_generic.c
--- autofs-4.1.3.orig/modules/mount_generic.c	2004-01-30 00:01:22.000000000 +0800
+++ autofs-4.1.3/modules/mount_generic.c	2004-05-02 20:54:10.000000000 +0800
@@ -85,8 +85,8 @@
 	unlink(AUTOFS_LOCK);
 
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && !(*name == '/' && strlen(name) == 1))
+			rmdir_path(name);
 
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
diff -Nur autofs-4.1.3.orig/modules/mount_nfs.c autofs-4.1.3/modules/mount_nfs.c
--- autofs-4.1.3.orig/modules/mount_nfs.c	2004-04-03 15:14:33.000000000 +0800
+++ autofs-4.1.3/modules/mount_nfs.c	2004-05-02 21:11:53.000000000 +0800
@@ -131,7 +131,6 @@
 
 	while (p && *p) {
 		char *next;
-		int alive = -1;
 
 		p += strspn(p, " \t,");
 		delim = strpbrk(p, "(, \t:");
@@ -187,29 +186,32 @@
 			for (haddr = he->h_addr_list; *haddr; haddr++) {
 				local = is_local_addr(p, *haddr, he->h_length);
 
-				if (local < 0) {
-					local = 0;
-					p = next;
-				}
+				if (local < 0)
+					continue;
 
 				if (local) {
-					alive = rpc_ping(p, sec, micros);
-					if (alive) {
-						winner = p;
-						break;
-					}
-					local = 0;
+					winner = p;
+					break;
 				}
 			}
+			
+			if (local < 0) {
+				local = 0;
+				p = next;
+				continue;
+			}
+
+			if (local)
+				break;
 		}
 
-		/* Are we actually alive */
-		if (!alive || (alive < 0 && !rpc_ping(p, sec, micros))) {
+		/* If it's not local is it alive */
+		if (!local && !rpc_ping(p, sec, micros)) {
 			p = next;
 			continue;
 		}
 
-		/* Not local, see if we have a previous 'winner' */
+		/* see if we have a previous 'winner' */
 		if (!winner) {
 			winner = p;
 		}
@@ -434,8 +436,8 @@
 		unlink(AUTOFS_LOCK);
 
 		if (err) {
-			if (!ap.ghost || (ap.ghost && !status))
-				rmdir_path(fullpath);
+			if (!ap.ghost && !(*name == '/' && strlen(name) == 1))
+				rmdir_path(name);
 			error(MODPREFIX "nfs: mount failure %s on %s",
 			      whatstr, fullpath);
 			return 1;
diff -Nur autofs-4.1.3.orig/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
--- autofs-4.1.3.orig/modules/parse_sun.c	2004-02-03 23:23:21.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2004-05-02 20:31:32.000000000 +0800
@@ -615,15 +615,15 @@
 
 /*
  * syntax is:
- *	[-options] location
- *	[-options] [mountpoint [-options] location]...
+ *	[-options] location [location] ...
+ *	[-options] [mountpoint [-options] location [location] ... ]...
  */
 int parse_mount(const char *root, const char *name,
 		int name_len, const char *mapent, void *context)
 {
 	struct parse_context *ctxt = (struct parse_context *) context;
 	char *pmapent, *options;
-	const char *p;
+	const char *p, *q;
 	int mapent_len, rv;
 	int optlen;
 
@@ -667,6 +667,18 @@
 
 	if (*p == '/') {
 		int l;
+		char *multi_root;
+
+		multi_root = alloca(strlen(root) + name_len + 2);
+		if (!multi_root) {
+			error(MODPREFIX "alloca: %m");
+			free(options);
+			return 1;
+		}
+
+		strcpy(multi_root, root);
+		strcat(multi_root, "/");
+		strcat(multi_root, name);
 
 		/* It's a multi-mount; deal with it */
 		do {
@@ -705,7 +717,15 @@
 				} while (*p == '-');
 			}
 
-			loc = dequote(p, l = chunklen(p, 1));
+			q = p;
+			while (*q && *q != '/') {
+				l = chunklen(q, 1);
+				q += l;
+				q = skipspace(q);
+			}
+			l = q - p;
+
+			loc = dequote(p, l);
 			loclen = strlen(loc);
 
 			if (loc == NULL || path == NULL) {
@@ -723,7 +743,7 @@
 			      "multimount: %.*s on %.*s with options %s",
 			      loclen, loc, pathlen, path, myoptions);
 
-			rv = sun_mount(root, name, name_len, path, pathlen, loc, loclen,
+			rv = sun_mount(multi_root, path, pathlen, "/", 1, loc, loclen,
 				       myoptions);
 			free(path);
 			free(loc);
@@ -739,12 +759,20 @@
 	} else {
 		/* Normal (non-multi) entries */
 		char *loc;
-		int loclen;
+		int loclen, l;
 
 		if (*p == ':')
 			p++;	/* Sun escape for entries starting with / */
 
-		loc = dequote(p, chunklen(p, 1));
+		q = p;
+		while (*q) {
+			l = chunklen(q, 1);
+			q += l;
+			q = skipspace(q);
+		}
+		l = q - p;
+
+		loc = dequote(p, l);
 		loclen = strlen(loc);
 
 		if (loc == NULL) {
