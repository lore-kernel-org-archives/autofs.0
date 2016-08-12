From: Ian Kent <raven@themaw.net>
Subject: [PATCH 13/18] autofs: Fix pr_debug() message
Date: Fri, 12 Aug 2016 10:48:36 +0800
Message-ID: <20160812024836.12352.74628.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=iDzx2h0wqxxbNZ7MYrdvt3rt3v4=; b=yrAGGI
	EHAZKbN4Zf/u4pjDkpUHaxc7N5hqPXj86MUbGGaobnwfYi6AdgNZ3vDj62/7pKXZ
	JIMT4j2R0ZRQBSu2KH3PVZPDTL/o3GGqey295QCPI16m+xM5Pv5tsx/MMfK75jF7
	Aqaq+8MBViJpJbQcsJ8Gwgk3gCBSfhp5bcbKM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=iDzx2h0wqxxbNZ7
	MYrdvt3rt3v4=; b=LxW3Gdddby0mqhtmjP9eRRziTLfU4S0WVmHOqFq0GWRvKRs
	gQtnnCjsTbZPP1dXnqCTbBfSTQQtxGnxUSTP0OODMYHpGDUUJ6BHalQip3DDelrk
	V94acxYmknrUrDR9ilDnTOxs8j4dvWJwgMwhbmmm5drFII0Wf5Dkj33/f3+c=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

This isn't a return value, so change the message to indicate
the status is the result of may_umount().

(or locate pr_debug() after put_user() with the same message)

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/root.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/root.c b/fs/autofs4/root.c
index 1b0495a..d25c55f 100644
--- a/fs/autofs4/root.c
+++ b/fs/autofs4/root.c
@@ -840,7 +840,7 @@ static inline int autofs4_ask_umount(struct vfsmount *mnt, int __user *p)
 	if (may_umount(mnt))
 		status = 1;
 
-	pr_debug("returning %d\n", status);
+	pr_debug("may umount %d\n", status);
 
 	status = put_user(status, p);
 

