From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] fs/autofs4/dev-ioctl.c: add __init to
 autofs_dev_ioctl_init
Date: Tue, 22 Apr 2014 21:56:17 +0200
Message-ID: <20140422215617.1646f3bb2fd7d159d268def2@skynet.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>, akpm <akpm@linux-foundation.org>, autofs@vger.kernel.org

autofs_dev_ioctl_init is only called by __init init_autofs4_fs

Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/autofs4/dev-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 232e03d..5b570b6 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -737,7 +737,7 @@ MODULE_ALIAS_MISCDEV(AUTOFS_MINOR);
 MODULE_ALIAS("devname:autofs");
 
 /* Register/deregister misc character device */
-int autofs_dev_ioctl_init(void)
+int __init autofs_dev_ioctl_init(void)
 {
 	int r;
 
-- 
1.8.4.5
