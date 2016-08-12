From: Ian Kent <raven@themaw.net>
Subject: [PATCH 16/18] autofs: Fix print format for ioctl warning message
Date: Fri, 12 Aug 2016 10:48:51 +0800
Message-ID: <20160812024851.12352.75458.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=o8GuvIsIt+skLgLefe+VHBjGCA4=; b=xqrh+L
	NCHSg65aVTZJFKI87HGYeO7pMZlNkQ9exNFEhiT52IfuiR6UecJjkxkxRlAAbp4i
	BxBA5SwLEP/YFnmpCsgm54oB7KPmRYQIraPQaPCFOPprpEQzj2l+eLuqj3EBRkq1
	jv0xmrzjE00eo7Duwn5v76B1q86PBj8jOwJU0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=o8GuvIsIt+skLgL
	efe+VHBjGCA4=; b=toP8wN6+Y8FOVmqgUQ3M0zZMbS14WJ+dlclLDoz49FKFAJb
	EiWjp2+vtwt3nYB4Qn7uICHZypBOEnQ37JEC23zhh3pFOr+H3f5dNUbfgqJaC/+b
	C3bSaiCbUGvMNLa61QvhaTPZMaZzrfZpHDJ1DBP2OzWhxaGhrB/ZaYkFE5PE=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

All other warnings use "cmd(0x%08x)" and this is the only one with "cmd(%d)".
(below comes from my userspace debug program, but not automount daemon)

[ 1139.905676] autofs4:pid:1640:check_dev_ioctl_version: ioctl control interface version mismatch: kernel(1.0), user(0.0), cmd(-1072131215)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/dev-ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 7289216..e89d6bb 100644
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

