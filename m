From: raven@themaw.net
Subject: [PATCH] continued difficulties with the replicated server code
Date: Thu, 6 May 2004 23:41:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405062317100.16711@donald.themaw.net>
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
Cc: James Pearson <james-p@moving-picture.com>, "Rigler, Steve" <SRigler@MarathonOil.com>


Hi all,

He's yet another update to the replicated server code.
As previously it replaces the last so back it out first.

I've had reports of mounts not happening when they should. It seems that 
the rpc discovery needs more work. It is fairly simple minded as it is 
atm.

However, this shouldn't have changed the behaviour of mounts that are not 
of the replicated server form. It did. I've changed that with this patch 
so entries in the usual form should now be attempted regardles. The 
check for "localness" still applies. The expected behaviour. Of course if 
"mount" fails, then it fails as usual.

So for those not completely feed up with testing this the behaviour you 
should expect to see is:

1) normal behaviour for normal mounts. If mount hangs, it hangs, still.
2) Replicated server formats understood:
   a) host1, host2, ...:/mount/point
   b) host1(m),host2(n),host3,...:/mount/point
   c) any combination of above as multiple locations.
     host(n),...:/mount/one host:/mount/two host,host:/mount/three

diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/mount_bind.c autofs-4.1.3/modules/mount_bind.c
--- autofs-4.1.3.orig/modules/mount_bind.c	2004-01-30 00:01:22.000000000 +0800
+++ autofs-4.1.3/modules/mount_bind.c	2004-05-04 21:48:13.000000000 +0800
@@ -96,7 +96,12 @@
 		error(MODPREFIX "alloca: %m");
 		return 1;
 	}
-	sprintf(fullpath, "%s/%s", root, name);
+
+	if (name_len)
+		sprintf(fullpath, "%s/%s", root, name);
+	else
+		sprintf(fullpath, "%s", root);
+
 	i = strlen(fullpath);
 	while (--i > 0 && fullpath[i] == '/')
 		fullpath[i] = '\0';
@@ -125,8 +130,8 @@
 		unlink(AUTOFS_LOCK);
 
 		if (err) {
-			if (!ap.ghost || (ap.ghost && !status))
-				rmdir_path(fullpath);
+			if (!ap.ghost && name_len)
+				rmdir_path(name);
 			return 1;
 		} else {
 			debug(MODPREFIX "mounted %s type %s on %s",
diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/mount_changer.c autofs-4.1.3/modules/mount_changer.c
--- autofs-4.1.3.orig/modules/mount_changer.c	2004-03-07 20:17:54.000000000 +0800
+++ autofs-4.1.3/modules/mount_changer.c	2004-05-04 21:48:13.000000000 +0800
@@ -61,7 +61,11 @@
 		error(MODPREFIX "alloca: %m");
 		return 1;
 	}
-	sprintf(fullpath, "%s/%s", root, name);
+
+	if (name_len)
+		sprintf(fullpath, "%s/%s", root, name);
+	else
+		sprintf(fullpath, "%s", root);
 
 	debug(MODPREFIX "calling umount %s", what);
 
@@ -77,7 +81,7 @@
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", name);
+		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
 		return 1;
 	}
 
@@ -105,9 +109,10 @@
 			     "-t", fstype, what, fullpath, NULL);
 	}
 	unlink(AUTOFS_LOCK);
+
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && name_len)
+			rmdir_path(name);
 
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/mount_ext2.c autofs-4.1.3/modules/mount_ext2.c
--- autofs-4.1.3.orig/modules/mount_ext2.c	2004-04-22 22:39:08.000000000 +0800
+++ autofs-4.1.3/modules/mount_ext2.c	2004-05-04 21:48:13.000000000 +0800
@@ -55,12 +55,16 @@
 		error(MODPREFIX "alloca: %m");
 		return 1;
 	}
-	sprintf(fullpath, "%s/%s", root, name);
+
+	if (name_len)
+		sprintf(fullpath, "%s/%s", root, name);
+	else
+		sprintf(fullpath, "%s", root);
 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", name);
+		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
 		return 1;
 	}
 
@@ -116,8 +120,8 @@
 	unlink(AUTOFS_LOCK);
 
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && name_len)
+			rmdir_path(name);
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
 		return 1;
diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/mount_generic.c autofs-4.1.3/modules/mount_generic.c
--- autofs-4.1.3.orig/modules/mount_generic.c	2004-01-30 00:01:22.000000000 +0800
+++ autofs-4.1.3/modules/mount_generic.c	2004-05-04 21:48:13.000000000 +0800
@@ -53,12 +53,16 @@
 		error(MODPREFIX "alloca: %m");
 		return 1;
 	}
-	sprintf(fullpath, "%s/%s", root, name);
+
+	if (name_len)
+		sprintf(fullpath, "%s/%s", root, name);
+	else
+		sprintf(fullpath, "%s", root);
 
 	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
 	if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-		error(MODPREFIX "mkdir_path %s failed: %m", name);
+		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
 		return 1;
 	}
 
@@ -85,8 +89,8 @@
 	unlink(AUTOFS_LOCK);
 
 	if (err) {
-		if (!ap.ghost || (ap.ghost && !status))
-			rmdir_path(fullpath);
+		if (!ap.ghost && name_len)
+			rmdir_path(name);
 
 		error(MODPREFIX "failed to mount %s (type %s) on %s",
 		      what, fstype, fullpath);
diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/mount_nfs.c autofs-4.1.3/modules/mount_nfs.c
--- autofs-4.1.3.orig/modules/mount_nfs.c	2004-04-03 15:14:33.000000000 +0800
+++ autofs-4.1.3/modules/mount_nfs.c	2004-05-06 21:59:17.000000000 +0800
@@ -105,8 +105,6 @@
 	
 	return 1;
 }
