From: Ian Kent <raven@themaw.net>
Subject: [PATCH 14/18] autofs - fix dev ioctl number range check
Date: Fri, 12 Aug 2016 10:48:41 +0800
Message-ID: <20160812024841.12352.11975.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=8mA4rtaIsYakCUjnJfZMsFxQqgE=; b=gNC1w6
	Z8ymvbf+WcRO5i+Qw4AvvCYlzFDDBouHi/Mv3TOsZRxhPIyY353R75l77Jd5DZ15
	o92UOKqwQXN4y+pk3Eikky3FauO5GXXIcaGNgkxTJ5aCNkMy4zl34vG/RjziuCcR
	JuQOY6pX+G5hqQ8BS552IAEnRB6RrnqEJiczs=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=8mA4rtaIsYakCUj
	nJfZMsFxQqgE=; b=juO9mi2PhRWXdwOlWN2OcrUvxh46jjXwWG5y77W42VvX2pe
	T38mRX/vFIaPTkNGrMH0dlEEb+T0rKflwDR+HjZVe72brNjwTAFNOmn1z5mbcFBE
	rSwdfge8kBynfieKOLxBZ9bmB42uVLU/RJTo3lzgPel3WzUX9aB12rrsrjvA=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

The count of miscellaneous device ioctls in fs/autofs4/autofs_i.h is wrong.

The number of ioctls is the difference between AUTOFS_DEV_IOCTL_VERSION_CMD
and AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD (14) not the difference between
AUTOFS_IOC_COUNT and 11 (21).

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
---
 fs/autofs4/autofs_i.h  |    3 ++-
 fs/autofs4/dev-ioctl.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index 73e3d38..dd71bd4 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -20,7 +20,8 @@
 #define AUTOFS_IOC_COUNT     32
 
 #define AUTOFS_DEV_IOCTL_IOC_FIRST	(AUTOFS_DEV_IOCTL_VERSION)
-#define AUTOFS_DEV_IOCTL_IOC_COUNT	(AUTOFS_IOC_COUNT - 11)
+#define AUTOFS_DEV_IOCTL_IOC_COUNT \
+	(AUTOFS_DEV_IOCTL_VERSION_CMD - AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index d47b35a..13e7517 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -642,7 +642,7 @@ static int _autofs_dev_ioctl(unsigned int command,
 	cmd = _IOC_NR(command);
 
 	if (_IOC_TYPE(command) != _IOC_TYPE(AUTOFS_DEV_IOCTL_IOC_FIRST) ||
-	    cmd - cmd_first >= AUTOFS_DEV_IOCTL_IOC_COUNT) {
+	    cmd - cmd_first > AUTOFS_DEV_IOCTL_IOC_COUNT) {
 		return -ENOTTY;
 	}
 

