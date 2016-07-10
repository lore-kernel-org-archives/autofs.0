From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 02/12] autofs: Don't fail to free_dev_ioctl(param)
Date: Sun, 10 Jul 2016 17:07:43 +0900
Message-ID: <1468138073-4870-2-git-send-email-kusumi.tomohiro@gmail.com>
References: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XIYCdLKe3bQXrnCU/y2jVWMeAbAWaLvDX4vcahcCNNA=;
        b=Mn6OVLKBIA+BMzaJU5PjQZl8FEzexCI2xuG36fwXHCiTBLCVIvkgoPoN0qUSBxarZD
         WudD51+OCThkgmjZrDnbIeeGPksfE0yvyowfFzZV5xDf/QJa5nrhFM3llbQj6S/nsbI4
         IyjHq7NUQmyHGrDb4iXanrdm4zWK1tvcXBBfBb1NgDTUqX2uAD77lyY7gDpmVoKiANMG
         zPuTzvylFZjQKlM0lcqpfgDU8A0h4l0uEbNLzjzKq+ozgjzxZX4AxBleuB7yCKUWvuYT
         W+Hm3Tz72ZvE6+XCQhI7rHnbeeaSX3d+9G/GQna1zYkDjMoWMs8HMQud3kq0RJhrACd9
         kMMQ==
In-Reply-To: <1468138073-4870-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Returning -ENOTTY here fails to free dynamically allocated param.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/dev-ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index c7fcc74..d47b35a 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -662,7 +662,8 @@ static int _autofs_dev_ioctl(unsigned int command,
 	fn = lookup_dev_ioctl(cmd);
 	if (!fn) {
 		pr_warn("unknown command 0x%08x\n", command);
-		return -ENOTTY;
+		err = -ENOTTY;
+		goto out;
 	}
 
 	fp = NULL;
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
