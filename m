From: Ian Kent <raven@themaw.net>
Subject: [PATCH 6/7] autofs: remove duplicated AUTOFS_DEV_IOCTL_SIZE
 definition
Date: Mon, 30 Jan 2017 18:21:06 +0800
Message-ID: <148577166656.9801.10322423666945951186.stgit@pluto.themaw.net>
References: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=66gzycCmDeV1L2O
        9B+ZKl+4u74o=; b=kKhUBMlclFdGkQWRX6uQE9nzghbVTZXOgLCePO3kO/pxKVL
        O0sJ4sqIXGvs9zEkOBENlb0Qcs1CJaOrR2CRihkN3TXG/Gs6d7nrSJRxggIs8R88
        ayCJqP2mlaW5BiNg2vCjeoOdVmOihd8PieTApPlWo5r/C6UH0RSo7YiEwki0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=66gzycCmDeV1L2O9B+ZKl+4u74o=; b=sHxqT+TGEhFy8MWHm4if
        2xD8OYcK3uwgPlOJYpoErBI2S+vCExi4Q9K+Em+bx9RCrW/lxGQM9QekvVmiOnII
        n07HXYTJD8g18pColByl83YXnzn0NvhyHDKmMZVg6Yc/Y6FeF8cT2sCEhGdtyiXh
        eOetoxv1cdSLVIMhflpODSM=
In-Reply-To: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This macro is already defined in uapi header.
Also use this macro where possible.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c              |    2 --
 include/uapi/linux/auto_dev-ioctl.h |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index fc09eb7..35099ac 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -38,8 +38,6 @@
  * which have been left busy at at service shutdown.
  */
 
-#define AUTOFS_DEV_IOCTL_SIZE	sizeof(struct autofs_dev_ioctl)
-
 typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
 			struct autofs_dev_ioctl *);
 
diff --git a/include/uapi/linux/auto_dev-ioctl.h b/include/uapi/linux/auto_dev-ioctl.h
index af107aa..744b3d0 100644
--- a/include/uapi/linux/auto_dev-ioctl.h
+++ b/include/uapi/linux/auto_dev-ioctl.h
@@ -113,10 +113,10 @@ struct autofs_dev_ioctl {
 
 static inline void init_autofs_dev_ioctl(struct autofs_dev_ioctl *in)
 {
-	memset(in, 0, sizeof(struct autofs_dev_ioctl));
+	memset(in, 0, AUTOFS_DEV_IOCTL_SIZE);
 	in->ver_major = AUTOFS_DEV_IOCTL_VERSION_MAJOR;
 	in->ver_minor = AUTOFS_DEV_IOCTL_VERSION_MINOR;
-	in->size = sizeof(struct autofs_dev_ioctl);
+	in->size = AUTOFS_DEV_IOCTL_SIZE;
 	in->ioctlfd = -1;
 }
 

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
