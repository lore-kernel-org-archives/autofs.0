From: kusumi.tomohiro@gmail.com
Subject: [PATCH 1/6] autofs: remove wrong comment
Date: Tue, 17 Jan 2017 23:42:28 +0900
Message-ID: <1484664153-20478-1-git-send-email-tkusumi@tuxera.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=75iL/EG96pqtVB/HQhNmKNe5YMG9mo9zW7L/GD3p7q8=;
        b=EXteJZxXux3JDQAwA78Fzgw5rxzkvKucRu2RvREh1UVNKrMjlblUfkurgGc/vv0OfE
         hDupciozbEbUjKHGczvZwAeKi2PKyuZafegxu3GQXhzh51HL7eu/dkcpHRjjaVe7BNFA
         nIL7SMPTHxBt4SozrLhKxna5M8nWTu5KApIBR2EmlkJOUA1be8WInLHDAry+SYZdIFxw
         ucbaZ/Xjvlyk5CnVNgBj4uqHL2p2q4/GLd1tQlCkghoYMPdbT9cc74pQ/QpGLE6A3HwM
         iGT/zZK7OV0bqzYIAx2kVK/5OyOpgugSrYzY/ANnG9Iwx5Wk/tSNkb0XRUJP0AOjclWS
         O5Lw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This format seems to have been taken from device mapper header,
but autofs has no such file:function in both kernel and userspace.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 include/uapi/linux/auto_dev-ioctl.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index 021ed33..388739b 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -120,10 +120,6 @@ static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
 	in->ioctlfd = -1;
 }
 
-/*
- * If you change this make sure you make the corresponding change
- * to autofs-dev-ioctl.c:lookup_ioctl()
- */
 enum {
 	/* Get various version info */
 	AUTOFS_DEV_IOCTL_VERSION_CMD = 0x71,
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
