From: Ian Kent <raven@themaw.net>
Subject: [PATCH 02/18] autofs: Drop unnecessary extern in autofs_i.h
Date: Fri, 12 Aug 2016 10:47:39 +0800
Message-ID: <20160812024739.12352.99354.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=jvJo6CURePcEHR3O3bo9nFC7dXM=; b=Dl19A/
	maJ9SG/+fc09r4nUcj3gVwJChJzMHu6Iav15ESQ4s/MnpW3v0T/m5P9tzN/KIV8C
	YgpKJG/3PHd/wiPi2gRex5olGJ2wz41bquZ2xMAALdLqGTxSR3sLvGH6RK/ijoNl
	4cQDq7NLhP6Xz7S+h4MGDJfXesh5OK/NjNBRc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=jvJo6CURePcEHR3
	O3bo9nFC7dXM=; b=Zk7DTH2ROJGURroXlStEaH6NKWtPnNtXIMRHqsw8Y6I31Wh
	M+zNQhG5GXbb90JlFeOZVDR1ExjuqDHDE/46vvQ3wD0MIruXH2F18kCrDrkY7ulD
	ja+6FZtRuIxxd0UoN6b1Kqqa+sg+t5kkoTOJXU8n836OeYwrDjlZRMdljDnE=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

autofs4_kill_sb() doesn't need to be declared as extern,
and no other functions in .h are explicitly declared as extern.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index a439548..eb87055 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -271,4 +271,4 @@ static inline void autofs4_del_expiring(struct dentry *dentry)
 	}
 }
 
-extern void autofs4_kill_sb(struct super_block *);
+void autofs4_kill_sb(struct super_block *);

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
