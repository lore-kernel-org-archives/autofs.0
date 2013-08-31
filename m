From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/10] autofs - create autofs Kconfig and Makefile
Date: Sat, 31 Aug 2013 19:42:57 +0800
Message-ID: <20130831114256.11807.50167.stgit@perseus.themaw.net>
References: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=QHg+UuOaVkeCWGiSCE+nEdfxyqM=; b=rBF6VT1NlVF6cnDaoSnVRsraMWjz
	hgMA6urA/L+3/W0IAm+kzrTW0H25Lk1DgRmDJ7Gi0odpJ+xwt+a8QZAXNiT9MgSy
	XuoR9AEh5fqsrlLS2GGccjhT7eT80hLd9styQA5rhgsUhuY44Pbbu0qvYX59y+BU
	wP23xvDyDaTi7bg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=QHg+UuOaVkeCWGiSCE+nEd
	fxyqM=; b=bZ3kf+VFzuS17u4f7396Y3G/SlrcbN1kiZs8V1Q6ZJuSmANiYgbONC
	YHULFHD9QGNJjY0/k9dHkDg7jzw3xwo1lcjLnr6hd2/rFgoRUlhpWwZGPBOADzQK
	6vjJf6SAlTRAgK5NY5uAMBw4Dewde/gjuJq1CTJHIqnVLHlKoQ1vY=
In-Reply-To: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-next@vger.kernel.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Create Makefile and Kconfig for autofs module.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/Kconfig         |    1 +
 fs/Makefile        |    1 +
 fs/autofs/Kconfig  |   19 +++++++++++++++++++
 fs/autofs/Makefile |    7 +++++++
 4 files changed, 28 insertions(+)
 create mode 100644 fs/autofs/Kconfig
 create mode 100644 fs/autofs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index c229f82..5c071f3 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -65,6 +65,7 @@ source "fs/notify/Kconfig"
 
 source "fs/quota/Kconfig"
 
+source "fs/autofs/Kconfig"
 source "fs/autofs4/Kconfig"
 source "fs/fuse/Kconfig"
 
diff --git a/fs/Makefile b/fs/Makefile
index 1afa0e0..4bf173a 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_AFFS_FS)		+= affs/
 obj-$(CONFIG_ROMFS_FS)		+= romfs/
 obj-$(CONFIG_QNX4FS_FS)		+= qnx4/
 obj-$(CONFIG_QNX6FS_FS)		+= qnx6/
+obj-$(CONFIG_AUTOFS_FS)		+= autofs/
 obj-$(CONFIG_AUTOFS4_FS)	+= autofs4/
 obj-$(CONFIG_ADFS_FS)		+= adfs/
 obj-$(CONFIG_FUSE_FS)		+= fuse/
diff --git a/fs/autofs/Kconfig b/fs/autofs/Kconfig
new file mode 100644
index 0000000..17f77a6
--- /dev/null
+++ b/fs/autofs/Kconfig
@@ -0,0 +1,19 @@
+config AUTOFS_FS
+	tristate "Kernel automounter support (supports v3, v4 and v5)"
+	help
+	   The automounter is a tool to automatically mount remote file systems
+	   on demand. This implementation is partially kernel-based to reduce
+	   overhead in the already-mounted case; this is unlike the BSD
+	   automounter (amd), which is a pure user space daemon.
+
+	   To use the automounter you need the user-space tools from
+	   <ftp://ftp.kernel.org/pub/linux/daemons/autofs/>; you also want
+	   to answer Y to "NFS file system support", below.
+
+	   To compile this support as a module, choose M here: the module will be
+	   called autofs.
+
+	   If you are not a part of a fairly large, distributed network or
+	   don't have a laptop which needs to dynamically reconfigure to the
+	   local network, you probably do not need an automounter, and can say
+	   N here.
diff --git a/fs/autofs/Makefile b/fs/autofs/Makefile
new file mode 100644
index 0000000..43fedde
--- /dev/null
+++ b/fs/autofs/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the linux autofs-filesystem routines.
+#
+
+obj-$(CONFIG_AUTOFS_FS) += autofs.o
+
+autofs-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o

