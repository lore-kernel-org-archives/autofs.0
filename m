From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/13] autofs - update fs/autofs4/Kconfig
Date: Mon, 03 Nov 2014 16:13:11 +0800
Message-ID: <20141103081311.6215.40881.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=ebNZHeQ9/CLOcG/jszGzxSYKPgw=; b=S9ojjrZublILdmtKI0
	usRexLwe4L/0vkOW8XaPTic1n2R+E75OD8rg3cY8gLNSTso44X2WWRh4pxTwLAE5
	qGX6MxJPu643v/uh/IKqIK4LpQnLMKiv//W2y5MYJu4E6WnGAmip8nOqwJc58o+R
	rPih4ngFT67pHkWTPAhzHQJt0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=ebNZHeQ9/CLOcG/jszGzxS
	YKPgw=; b=I+C0LzdGoE4t2Dm+t/i1GLmgWk3GeYe1C5d2ih34rg3UPbGFCLMB5d
	8UjVHwpGDEbeVrr/nTh6sg3cTpCfA7LWhbNqmfP9laUUCG0wx86c5Nxa31ih3D2b
	P/hcSQM058D6N6c04iLEVOVSt5sP9tRmklF4sL75+t1uOTABUuYkM=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 1204d63..26dbb00 100644
--- a/fs/autofs4/Kconfig
+++ b/fs/autofs4/Kconfig
@@ -1,5 +1,6 @@
 config AUTOFS4_FS
-	tristate "Kernel automounter version 4 support (also supports v3)"
+	tristate "Kernel automounter support (supports v3, v4 and v5)"
+	depends on AUTOFS_FS = n
 	help
 	  The automounter is a tool to automatically mount remote file systems
 	  on demand. This implementation is partially kernel-based to reduce
@@ -7,14 +8,25 @@ config AUTOFS4_FS
 	  automounter (amd), which is a pure user space daemon.
 
 	  To use the automounter you need the user-space tools from
-	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/>; you also
-	  want to answer Y to "NFS file system support", below.
+	  <ftp://ftp.kernel.org/pub/linux/daemons/autofs/>; you also want
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
+	  will be removed two kernel version from the inclusion of this
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

