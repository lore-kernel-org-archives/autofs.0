From: Ian Kent <raven@themaw.net>
Subject: [PATCH 4/8] autofs: reformat 0pt enum declaration
Date: Fri, 22 Sep 2023 12:12:11 +0800
Message-ID: <20230922041215.13675-5-raven@themaw.net>
References: <20230922041215.13675-1-raven@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1695355969; x=
        1695442369; bh=ryCXqbIXzg6S6gQUjvoPfXhRLeM6IuhwCFN5VCJzJFc=; b=A
        QJ22VOomJC0WZVbO0CwEOPShSyigDPVMPrsRKLnaEDOcf3JSYevhn0tGuLgL9TvP
        EQQvYm5xA0MKGgoFyc4MNdmyBkXT9ssgx5Gz61Om//QySzFtwPQBs7J4Vq+TQGKE
        9BfX3tZE7ubgRZSvo/GL+tJNcfz8ZiW5/DiifY6caxitzl55pMGwb/oSeW6vF99W
        iFQogkGgkb8OvdaDicWU15foke8vUcI8zFJPkWVPSvJMGmUhD93QRK4XKUIbj4kY
        qk9bMa3j5Arg15+NSyJMmF99e3/tikxwzTk1ypXobQ1MzXhpMHsE+XF+bEIEkEcy
        vawxBu5ILeLXOS5H8WfgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695355969; x=
        1695442369; bh=ryCXqbIXzg6S6gQUjvoPfXhRLeM6IuhwCFN5VCJzJFc=; b=X
        zPj8XBtqSEcH359KhBDLDTJ4lr3B+eObBDUY4RUL1LwWdn53BwlNUQiGwpN2cFi/
        EUIQ52MR5QF92UdJSxySibGePcy/xyIplfL6PLgJMOijM+z9AyG+k1mF+N72wTvp
        BZKd4cyUiuJtBUPfujAyEhVQR7RLeM5peY+HyXpYIVQ4lPHnjDlrZcw7nnYvxIpd
        JbiGc3Ps50s6akEdr7YBwyb1x0UbVuZe1s9l8aIEmCpK9nde/clAWW/GqyNFbPJT
        rIiy01WYrp5YzcaofTaolKrXhaDOnCZQ3TLBrE7+Q1Ba2ceMNyHQo8IhEQFLcal6
        v3FlSzloinL89kPzGFrBA==
In-Reply-To: <20230922041215.13675-1-raven@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill O'Donnell <billodo@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>

The enum of options is only reformated in the patch to convert autofs
to use the mount API so do that now to simplify the conversion patch.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 992d6cb29707..d2b333c0682a 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -110,9 +110,20 @@ static const struct super_operations autofs_sops = {
 	.evict_inode	= autofs_evict_inode,
 };
 
-enum {Opt_err, Opt_fd, Opt_uid, Opt_gid, Opt_pgrp, Opt_minproto, Opt_maxproto,
-	Opt_indirect, Opt_direct, Opt_offset, Opt_strictexpire,
-	Opt_ignore};
+enum {
+	Opt_err,
+	Opt_direct,
+	Opt_fd,
+	Opt_gid,
+	Opt_ignore,
+	Opt_indirect,
+	Opt_maxproto,
+	Opt_minproto,
+	Opt_offset,
+	Opt_pgrp,
+	Opt_strictexpire,
+	Opt_uid,
+};
 
 static const match_table_t tokens = {
 	{Opt_fd, "fd=%u"},
-- 
2.41.0

