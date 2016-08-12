From: Ian Kent <raven@themaw.net>
Subject: [PATCH 05/18] autofs: Add WARN_ON(1) for non dir/link inode case
Date: Fri, 12 Aug 2016 10:47:54 +0800
Message-ID: <20160812024754.12352.8536.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=lKUwlJHMSWB72x/V7aKmA9Z2d68=; b=pMfOOI
	xbv6Fl3I7TT+RESNOKOZ+Gjoe7GINFjHrplYdUMF3fVN29BzJS5fFn3NIjhjGCcB
	tR2vZuM9VfVS9N8NDjzww2EvJV01jXALCoXnYKW4yNLAhWUCBnhF2tguFTWF6XQ2
	KLj20kopKbKxRoPYVVD68RAooU7iD+XW+Cukk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=lKUwlJHMSWB72x/
	V7aKmA9Z2d68=; b=MgjqMcCn4aJxh7UgbPSZwBYWMDIPIEMPxpL0lU5QPeo038G
	dkOXBbhsUoKQV5ZhWGbrv8Dx9AFkoW6ioPt7AGG3/xZaPa8FYjjOohcx+i5UpfM6
	b44Kz4x1H8eg9QgymzdB/mlwGWY1FeMxVmOHg/0KG83BSVIYj04ckSzIfRLk=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

It's invalid if the given mode is neither dir nor link,
so warn on else case.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/inode.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 64d721f..0dd4db9 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -368,7 +368,8 @@ struct inode *autofs4_get_inode(struct super_block *sb, umode_t mode)
 		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(mode)) {
 		inode->i_op = &autofs4_symlink_inode_operations;
-	}
+	} else
+		WARN_ON(1);
 
 	return inode;
 }

