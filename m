From: Jeff Moyer <jmoyer@redhat.com>
Subject: [autofs4 patch] add a make option to not strip debugging
	symbols
Date: Fri, 03 Nov 2006 18:32:33 -0500
Message-ID: <x49bqno14z2.fsf@segfault.boston.devel.redhat.com>
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
To: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@linux.kernel.org>

Hi, Ian, list,

This patch was posed for v5 and was taken in.  We should do something
similar for v4.  Guillaume noted that the build process is somewhat
unorthodox, so perhaps we should fix it "the right way."  However, I lack
the cycles at the moment.

-Jeff

diff --git a/Makefile.rules b/Makefile.rules
index 99393f6..82ded1f 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -22,10 +22,16 @@ CFLAGS    = -O2 -g -DDEBUG
 LDFLAGS   = -g
 STRIP     = :
 else
+ifdef DONTSTRIP
+CFLAGS    = -O2 -g
+LDFLAGS   = -g
+STRIP     = :
+else # normal compile
 CFLAGS    = -O3 -fomit-frame-pointer -Wall
 LDFLAGS   = -s
 STRIP     = strip --strip-debug
-endif
+endif # DONTSTRIP
+endif # DEBUG
 
 CC        = gcc
 CXX       = g++
