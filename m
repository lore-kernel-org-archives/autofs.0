From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
Date: Mon, 21 May 2018 09:04:18 +0800
Message-ID: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
failure.

It isn't possible to unset one if the other is set because it
introduces a circular dependency.

But adding "depends on AUTOFS_FS = n && AUTOFS_FS != m" will make
autofs4 appear under the autofs entry which should call attention
to it. It also results in AUTOFS4_FS being removed from .config
for any setting of AUTOFS_FS except n.

Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
awareness of the change to smooth the transition.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 fs/autofs4/Kconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 53bc592a250d..2c2fdf989f90 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,6 +1,7 @@
 config AUTOFS4_FS
 	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
 	default n
+	depends on AUTOFS_FS = n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -30,3 +31,10 @@ config AUTOFS4_FS
 	  - any "alias autofs autofs4" will need to be removed.
 
 	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
+
+	  NOTE: Since the modules autofs and autofs4 use the same file system
+		type name of "autofs" only one can be built. The "depends"
+		above will result in AUTOFS4_FS not appearing in .config for
+		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
+		appear under the AUTOFS_FS entry otherwise which is intended
+		to draw attention to the module rename change.

