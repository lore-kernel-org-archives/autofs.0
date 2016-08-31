From: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/3] autofs: remove possibly misleading /* #define DEBUG */
Date: Wed, 31 Aug 2016 11:34:09 +0800
Message-ID: <20160831033409.9910.77067.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=MLK
        QWL0fNqveOGwVhoPrlk2ZhEY=; b=I4FS+rd4f8tlSMilJgK8qM6WxS/9TDf4dTL
        GzKjUdEii2vMJtNDkLzPLPjr/AedHdJYk5WkQrDf/MTvQqcC6NHpsBfoMLm1qw05
        c7MQmsUpuHILXR8+tnpv5Hu418hqk1Kt+b5/yi3TyAqv3zm4oziGZDOk8yUnS+MG
        GlROKnn4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=MLKQWL0fNqveOGwVhoPrlk2ZhEY=; b=Thwti
        idvNbeHdY8NGRtYiD6RkmCbEJZiCIZdiKH6t60h8+8ww03tHFeM20PDhh+YzDRP+
        Uy3TEKuQez8sGadYQtHs3oQ7Fi636EcWeJPrE0HEns3qdAHmqlm+glT3d1/kytsf
        p6Jka06Pk7TJRs7fOjwC6S8D/+Xonk+QBykSFE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Tomohiro Kusumi <kusumi.tomohiro@gmail.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

From: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>

Having this in autofs_i.h gives illusion that uncommenting this
enables pr_debug(), but it doesn't enable all the pr_debug() in
autofs because inclusion order matters.

XFS has the same DEBUG macro in its core header fs/xfs/xfs.h,
however XFS seems to have a rule to include this prior to other
XFS headers as well as kernel headers. This is not the case with
autofs, and DEBUG could be enabled via Makefile, so autofs should
just get rid of this comment to make the code less confusing.
It's a comment, so there is literally no functional difference.

Signed-off-by: Tomohiro Kusumi <kusumi.tomohiro@gmail.com>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs4/autofs_i.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs4/autofs_i.h b/fs/autofs4/autofs_i.h
index dd71bd4..4404a22 100644
--- a/fs/autofs4/autofs_i.h
+++ b/fs/autofs4/autofs_i.h
@@ -34,8 +34,6 @@
 #include <asm/current.h>
 #include <linux/uaccess.h>
 
-/* #define DEBUG */
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif

