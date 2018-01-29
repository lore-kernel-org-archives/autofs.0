From: NeilBrown <neilb@suse.com>
Subject: [PATCH 3/3] Makefiles.rules: remove 'samples' from SUBDIRS
Date: Mon, 29 Jan 2018 18:19:54 +1100
Message-ID: <151721039461.27355.7072582190975559727.stgit@noble>
References: <151721021295.27355.1968703903360394469.stgit@noble>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <151721021295.27355.1968703903360394469.stgit@noble>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org

The rules in Makefile make it quite clear that
'samples' is not expected to be part of SUBDIRS.
e.g.
 - The rule for "clean" handles both $(SUBDIRS) *and* samples.
 - There are separate "install" and "install_samples" targets.

However SUBDIRS does contain 'samples'.  This means that
a simple "make; make install" will over-write your configuration files.

So remove 'samples' from SUBDIRS.  Note that it has been removed in
the past, but then got added back again.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 Makefile.rules |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.rules b/Makefile.rules
index 0edf9bfe2194..267758e0f94c 100644
--- a/Makefile.rules
+++ b/Makefile.rules
@@ -3,7 +3,7 @@
 #
 
 # Root directory contents
-SUBDIRS = lib daemon modules man samples
+SUBDIRS = lib daemon modules man
 INCDIRS = include
 INCFILES = COPYING COPYRIGHT NEWS README* TODO Makefile Makefile.rules \
 	   Makefile.conf.in .version .autofs-* configure.in aclocal.m4 \


--
To unsubscribe from this list: send the line "unsubscribe autofs" in
