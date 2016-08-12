From: Ian Kent <raven@themaw.net>
Subject: [PATCH 08/18] autofs: Remove obsolete sb fields
Date: Fri, 12 Aug 2016 10:48:10 +0800
Message-ID: <20160812024810.12352.96377.stgit@pluto.themaw.net>
References: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=6lNM6eURirB3s7Wqc9DJLWEigxI=; b=UT7PrP
	49Sv1EbVsShkV6Y60FS5738gn+Ag0n4r85r05gyRfp1MmumZfpYMfaRcCENR7Yo3
	bhaCU/qjqiGatTiLsBa2TfOSPJ+oGeNOn62VvYBdtAd2+HHAlHq4miptVylOukfT
	+aY2UmocsJzvX7594OQcTfqvKeTqTHFe9inaw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=6lNM6eURirB3s7W
	qc9DJLWEigxI=; b=Tau7Cn3l+EcUYxBQ1mFNC2qSq8oMoHutuew6705zKZ9jbCc
	IyyHL9NSCcLGV3IcJidOP6JCTlzkLE5SGHCOBn3JekYvZ1yRMOcNjDQYAj68H6F5
	AqJAHMp4vhjeUokEB3qkkpu3WfSo3dCUd4kyImY1bc1kkxviFJsDB8nv+x6E=
In-Reply-To: <20160812024734.12352.17122.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

These two were left from aa55ddf3 which removed unused ioctls.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <ikent@redhat.com>
---
 fs/autofs4/autofs_i.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index eb87055..73e3d38 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -111,8 +111,6 @@ struct autofs_sb_info {
 	int max_proto;
 	unsigned long exp_timeout;
 	unsigned int type;
-	int reghost_enabled;
-	int needs_reghost;
 	struct super_block *sb;
 	struct mutex wq_mutex;
 	struct mutex pipe_mutex;

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
