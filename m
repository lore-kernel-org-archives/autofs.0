From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: configure pie problem
Date: Tue, 11 May 2004 09:17:03 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16544.53839.846016.786437@segfault.boston.redhat.com>
References: <Pine.LNX.4.58.0405091113130.15537@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405091113130.15537@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding configure pie problem; raven@themaw.net adds:

raven> Hi Jeff,

raven> I have a problem on the sparc64 arch where the -pie link fails to
raven> produce a working executable. This is not detected by the autoconf
raven> test.

raven> When you get a chance could you check the following patch an an arch
raven> you know works please.


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

Okay, change that -fpie to -fPIE (at least for sparc, don't think it hurts
if we do this for everyone).  And I just confirmed with Jakub, that it is
better to actually try to run the program:

  <jakub> phro: if you have old glibc on sparc, it will compile and link,
          but not run e.g.

Thanks, Ian,

Jeff
