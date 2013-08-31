From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/10] autofs - update fs/autofs4/Makefile
Date: Sat, 31 Aug 2013 19:43:07 +0800
Message-ID: <20130831114307.11807.68114.stgit@perseus.themaw.net>
References: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=mesmtp;
	 bh=xvjlPPPMlEsQUumIX9qyF/annWU=; b=AMl7ao4stdZ6tIBESxl+RkX7cSpL
	yCtpNLOa1h121K95zXRSEfVVRPgwqDE0/ip0yUEr54Xz0kq0ryt/HUNLepLoLhUG
	EKcAy7rU0rasSBafwEg7W2j/N1x6vEqHnUaxQjewhDwZpaesbyDd0CQhCLPpr4TC
	XijiT4wrluGgdSY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=xvjlPPPMlEsQUumIX9qyF/
	annWU=; b=GGsNdu5vk58UFWaNxEDoDJNBssTp0CqbXQX73DV4oCHKtMooN5gUBb
	MJISvOj0gEOWGTKWJhzsRZtVZx2CuG+C9DY3PygTGWNNBqVN9hQq5phTNfBlAchu
	RxMdWzMuv3e94wvphPNrcJ3bjk34u+81hahiYpWwqeSLjWsVHNCTY=
In-Reply-To: <20130831114133.11807.35953.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-next@vger.kernel.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Update Makefile to build from source in fs/autofs instead of
fs/autofs4.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/Makefile b/fs/autofs4/Makefile
index a811c1f..417dd72 100644
--- a/fs/autofs4/Makefile
+++ b/fs/autofs4/Makefile
@@ -4,4 +4,6 @@
 
 obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
 
-autofs4-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o
+autofs4-objs := ../autofs/init.o ../autofs/inode.o ../autofs/root.o \
+	../autofs/symlink.o ../autofs/waitq.o ../autofs/expire.o \
+	../autofs/dev-ioctl.o
