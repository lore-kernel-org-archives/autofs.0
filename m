From: Ian Kent <raven@themaw.net>
Subject: [PATCH 09/18] autofs: Don't fail to free_dev_ioctl(param)
Date: Fri, 12 Aug 2016 10:48:15 +0800
Message-ID: <20160812024815.12352.69153.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=q9VXWd9iPisb6v0mJsUjTgw3+E4=; b=vfh64A
	A3IFJZErOP4vwMQvsTclsabPpHLr+LrtZL6/rO9603uokAkqFXWOIpKpOyn0KlkD
	A1CCqTcDcBdVTVwY6DzqmkTm+zRAOpCcXne4EdM4mkHseDyhL8PQxv1muFaLIY24
	hH9I+H5kLQzeSNsIE1kVChHfBw24aZpgIMIo4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=q9VXWd9iPisb6v0
	mJsUjTgw3+E4=; b=D1iW+HXy2/kHcc1QdyhnH4Fzk3vQhpSmL46Johbmaq2/Oze
	yOe3ZtW1JMumZQLllQXRm8Y220vUme8PsHt9kBK+UtT5uGx3kbq93GhYUPxPiydg
	959VjkFHHSG6obh+oRS+TWQaVjPo9++9GG2r4aO0fFGcZkUFvBI5TozcZRss=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Returning -ENOTTY here fails to free dynamically allocated param.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/dev-ioctl.c |    3 ++-
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

