From: Ian Kent <raven@themaw.net>
Subject: The add -c option when calling /bin/umount
Date: Thu, 08 Jun 2017 11:00:15 +0800
Message-ID: <1496890815.9718.1.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:message-id
        :mime-version:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=fm1; bh=OKZ+e1C4yVE3oIxlcd5lahKQkGTzQwkaR5jWFzKGR
        YI=; b=ck6SrTP7TDV4o7hL8N0PHg/iYBuFuj9pmVUZ0OAhVziFAuBtA3hDCcDkf
        0qBhsF4/13Fehakktm0O5xA8ROgNG3+N2KSf/alpV4z5HdwlYCu2Pd/q+DKzszfn
        vvuH/xsFX7RYQHj3OZk3l23mpMKA7mVLoAViLplKWtNtllYRdQpx6j+gBd5j3EJw
        JlF0NjPoVpqVyewMekc7hnzPuCOJ5gNcGIXNEQik3ZEDmG5kj2rA4zMWoTeYnZ51
        mSGneJcwMOc2R7wJLo40GX8RPQSsvZYMdQIKLKYPy8ho77c3q8w2Cc9HSxk14/Rz
        BsKHDs499EfifdMDjwRPcZYAWYmqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=OKZ+e1C4yVE3oIxlcd
        5lahKQkGTzQwkaR5jWFzKGRYI=; b=pQ/TbN8cQNo/uJ6rPwsR3uWSkWgSZkWQBN
        UGmq/075C3El8neDv2dObWr72xHN/IzU/VvaBhUaArMlPowAZpzU4iFccOu5LUnc
        I5RmLy/SLYH7QFClU6Wu7pRP00ycpINGZp/cimlMQQ9XlnwlqSYTyXy2GZKUVEgt
        nOEWGaXU/UJd1i+MSA2YFaWPgZxtJtU2qiSaPpEmPHyJUJi4G+5SyFw8VX43frdn
        LrDJgiYruAZG1O3Vzs2ccLLdJqBqrzYisqtsRK7GDfSO8KlC1y04x1D8UsNzVcAz
        opVRxEyU97/oXosdJ+Nj5LVXdV5jZFFrnsf2FzNVf/u+6s1c6f6w==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: NeilBrown <neilb@suse.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

Hi Neil,

Can you re-send the patch please.
I've "lost" it ....

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
