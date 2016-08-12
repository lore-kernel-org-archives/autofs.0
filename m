From: Ian Kent <raven@themaw.net>
Subject: [PATCH 10/18] autofs: Remove AUTOFS_DEVID_LEN
Date: Fri, 12 Aug 2016 10:48:20 +0800
Message-ID: <20160812024820.12352.21210.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=foG8Sf7VQp///bDi1Bigh5XgYSs=; b=vJa9P6
	WbNYTr2yZlquekImvoLiHAWu/X/zlKyULESeqW3LxmMKYRjiyZsDFHIHDGEXN+MM
	l9QDFfeerZVLv2pZMjnEp7wySUGazKsqeF+16f9KDEb6oAgH7jNL/++sZaMnA07/
	404xxqalW4s2iYvT4feWL5VGDfZaH13h6mvms=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=foG8Sf7VQp///bD
	i1Bigh5XgYSs=; b=G40eRDJ2HjjyY8awLrSnItHYz2o+51zAhap5/bEx9z4+l5r
	z6cny8XlM5CSYwSjPez8zBObj1EyKCF5HN8pSZHdNZjJ953nZl/sY5ZmDP7LUUff
	8L4688VYcilYi0TmBa0J3J/QIvBfj7JWBLrzrIqo7OuFkAfPHnjiz3bhLnDo=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

This macro was never used by neither kernel nor userspace,
and also doesn't represent "devid length" in bytes.
(unless it was added to mean something else).

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 include/linux/auto_dev-ioctl.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/auto_dev-ioctl.h b/include/linux/auto_dev-ioctl.h
index 7caaf29..bf82e3a 100644
--- a/include/linux/auto_dev-ioctl.h
+++ b/include/linux/auto_dev-ioctl.h
@@ -18,8 +18,6 @@
 #define AUTOFS_DEV_IOCTL_VERSION_MAJOR	1
 #define AUTOFS_DEV_IOCTL_VERSION_MINOR	0
 
-#define AUTOFS_DEVID_LEN		16
-
 #define AUTOFS_DEV_IOCTL_SIZE		sizeof(struct autofs_dev_ioctl)
 
 /*

