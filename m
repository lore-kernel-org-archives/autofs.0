From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: [PATCH] 5.0.0_beta1: add "-s --stderr" option
Date: Wed, 26 Sep 2007 10:51:17 +0100
Message-ID: <200709261051.17951.vda.linux@googlemail.com>
References: <200709261048.48044.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Vui+GaoIiHMewwn"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261048.48044.vda.linux@googlemail.com>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--Boundary-00=_Vui+GaoIiHMewwn
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ian,

I see that almost everything is in place for this to work, only
actual option handling is missing.

I added it and it works (run-tested).

Please apply attached patch
(should apply on top of autofs-5.0.0_beta1-fg.patch).
--
vda

--Boundary-00=_Vui+GaoIiHMewwn
Content-Type: text/x-diff; charset="iso-8859-15";
	name="autofs-5.0.0_beta1-stderr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="autofs-5.0.0_beta1-stderr.patch"

diff -d -urpN autofs-5.0.0_beta1-fg/daemon/automount.c autofs-5.0.0_beta1-stderr/daemon/automount.c
--- autofs-5.0.0_beta1-fg/daemon/automount.c	2007-09-26 10:27:30.000000000 +0100
+++ autofs-5.0.0_beta1-stderr/daemon/automount.c	2007-09-26 10:24:17.000000000 +0100
@@ -719,12 +719,12 @@ static int handle_packet(struct autofs_p
 	return -1;
 }
 
+static unsigned char to_stderr;
 
 static void become_daemon(unsigned foreground)
 {
 	FILE *pidfp;
 	char buf[MAX_ERR_BUF];
-	unsigned to_stderr = 0;
 	pid_t pid;
 
 	/* Don't BUSY any directories unnecessarily */
@@ -1282,6 +1282,7 @@ static void usage(void)
 		"	-v --verbose	be verbose\n"
 		"	-d --debug	log debuging info\n"
 		"	-f --foreground do not fork into background\n"
+		"	-s --stderr	log to stderr instead of syslog\n"
 		"	-V --version	print version and exit\n"
 		, program);
 }
@@ -1302,6 +1303,7 @@ int main(int argc, char *argv[])
 		{"verbose", 0, 0, 'v'},
 		{"debug", 0, 0, 'd'},
 		{"foreground", 0, 0, 'f'},
+		{"stderr", 0, 0, 's'},
 		{"version", 0, 0, 'V'},
 		{0, 0, 0, 0}
 	};
@@ -1318,7 +1320,7 @@ int main(int argc, char *argv[])
 	foreground = 0;
 
 	opterr = 0;
-	while ((opt = getopt_long(argc, argv, "+hp:t:vdfV", long_options, NULL)) != EOF) {
+	while ((opt = getopt_long(argc, argv, "+hp:t:vdfsV", long_options, NULL)) != EOF) {
 		switch (opt) {
 		case 'h':
 			usage();
@@ -1344,6 +1346,10 @@ int main(int argc, char *argv[])
 			foreground = 1;
 			break;
 
+		case 's':
+			to_stderr = 1;
+			break;
+
 		case 'V':
 			printf("Linux automount version %s\n", version);
 			exit(0);

--Boundary-00=_Vui+GaoIiHMewwn
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_Vui+GaoIiHMewwn--

