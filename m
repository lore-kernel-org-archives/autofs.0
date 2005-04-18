From: Chris Feist <cfeist@redhat.com>
Subject: Re: [daniel@vision.ime.usp.br: Bug#304245: patch - NFS mounts
	occasionally fail]
Date: Mon, 18 Apr 2005 14:44:07 -0500
Message-ID: <42640E07.9080305@redhat.com>
References: <20050417154240.GA17232@uio.no>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020707020807070203080609"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050417154240.GA17232@uio.no>
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.
--------------020707020807070203080609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm currently using the attached patch which should fix this problem. We've 
tested it and it works pretty well (It also fixes a problem with local mounts 
not using --bind).

Thanks,
Chris

Steinar H. Gunderson wrote:
> Hi,
> 
> Thanks for the patch; sending upstream for evaluation.
> 
> /* Steinar */
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs


--------------020707020807070203080609
Content-Type: text/x-patch;
 name="autofs-4.1.4-non-replicated-ping.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="autofs-4.1.4-non-replicated-ping.patch"

--- autofs-4.1.4/modules/mount_nfs.c.orig	2005-04-13 20:31:24.639009544 -0400
+++ autofs-4.1.4/modules/mount_nfs.c	2005-04-13 20:31:40.727563712 -0400
@@ -31,6 +31,7 @@
 #include <netinet/in.h>
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
+#include <ctype.h>
 
 #define MODULE_MOUNT
 #include "automount.h"
@@ -105,28 +106,116 @@ int is_local_addr(const char *host, cons
 	
 	return 1;
 }
+
+/*
+ * If the map doesn't contain a ',' and doesn't contain more than
+ * one ':' then @what is not a multimount entry.
+ */
+static int is_multimount_entry(char *what)
+{
+	return !strchr(what, ',') && (strchr(what, ':') == strrchr(what, ':'));
+}
+
+/*
+ *  Check to see if the 'host:path' or 'host' is on the local machine
+ *  Returns < 0 if there is a host lookup problem, otherwise returns 0
+ *  if it's not a local mount, and returns > 0 if it is a local mount.
+ */
+int is_local_mount(const char *hostpath)
+{
+	struct hostent *he;
+	char **haddr;
+	char *delim;
+	char *hostname;
+	int hostnamelen;
+	int local = 0;
+
+	debug(MODPREFIX "is_local_mount: %s", hostpath);
+	delim = strpbrk(hostpath,":");
+
+	if (delim) 
+		hostnamelen = delim - hostpath; 
+	else 
+		hostnamelen = strlen(hostpath);
+
+	hostname = malloc(hostnamelen+1);
+	strncpy(hostname,hostpath,hostnamelen);
+	hostname[hostnamelen] = '\0';
+	he = gethostbyname(hostname);
+	if (!he) {
+		error(MODPREFIX "host %s: lookup failure", hostname);
+		return -1;
+	}
+
+	for (haddr = he->h_addr_list; *haddr; haddr++) {
+		local = is_local_addr(hostname, *haddr, he->h_length);
+		if (local < 0) 
+			return local;
+ 		if (local) {
+			debug(MODPREFIX "host %s: is localhost",
+					hostname);
+			return local;
+		}
+	}
+	return 0;
+}
+
 /*
  * Given a mount string, return (in the same string) the
- * best mount to use based on weight/locality/rpctime
+ * best mount to use based on locality/weight/rpctime.
+ *
+ * If longtimeout is set to 0 then we only do 100 ms pings to hosts.  In
+ * the event that this fails, we call ourself recursively with the
+ * longtimeout option set to 1.  In this case we ping for up to 10s and
+ * skip logic for detecting if a localhost has been passed. (if a local
+ * host had been passed, we would have returned that mount as the best
+ * mount.  The skipping of local maps in this case is an optimization).
+ *
  * - return -1 and what = '\0' on error,
  *           1 and what = local mount path if local bind,
  *     else  0 and what = remote mount path
  */
-int get_best_mount(char *what, const char *original, int longtimeout, int skiplocal)
+int get_best_mount(char *what, const char *original, int longtimeout)
 {
 	char *p = what;
 	char *winner = NULL;
 	int winner_weight = INT_MAX, local = 0;
 	double winner_time = 0;
-	char *delim;
+	char *delim, *pstrip;
 	int sec = (longtimeout) ? 10 : 0;
 	int micros = (longtimeout) ? 0 : 100000;
+	int skiplocal = longtimeout; /* clearly local is not available */
 
 	if (!p) {
 		*what = '\0';
 		return -1;
 	}
 
+	/*
+	 *  If only one mountpoint has been passed in, we don't need to
+	 *  do anything except strip whitespace from the end of the string.
+	 */
+	if (!is_multimount_entry(p)) {
+		for (pstrip = p+strlen(p) - 1; pstrip >= p; pstrip--) 
+			if (isspace(*pstrip))
+				*pstrip = '\0';
+
+		/* Check if the host is the localhost */
+		if (is_local_mount(p)) {
+			debug(MODPREFIX "host %s: is localhost", p);
+
+			/* Strip off hostname and ':' */
+			delim = strchr(p,':');
+			while (delim && *delim != '\0') {
+				delim++;
+				*what = *delim;
+				what++;
+			}
+			return 1;
+		}
+		return 0;
+	}
+
 	while (p && *p) {
 		char *next;
 		unsigned int ping_stat = 0;
@@ -171,37 +260,17 @@ int get_best_mount(char *what, const cha
 		/* p points to a server, "next is our next parse point */
 		if (!skiplocal) {
 			/* Check if it's localhost */
-			struct hostent *he;
-			char **haddr;
-
-			he = gethostbyname(p);
-			if (!he) {
-				error(MODPREFIX "host %s: lookup failure", p);
-				p = next;
-				continue;
-			}
-
-			/* Check each host in round robin list */
-			for (haddr = he->h_addr_list; *haddr; haddr++) {
-				local = is_local_addr(p, *haddr, he->h_length);
-
-				if (local < 0)
-					continue;
-
-				if (local) {
-					winner = p;
-					break;
-				}
-			}
-			
+			local = is_local_mount(p);
 			if (local < 0) {
 				local = 0;
 				p = next;
 				continue;
 			}
 
-			if (local)
+			if (local) {
+				winner = p;
 				break;
+			}
 		}
 
 		/* ping each (or the) entry to see if it's alive. */
@@ -256,7 +325,7 @@ int get_best_mount(char *what, const cha
 	 */
 	if (!local && winner_weight == INT_MAX) {
 		/* We had more than one contender and none responded in time */
-		if (winner_time != 0 && winner_time > 500) {
+		if (winner_time == 0 || winner_time > 500) {
 			/* We've already tried a longer timeout */
 			if (!longtimeout) {
 				/* Reset string and try again */
@@ -267,7 +336,7 @@ int get_best_mount(char *what, const cha
 				      "retrying with longer timeout",
 				      original);
 
-				return get_best_mount(what, original, 1, 1);
+				return get_best_mount(what, original, 1);
 			}
 		}
 	}
@@ -395,7 +464,7 @@ int mount_mount(const char *root, const 
 		/* No colon, take this as a bind (local) entry */
 		local = 1;
 	} else if (!nosymlink) {
-		local = get_best_mount(whatstr, what, 0, 0);
+		local = get_best_mount(whatstr, what, 0);
 		if (!*whatstr) {
 			warn(MODPREFIX "no host elected");
 			return 1;

--------------020707020807070203080609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------020707020807070203080609--

