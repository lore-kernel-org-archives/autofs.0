From: Ian Kent <raven@themaw.net>
Subject: [PATCH] autofs4: check dev ioctl size before allocating
Date: Mon, 07 Apr 2014 09:42:00 +0800
Message-ID: <20140407014200.5099.51469.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	subject:to:from:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=mesmtp; bh=g9V0Y6KCO9OiU3/JMEHn6KR
	6BgM=; b=OzHVANOrd1+Y8ntYets0LKWV4Q60oU3yOh/aGBITIIjL5xhkdHx8/vz
	nvYPzsUkJtV1uxoUBHCPfMm6hhT/wOQik9tVzKdJvn1uLUDh4jeb+6qaKhJ3txPF
	17ZPkddxSLDD3cYtbhWcieNAs6z+2D/3t5LM5S8367/39eBideqY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=subject:to:from:cc:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=smtpout;
	 bh=g9V0Y6KCO9OiU3/JMEHn6KR6BgM=; b=V70Y6nWOz62fTEgFfr51G68lIzrv
	BrOsEZgthZpR71biAKP7QljZtNWIPgIanhgf8UOMsB+FimZ7eILR41RB6CHmDMKn
	OgcavGJTXMbfl19apzzTB3fHYo5ejJdM5vBYsGRk1so+HwYYX9XUf5A8z/h2uTCe
	QqeMYEbGFUGHSLs=
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sasha.levin@oracle.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Sasha Levin <sasha.levin@oracle.com>

There wasn't any check of the size passed from userspace before
trying to allocate the memory required.

This meant that userspace might request more space than allowed,
triggering an OOM.

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/dev-ioctl.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/autofs4/dev-ioctl.c b/fs/autofs4/dev-ioctl.c
index 3182c0e..232e03d 100644
--- a/fs/autofs4/dev-ioctl.c
+++ b/fs/autofs4/dev-ioctl.c
@@ -103,6 +103,9 @@ static struct autofs_dev_ioctl *copy_dev_ioctl(struct autofs_dev_ioctl __user *i
 	if (tmp.size < sizeof(tmp))
 		return ERR_PTR(-EINVAL);
 
+	if (tmp.size > (PATH_MAX + sizeof(tmp)))
+		return ERR_PTR(-ENAMETOOLONG);
+
 	return memdup_user(in, tmp.size);
 }
 

