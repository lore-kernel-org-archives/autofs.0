From: "Marty Leisner" <leisner@rochester.rr.com>
Subject: autofs 5.0.3 problems
Date: Sun, 20 Jan 2008 22:59:08 -0500
Message-ID: <200801210359.m0L3x8Bs032116@dell2.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-ID: <32113.1200887948.1@dell2.home>
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

I want to build and install autofs 5.0.3 as nonroot
on ubuntu gutsy gibbon.
(other recent systems have autofs5,  ubuntu gutsy gibbon doesn't, 
I'm very pleased that direct mounts work in autofs5 -- I've waited 
for this for years).


I wanted to install all files in /usr/local/autofs-5.0.3

Just doing
./configure --prefix=/usr/local/autofs-5.0.3
didn't do everything I needed.

I had to:

: leisner@gateway 10:45:40;rcsdiff -u Makefile.conf
===================================================================
RCS file: Makefile.conf,v
retrieving revision 1.2
diff -u -r1.2 Makefile.conf
--- Makefile.conf       2008/01/21 00:20:10     1.2
+++ Makefile.conf       2008/01/21 00:20:47
@@ -78,6 +78,8 @@
 sbindir = ${exec_prefix}/sbin

 # Where to install man pages
+# datarootdir is undefined??
+datarootdir=${prefix}/share
 mandir = ${datarootdir}/man

 # Location for init.d files

since datarootdir wasn't defined...
(it should default to ${prefix}/share according to configure).

I had to manually do
make install INSTALLROOT=/usr/local/autofs-5.0.3
to get the man pages to install in the right place.

I also started in the init.d/autofs $DAEMON instead of $prog
(so it prepended the pathname).

The README file mentions a README.options file, I don't see one there.

marty
