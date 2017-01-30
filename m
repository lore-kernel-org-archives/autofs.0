From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/7] autofs: remove wrong comment
Date: Mon, 30 Jan 2017 18:20:40 +0800
Message-ID: <148577164094.9801.4775075118014742496.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=QVc5JQ94zWUstGipiBEfo9XgpfI=; b=M2OcCw
        j+jvHUbaM9PnY+pwh/FKEBAdVEFX8knuCBxbKIi6HVSYyp3UhCgvYhXkMiG5Ni1S
        jtzRdUlyo21qmNj+2SkxhXnjRiNKUMRjno0RARt7TUhoFzxUdeclTG6W7H7iSP/l
        66zQZnmqkuQK6q7r/cNu0jeigLpAbAElcf1Y8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=smtpout; bh=QVc5JQ94zWUstG
        ipiBEfo9XgpfI=; b=uqw96e22qiqhN5hKp82ZlFxmS3wokvrCslWF8Bgk1DdkOD
        z8OCGun0vyQXinnEO61wdgd1AQ9tkDyZAPdjibdTBvt00OlRYF2+VpZbvDBx22gn
        w1XXfO9vPljBpGMT064N4+MWNYW1cBtV/MFkcXGMYr/wQFbX2hWqzcUabKksk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

This format seems to have been taken from device mapper header,
but autofs has no such file:function in both kernel and userspace.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 include/uapi/linux/auto_dev-ioctl.h |    4 ----
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

