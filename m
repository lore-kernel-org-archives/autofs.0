From: Ian Kent <raven@themaw.net>
Subject: [PATCH 07/18] autofs: Use autofs4_free_ino() to kfree dentry data
Date: Fri, 12 Aug 2016 10:48:05 +0800
Message-ID: <20160812024805.12352.43650.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=gGkWZXPdUE4CcOl/cCpULAcoLp0=; b=E9Bzpp
	H6q2+ItK3NL6SjE5odsJQCvcPqVlW8ruOYwYDgfJDSFEqOvvMXLiBwo7ca/SYKt1
	IxPFV7mjwwPE40KAfjWtJcUBQL+u9M7+6a4KGYeLhNNqBWTPhkMSBb/2gvGyeq1i
	+ND6YLxjNuzepSkGzDwpYKCd5IikfSzWrpi7M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=gGkWZXPdUE4CcOl
	/cCpULAcoLp0=; b=NCU4UHvcbvUOflRyrGmEIBv3MDTUvtgM9KB/sDHR77yYVQe
	oez7SCrfzUxN75qO0oJtXpJA50qVMbZwnoa+5ipHS8ypGDIfTXTwGmTGWV+T/Sa8
	wDWkXd2XubQc8QSCLGCpZHo54gjj+0vG8T190ily8VzyD6sdBnKYSrRLvlKk=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

kfree dentry data allocated by autofs4_new_ino() with
autofs4_free_ino() instead of raw kfree.
(since we have the interface to free autofs_info*)

This patch was modified to remove the need to set the dentry
info field to NULL dew to a change in the previous patch.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 0dd4db9..f35ead7 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -340,7 +340,7 @@ fail_dput:
 	dput(root);
 	goto fail_free;
 fail_ino:
-	kfree(ino);
+	autofs4_free_ino(ino);
 fail_free:
 	kfree(sbi);
 	s->s_fs_info = NULL;

