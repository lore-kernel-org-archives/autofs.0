From: Ian Kent <raven@themaw.net>
Subject: [PATCH 2/3] autofs: refactor ioctl fn vector in iookup_dev_ioctl()
Date: Wed, 31 Aug 2016 11:34:15 +0800
Message-ID: <20160831033414.9910.66697.stgit@pluto.themaw.net>
References: <20160831033409.9910.77067.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=TLfb5Y2yGggiIdZ6AqdtOPSc+5Q=; b=dOxL2O
        Kj7/HnclKKb1XYH73xFEPG590V8IBKERH0HW0rM8rFC4rWkhRv/7oOgHWgrLaCAp
        yipaZ2QqHPwiDFzyfeKXM5STzuqIr6OyrQYLVui+0MyS5YpJe7xZ3L2XaJDT5cM6
        kNsfvmhF2KSmk7OH7/+VHL6I2/7QmLHb4Ameg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=TLfb5Y2yGggiIdZ
        6AqdtOPSc+5Q=; b=B7V2DYdep6o7kctfvshLMY0hylkfdzrVKIbVw5g37UEvYt3
        nM4yStLNUfYksDW0gozJFHRS5xtfrcssOL1pUKLxpHlpSHoR2zjC1AS1OQTcOpEo
        6okEtZOMlLjgPwUMDS+rO8lqql1CHO3s60LYw3vh+5uuvQIT5j8H1Pb5ovFQ=
In-Reply-To: <20160831033409.9910.77067.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

cmd part of this struct is the same as an index of itself within
_ioctls[]. In fact this cmd is unused, so we can drop this part.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c |   49 ++++++++++++++++--------------------------------
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

