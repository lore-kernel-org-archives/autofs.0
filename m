From: Hans Deragon <hans@deragon.biz>
Subject: backfstype patch.
Date: Tue, 29 Jun 2004 16:10:43 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E1CCC3.1010809@deragon.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_NTQfMKsAfgYEQuzeDNgvOA)"
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
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_NTQfMKsAfgYEQuzeDNgvOA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Greetings.


   Attached, my patch for supporting backfstype.  If the OS is Linux and cachefs 
is detected, this fs is ignored and no attempt is made to mount a cachefs kernel 
module (none exist).  This way we avoid useless error messages in syslog.

   If mounting the fstype fails or is cachefs, backfstype is then tried.

   It works fine under RHL 9.  Only one file was changed:  parse_sun.c.  The 
changes were made from the 4.1.3 branch.  Changes are very localized and I 
believe they are safe (though code inspection is always desired).

   Please confirm if my patch has been accepted.


Best regards,
Hans Deragon
--
Consultant en informatique/Software Consultant
Deragon Informatique inc.     Open source:
http://www.deragon.biz        http://facil.qc.ca (Promotion du libre)
mailto://hans@deragon.biz     http://autopoweroff.sourceforge.net (Logiciel)

--Boundary_(ID_NTQfMKsAfgYEQuzeDNgvOA)
Content-type: text/plain; name=autofs-4.1.3-backfstype.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=autofs-4.1.3-backfstype.patch

diff -Nur autofs-4.1.3.org/modules/parse_sun.c autofs-4.1.3/modules/parse_sun.c
--- autofs-4.1.3.org/modules/parse_sun.c	2004-05-18 08:22:40.000000000 -0400
+++ autofs-4.1.3/modules/parse_sun.c	2004-06-29 14:54:49.000000000 -0400
@@ -22,7 +22,6 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <syslog.h>
 #include <string.h>
 #include <syslog.h>
 #include <ctype.h>
@@ -516,17 +515,20 @@
 static int sun_mount(const char *root, const char *name, int namelen,
 		     const char *loc, int loclen, const char *options)
 {
-	char *fstype = "nfs";	/* Default filesystem type */
+	char *fstype     = "nfs"; /* Default filesystem type */
+	char *backfstype = "nfs";	/* Default filesystem type */
+	char *curfstype = NULL;
 	int nonstrict = 1;
-	int rv;
+	int rv = -1;
 	char *mountpoint;
 	char *what;
+	char *noptions = NULL;
 
-	if (*options == '\0')
+	if (*options == '\0') {
 		options = NULL;
+  }
 
 	if (options) {
-		char *noptions;
 		const char *comma;
 		char *np;
 		int len = strlen(options) + 1;
@@ -551,6 +553,15 @@
 				fstype = alloca(typelen + 1);
 				memcpy(fstype, cp + 7, typelen);
 				fstype[typelen] = '\0';
+			} else if (strncmp("backfstype=", cp, 11) == 0) {
+				int typelen = comma - (cp + 11);
+				backfstype = alloca(typelen + 1);
+				memcpy(backfstype, cp + 11, typelen);
+				backfstype[typelen] = '\0';
+#if 0
+			} else if (strncmp("cachedir=", cp, 9) == 0) {
+        /* Ignoring cachedir, since cachefs is not supported. */
+#endif
 			} else if (strncmp("strict", cp, 6) == 0) {
 				nonstrict = 0;
 			} else if (strncmp("nonstrict", cp, 9) == 0) {
@@ -589,17 +600,64 @@
 		what[loclen] = '\0';
 	}
 
-	debug(MODPREFIX
-	    "mounting root %s, mountpoint %s, what %s, fstype %s, options %s\n",
-	    root, mountpoint, what, fstype, options);
-
-	if (!strcmp(fstype, "nfs")) {
-		rv = mount_nfs->mount_mount(root, mountpoint, strlen(mountpoint),
-					    what, fstype, options, mount_nfs->context);
-	} else {
-		/* Generic mount routine */
-		rv = do_mount(root, mountpoint, strlen(mountpoint), what, fstype,
-			      options);
+	int index;
+	char *curoptions = NULL;
+	char *start, *end;
+	for (index=0; index<2; index++) {
+		if (index==0)
+			curfstype=fstype;
+		else
+			curfstype=backfstype;
+
+#ifdef __linux__
+		if (!strcmp(curfstype, "cachefs")) {
+			/* cachefs not supported for Linux.  We do not even try because when
+			   we try, mount will complain about the module being absent.  This is
+			   not desired because if backfstype parameter is provided and works,
+			   we sure do not want any error messages reported to syslog. */
+			debug("cachefs not implemented under Linux and thus ignored.");
+			continue;
+		}
+#endif
+
+		if (!strcmp(curfstype, "nfs")) {
+			/* Removing cachedir parameter which is not understood by nfs. */
+			start=strstr(noptions, ",cachedir=");
+			if (start != NULL) {
+				/* cachedir parameter found.  Now removing it. */
+				int noptions_len=strlen(noptions);
+				end=strstr(start+1, ",");
+				curoptions = alloca(noptions_len-(end-start)+1);
+				strncpy(curoptions, noptions, start-noptions);
+				strncpy(curoptions+(start-noptions), end, noptions_len-(end-noptions));
+			} else {
+				/* No cachedir parameter found.  Using noptions as is. */
+				curoptions=noptions;
+			}
+		}
+		else
+			curoptions=noptions;
+
+		/* Updating options for calling function. */
+		options=curoptions;
+
+		debug(MODPREFIX
+				"mounting root %s, mountpoint %s, what %s, fstype %s, options %s\n",
+				root, mountpoint, what, curfstype, curoptions);
+
+		if (!strcmp(curfstype, "nfs")) {
+			rv = mount_nfs->mount_mount(root, mountpoint, strlen(mountpoint),
+			                what, curfstype, curoptions, mount_nfs->context);
+		} else {
+			/* Generic mount routine */
+			rv = do_mount(root, mountpoint, strlen(mountpoint), what, curfstype,
+			              curoptions);
+		}
+
+		if(!rv)
+		{
+			break;
+		}
 	}
 
 	if (nonstrict && rv) {

--Boundary_(ID_NTQfMKsAfgYEQuzeDNgvOA)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary_(ID_NTQfMKsAfgYEQuzeDNgvOA)--

