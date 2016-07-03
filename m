From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs: Drop unnecessary extern in .h
Date: Sun,  3 Jul 2016 16:56:46 +0900
Message-ID: <1467532606-6510-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=poIK4Amua1Cdn5DofuN+tQS31Lwij8vJlG9lg8+x5HM=;
        b=TjXq1xvZhr3yNfyU+x80hARog864gT/a/MXAUCPZrPCaMzsJ9EWdVdgWZ5D29Ma5nk
         R4aN8dpLphbsWfHYEh+iOAfDuiZUudi1GSprwuquTj5lGPBr+qD4zBVJ9c+EzT7VpuAM
         EQjUeoPNe67oNf+9kxpyqPmJZixOpHqYj4yGEG8Oa0YfJ/hGXptmDhH5XB6hHkgHe0KQ
         DhDZiB0nHDgHzJbGuOEVo0niMGh2DQPCkMqAPT5K+3fu9J82puCnACvkwaBb67iPygZo
         CSfuv3vCTGLIwT0BcUZeWl1f00Ll7W8KCcSQEFHSgqD/MTbArnnB+og+w7JKSC4839nq
         5zlw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

autofs4_kill_sb() doesn't need to be declared as extern,
and no other functions in .h are explicitly declared as extern.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index a439548..eb87055 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -271,4 +271,4 @@ static inline void autofs4_del_expiring(struct dentry *dentry)
 	}
 }
 
-extern void autofs4_kill_sb(struct super_block *);
+void autofs4_kill_sb(struct super_block *);
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
