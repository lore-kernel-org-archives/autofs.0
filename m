From: Ian Kent <raven@themaw.net>
Subject: [PATCH 3/3] autofs: fix "fix dev ioctl number range check"
Date: Wed, 31 Aug 2016 11:34:20 +0800
Message-ID: <20160831033420.9910.16809.stgit@pluto.themaw.net>
References: <20160831033409.9910.77067.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=FVy1m17NuevLOIt8wck8cHhA8YY=; b=EApBX6
        rZ2aNyWT/MkxseZRYLHLZZ8ePjXBjZF+7sqKDeLfgzcz4NuYLhg/HJRUKMnWYN5y
        qFLi334nKfJFsXB+WQ1XwdQYHuc4tCDQBt2GXykXBn3qIz++BOfy+0RMtUlsIkiu
        o+QjsqVeIqLbDYz3QU/mKKwDYtd2Cmv83GPVs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=FVy1m17NuevLOIt
        8wck8cHhA8YY=; b=jhVTm49hbEeTBQYhgc11xIQkRAZ3sNDOVLjTb9xSdqk1nd1
        vwvHkVcJvplx+jkWf2FK4+GSlrLWbtAY6s/C3kjEPFu0BEmlG+sBC76jJ9j701dN
        tjULn0zvbCxt4J+Nb7AjzHl9GvjJZVzfZh0Fyuh4nGSFaTGcGiamQOz7WChE=
In-Reply-To: <20160831033409.9910.77067.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

102a340f had a typo that made the count macro negative (-13).
The acutal check used by ioctl is ((cmd - cmd_first) > COUNT),
so it needs to be positive (13).

* 102a340f is a commit in linux-next which hasn't been merged
to mainline upstream.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 4404a22..a1fba42 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -21,7 +21,7 @@
 
 #define AUTOFS_DEV_IOCTL_IOC_FIRST	(AUTOFS_DEV_IOCTL_VERSION)
 #define AUTOFS_DEV_IOCTL_IOC_COUNT \
-	(AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
+	(AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD - AUTOFS_DEV_IOCTL_VERSION_CMD)
 
 #include <linux/kernel.h>
 #include <linux/slab.h>

