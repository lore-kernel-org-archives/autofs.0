From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] autofs: fix doubled word
Date: Wed, 15 Jul 2020 18:28:47 -0700
Message-ID: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ivt/S2E26MMmfuGaOWJ4/5vbxsd/UYTBZ3TQCIqNLng=; b=MyQFx3UcYSKlzISyFpi1oast9v
        AXcaUvG75KxTI6/bxqStU3uCRyw56lDwAEgtNFQGuGbd34h91cli8lIGkL+k9scQcgH/lyN8NLei8
        l4qf3ULUQTTX4jFWPEcg4h0x4jzGYg/A462dAqNLQn+6IkwooqAUWGPmrKMAmje0jCmWlbGY5cnwj
        ARoe6h4HOVVGFCcWKQ+PWdVTQ4bd7HGjYkc/50oaxFmPGUqGmXzgslTkFEKcsGz7RBxywoCICrRjX
        +prYNKXS/7T0W1GNKlS63+yTm87gWJLoB+YGxSc/FR725efAA29o0ullXUf33URuf/EPrPbndOqNB
        PfLut/xQ==;
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: LKML <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@vger.kernel.org>, Ian Kent <raven@themaw.net>, Andrew Morton <akpm@linux-foundation.org>

From: Randy Dunlap <rdunlap@infradead.org>

Change doubled word "is" to "it is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/uapi/linux/auto_dev-ioctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/auto_dev-ioctl.h
+++ linux-next-20200714/include/uapi/linux/auto_dev-ioctl.h
@@ -82,7 +82,7 @@ struct args_ismountpoint {
 /*
  * All the ioctls use this structure.
  * When sending a path size must account for the total length
- * of the chunk of memory otherwise is is the size of the
+ * of the chunk of memory otherwise it is the size of the
  * structure.
  */
 

