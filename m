From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs - comment on selinux changes needed for module
 autoload
Date: Mon, 21 May 2018 09:05:41 +0800
Message-ID: <152686474171.6155.1239659539983577463.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Due to the autofs4 module using a file system type name of autofs
different from the module containing directory name autoload did
not function properly. To work around this kernel configurations
have often elected to build the module into the kernel.

This can result in selinux policies that prohibit autoloading of
the autofs module which need to be changed.

Add a comment about this to "possible changes" section of the
autofs4 module help.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Kconfig |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
index 2c2fdf989f90..99fda4d6da25 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -29,6 +29,12 @@ config AUTOFS4_FS
 	    and the module name are the same as the file system name there
 	    is no need to manually load module.
 	  - any "alias autofs autofs4" will need to be removed.
+	  - due to the autofs4 module directory name not being the same as
+	    its file system name autoloading didn't work properly. Because
+	    of this kernel configurations would often build the module into
+	    the kernel. This may have resulted in selinux policies that will
+	    prevent the autofs module from autoloading and will need to be
+	    updated.
 
 	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
 