-
-
 /*
  * Given a mount string, return (in the same string) the
  * best mount to use based on weight/locality/rpctime
@@ -118,6 +116,7 @@
 {
 	char *p = what;
 	char *winner = NULL;
+	char *is_replicated = NULL;
 	int winner_weight = INT_MAX, local = 0;
 	double winner_time = 0;
 	char *delim;
@@ -129,9 +128,17 @@
 		return -1;
 	}
 
+	/*
+	 * If it's not a replicated server map entry we need
+	 * to only check for a local mount and return the mount
+	 * string
+	 */
+	is_replicated = strpbrk(p, "(,");
+	if (skiplocal)
+		return local;
+
 	while (p && *p) {
 		char *next;
-		int alive = -1;
 
 		p += strspn(p, " \t,");
 		delim = strpbrk(p, "(, \t:");
@@ -187,29 +194,35 @@
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
+		/*
+		 * If it's not local and it's a replicated server map entry
+		 * is it alive
+		 */
+		if (!local && is_replicated && !rpc_ping(p, sec, micros)) {
 			p = next;
 			continue;
 		}
 
-		/* Not local, see if we have a previous 'winner' */
+		/* see if we have a previous 'winner' */
 		if (!winner) {
 			winner = p;
 		}
@@ -237,8 +250,11 @@
 
 	debug(MODPREFIX "winner = %s local = %d", winner, local);
 
-	/* We didn't find a weighted winner or local */
-	if (!local && winner_weight == INT_MAX) {
+	/*
+	 * We didn't find a weighted winner or local and it's a replicated
+	 * server map entry
+	 */
+	if (!local && is_replicated && winner_weight == INT_MAX) {
 		/* We had more than one contender and none responded in time */
 		if (winner_time != 0 && winner_time > 5) {
 			/* We've already tried a longer timeout */
@@ -391,7 +407,11 @@
 		error(MODPREFIX "alloca: %m");
 		return 1;
 	}
-	sprintf(fullpath, "%s/%s", root, name);
+
+	if (name_len)
+		sprintf(fullpath, "%s/%s", root, name);
+	else
+		sprintf(fullpath, "%s", root);
 
 	if (local) {
 		/* Local host -- do a "bind" */
@@ -406,7 +426,7 @@
 
 		debug(MODPREFIX "calling mkdir_path %s", fullpath);
 		if ((status = mkdir_path(fullpath, 0555)) && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", name);
+			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
 			return 1;
 		}
 
@@ -434,8 +454,8 @@
 		unlink(AUTOFS_LOCK);
 
 		if (err) {
-			if (!ap.ghost || (ap.ghost && !status))
-				rmdir_path(fullpath);
+			if (!ap.ghost && name_len)
+				rmdir_path(name);
 			error(MODPREFIX "nfs: mount failure %s on %s",
 			      whatstr, fullpath);
 			return 1;
diff -Nur --exclude modules/lookup_yp.c autofs-4.1.3.orig/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
--- autofs-4.1.3.orig/modules/parse_sun.c	2004-02-03 23:23:21.000000000 +0800
+++ autofs-4.1.3/modules/parse_sun.c	2004-05-04 21:48:13.000000000 +0800
@@ -514,7 +514,6 @@
 }
 
 static int sun_mount(const char *root, const char *name, int namelen,
-		     const char *path, int pathlen,
 		     const char *loc, int loclen, const char *options)
 {
 	char *fstype = "nfs";	/* Default filesystem type */
@@ -565,17 +564,13 @@
 		options = noptions;
 	}
 
-	while (*path == '/') {
-		path++;
-		pathlen--;
+	while (*name == '/') {
+		name++;
+		namelen--;
 	}
 
-	mountpoint = alloca(namelen + pathlen + 2);
-
-	if (pathlen)
-		sprintf(mountpoint, "%.*s/%.*s", namelen, name, pathlen, path);
-	else
-		sprintf(mountpoint, "%.*s", namelen, name);
+	mountpoint = alloca(namelen + 1);
+	sprintf(mountpoint, "%.*s", namelen, name);
 
 	what = alloca(loclen + 1);
 	memcpy(what, loc, loclen);
@@ -615,15 +610,15 @@
 
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
 
@@ -667,6 +662,18 @@
 
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
@@ -705,7 +712,15 @@
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
@@ -723,7 +738,7 @@
 			      "multimount: %.*s on %.*s with options %s",
 			      loclen, loc, pathlen, path, myoptions);
 
-			rv = sun_mount(root, name, name_len, path, pathlen, loc, loclen,
+			rv = sun_mount(multi_root, path, pathlen, loc, loclen,
 				       myoptions);
 			free(path);
 			free(loc);
@@ -739,12 +754,20 @@
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
@@ -763,7 +786,7 @@
 		debug(MODPREFIX "core of entry: options=%s, loc=%.*s",
 		      options, loclen, loc);
 
-		rv = sun_mount(root, name, name_len, "/", 1, loc, loclen, options);
+		rv = sun_mount(root, name, name_len, loc, loclen, options);
 		free(loc);
 		free(options);
 	}
