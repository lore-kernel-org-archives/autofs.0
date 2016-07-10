From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 11/12] autofs: Fix print format for ioctl warning message
Date: Sun, 10 Jul 2016 17:07:52 +0900
Message-ID: <1468138073-4870-11-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B456KxGn/WY/CYBcGG/Pg5at+c6Apw6GYdbFCYK89bM=;
        b=cyZ5nWrgqWemNk9pNPvVXbLkfCf9cN8BjpNecUpIS1tS0TzjZINNIMB4hH+2WQxeT2
         KL/LgzBm7+ymY3LLprAcZ0A6DMtK21BmK4k8A/5geku74KZJNQF/B6mLF2Rv6wMqsB+2
         g3VYc3HGQd7sR+EuKdNY4jJU52Ux9W4ra963MZCOiy1ZxS8MHr4MttTBSVht/VCDOqj1
         SbMe5qm4016zyHMK3qu41zaWUzepOQLa/G91jJRC/oerAw0YQIafNxVHT/LH/chw15vi
         20rhd3Bl6UUJI1nyasqk/n2lcMhXg+aIljeXgrEdycn5xu6i4EyC6crb4jaV52a4mPZh
         +cSA==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

All other warnings use "cmd(0x%08x)" and this is the only one with "cmd(%d)".
(below comes from my userspace debug program, but not automount daemon)

[ 1139.905676] autofs4:pid:1640:check_dev_ioctl_version: ioctl control interface version mismatch: kernel(1.0), user(0.0), cmd(-1072131215)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/dev-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 3a1a969..53dfd7d 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -75,7 +75,7 @@ static int check_dev_ioctl_version(int cmd, struct autofs_dev_ioctl *param)
 	if ((param->ver_major != AUTOFS_DEV_IOCTL_VERSION_MAJOR) ||
 	    (param->ver_minor > AUTOFS_DEV_IOCTL_VERSION_MINOR)) {
 		pr_warn("ioctl control interface version mismatch: "
-			"kernel(%u.%u), user(%u.%u), cmd(%d)\n",
+			"kernel(%u.%u), user(%u.%u), cmd(0x%08x)\n",
 			AUTOFS_DEV_IOCTL_VERSION_MAJOR,
 			AUTOFS_DEV_IOCTL_VERSION_MINOR,
 			param->ver_major, param->ver_minor, cmd);
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
