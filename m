From: raven@themaw.net
Subject: configure pie problem
Date: Sun, 9 May 2004 11:46:01 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405091113130.15537@donald.themaw.net>
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
To: Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>


Hi Jeff,

I have a problem on the sparc64 arch where the -pie link fails to produce 
a working executable. This is not detected by the autoconf test.

When you get a chance could you check the following patch an an arch you 
know works please.

Ian

--- autofs-4.1.2/configure.in.orig	2004-05-09 10:31:30.000000000 +0800
+++ autofs-4.1.2/configure.in	2004-05-09 10:59:46.000000000 +0800
@@ -133,11 +133,12 @@
 int main(void) { return 0; }
 EOF
 CFLAGS=-fpie
+LDFLAGS=-pie
 DAEMON_CFLAGS=
 DAEMON_LDFLAGS=
 AC_MSG_CHECKING([whether gcc accepts -fpie])
-AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[int main(void) {return 0;}]])],
-		  [gcc_supports_pie=yes], [gcc_supports_pie=no])
+AC_RUN_IFELSE([AC_LANG_PROGRAM([[]], [[int main(void) {return 0;}]])],
+	      [gcc_supports_pie=yes], [gcc_supports_pie=no])
 AC_MSG_RESULT([$gcc_supports_pie])
 if test $gcc_supports_pie = yes ; then
 	DAEMON_CFLAGS="-fpie"
