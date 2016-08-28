From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Subject: [PATCH 2/3] autofs: refactor ioctl fn vector in iookup_dev_ioctl()
Date: Sun, 28 Aug 2016 13:05:58 +0900
Message-ID: <1472357159-1871-2-git-send-email-kusumi.tomohiro@gmail.com>
References: <1472357159-1871-1-git-send-email-kusumi.tomohiro@gmail.com>
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WxlIpbWHkcGDiQjwAfBYHJvFqccVKhgogXWF3/2iprQ=;
        b=JEWERskQsah4kKAguFBqYcvRCvjWoQb0oeP/3Lzvp6fTiXeKl1UIX0OV6Ke0whTxVn
         p7YjgodHVIew6mWoN+oR+pc5rBN/bMFCJq8xT7wbpVRG+tcx0gsjx5gzRd6LEhdp9rV5
         ytTzX3b1EZZ6fSL+gBfHmhkT2SlI0ufUtmD2cuMBColiNRJg/iJY0dKenIijfbjmITgM
         dqnjOVB9M0BO59hecu/6VgxCXL4mCksGvCS75ZquRo/m+raS1DBmrMToha3robePxfGf
         bSGBdtdwWVmZZpBum6TKJhIrG+qmMt/spR9aZTMxmBe48FEFsiC+LmyWpneUfFUP0Obw
         tGLA==
In-Reply-To: <1472357159-1871-1-git-send-email-kusumi.tomohiro@gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net, autofs@vger.kernel.org
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

cmd part of this struct is the same as an index of itself within
_ioctls[]. In fact this cmd is unused, so we can drop this part.

* This patch is made on top of linux-next as there are series of
autofs patches in linux-next (that contain a patch for the same
function) that have't been merged to mainline upstream.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/dev-ioctl.c | 49 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index e89d6bb..fc09eb7 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -597,42 +597,25 @@ out:
 
 static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 {
-	static struct {
-		int cmd;
-		ioctl_fn fn;
-	} _ioctls[] = {
-		{cmd_idx(AUTOFS_DEV_IOCTL_VERSION_CMD),
-			 autofs_dev_ioctl_version},
-		{cmd_idx(AUTOFS_DEV_IOCTL_PROTOVER_CMD),
-			 autofs_dev_ioctl_protover},
-		{cmd_idx(AUTOFS_DEV_IOCTL_PROTOSUBVER_CMD),
-			 autofs_dev_ioctl_protosubver},
-		{cmd_idx(AUTOFS_DEV_IOCTL_OPENMOUNT_CMD),
-			 autofs_dev_ioctl_openmount},
-		{cmd_idx(AUTOFS_DEV_IOCTL_CLOSEMOUNT_CMD),
-			 autofs_dev_ioctl_closemount},
-		{cmd_idx(AUTOFS_DEV_IOCTL_READY_CMD),
-			 autofs_dev_ioctl_ready},
-		{cmd_idx(AUTOFS_DEV_IOCTL_FAIL_CMD),
-			 autofs_dev_ioctl_fail},
-		{cmd_idx(AUTOFS_DEV_IOCTL_SETPIPEFD_CMD),
-			 autofs_dev_ioctl_setpipefd},
-		{cmd_idx(AUTOFS_DEV_IOCTL_CATATONIC_CMD),
-			 autofs_dev_ioctl_catatonic},
-		{cmd_idx(AUTOFS_DEV_IOCTL_TIMEOUT_CMD),
-			 autofs_dev_ioctl_timeout},
-		{cmd_idx(AUTOFS_DEV_IOCTL_REQUESTER_CMD),
-			 autofs_dev_ioctl_requester},
-		{cmd_idx(AUTOFS_DEV_IOCTL_EXPIRE_CMD),
-			 autofs_dev_ioctl_expire},
-		{cmd_idx(AUTOFS_DEV_IOCTL_ASKUMOUNT_CMD),
-			 autofs_dev_ioctl_askumount},
-		{cmd_idx(AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD),
-			 autofs_dev_ioctl_ismountpoint}
+	static ioctl_fn _ioctls[] = {
+		autofs_dev_ioctl_version,
+		autofs_dev_ioctl_protover,
+		autofs_dev_ioctl_protosubver,
+		autofs_dev_ioctl_openmount,
+		autofs_dev_ioctl_closemount,
+		autofs_dev_ioctl_ready,
+		autofs_dev_ioctl_fail,
+		autofs_dev_ioctl_setpipefd,
+		autofs_dev_ioctl_catatonic,
+		autofs_dev_ioctl_timeout,
+		autofs_dev_ioctl_requester,
+		autofs_dev_ioctl_expire,
+		autofs_dev_ioctl_askumount,
+		autofs_dev_ioctl_ismountpoint,
 	};
 	unsigned int idx = cmd_idx(cmd);
 
-	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx].fn;
+	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx];
 }
 
 /* ioctl dispatcher */
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
