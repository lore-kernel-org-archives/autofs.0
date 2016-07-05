From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH] autofs: Remove obsolete sb fields
Date: Wed,  6 Jul 2016 00:18:09 +0900
Message-ID: <1467731889-6512-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NYLHywA2xT1Bea8y2ZJjCCqKT1eNbie11t/wbt8C4lM=;
        b=AG5doOR8xpzEjvtPwen8RgT0rIQ12gj2S8OywceoV1CeyKhqSLYxNvLTlKWLqs8g6u
         oKObV5/FEKJwHcRs59YC9YN9n3HpBXAV5HOtTyvng0TquE3GBiFz3nbeOwpcjHNzXWVZ
         ohP/+8r7tBs48iNVI8MFNJN++DbwJYJmWUcKxLZFGN+QT81cNGCC77IwSk0C8Yfpxf5u
         gJfJw0JR9zmpuaTRZh5X7BJeagHF4s5jRDNV0n9w83vM+cndTpb+atDPh3mGiWQzgv61
         m5yi5l7j2Io3RfuiTpCpOfLKn6SpQLC0PFVqZD94g2Y9eObodKmKkWY7E9tmGM4KWXlY
         Kpvw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@vger.kernel.org, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

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
