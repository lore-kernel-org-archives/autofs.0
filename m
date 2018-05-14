From: Ian Kent <raven@themaw.net>
Subject: [PATCH 06/10] autofs - update fs/autofs4/Makefile
Date: Mon, 14 May 2018 11:04:28 +0800
Message-ID: <152626706824.28589.1915028175544560855.stgit@pluto.themaw.net>
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

Update Makefile to build from source in fs/autofs instead of
fs/autofs4.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/Makefile b/fs/autofs4/Makefile
index a811c1f7d9ab..417dd726d9ef 100644
--- a/fs/autofs4/Makefile
+++ b/fs/autofs4/Makefile
@@ -4,4 +4,6 @@
 
 obj-$(CONFIG_AUTOFS4_FS) += autofs4.o
 
-autofs4-objs := init.o inode.o root.o symlink.o waitq.o expire.o dev-ioctl.o
+autofs4-objs := ../autofs/init.o ../autofs/inode.o ../autofs/root.o \
+	../autofs/symlink.o ../autofs/waitq.o ../autofs/expire.o \
+	../autofs/dev-ioctl.o

