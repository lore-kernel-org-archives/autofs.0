From: joe@perches.com
Subject: [PATCH] [277/2many] MAINTAINERS - KERNEL AUTOMOUNTER v4 (AUTOFS4)
Date: Sun, 12 Aug 2007 23:30:41 -0700
Message-ID: <46bffa91.mhwtn3owiJ9Kj9Zh%joe@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966104AbXHMI5d@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: torvalds@linux-foundation.org, raven@themaw.net, linux-kernel@vger.kernel.org, autofs@linux.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index dc0823d..fc719d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2648,6 +2648,7 @@ P:	Ian Kent
 M:	raven@themaw.net
 L:	autofs@linux.kernel.org
 S:	Maintained
+F:	fs/autofs4/
 
 KERNEL BUILD (kbuild: Makefile, scripts/Makefile.*)
 P:	Kai Germaschewski
