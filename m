From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 01/12] autofs: Remove obsolete sb fields
Date: Sun, 10 Jul 2016 17:07:42 +0900
Message-ID: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NYLHywA2xT1Bea8y2ZJjCCqKT1eNbie11t/wbt8C4lM=;
        b=NOTy3VCjS//EzpdV/3KaxG/SStAsm08fnF+oFnzlIeOTMVw8J2O9XwEpAfGqKd9C5k
         +UykUI7BDXEKgtii8Y26bUW4PU7ID6WJaH+xVPUAhE+OtNjHGQ/gn0N5LXS9GkNV3T4C
         J1v0+0+cTDEd5ea1lHysr64euu1IOvWy1ws1uIVQXlzdEEdM9pcKJldNKhF6lQJNXDtm
         SUU9Dc/Eabtop59I3TMOVT1Fe7zi5apcCazoPGjTbDlDYZ5L+pvyW6TaBJCnf5lYIN+6
         lCJlTalq7HHHt8e3Gv8DVBWUZ65qAL00LTex7uasGQandiMqh0djOhmJeKfwvuEf2ggs
         CE4w==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

These two were left from aa55ddf3 which removed unused ioctls.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index eb87055..73e3d38 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -111,8 +111,6 @@ struct autofs_sb_info {
 	int max_proto;
 	unsigned long exp_timeout;
 	unsigned int type;
-	int reghost_enabled;
-	int needs_reghost;
 	struct super_block *sb;
 	struct mutex wq_mutex;
 	struct mutex pipe_mutex;
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
