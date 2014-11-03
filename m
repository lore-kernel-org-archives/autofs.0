From: Ian Kent <raven@themaw.net>
Subject: [PATCH 12/13] autofs - update fs/autofs4/Makefile
Date: Mon, 03 Nov 2014 16:13:16 +0800
Message-ID: <20141103081316.6215.67442.stgit@perseus.themaw.net>
References: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	x-sasl-enc:subject:from:to:cc:date:message-id:in-reply-to
	:references:mime-version:content-type:content-transfer-encoding;
	 s=mesmtp; bh=xvjlPPPMlEsQUumIX9qyF/annWU=; b=IMPUSIue+uSZbgQ38w
	IVSAVzJN4L5AI8zYYcXI0psVB8nP31dr6P0wejIrQ7kKuR9LKQVnDuh5vlh2z1p5
	Q3N26DzGPiDFC6hEzpvU83WPHTdCHbgLY1uEw2uRswmuHCGc5Xat98jx1yRt3bLj
	cXeQSczY5tgcdstpr7CHQBEHc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:subject:from:to:cc:date
	:message-id:in-reply-to:references:mime-version:content-type
	:content-transfer-encoding; s=smtpout; bh=xvjlPPPMlEsQUumIX9qyF/
	annWU=; b=uLI/yCiA4wmaF+5TG+J23KFmEHXjhHtHAshGc64sNhHJbTXaIyFMcO
	kNHCTHmi6Xd15lCb/F702+tgXBMbAbsLf2T+UZMSfk3wfzR+E9Ogyknn2H9f2Qn3
	eK6RAYmqKXSQZhYNVjGpbHSrI5+iAv5gWQbDVCFQlgQ9WwCV/jp7Y=
In-Reply-To: <20141103081218.6215.85903.stgit@perseus.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
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
