From: Ian Kent <raven@themaw.net>
Subject: [PATCH 11/18] autofs: Fix Documentation regarding devid on ioctl
Date: Fri, 12 Aug 2016 10:48:25 +0800
Message-ID: <20160812024825.12352.13486.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=q4qX/VgewuQWD44VGZLaV/PSKPo=; b=U0sT4d
	lDVOyhHA6IA6NdX+myfX8t1Vo6WotYvb3+JU0po8dFEa4/xBGCNNS5D8H1e7EmIh
	WQ885e6bZKzJ3MtE7s3qrvgV58jLeP/nUwbmL05+oYZ9F2CxewpV6uyu8ZTg0PSU
	pc2bw/M+7JsXNJOB6U2tQpsg5abu2YZNMcJSM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=q4qX/VgewuQWD44
	VGZLaV/PSKPo=; b=FD8XjfTsvOtyh6X4NV2LH019SB8RoS8MjG7qnXCzMMLx8mB
	FdRSZHddbcHzv7r7a03TnBdWkltwzQ/sz9gaqxyNA8ye7G73o2PFnCj6GJRoL5Qn
	HUoXjOGDwGmV1aQR/gb5phYy/HNqDg17nqHAoAJqsfTMCQBTZ3RFWk1Mf/7c=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

The explanation on how ioctl handles devid seems incorrect.
Userspace who calls this ioctl has no input regarding devid,
and ioctl implementation retrieves devid via superblock.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 .../filesystems/autofs4-mount-control.txt          |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/autofs4-mount-control.txt b/Documentation/filesystems/autofs4-mount-control.txt
index aff2211..540d9a7 100644
--- a/Documentation/filesystems/autofs4-mount-control.txt
+++ b/Documentation/filesystems/autofs4-mount-control.txt
@@ -323,9 +323,8 @@ mount on the given path dentry.
 
 The call requires an initialized struct autofs_dev_ioctl with the path
 field set to the mount point in question and the size field adjusted
-appropriately as well as the arg1 field set to the device number of the
-containing autofs mount. Upon return the struct field arg1 contains the
-uid and arg2 the gid.
+appropriately. Upon return the struct field arg1 contains the uid and
+arg2 the gid.
 
 When reconstructing an autofs mount tree with active mounts we need to
 re-connect to mounts that may have used the original process uid and

