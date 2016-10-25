From: Ian Kent <raven@themaw.net>
Subject: [PATCH 01/37] autofs-5.1.2 - fix release date in CHANGELOG
Date: Tue, 25 Oct 2016 09:17:30 +0800
Message-ID: <20161025011730.7778.63467.stgit@pluto.themaw.net>
References: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
        x-sasl-enc:subject:from:to:date:message-id:in-reply-to
        :references:mime-version:content-type:content-transfer-encoding;
         s=mesmtp; bh=qatQxbcsouIVlL3JCzn0Y6jSDyg=; b=v/MV5nSKhP+GT4T/cx
        OIoFbYSYfPwODzVsc3rDtcRMBcrXopGo8rnhFgnXnYRTj1SOoB4L0uQiK7/aJ3Kd
        iyRfOClDVi62DhIxkgQDOfxkQBmeuqWkOksbOIDGn1mxxCUyqIVpZftx8qiLy8i9
        muj3dRvaH98jaXTL364NphUdU=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:subject:from:to:date
        :message-id:in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=smtpout; bh=qatQxbcsouIVlL3JCzn0Y6
        jSDyg=; b=YOX4zKooYfxrPISKdhMo9P8wbSlzzAZ22mjf/Dc8NTALAkPj7oOw5R
        m5w9QhLrdSoLsjqk6nZ9KjZ/bphjBmTfPMWmlYd/Sd5TecE3B62sb14TGwcy1Gma
        +YeecaBzg0gYqpXEnL1iVUCzf2HdlGzWrsLj361eorvZGsgu1Ah9E=
In-Reply-To: <20161025010014.7778.69274.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs mailing list <autofs@vger.kernel.org>

Oops!

Also add heading for 5.1.3.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 CHANGELOG |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/CHANGELOG b/CHANGELOG
index 39019a9..d31bb80 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,4 +1,8 @@
-15/06/2015 autofs-5.1.2
+xx/xx/2016 autofs-5.1.3
+=======================
+- fix release date in CHANGELOG.
+
+15/06/2016 autofs-5.1.2
 =======================
 - update libtirpc workaround for new soname.
 - revert fix libtirpc name clash.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
