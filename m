From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] try next host in replicated server list if
	first fails
Date: Fri, 03 Nov 2006 11:35:23 -0500
Message-ID: <x4964dw32us.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <ikent@redhat.com>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

This patch, authored by Chris Feist, updates the replicated server code to
handle failures.  Currently, if the host chosen to serve up a directory
gives a mount failure, autofs will not try the next server in the list.
This patch fixes this.

I tested this locally with the following test procedure:

Setup a replicated map in autofs pointing to two hosts.
For example:
in /etc/auto.master:
/misc2 /etc/auto.misc2

in /etc/auto.misc2:
test hosta(1):/mountpoint hostb(2):/mountpoint

Configure nfs on hosta to export /mountpoint only to 127.0.0.1 & configure
nfs on hostb to export /mountpoint to *.

You should be able to run 'ls /misc2/test' and autofs will first attempt to
mount hosta, but get permission denied, and then try to mount hostb and
succeed.


Comments welcome, as always.

-Jeff

diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index 7d46a86..3f9de50 100644
--- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -67,6 +67,53 @@ int mount_init(void **context)
 	return !mount_bind;
 }
 
+int add_bad_host(char ***badhosts_ptr, int *num_badhosts, char *badhost)
+{
+	char *newhost, *colon_loc;
+
+	debug (MODPREFIX "add_bad_host: %s", badhost);
+	(*num_badhosts)++;
+	*badhosts_ptr = realloc(*badhosts_ptr, (*num_badhosts) * sizeof(char *));
+
+	if (*badhosts_ptr == NULL) {
+		(*num_badhosts)--;
+		return 0;
+	}
+
+
+	newhost = strdup(badhost);
+	(*badhosts_ptr)[*num_badhosts-1] = newhost;
+
+	/* Remove directory from string as we only compare hosts */
+	colon_loc = strchr(newhost, ':');
+	if (colon_loc) 
+		*colon_loc = '\0';
+
+	return 1;
+}
+
+int is_bad_host(char *host, char **badhosts, int num_badhosts)
+{
+	int i;
+
+	debug(MODPREFIX "is_bad_host: %s", host);
+	for (i = 0; i < num_badhosts; i++) {
+		if (strcmp(badhosts[i], host) == 0) {
+			debug(MODPREFIX "is_bad_host: %s is bad", host);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+void free_bad_hosts(char **badhosts, int num_badhosts)
+{
+	int i;
+	for (i = 0; i < num_badhosts; i++)
+		free(badhosts[i]);
+	free(badhosts);
+}
+
 int is_local_addr(const char *host, const char *host_addr, int addr_len)
 {
 	struct sockaddr_in src_addr, local_addr;
@@ -166,7 +213,8 @@ int is_local_mount(const char *hostpath)
  *           1 and what = local mount path if local bind,
  *     else  0 and what = remote mount path
  */
-int get_best_mount(char *what, const char *original, int longtimeout)
+int get_best_mount(char *what, const char *original, int longtimeout, char **badhosts,
+	int num_badhosts, int *is_replicated, int skiplocal)
 {
 	char *p = what;
 	char *winner = NULL;
@@ -175,7 +223,6 @@ int get_best_mount(char *what, const cha
 	char *delim, *pstrip;
 	int sec = (longtimeout) ? 10 : 0;
 	int micros = (longtimeout) ? 0 : 100000;
-	int skiplocal = longtimeout; /* clearly local is not available */
 
 	if (!p) {
 		*what = '\0';
@@ -189,15 +236,23 @@ int get_best_mount(char *what, const cha
 	if (!strchr(p, ',') && (strchr(p,':') == strrchr(p,':'))) {
 		int ret;
 
+		*is_replicated = 0;
 		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) {
 			if (!isspace(*pstrip))
 				break;
 			*pstrip = '\0';
 		}
 
+		if (is_bad_host(p, badhosts, num_badhosts)) {
+			*what = '\0';
+			return 0;
+		}
+
 		/* Check if the host is the localhost */
 		ret = is_local_mount(p);
-		if (ret > 0) {
+		if ((ret < 0) || (ret == 0 && skiplocal))
+			*what = '\0';
+		else if (ret > 0) {
 			debug(MODPREFIX "host %s: is localhost", p);
 
 			/* Strip off hostname and ':' */
@@ -208,11 +263,11 @@ int get_best_mount(char *what, const cha
 				what++;
 			}
 			return 1;
-		} else if (ret < 0)
-			*what = '\0';
+		}
 
 		return ret;
-	}
+	} else
+		  *is_replicated = 1;
 
 	while (p && *p) {
 		char *next;
@@ -237,7 +292,10 @@ int get_best_mount(char *what, const cha
 				*delim = '\0';
 				w = atoi(weight);
 
-				alive = rpc_ping(p, sec, micros);
+				if (!is_bad_host(p, badhosts, num_badhosts))
+					alive = rpc_ping(p, sec, micros);
+				else
+					alive = 0;
 				if (w < winner_weight && alive) {
 					winner_weight = w;
 					winner = p;
@@ -266,6 +324,11 @@ int get_best_mount(char *what, const cha
 		} else
 			break;
 
+		if (is_bad_host(p, badhosts, num_badhosts)) {
+			p = next;
+			continue;
+		}
+
 		/* p points to a server, "next is our next parse point */
 		if (!skiplocal) {
 			/* Check if it's localhost */
@@ -336,7 +399,11 @@ int get_best_mount(char *what, const cha
 		/* We had more than one contender and none responded in time */
 		if (winner_time == 0 || winner_time > 500) {
 			/* We've already tried a longer timeout */
-			if (!longtimeout) {
+			if (longtimeout) {
+				/* Just pick the first one. */
+				if (!is_bad_host(what, badhosts, num_badhosts))
+					winner = what;
+			} else {
 				/* Reset string and try again */
 				strcpy(what, original);
 
@@ -345,7 +412,9 @@ int get_best_mount(char *what, const cha
 				      "retrying with longer timeout",
 				      original);
 
-				return get_best_mount(what, original, 1);
+				return get_best_mount(what, original, 1,
+				    		      badhosts, num_badhosts,
+						      is_replicated, 1);
 			}
 		}
 	}
@@ -394,10 +463,14 @@ int mount_mount(const char *root, const 
 {
 	char *colon, *fullpath;
 	char *whatstr;
+	char **badhosts = NULL;
 	char *nfsoptions = NULL;
 	int local, err;
 	int nosymlink = 0;
 	int ro = 0;            /* Set if mount bind should be read-only */
+	int num_badhosts = 0;
+	int is_replicated = 1;
+	int status, existed = 1;
 
 	debug(MODPREFIX "root=%s name=%s what=%s, fstype=%s, options=%s",
 	      root, name, what, fstype, options);
@@ -473,7 +546,8 @@ #endif
 		/* No colon, take this as a bind (local) entry */
 		local = 1;
 	} else if (!nosymlink) {
-		local = get_best_mount(whatstr, what, 0);
+		local = get_best_mount(whatstr, what, 0, badhosts,
+				       num_badhosts, &is_replicated, 0);
 		if (!*whatstr) {
 			warn(MODPREFIX "no host elected");
 			return 1;
@@ -494,62 +568,80 @@ #endif
 
 	if (local) {
 		/* Local host -- do a "bind" */
-
 		const char *bind_options = ro ? "ro" : "";
 
 		debug(MODPREFIX "%s is local, doing bind", name);
 
-		return mount_bind->mount_mount(root, name, name_len,
-					       whatstr, "bind", bind_options,
-					       mount_bind->context);
-	} else {
-		/* Not a local host - do an NFS mount */
-		int status, existed = 1;
+		if (!mount_bind->mount_mount(root, name, name_len,
+					     whatstr, "bind", bind_options,
+					     mount_bind->context))
+			return 0;
+		else if (!is_replicated)
+			return 1;
 
-		debug(MODPREFIX "calling mkdir_path %s", fullpath);
+		strcpy(whatstr, what);
+		get_best_mount(whatstr, what, 0, badhosts,
+			       num_badhosts, &is_replicated, 1);
+	}
 
-		status = mkdir_path(fullpath, 0555);
-		if (status && errno != EEXIST) {
-			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
-			return 1;
-		}
+	/* Not a local host - do an NFS mount */
+	debug(MODPREFIX "calling mkdir_path %s", fullpath);
 
-		if (!status)
-			existed = 0;
+	status = mkdir_path(fullpath, 0555);
+	if (status && errno != EEXIST) {
+		error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
+		return 1;
+	}
 
-		if (is_mounted(_PATH_MOUNTED, fullpath)) {
-			error(MODPREFIX 
-			  "warning: %s is already mounted", fullpath);
-			return 0;
-		}
+	if (!status)
+		existed = 0;
+
+	if (is_mounted(_PATH_MOUNTED, fullpath)) {
+		error(MODPREFIX 
+		      "warning: %s is already mounted", fullpath);
+		return 0;
+	}
 
+	do {
+		aquire_lock();
 		if (nfsoptions && *nfsoptions) {
 			debug(MODPREFIX "calling mount -t nfs " SLOPPY 
 			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
 
 			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", SLOPPYOPT "-o", nfsoptions,
-				     whatstr, fullpath, NULL);
+				      PATH_MOUNT, PATH_MOUNT, "-t",
+				      "nfs", SLOPPYOPT "-o", nfsoptions,
+				      whatstr, fullpath, NULL);
 		} else {
 			debug(MODPREFIX "calling mount -t nfs %s %s",
 			      whatstr, fullpath);
 			err = spawnll(LOG_NOTICE,
-				     PATH_MOUNT, PATH_MOUNT, "-t",
-				     "nfs", whatstr, fullpath, NULL);
+				      PATH_MOUNT, PATH_MOUNT, "-t",
+				      "nfs", whatstr, fullpath, NULL);
 		}
 
+		unlink(AUTOFS_LOCK);
 		if (err) {
-			if ((!ap.ghost && name_len) || !existed)
-				rmdir_path(name);
-
-			error(MODPREFIX "nfs: mount failure %s on %s",
-			      whatstr, fullpath);
-			return 1;
-		} else {
-			debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
-			return 0;
+			add_bad_host(&badhosts, &num_badhosts,
+				     whatstr);
 		}
+	} while (err && strcpy(whatstr, what) && is_replicated &&
+		 !get_best_mount(whatstr, what, 0, badhosts, 
+				 num_badhosts, &is_replicated, 1) &&
+		 (*whatstr != '\0'));
+
+	free_bad_hosts(badhosts, num_badhosts);
+
+	if (err) {
+		if ((!ap.ghost && name_len) || !existed)
+			rmdir_path(name);
+
+		error(MODPREFIX "nfs: mount failure %s on %s",
+		      whatstr, fullpath);
+		return 1;
+	} else {
+		debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
+		return 0;
 	}
 }
