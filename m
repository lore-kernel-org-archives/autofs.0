From: Colin King <colin.king@canonical.com>
Subject: [PATCH] autofs: remove redundant assignment to variable err
Date: Sun,  1 Sep 2019 16:22:51 +0100
Message-ID: <20190901152251.11374-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable err is being assigned a value that is never read and
is being re-assigned a little later on. The assignment is redundant
and hence can be removed.

Addresses-Coverity: ("Ununsed value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/autofs/dev-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index a3cdb0036c5d..65d84b4d4464 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -422,7 +422,7 @@ static int autofs_dev_ioctl_requester(struct file *fp,
 	struct autofs_info *ino;
 	struct path path;
 	dev_t devid;
-	int err = -ENOENT;
+	int err;
 
 	/* param->path has been checked in validate_dev_ioctl() */
 
-- 
2.20.1

