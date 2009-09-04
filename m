From: Jeff Moyer <jmoyer@redhat.com>
Subject: a note on all the patches I just sent
Date: Fri, 04 Sep 2009 15:27:24 -0400
Message-ID: <x491vmmtsrn.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
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

These were a result of running clang against the autofs source tree.
See:
  http://clang-analyzer.llvm.org/

If you want to run this against autofs, you'll have to make the attached
change to Makefile.rules.

Cheers,
Jeff

diff --git a/Makefile.rules b/Makefile.rules
index f2ba386..26da6d8 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -38,7 +38,7 @@ STRIP     = strip --strip-debug
 endif
 endif
 
-CC        = gcc
+# CC        = gcc
 CXX       = g++
 CXXFLAGS  = $(CFLAGS)
 LD        = ld
