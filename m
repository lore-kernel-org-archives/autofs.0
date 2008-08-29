From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] fs/Kconfig: move autofs, autofs4 out
Date: Fri, 29 Aug 2008 07:18:29 +0400
Message-ID: <20080829031829.GB10703@x200.localdomain>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=u29YlhfkvEJfnkl5WMFrEVGx0Bfx1AlGZ1dnr27gd2E=;
        b=yG2p/vsteZZncSwD/Tr5mzpFBNUT1CQU3Jzb7lzx2P/ILarupnMCGEcclnMYqxzHj/
         l6WS2FW/IFuw5lJZ0xah0YV1HISF/6G+/MLZoWQNVD6RaDwwCBMCXj5NmPL0TiPHqG6v
         FflriGhwz5DwyjP5f4+aRp1oIW1UdRdxsbIE4=
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@osdl.org
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/Kconfig         |   44 ++------------------------------------------
 fs/autofs/Kconfig  |   21 +++++++++++++++++++++
 fs/autofs4/Kconfig |   20 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 42 deletions(-)

--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -142,48 +142,8 @@ config QUOTACTL
 	depends on XFS_QUOTA || QUOTA
 	default y
 
-config AUTOFS_FS
-	tristate "Kernel automounter support"
-	help
-	  The automounter is a tool to automatically mount remote file systems
-	  on demand. This implementation is partially kernel-based to reduce
-	  overhead in the already-mounted case; this is unlike the BSD
-	  automounter (amd), which is a pure user space daemon.
-
-	  To use the automounter you need the user-space tools from the autofs
-	  package; you can find the location in <file:Documentation/Changes>.
-	  You also want to answer Y to "NFS file system support", below.
-
-	  If you want to use the newer version of the automounter with more
-	  features, say N here and say Y to "Kernel automounter v4 support",
-	  below.
-
-	  To compile this support as a module, choose M here: the module will be
-	  called autofs.
-
-	  If you are not a part of a fairly large, distributed network, you
-	  probably do not need an automounter, and can say N here.
-
-config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
-	help
-	  The automounter is a tool to automatically mount remote file systems
-	  on demand. This implementation is partially kernel-based to reduce
-	  overhead in the already-mounted case; this is unlike the BSD
-	  automounter (amd), which is a pure user space daemon.
-
-	  To use the automounter you need the user-space tools from
-	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/>; you also
-	  want to answer Y to "NFS file system support", below.
-
-	  To compile this support as a module, choose M here: the module will be
-	  called autofs4.  You will need to add "alias autofs autofs4" to your
-	  modules configuration file.
-
-	  If you are not a part of a fairly large, distributed network or
-	  don't have a laptop which needs to dynamically reconfigure to the
-	  local network, you probably do not need an automounter, and can say
-	  N here.
+source "fs/autofs/Kconfig"
+source "fs/autofs4/Kconfig"
 
 config FUSE_FS
 	tristate "Filesystem in Userspace support"
new file mode 100644
--- /dev/null
+++ b/fs/autofs/Kconfig
@@ -0,0 +1,21 @@
+config AUTOFS_FS
+	tristate "Kernel automounter support"
+	help
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case; this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
+
+	  To use the automounter you need the user-space tools from the autofs
+	  package; you can find the location in <file:Documentation/Changes>.
+	  You also want to answer Y to "NFS file system support", below.
+
+	  If you want to use the newer version of the automounter with more
+	  features, say N here and say Y to "Kernel automounter v4 support",
+	  below.
+
+	  To compile this support as a module, choose M here: the module will be
+	  called autofs.
+
+	  If you are not a part of a fairly large, distributed network, you
+	  probably do not need an automounter, and can say N here.
new file mode 100644
--- /dev/null
+++ b/fs/autofs4/Kconfig
@@ -0,0 +1,20 @@
+config AUTOFS4_FS
+	tristate "Kernel automounter version 4 support (also supports v3)"
+	help
+	  The automounter is a tool to automatically mount remote file systems
+	  on demand. This implementation is partially kernel-based to reduce
+	  overhead in the already-mounted case; this is unlike the BSD
+	  automounter (amd), which is a pure user space daemon.
+
+	  To use the automounter you need the user-space tools from
+	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/>; you also
+	  want to answer Y to "NFS file system support", below.
+
+	  To compile this support as a module, choose M here: the module will be
+	  called autofs4.  You will need to add "alias autofs autofs4" to your
+	  modules configuration file.
+
+	  If you are not a part of a fairly large, distributed network or
+	  don't have a laptop which needs to dynamically reconfigure to the
+	  local network, you probably do not need an automounter, and can say
+	  N here.

