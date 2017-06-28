From: Ian Kent <raven@themaw.net>
Subject: Re: fix cross-compile when libtirpc is used
Date: Wed, 28 Jun 2017 08:17:25 +0800
Message-ID: <1498609045.2740.3.camel@themaw.net>
References: <20170627192239.GC26922@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=wks1QZ2piRQzIGNEgM
        aCY5QDXjn2wL9IhKV2naBtu8c=; b=L611fSmLiPVRQIF5IE/Jct6/5GM3k3P9mf
        mAPDIwe2UG7pVV7nzyKFu5tz2ERqHONghk5caomF9gs0e0RJyW/+kXG4UPO+iR+N
        ot4C5kRP6F3nBznQRkQkH8XzYaKN+rExXnQ6YPtoO+yBwoD3kqwtiQTXCTDNFCJB
        Wbyc3UDwttYD4gy5UoPvHT+bG2TnYRAgeAalVZhjNCGOq4gL7v3SFv6CVO6aWQ5c
        F5Dc3wQWSxxdn0sRSWJPbUr3CkdQldAlMgixnh4TEgmSKlb1v36pjr91wKKnBAl1
        i4U2Z+5ahig3oqL3QNWJ3/W7kVgWhcz5gx1sG0jMAR/Cn2YotEEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=wks1QZ2piRQzIGNEgMaCY5QDXjn2wL9IhKV2naBtu8c=; b=UCR5ZGav
        rRbw4HFIRxHJiwnQk4eFNRx9fk/Wh7GSy69yKeVHgZe4L+g74MxWDqlbFdtF91TF
        SS7HsT2uYLHA36ByeA7wK/VGZH9b253Hel4GA0QPIzVQQMWetdCJskVs8Y1VXvhu
        kpBAdN8HAFp+9sTW7l0VNzfdkwpSWWy2q9EtEoiWoS5A3uvOUYSPDjxsSqEAoCHU
        bdekIDJPIHv9S6SLIH1KlChGW0K+zW3DaJaCxz6I10mBby15nIStLjHAGiC2lsVF
        3pVqh9qn3KHPXcI6ifsuCWLRE/5yoWo0B3ZJpCbo1yfo7V+TpC/bw0ZLjVQXiMMl
        fzALHdu/qf49Ng==
In-Reply-To: <20170627192239.GC26922@waldemar-brodkorb.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Waldemar Brodkorb <wbx@openadk.org>, autofs@vger.kernel.org

On Tue, 2017-06-27 at 21:22 +0200, Waldemar Brodkorb wrote:
> Hi,
>=20
> I would like to suggest following patch, which uses pkg-config
> to find libtirpc headers and libraries.
> This allows to cross-compile autofs. The patch was suggested=C2=A0
> on the buildroot mailinglist, too.

Where is the patch description?
What happens if a pkg config package is not installed?

And how are WITH_LIBTIRPC and TIRPC_WORKAROUND defined?

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
