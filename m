From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] fs/autofs4/dev-ioctl.c: add missing free_dev_ioctl
Date: Sat, 14 Apr 2012 11:48:48 +0200
Message-ID: <1334396928-17537-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: kernel-janitors@vger.kernel.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Free param as done in the other error-handling code.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 fs/autofs4/dev-ioctl.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 9dacb85..f99c2ce 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -651,7 +651,8 @@ static int _autofs_dev_ioctl(unsigned int command, struct autofs_dev_ioctl __use
 	fn = lookup_dev_ioctl(cmd);
 	if (!fn) {
 		AUTOFS_WARN("unknown command 0x%08x", command);
-		return -ENOTTY;
+		err = -ENOTTY;
+		goto out;
 	}
 
 	fp = NULL;
