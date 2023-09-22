From: Ian Kent <raven@themaw.net>
Subject: [PATCH 8/8] autofs: fix protocol sub version setting
Date: Fri, 22 Sep 2023 12:12:15 +0800
Message-ID: <20230922041215.13675-9-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355986; x=
        1695442386; bh=TVdA8h0DNl8QhVA+dGkTgVhkAap2oNQG0MwE5XL5kpw=; b=i
        KyjMpSdhrt3uQsxr6T6UxoeYCbayRCf6SkJDZKUT4DjCRR4XZI7A4vp6vVa7IWY2
        iAlx/Z5r7iLqsma8ChIdZ0uHbC6hqEiGT/J1VYhxYkNNsvNnRIPgkWk0gKhsIDFY
        WtgUstVwu6J+U17BBmdF06sF2Pr9eCAEbdMGKuA5YupM4mj7WfP9lz7h29e4/9Na
        +B2kmRJo1xVJ9ygM6cmPc2LT4bNSqqh9Y6BKwROZfdep7y87BBdKrPW6OTdFRRbQ
        iRE+MQi//Uy3JQhSGl/sLN0+4R06QVi0eVulUtvzfmVGOoEWmU/ZNJ87zlOmYE5V
        g3+OU2puQL+OQocE6EgZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355986; x=
        1695442386; bh=TVdA8h0DNl8QhVA+dGkTgVhkAap2oNQG0MwE5XL5kpw=; b=L
        7OBvXe8GQHWpMoWy0wgEbjaCZ212zowRiQ+RXQILK5CTv+qTNNaMNV3LMpx2ZncF
        jcH4elhoAb8due9ZEchpzGG0xafIPAKpgC31HpEZFHO/ASLmmanGazJslyE/WI5n
        pvXZ0OuFQyrOS8IjBkEJQOO5EP43Q9g9zzW5Q6bKwIzKOS406f4Q3WDVv+vTRuVq
        AGPpUhHDDoqaauZLdG3SxtmsGpOyog7/Zvc7YGXstxk0v+loWIjiLoviaLido0ft
        aOOR5cQmcvvdJhcqoD0M87w4DOvu5Gd+cavaQG8nXyEaQC936trU16dw+7H4ofvP
        1nUnDIL5R22VvFGLFSWQw==
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>

There were a number of updates to protocol version 4, take account of
that when setting the super block info sub version field.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 3f2dfed428f9..53c0df354206 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -279,7 +279,17 @@ static int autofs_validate_protocol(struct fs_context *fc)
 		sbi->version = AUTOFS_MAX_PROTO_VERSION;
 	else
 		sbi->version = sbi->max_proto;
-	sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+
+	switch (sbi->version) {
+	case 4:
+		sbi->sub_version = 7;
+		break;
+	case 5:
+		sbi->sub_version = AUTOFS_PROTO_SUBVERSION;
+		break;
+	default:
+		sbi->sub_version = 0;
+	}
 
 	return 0;
 }
-- 
2.41.0

