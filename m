From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] make autofs understand the -[no]browse option
Date: Mon, 15 Nov 2004 14:47:45 -0500
Message-ID: <16793.2017.226139.516137@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cRo2mxynsa"
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org


--cRo2mxynsa
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: 7bit

Hi, Ian, list,

The patch below makes the Linux automounter a bit more compatibile with the
Sun automounter, by parsing the -[no]browse options, and converting them
into the equivalent --ghost option.

Ian, I've not made this patch against vanilla 4.1.3.  This is the patch
that went into the Red Hat RPM.  I will generate a diff to whatever version
you like, but I didn't want to do extra work since your tree may be quite
different from 4.1.3 at this point.

Please let me know if you want me to rediff this.

Thanks!

Jeff


--cRo2mxynsa
Content-Type: text/plain
Content-Disposition: inline;
	filename="autofs-4.1.3-browse.patch"
Content-Transfer-Encoding: 7bit

--- autofs-4.1.3/modules/mount_autofs.c.b4phro	2004-11-12 14:35:01.000000000 -0500
+++ autofs-4.1.3/modules/mount_autofs.c	2004-11-12 17:41:00.305656112 -0500
@@ -40,7 +40,7 @@ int mount_mount(const char *root, const 
 		void *context)
 {
 	char *fullpath, **argv;
-	int argc, status;
+	int argc, status, ghost = ap.ghost;
 	char *options, *p;
 	pid_t slave, wp;
 	char timeout_opt[30];
@@ -78,10 +78,16 @@ int mount_mount(const char *root, const 
 		return 0;
 	}
 
+	if (strstr(options, "browse")) {
+		if (strstr(options, "nobrowse"))
+			ghost = 0;
+		else
+			ghost = 1;
+	}
 	/* Build our argument vector.  */
 
 	argc = 5;
-	if (ap.ghost)
+	if (ghost)
 		argc++;
 
 	if (do_verbose || do_debug)
@@ -106,8 +112,8 @@ int mount_mount(const char *root, const 
 	argv[argc++] = PATH_AUTOMOUNT;
 	argv[argc++] = "--submount";
 
-	if (ap.ghost)
+	if (ghost)
 		argv[argc++] = "--ghost";
 
 	if (ap.exp_timeout != DEFAULT_TIMEOUT)

--- autofs-4.1.3/samples/rc.autofs.in.b4phro	2004-11-15 13:33:35.408034112 -0500
+++ autofs-4.1.3/samples/rc.autofs.in	2004-11-15 13:33:42.868899888 -0500
@@ -182,7 +182,12 @@ function getmounts()
 		then
 		    startupoptions="$startupoptions --ghost"
 		fi
-
+		# Dont even deal with conflicts between --ghost and [no]browse
+		# Its just insane to configure things like that.
+		if echo "$options" | grep -qE -- '\B-browse\b' ;
+		then
+		    startupoptions="$startupoptions --ghost"
+		fi
 		# Check for verbose
 		if echo "$DAEMONOPTIONS $options" | \
 					grep -qE -- '\B-(v\b|-verbose\b)' ;
@@ -202,7 +207,8 @@ function getmounts()
 		      sed   's/-\(t[^0-9]*\|-timeout\)[ \t=]*\([0-9][0-9]*\)//g' |
 		      sed   's/-\(g\b\|-ghost\b\)//g' |
 		      sed   's/-\(v\b\|-verbose\b\)//g' |
-		      sed   's/-\(d\b\|-debug\b\)//g')"
+		      sed   's/-\(d\b\|-debug\b\)//g' |
+		      sed   's/-\(no\)\?browse\b//g')"
 
 		# Break up the maptype and map, if the map type is specified
 		maptype=`echo $map | cut -f1 -d:`

--cRo2mxynsa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--cRo2mxynsa--

