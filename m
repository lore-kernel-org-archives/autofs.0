From: raven@themaw.net
Subject: Re: configure pie problem
Date: Tue, 11 May 2004 22:18:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405112215110.18413@donald.themaw.net>
References: <Pine.LNX.4.58.0405091113130.15537@donald.themaw.net>
 <16544.53839.846016.786437@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16544.53839.846016.786437@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 11 May 2004, Jeff Moyer wrote:

> 
> Okay, change that -fpie to -fPIE (at least for sparc, don't think it hurts
> if we do this for everyone).  And I just confirmed with Jakub, that it is
> better to actually try to run the program:
> 
>   <jakub> phro: if you have old glibc on sparc, it will compile and link,
>           but not run e.g.
> 

This would be the final patch on this issue then, yes.

--- autofs-4.1.3.orig/configure.in	2004-05-02 16:31:40.000000000 +0800
+++ autofs-4.1.3/configure.in	2004-05-11 22:12:59.000000000 +0800
@@ -134,15 +134,16 @@
 cat > pietest.c <<EOF
 int main(void) { return 0; }
 EOF
-CFLAGS=-fpie
+CFLAGS=-fPIE
+LDFLAGS=-pie
 DAEMON_CFLAGS=
 DAEMON_LDFLAGS=
-AC_MSG_CHECKING([whether gcc accepts -fpie])
-AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[int main(void) {return 0;}]])],
-		  [gcc_supports_pie=yes], [gcc_supports_pie=no])
+AC_MSG_CHECKING([whether gcc -fPIE works])
+AC_RUN_IFELSE([AC_LANG_PROGRAM([[]], [[int main(void) {return 0;}]])],
+	      [gcc_supports_pie=yes], [gcc_supports_pie=no])
 AC_MSG_RESULT([$gcc_supports_pie])
 if test $gcc_supports_pie = yes ; then
-	DAEMON_CFLAGS="-fpie"
+	DAEMON_CFLAGS="-fPIE"
 	DAEMON_LDFLAGS="-pie"
 fi
 rm -f pietest.c
