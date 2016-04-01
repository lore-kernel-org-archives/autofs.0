From: Andrey Vagin <avagin@gmail.com>
Subject: [PATCH] autofs: don't stuck in a loop if vfs_write returns an error
Date: Thu, 31 Mar 2016 22:12:38 -0700
Message-ID: <1459487558-21258-1-git-send-email-avagin@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jPUiY2ASl4QgDda/LIzpc1Sq8c5TPwzla0zeetf7lQ8=;
        b=rkjY7sc2zjfP7XWKFgiZkOyL4wyAb25/WjR/L7ppp9+PF1y5UvNc1NOtd69hr9TQQC
         opA8LSDfGFpky3qrB7SO4urn7R9zKurUv/xD9yXT48guyO4Ux5zOKlWETbvMEzB8VCB9
         I2eFfdl/iq86Uvps9pSgODzVDG+EZUNFH5aiu2lgFG26KA6UNMIof9kqDSM60Rtx3H6+
         3MLWH1X6zNM8wNoqo0s92FZP66hEBJZY2373BQxMA6N2Wejm8s6P4eokZGWWlhP+8Ht7
         AF6AcvPXhOoyVxAMCsbf/9jTfK/0rRGOtcvcVE0d0kdqhuNxZjFnqMGDdx06Ii9n+DIo
         msmg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-kernel@vger.kernel.org, Andrey Vagin <avagin@openvz.org>

From: Andrey Vagin <avagin@openvz.org>

__vfs_write() returns a negative value in a error case.

Cc: Ian Kent <raven@themaw.net>
Signed-off-by: Andrey Vagin <avagin@openvz.org>
---
 fs/autofs4/waitq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 0146d91..631f155 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -66,11 +66,12 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 	set_fs(KERNEL_DS);
 
 	mutex_lock(&sbi->pipe_mutex);
-	wr = __vfs_write(file, data, bytes, &file->f_pos);
-	while (bytes && wr) {
+	while (bytes) {
+		wr = __vfs_write(file, data, bytes, &file->f_pos);
+		if (wr <= 0)
+			break;
 		data += wr;
 		bytes -= wr;
-		wr = __vfs_write(file, data, bytes, &file->f_pos);
 	}
 	mutex_unlock(&sbi->pipe_mutex);
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
