From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/10] autofs - update fs/autofs4/Kconfig
Date: Mon, 14 May 2018 11:04:21 +0800
Message-ID: <152626706133.28589.11994171621899212952.stgit@pluto.themaw.net>
References: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152626703024.28589.9571964661718767929.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Update Kconfig and add a depricated warning.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Kconfig |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 44727bf18297..53bc592a250d 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,5 +1,6 @@
 config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
+	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
+	default n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -7,14 +8,25 @@ config AUTOFS4_FS
 	  automounter (amd), which is a pure user space daemon.
 
 	  To use the automounter you need the user-space tools from
-	  <https://www.kernel.org/pub/linux/daemons/autofs/v4/>; you also
-	  want to answer Y to "NFS file system support", below.
+	  <https://www.kernel.org/pub/linux/daemons/autofs/>; you also want
+	  to answer Y to "NFS file system support", below.
 
-	  To compile this support as a module, choose M here: the module will be
-	  called autofs4.  You will need to add "alias autofs autofs4" to your
-	  modules configuration file.
+	  This module is in the process of being renamed from autofs4 to
+	  autofs. Since autofs is now the only module that provides the
+	  autofs file system the module is not version 4 specific.
 
-	  If you are not a part of a fairly large, distributed network or
-	  don't have a laptop which needs to dynamically reconfigure to the
-	  local network, you probably do not need an automounter, and can say
-	  N here.
+	  The autofs4 module is now built from the source located in
+	  fs/autofs. The autofs4 directory and its configuration entry
+	  will be removed two kernel versions from the inclusion of this
+	  change.
+
+	  Changes that will need to be made should be limited to:
+	  - source include statments should be changed from autofs_fs4.h to
+	    autofs_fs.h since these two header files have been merged.
+	  - user space scripts that manually load autofs4.ko should be
+	    changed to load autofs.ko. But since the module directory name
+	    and the module name are the same as the file system name there
+	    is no need to manually load module.
+	  - any "alias autofs autofs4" will need to be removed.
+
+	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.

