From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH 2/5] add --foreground option
Date: Fri, 11 Feb 2005 12:01:43 +0200
Message-ID: <200502111201.43507.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200502111155.33706.vda@port.imtp.ilyichevsk.odessa.ua>
	<200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HKIDCAC2jjam4Bk"
In-Reply-To: <200502111159.50103.vda@port.imtp.ilyichevsk.odessa.ua>
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


--Boundary-00=_HKIDCAC2jjam4Bk
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Add support for running in foreground:

-f --foreground do not daemonize

--
vda

--Boundary-00=_HKIDCAC2jjam4Bk
Content-Type: text/x-diff;
  charset="koi8-r";
  name="414b1.12.fg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="414b1.12.fg.patch"

diff -urpN autofs-4.1.4_beta1_1/daemon/automount.c autofs-4.1.4_beta1_2/daemon/automount.c
--- autofs-4.1.4_beta1_1/daemon/automount.c	Wed Jan 26 15:03:02 2005
+++ autofs-4.1.4_beta1_2/daemon/automount.c	Fri Feb 11 10:49:55 2005
@@ -60,6 +60,7 @@ static int submount = 0;
 
 int do_verbose = 0;		/* Verbose feedback option */
 int do_debug = 0;		/* Enable full debug output */
+int daemonize = 1;		/* Shall we daemonize? */
 
 sigset_t ready_sigs;		/* signals only accepted in ST_READY */
 sigset_t lock_sigs;		/* signals blocked for locking */
@@ -1282,7 +1283,7 @@ static void become_daemon(void)
 	chdir("/");
 
 	/* Detach from foreground process */
-	if (!submount) {
+	if (!submount && daemonize) {
 		pid = fork();
 		if (pid > 0)
 			exit(0);
@@ -1300,7 +1301,7 @@ static void become_daemon(void)
 	my_pid = getpid();
 
 	/* Make our own process group for "magic" reason: processes that share
-	   our pgrp see the raw filesystem behine the magic.  So if we are a 
+	   our pgrp see the raw filesystem behind the magic.  So if we are a 
 	   submount, don't change -- otherwise we won't be able to actually
 	   perform the mount.  A pgrp is also useful for controlling all the
 	   child processes we generate. */
@@ -1321,7 +1322,7 @@ static void become_daemon(void)
 		crit("redirecting file descriptors failed: %m");
 		exit(1);
 	}
-	close(nullfd);
+	if (nullfd > 2) close(nullfd);
 
 	/* Write pid file if requested */
 	if (pid_file) {
@@ -1373,7 +1374,19 @@ static unsigned long getnumopt(char *str
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: %s [options] path map_type [args...]\n", program);
+	fprintf(stderr,
+		"Usage: %s [options] path map_type [args...]\n"
+		"	-h --help	this text\n"
+		"	-p --pid-file f	write process id to file f\n"
+		"	-t --timeout n	auto-unmount in n seconds (0-disable)\n"
+		"	-f --foreground	do not daemonize\n"
+		"	-v --verbose	be verbose\n"
+		"	-d --debug	be even more verbose\n"
+		"	-V --version	print version and exit\n"
+		/* "	-g --ghost	\n" */
+		/* "	--submount	\n" */
+		, program
+	);
 }
 
 static void setup_signals(__sighandler_t event_handler, __sighandler_t cld_handler)
@@ -1660,6 +1673,7 @@ int main(int argc, char *argv[])
 		{"help", 0, 0, 'h'},
 		{"pid-file", 1, 0, 'p'},
 		{"timeout", 1, 0, 't'},
+		{"foreground", 0, 0, 'f'},
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"version", 0, 0, 'V'},
@@ -1677,7 +1691,7 @@ int main(int argc, char *argv[])
 	ap.dir_created = 0; /* We haven't created the main directory yet */
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdVg", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:fvdVg", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1689,6 +1703,10 @@ int main(int argc, char *argv[])
 
 		case 't':
 			ap.exp_timeout = getnumopt(optarg, opt);
+			break;
+
+		case 'f':
+			daemonize = 0;
 			break;
 
 		case 'v':

--Boundary-00=_HKIDCAC2jjam4Bk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_HKIDCAC2jjam4Bk--

